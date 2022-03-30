import './ThirdScreen.css';
import React, { useState, useEffect } from 'react';
import Table from '../Table/Table.js';

function ThirdScreen() {

    const [modeToggleFirstScreen, setModeToggleFirstScreen] = useState(0);
    const [servicesArray, setServicesArray] = useState([]);
    const [idnfc, setIdNfc] = useState(0);

    

    const columns1 = [ "idplace", "placename", "placedescription", "entrydatetime", "exitdatetime"];
    const columns2 = ["idnfc", "firstname", "lastname", "idplace", "entrydatetime", "exitdatetime"];


    
    useEffect(() => showplacesFromInfectedPerson(), [])


    const showplacesFromInfectedPerson = () => {
        setModeToggleFirstScreen(0);
        fetch("http://localhost:3001/showplacesfrominfectedperson?&idnfc="+idnfc)
        .then(res => res.json())
        .then(data => setServicesArray(data))
        .catch(err => console.log(err))
    }

    const getCustomerDetails = () => {
        setModeToggleFirstScreen(1);
        fetch("http://localhost:3001/showpersonsfrominfectedperson?&idnfc="+idnfc)
        .then(res => res.json())
        .then(data => setServicesArray(data))
        .catch(err => console.log(err))
    }

    const onType0 = (event) => {
        if(!isNaN(event.nativeEvent.data)){
          setIdNfc(event.target.value) 
        }
      }
  
  
  



    return(
        <div className="Body-Container">

            <div  className="Mode-Toggle" >
                <div className="Cost-Selector" >
                      Type idfnc of infected customer:  <input style={{width:60,backgroundColor:"Mode-Toggle", borderRadius:5, marginLeft:15}} value={idnfc} onChange={onType0} /> 
                </div>
            </div> 

            <div style={{width: 600}} className="Mode-Toggle" >
              <div onClick={showplacesFromInfectedPerson} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 0 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show places the infected person visited
              </div> 
              <div onClick={getCustomerDetails} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 1 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show customer at risk
              </div> 
            </div> 
            <div style={{marginTop:50}} className="Table-And-Filters">
              <div style={{width:1000}} className="Table-Container" >
                <Table data={servicesArray} columns={modeToggleFirstScreen === 0 ? columns1 : columns2} />
              </div>
            </div> 
        </div>
    )
    
}

export default ThirdScreen;
