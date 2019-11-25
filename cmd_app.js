let express = require("express");
let url = require("url");
let querystr = require("querystring");

let bodyParser = require('body-parser');
let cors = require('cors');
let mysql = require("mysql2");

let sys = require('util');
let exec = require('child_process').exec;

let os = require('os');
console.log(os.platform()==="win32");

const fs = require('fs');
let sha = require("js-sha256").sha224 ;



let small_test = require("./exec_cmd").small_test ;

let lunch_listen = require("./exec_cmd").lunch_listeners;

let exec_ext ="";
if(os.platform()==="win32") {
     exec_ext = "ps1";
}
else{
     exec_ext="sh";
}
/// depends on host os for this application current : powershell vs linux .sh

const randhash = ()=>{
    const lt = "abcdefghigklmnopqrstuvwxyz0123456789";
    let str="";
    for(let i=0;i<14;i++){
        str = str +  lt[Math.floor((Math.random() * 1000)%35)];
    }

    return str;

};


const connection = mysql.createConnection(
    {host:'localhost',
        user: 'root',
        password: "ux2018@A",
        insecureAuth : true,
        database: 'sonatrach'}
);


connection.connect(function(err) {
    if (err) {
        console.error('error connecting: ' + err.stack);

    }
    else{
        console.log("connection _up");
    }
} );


let app = new express();



// post json
let jsonParser = bodyParser.json({limit: '50mb', extended: true});
let urlencodedParser = bodyParser.urlencoded({limit: '50mb', extended: true});


app.use(jsonParser);
app.use(urlencodedParser);

// links


app.use(cors({origin: new RegExp("")}));


// admin_ check

const admin_check = (_id)=>{
    return new Promise((resolve, reject) => {
        connection.promise().execute("select user_type from utilisateur where user_id=?",[_id]).then(
            ([result,fields])=>{
                if((result.length===1)&&(result[0].user_type==='admin')){
                    resolve({status:true})
                }
                else{
                    reject({status:false})
                }
            }
        ).catch((err)=>{console.log(err);
            reject({status:false})

        });
    });
};

let var_new = true ;
let old_vals_id = [];

setInterval(()=>{
    if(var_new===true){
        var_new=false ;
        lunch_listen(connection,old_vals_id).then(
            (result)=>{
                old_vals_id = result.old_var_ids ;
        }).catch((err)=>{
            console.log(err);
        }) ;
    }
},3000); // each 30000s


/// get path


app.get('/api/get_type_objects',(req,res)=>{
    res.header("Content-Type",'application/json');
    connection.promise().execute("select * from type_objet").then(
        ([result,fields]) => {
            let ls =[] ;
            result.forEach((i)=>{
                ls.push(i.obj_type);
            });
            res.end(JSON.stringify(ls));
        }
    ).catch((err)=>{console.log(err);
            res.end("[]");
    })  ;
    /*
    let ab = {"ab":"helllo",os:os.platform()};
    exec('tasklist', (err, stdout, stderr) => {

        if (err) {
            //some err occurred
            console.error(err)
        } else {
            // the *entire* stdout and stderr (buffered)
            console.log('stdout: '+stdout);
            console.log('stderr: '+stderr);
        }
    });


     */

});

app.get("/api/get_all_objects",(req,res)=>{
    let params = querystr.parse(url.parse(req.url).query);
    res.setHeader('Content-Type', 'application/json');

    connection.promise().execute("select * from objet ").then(
        ([result,fields])=>{
            res.json(result) ;

        }
    ).catch( (err)=> { console.log(err);
            res.end("[]");
        }
    );

});

app.get("/api/get_one_object_line",async (req,res)=>{   // _id is object's id with we will give all family
    let params = querystr.parse(url.parse(req.url).query);
    res.setHeader('Content-Type', 'application/json');
    if(!("_id" in params)){
        res.end("[]");
    }
    else{
        let _id = params["_id"];
        //console.log(_id);
        let ls = [] ;
        let [rows,fields] = await connection.promise().execute("select * from objet where obj_id=?",[_id]) ;
        //console.log(rows[0]);
        ls.push(rows[0]);

        while(ls[ls.length-1].obj_pere!==null){
            _id= ls[ls.length-1].obj_pere ;
            let [rows,fields] = await connection.promise().execute("select * from objet where obj_id=?",[_id]) ;
            //console.log(rows[0]);
            ls.push(rows[0]);
        }

        res.json(ls);


    }
});



