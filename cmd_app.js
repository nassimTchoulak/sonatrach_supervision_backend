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



let app = new express();



// post json
let jsonParser = bodyParser.json({limit: '50mb', extended: true});
let urlencodedParser = bodyParser.urlencoded({limit: '50mb', extended: true});


app.use(jsonParser);
app.use(urlencodedParser);

// links


app.use(cors({origin: new RegExp("")}));


// admin_ check



app.post("/api/test_cmd",urlencodedParser,(req,res)=>{
    if(!req.body){
        res.sendStatus(400);
    }
   // res.writeHeader(200,{"content-type":"application/json"});
    let _id = req.body.user_id ;
    let cmd = req.body.cmd || "";


            small_test(cmd).then((msg)=>{
                //res.end(msg);
               // console.log(msg.msg);
                res.end(msg.msg);
            }).catch();


});

app.listen();
