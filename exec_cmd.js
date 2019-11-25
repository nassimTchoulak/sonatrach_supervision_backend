
//  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned to allow exec on windows

function get_running_var(connection){
    return new Promise((resolve,reject) =>{

        connection.promise().execute("select * from variable").then(
            ([result,fields])=>{
                resolve({data:result});
            }
        ).catch((err)=>{console.log(err); reject({cause:"sql error"}) } );
    } ) ;

}

function get_one_value(connection,_id,params,line,splitter,order){
    // variable


        if((params!==null)&&(params!==undefined)){
            params = params.split("_|_").join(" ");
        }
        else{
            params = "";
        }

        let back ="";

        let spawn = require("child_process").spawn;

        //let child = spawn("powershell.exe",[str]);
        let os = require("os");
        let child ;
        if(os.platform()==="win32") {
           child = spawn("powershell.exe", [__dirname + "\\cmd\\" + _id + ".ps1"]);
        }
        else{
            child = spawn(__dirname + "\\cmd\\" + _id + ".sh");
        }


        child.stdout.on("data",function(data){
            back = back + data ;
        });

        child.stderr.on("data",function(data){
            back = back + data;
        });

        child.on("exit",(code)=>{
            //find the value to insert depending on params
            if(code===0){
                //console.log("gonna insert"+_id)
                let within_line = back.split("\n")[line] ;
                //console.log(within_line);
                let char  ;
                let value = 0 ;

                if((splitter===null)||(splitter==="")){
                    char=within_line ;
                }
                else{ // if splitter is on
                    let ls = within_line.split(splitter);
                    let ls2 =[];
                    ls.forEach((i)=>{
                       if(i!==""){
                          ls2.push(i);
                       }
                    });
                    char = ls2[order] ;
                }
                char = char.replace(" ","") ;

                if(isNaN(char)){
                    console.log("params not a number")
                }else{

                    value = Number(char);
                    connection.promise().query("insert into snapshots values (?,NOW(),?)",[_id,value]).then().catch((err)=>{
                        console.log(err);
                        console.log("sql error on "+_id);
                    }) ;
                }




            }
            else{
                console.log("bad exit code"+_id)
            }

        });
        child.stdin.end();




}


function small_test(str){

    return new Promise((resolve,reject)=>{

    let spawn = require("child_process").spawn;

        let child ;
        let os = require("os");

        if(os.platform()==="win32"){
            child = spawn("powershell.exe",[str]);
        }else{
            child = spawn(str);
        }

        let back ="";

    child.stdout.on("data",function(data){
       back = back + data ;
    });

    child.stderr.on("data",function(data){
            back = back + data;
    });

    child.on("exit",(code)=>{
            resolve({msg: back,code:code})
    });
    child.stdin.end();
    });
}

function lunch_listeners(connection,old_var_ids){
    return new Promise((resolve,reject)=>{

        connection.promise().execute("select var_id,var_priorite,var_params,var_line,var_splitter,var_order from variable").then(
            ([result,fields])=>{
                result.forEach((i)=>{
                    if(old_var_ids.indexOf(i.var_id)===-1 ){

                        old_var_ids.push(i.var_id) ;

                        setInterval((_id,params,line,splitter,order,connection)=>{

                            get_one_value(connection,_id,params,line,splitter,order) ; // this one analyses & inserts in db

                        },10000*i.var_priorite*i.var_priorite*i.var_priorite,i.var_id,i.var_params,i.var_line,i.var_splitter,i.var_order,connection) ; // 10000

                    }
                });

                resolve({old_var_ids:old_var_ids})
            }
        ).catch((err)=>{
            reject({cause:err})
        })
    })
}

module.exports = {
    get_vars:get_running_var,
    small_test:small_test,
    lunch_listeners:lunch_listeners
};