app.post("/api/post_object",urlencodedParser,(req,res)=>{
    if (!req.body) {
        return res.sendStatus(400);
    }
    let _pere = req.body.obj_pere || null ;
    let _id = randhash() ;
    let nom_phy = req.body.obj_nom_phy || "" ;
    let nom_log = req.body.obj_nom_log  || "";
    let adress = req.body.obj_adress || "";
    let type = req.body.obj_type ;
    if(type!==undefined){
        connection.promise().execute("insert into objet values (?,?,?,?,?,?) ;",[_id,_pere,nom_log,nom_phy,type,adress]).then(()=>{
            res.json({status:true});
        }).catch((err)=>{
            console.log(err);
            res.json({status:false});
        })
    }
    else{
        res.json({status:false});
    }

});

// acount handler
app.post("/api/login",urlencodedParser,(req,res)=>{
    if(!req.body){
            return res.sendStatus(400);
    }
    res.header("Content-Type",'application/json');

    let user = req.body.user_email || "";
    let pwd = req.body.user_pwd || "";


    connection.promise().execute("select * from utilisateur where ((user_email=?) and (user_pwd=?))",[user,sha(pwd)]).then(
        ([result,fields])=>{
           if(result.length===1){
               delete result[0]["user_pwd"] ;
               res.json({status:true,user:result[0]})
           }
           else{
               res.json({status:false});
           }
        }
    ).catch(
        (err)=>{ console.log(err);
            res.json({status:false});
        }
    )
});
app.post("/api/init_accounts",urlencodedParser,(req,res)=>{
    if(!req.body){
        res.sendStatus(400);
    }
    let _id = randhash() ;
    connection.promise().execute("insert into utilisateur values (?,?,?,?,?,?,?)",[_id,'admin','admin',sha('admin'),'admin','admin','admin']).then(
        ([result,fields])=>{
            res.end(JSON.stringify(result));
        }
    ).catch((err)=>{
        res.json(err);
    })
});
app.post("/api/post_variable",urlencodedParser,(req,res)=>{
    if(!req.body){
        res.sendStatus(400);
    }
    let user = req.body.token || "" ;
    let obj_id = req.body.obj_id ;
    let nom = req.body.var_nom ;
    let desc = req.body.var_description || "";
    let prior = req.body.var_priorite || 5 ;
    let file = req.body.var_exec ;
    let params = req.body.params || null ; // must be separated eact by _|_ 3chars

    let line = req.body.var_line || 0 ;
    let splitter = req.body.var_splitter || null ;
    let order = req.body.var_order || 0 ;

    if(params===""){
        params=null;
    }


    if((obj_id!==undefined)&&(nom!==undefined)&&(file!==undefined)) {

        admin_check(user).then(
            () => {
                let var_id = randhash();
                fs.writeFile('./cmd/'+var_id+'.'+exec_ext,file, (err) => {

                    if (err){
                        console.log("not writing");
                        res.json({status:false});
                    }
                    else{

                        connection.promise().execute("insert into variable values (?,?,?,?,?,?,?,?,?) ;",
                            [var_id,obj_id,nom,desc,prior,params,line,splitter,order]).then(
                            ()=>{
                                res.json({status:true})
                            }
                        ).catch((errr)=>{
                            console.log(errr);
                            res.json({status:false});
                        });

                    }

                });

            }
        ).catch(() => {
            res.json({status:false});
        });

    }
    else{
        res.json({status:false});
    }

});


app.post("/api/test_cmd",urlencodedParser,(req,res)=>{
    if(!req.body){
        res.sendStatus(400);
    }
   // res.writeHeader(200,{"content-type":"application/json"});
    let _id = req.body.user_id ;
    let cmd = req.body.cmd || "";

    admin_check(_id).then(()=>{
        if(cmd!=="") {
            small_test(cmd).then((msg)=>{
                //res.end(msg);
               // console.log(msg.msg);
                res.end(msg.msg);
            }).catch();
        }
    }).catch(()=>{
        res.end("error");
    });
});

