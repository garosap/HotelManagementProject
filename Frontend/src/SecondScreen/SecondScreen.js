import './SecondScreen.css';
import React, { useState, useEffect } from 'react';
import Table from '../Table/Table.js';

function SecondScreen() {

    const [modeToggleFirstScreen, setModeToggleFirstScreen] = useState(0);
    const [servicesArray, setServicesArray] = useState([]);
    
    

    const columns1 = ["servicedescription", "sales_per_service"];
    const columns2 = ["idnfc", "firstname", "lastname", "birthday", "iddocnumber", "iddoctype", "iddocauthority"];





    
    useEffect(() => getSalesPerService(), [])


    const getSalesPerService = () => {
        setModeToggleFirstScreen(0);
        fetch("http://localhost:3001/showsalesperservice")
        .then(res => res.json())
        .then(data => setServicesArray(data))
        .catch(err => console.log(err))
      }

    const getCustomerDetails = () => {
    setModeToggleFirstScreen(1);
    fetch("http://localhost:3001/showcustomerdetails")
    .then(res => res.json())
    .then(data => setServicesArray(data))
    .catch(err => console.log(err))
    }

  
  



    return(
        <div className="Body-Container">
            <div style={{width: 500}} className="Mode-Toggle" >
              <div onClick={getSalesPerService} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 0 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show sales per service
              </div> 
              <div onClick={getCustomerDetails} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 1 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show customer details
              </div> 
            </div> 
            <div className="Table-And-Filters">
              <div style={{width:1000}} className="Table-Container" >
                <Table data={servicesArray} columns={modeToggleFirstScreen === 0 ? columns1 : columns2} />
              </div>
            </div> 
        </div>
    )
    
}

export default SecondScreen;
