import './FourthScreen.css';
import React, { useState, useEffect } from 'react';
import Table from '../Table/Table.js';

function FourthScreen() {

    const [ageGroup, setAgeGroup] = useState(0);
    const [firstTableData, setFirstTableData] = useState([]);
    const [secondTableData, setSecondTableData] = useState([]);
    const [thirdTableData, setThirdTableData] = useState([]);
    const [lastMonth, setLastMonth] = useState(true);

    useEffect(() => {
      const lastMonthStr = lastMonth ? "month" : "year";

      switch (ageGroup){
        case 0:
          press2040(lastMonthStr);
          break;
        case 1:
          press4160(lastMonthStr);
          break;
        case 2:
          press61(lastMonthStr);
          break;
    
      }

    }, [lastMonth, ageGroup])

    

    const columns0 = ["idplace", "placename", "visit_count"];
    const columns1 = ["servicedescription", "count"];
    const columns2 = ["servicedescription", "count"];

    // useEffect(() => press2040(), [])
  

    const press2040 = (lmonth) => {
      // setAgeGroup(0);

      //Get most visited places
      fetch("http://localhost:3001/showmostvisitedplaces?&ageGroup=2040&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setFirstTableData(data))
        .catch(err => console.log(err))

      //Get most frequenty used services
      fetch("http://localhost:3001/showmostusedservices?&ageGroup=2040&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setSecondTableData(data))
        .catch(err => console.log(err))
      
      //Get services with most customers
      fetch("http://localhost:3001/showserviceswithmostusers?&ageGroup=2040&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setThirdTableData(data))
        .catch(err => console.log(err))
    }

    const press4160 = (lmonth) => {
      // setAgeGroup(1);

      //Get most visited places
      fetch("http://localhost:3001/showmostvisitedplaces?&ageGroup=4160&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setFirstTableData(data))
        .catch(err => console.log(err))

      //Get most frequenty used services
      fetch("http://localhost:3001/showmostusedservices?&ageGroup=4160&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setSecondTableData(data))
        .catch(err => console.log(err))
      
      //Get services with most customers
      fetch("http://localhost:3001/showserviceswithmostusers?&ageGroup=4160&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setThirdTableData(data))
        .catch(err => console.log(err))
    }

    const press61 = (lmonth) => {
      // setAgeGroup(2);

      //Get most visited places
      fetch("http://localhost:3001/showmostvisitedplaces?&ageGroup=61&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setFirstTableData(data))
        .catch(err => console.log(err))

      //Get most frequenty used services
      fetch("http://localhost:3001/showmostusedservices?&ageGroup=61&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setSecondTableData(data))
        .catch(err => console.log(err))
      
      //Get services with most customers
      fetch("http://localhost:3001/showserviceswithmostusers?&ageGroup=61&lastMonth=" + lmonth)
        .then(res => res.json())
        .then(data => setThirdTableData(data))
        .catch(err => console.log(err))
    }




    // const showMostVisited2040 = () => {
    //     fetch("http://localhost:3001/showMostVisited2040?&ageGroup=" + )
    //     .then(res => res.json())
    //     .then(data => setFirstTableData(data))
    //     .catch(err => console.log(err))
    // }





    return(
        <div className="Body-Container">
            <div style={{marginTop: 15,height: 60, justifyContent:'center', alignItems:'center',  color: '#214358'}}>Age group</div>
            <div  style={{width: 700}} className="Mode-Toggle" >
              <div  onClick={() => setAgeGroup(0)} className="Mode-Toggle-But" style={ageGroup === 0 ?{backgroundColor: "#214358", color:"white"} : {}} >
                20 - 40
              </div> 
              <div  onClick={() => setAgeGroup(1)}  className="Mode-Toggle-But" style={ageGroup === 1 ?{backgroundColor: "#214358", color:"white"} : {}} >
                41 - 60
              </div>
              <div  onClick={() => setAgeGroup(2)}  className="Mode-Toggle-But" style={ageGroup === 2 ?{backgroundColor: "#214358", color:"white"} : {}} >
                61+
              </div> 
            </div> 
            <div  style={{width: 400, marginTop:15}} className="Mode-Toggle" >
              <div onClick={() => setLastMonth(true)} className="Mode-Toggle-Button" style={lastMonth ?{backgroundColor: "#214358", color:"white"} : {}} >
                Last Month
              </div> 
              <div onClick={() => setLastMonth(false)} className="Mode-Toggle-Button" style={!lastMonth ?{backgroundColor: "#214358", color:"white"} : {}} >
                Last year
              </div>
            </div> 
            <div style={{marginTop: 0}} className="Table-Space">

              <div style={{height: 450}} className="Node">
                <div style={{height:'10%', justifyContent:'center', alignItems:'center',  color: '#214358'}}>Most visited places</div>
                <div style={{ width:'100%', height:'90%', justifyContent:'center', alignItems:'center'}}>
                    <Table data={firstTableData} columns={columns0} />
                </div>
              </div>

              <div style={{height: 450}} className="Node">
                <div style={{height:'10%', justifyContent:'center', alignItems:'center',  color: '#214358'}}>Most frequently used services</div>
                <div style={{ width:'100%', height:'90%', justifyContent:'center', alignItems:'center'}}>
                    <Table data={secondTableData} columns={columns1} />
                </div>
              </div>

              <div style={{height: 450}} className="Node">
                <div style={{height:'10%', justifyContent:'center', alignItems:'center',  color: '#214358'}}>Services with most customers</div>
                <div style={{ width:'100%', height:'90%', justifyContent:'center', alignItems:'center'}}>
                    <Table data={thirdTableData} columns={columns2} />
                </div>
              </div>

            </div> 
        </div>
    )
    
}

export default FourthScreen;