app.get("/api/get_critics_all",(req,res)=>{

    connection.promise().execute("select alarme.var_id,alerte.niveau,max(alerte.date_time) as last_alerte, variable.var_nom  ,variable.obj_id" +
        " from alerte natural join alarme natural join variable " +
        "where alerte.archive=0 " +
        "group by var_id,niveau order by last_alerte desc ;").then(
        ([result,rows])=>{
            res.json(result);
        }
    ).catch((err)=>{
        console.log(err);
        res.end("[]");
    })
});
app.post("/api/archive_alertes",urlencodedParser,(req,res)=>{
        if(!req.body){
            res.sendStatus(400);
        }
        let var_id = req.body.var_id || "" ;
        if(var_id===""){
            res.end("no id");
        }
        else{
            res.end("we ll see");

            connection.promise().execute("update alerte set archive=1 where id_alarme in " +
                "( select id_alarme from alarme where var_id = ? )  ",[var_id]).then(([re,fi])=>{

            }).catch((err)=>{
                    console.log(err);
            })
        }
});
app.get("/api/snapshots",(req,res)=>{
    let params = querystr.parse(url.parse(req.url).query);
    let var_id = params["var_id"] ||"" ;
    if(var_id===""){
        res.end("[]");
    }
    else{
        connection.promise().execute("select * from snapshots where var_id=? order by date_time desc limit 500",[var_id]).then(
            ([result,rows])=>{
                res.json(result) ;
            }
        ).catch((err)=>{
            console.log(err);
            res.end("[]");
        })
    }
});


app.post("/api/post_alarme",urlencodedParser,(req,res)=>{
   if(!req.body){
       res.sendStatus(400);
   }
   let user_id = req.body.user_id || "" ;
   let description = req.body.description || "" ;
   let max = req.body.max ;
   let min = req.body.min || "0" ;
   let niveau = Number(req.body.niveau) || 10 ;
   let interval = req.body.interval_rep || 100 ;
   let var_id = req.body.var_id ;

   if(isNaN(interval)){
       interval = 100 ;
   }
   


   if((!isNaN(max))&&(!isNaN(min))){

       max = Number(max);
       min = Number(min);
        if(max>min) {
            admin_check(user_id).then(() => {

                connection.promise().execute("insert into alarme(var_id,description,seuil_max,seuil_min,niveau,interval_rep,etat) values (?,?,?,?,?,?,?)",
                    [var_id,description,max,min,niveau,interval,1]).then(()=>{
                    res.json({status:true});
                }).catch((err)=>{
                        console.log(err);
                    res.json({status:false})
                }) ;

            }).catch(() => {
                res.json({status:false})
            })
        }
        else{
            res.json({status:false})
        }
   }
   else{
       res.json({status:false})
   }

});
app.get("/api/get_variable_alarmes",(req,res)=>{

    connection.promise().execute("select * from variable").then(([ress,rows1])=>{

        connection.promise().execute("select * from alarme ").then(([res2,rows2])=>{
            let dict ={} ;
            ress.forEach((i)=>{
                i.alarmes=[] ; // create array to nest alarme in variable
                dict[i.var_id] = i ; // allow to find variable by var_id only
            })

            res2.forEach((j)=>{
                dict[j.var_id].alarmes.push(j)
            })
            res.json(Object.values(dict));

        }).catch(er2=>{
            console.log(er2)
        })
    }).catch(err=>{console.log(err)})

});
app.get("/api/get_variable_one",(req,res)=>{
    let params = querystr.parse(url.parse(req.url).query);
    if(params["_id"]===undefined){
        res.json({});
    }
    else{
        connection.promise().execute("select * from variable where var_id=?",[params["_id"]]).then(([ress,rows])=>{
            if(ress.length>0){
                res.json(ress[0]);
            }
            else{
                res.json({});
            }
        }).catch(err=>{console.log(err)
            res.json({});
        })

    }


});

app.listen(8080);
