const express = require('express');
const mysql = require('mysql');

const app = express();
app.use(express.json());

app.use(function (req, res, next) {

  // Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');

  // Request methods you wish to allow
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

  // Request headers you wish to allow
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.setHeader('Access-Control-Allow-Credentials', false);

  // Pass to next layer of middleware
  next();
});


const con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database:'hotel_management'
}); 

con.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL!');
});

app.get('/showservices', (req,res) => {
  try{
    const getServicesQuery = "SELECT * FROM service";
    con.query(getServicesQuery, function (err, result, fields) {
      if (err) throw err;
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})


app.get('/showservicevisits', (req,res) => {
  try{
    let servicePartOfQuery = "";

    if(req.query.service && Array.isArray(req.query.service)) {
      servicePartOfQuery += `AND S.servicedescription IN (`;
      req.query.service.forEach((service, i) => {
        if(i === 0) servicePartOfQuery += `'${service}'` 
        else servicePartOfQuery += `,'${service}'` 
      })
      servicePartOfQuery += ')' 
    }
    else if(req.query.service && !Array.isArray(req.query.service)){
      servicePartOfQuery += `AND S.servicedescription = '${req.query.service}' ` 
    }
    else servicePartOfQuery = `AND S.servicedescription IN ("")`;


    let costPartOfQuery = "";

    if(req.query.lowcostlimit && req.query.highcostlimit){
      costPartOfQuery = `AND SC.cost BETWEEN ${parseFloat(req.query.lowcostlimit, 10)} AND ${parseFloat(req.query.highcostlimit, 10)}`
    }

    let datePartOfQuery = "";

    if(req.query.firstdatelimit && req.query.finaldatelimit){
      datePartOfQuery = `AND SC.chargedatetime BETWEEN '${req.query.firstdatelimit.replace("@", " ")}' AND '${req.query.finaldatelimit.replace("@", " ")}'`
    }


    const getServiceVisits = `SELECT S.idservice, C.idnfc, SC.chargedatetime, SC.description, SC.cost, C.firstname, C.lastname, S.servicedescription
    FROM service_charge AS SC, customer AS C, service AS S
    WHERE SC.idnfc = C.idnfc AND SC.idservice = S.idservice ${servicePartOfQuery} ${costPartOfQuery} ${datePartOfQuery}
    `
    con.query(getServiceVisits, function (err, result, fields) {
      if (err) throw err;
      // console.log(result);
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})

app.get('/showsalesperservice', (req,res) => {
  try{
    const getSalesPerService = "SELECT * FROM sales";
    
    con.query(getSalesPerService, function (err, result, fields) {
      if (err) throw err;
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})

app.get('/showcustomerdetails', (req,res) => {
  try{
    const getSalesPerService = "SELECT * FROM customer_details";
    
    con.query(getSalesPerService, function (err, result, fields) {
      if (err) throw err;
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})

app.get('/showplacesfrominfectedperson', (req,res) => {
  try{
    
    const getPlacesFromInfectedPerson = 
    `SELECT P.idplace, P.placename, P.placedescription, V.entrydatetime, V.exitdatetime
     FROM visits AS V, customer AS C, place AS P 
     WHERE V.idnfc = C.idnfc AND V.idplace = P.idplace AND C.idnfc = ${req.query.idnfc}
    `;


    con.query(getPlacesFromInfectedPerson, function (err, result, fields) {
      if (err) throw err;
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})

app.get('/showpersonsfrominfectedperson', (req,res) => {
  try{
    
    const getPlacesFromInfectedPerson = 
            `SELECT C.firstname, C.lastname, C.idnfc, B.idplace, B.entrydatetime, B.exitdatetime
            FROM visits A, visits B, customer C
            WHERE B.idnfc = C.idnfc AND A.idnfc = ${req.query.idnfc} AND A.idnfc <> B.idnfc AND A.idplace = B.idplace AND NOT(B.entrydatetime > DATE_ADD(A.exitdatetime, INTERVAL 1 DAY) OR B.exitdatetime < A.entrydatetime);            
            `;

    con.query(getPlacesFromInfectedPerson, function (err, result, fields) {
      if (err) throw err;
      res.status(200).json(result);
    });
  
  }
  catch(e){
    res.status(400).send(e)
  }
})


//Show for 3 age groups the most visited places
app.get('/showmostvisitedplaces', (req,res) => {
  let lastMonth = req.query.lastMonth.toUpperCase()

  let ageGroup = ''

  if(req.query.ageGroup == "2040") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR)"
  }
  else if(req.query.ageGroup == "4160") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"

  }
  else ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"

    try{
      const getMostVisitedPlaces = 
              `SELECT P.idplace, P.placename, COUNT(P.idplace) as visit_count
                FROM visitS as V, place as P, customer as C
                WHERE V.idplace = P.idplace AND V.idnfc = C.idnfc AND ${ageGroup} AND V.entrydatetime >= DATE_SUB(CURDATE(), INTERVAL 1 ${lastMonth})
                GROUP BY P.idplace
                ORDER BY COUNT(P.idplace) DESC;
              `;


      con.query(getMostVisitedPlaces, function (err, result, fields) {
        if (err) throw err;
        res.status(200).json(result);
      });
    
    }
    catch(e){
      res.status(400).send(e)
    }
})


//Show for 3 age groups the most used services
app.get('/showmostusedservices', (req,res) => {
  
  let lastMonth = req.query.lastMonth.toUpperCase()

  let ageGroup = ''
  
  if(req.query.ageGroup == "2040") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR)"
  }
  else if(req.query.ageGroup == "4160") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"
  
  }
  else ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"
  

    try{
      const getMostUsedServices =   
              ` SELECT S.servicedescription, COUNT(V.idservice) as count 
                FROM service_charge as V, customer as C, service as S
                WHERE  V.idnfc = C.idnfc AND V.idservice = S.idservice AND ${ageGroup} AND V.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 ${lastMonth})
                GROUP BY S.servicedescription
                ORDER BY COUNT(V.idservice) DESC;                
              `;
  
      con.query(getMostUsedServices, function (err, result, fields) {
        if (err) throw err;
        res.status(200).json(result);
      });
    
    }
    catch(e){
      res.status(400).send(e)
    }
  })


  
//Show for 3 age groups the services with most users
app.get('/showserviceswithmostusers', (req,res) => {
  let lastMonth = req.query.lastMonth.toUpperCase()

  let ageGroup = ''
  
  if(req.query.ageGroup == "2040") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 20 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 41 YEAR)"
  }
  else if(req.query.ageGroup == "4160") {
    ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 41 YEAR) AND C.birthday > DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"
  
  }
  else ageGroup = "C.birthday <= DATE_SUB(CURDATE(), INTERVAL 61 YEAR)"

    try{
      const getServicesWithMostUsers =   
              ` SELECT S.servicedescription, COUNT(DISTINCT C.idnfc) as count
                FROM customer as C, service as S, service_charge as R
                WHERE R.idservice = S.idservice AND R.idnfc = C.idnfc AND ${ageGroup} AND R.chargedatetime >= DATE_SUB(CURDATE(), INTERVAL 1 ${lastMonth})
                GROUP BY S.servicedescription
                ORDER BY COUNT(DISTINCT C.idnfc) DESC;               
              `;
  
      con.query(getServicesWithMostUsers, function (err, result, fields) {
        if (err) throw err;
        res.status(200).json(result);
      });
    
    }
    catch(e){
      res.status(400).send(e)
    }
  })




app.listen(3001, () => {
  console.log('Server is up on port ' + 3001)
})
