import './FirstScreen.css';
import React, { useState, useEffect } from 'react';
import Table from '../Table/Table.js';
import DateTimePicker from 'react-datetime-picker';

function FirstScreen() {
    const allServices = ["Room", "Bar", "Restaurant", "Barbershop", "Gym", "Conference Room", "Sauna" ];

    const [modeToggleFirstScreen, setModeToggleFirstScreen] = useState(0);
    const [servicesArray, setServicesArray] = useState([]);
    const [filterServices, setFilterServices] = useState(allServices);
    const [filterCost, setFilterCost] = useState( ["0", "1000000"]);
    const [filterDate, setFilterDate] = useState([new Date(1990, 1, 1, 10, 0, 0), new Date(2025, 1, 1, 10, 0, 0)]);
    // let filterDate = ['2021-06-16', '2021-06-18'];
    
    

    const columns1 = ["idservice", "servicedescription", "needsregistration"];
    const columns2 = ["firstname", "lastname", "servicedescription", "chargedatetime", "cost", "description"];


    function twoDigits(d) {
      if(0 <= d && d < 10) return "0" + d.toString();
      if(-10 < d && d < 0) return "-0" + (-1*d).toString();
      return d.toString();
  }
  

    const dateToMysqlFormat = (date) => {
      // return date.toISOString().split('T')[0] + ' ' + date.toTimeString().split(' ')[0];
      return date.getUTCFullYear() + "-" + twoDigits(1 + date.getUTCMonth()) + "-" + twoDigits(date.getUTCDate()) + " " + twoDigits(date.getUTCHours()) + ":" + twoDigits(date.getUTCMinutes()) + ":" + twoDigits(date.getUTCSeconds());
    }
    // console.log(filterDate[0],filterDate[1])


    
    useEffect(() => getServices(), [])

    const getServices = () => {
      setModeToggleFirstScreen(0);
      fetch("http://localhost:3001/showservices")
      .then(res => res.json())
      .then(data => setServicesArray(data))
      .catch(err => console.log(err))
    }
  
    const getServiceVisits = () => {  
  
      setModeToggleFirstScreen(1);
  
      let filterServicesString = "";
      filterServices.forEach((service, i) => {
        filterServicesString +=  `&service=${service}`
      })
  
      try {
        dateToMysqlFormat(filterDate[0]);
        dateToMysqlFormat(filterDate[1]);
        console.log(dateToMysqlFormat(filterDate[0]),  dateToMysqlFormat(filterDate[1]))
      } catch (error) {
        console.log(error)
        alert("Please input valid dates");
        return;
      }
      
      let filterCostString =  `&lowcostlimit=${filterCost[0]}&highcostlimit=${filterCost[1]}`
  
      const tempDates = [ dateToMysqlFormat(filterDate[0]).replace(" ", "@"), dateToMysqlFormat(filterDate[1]).replace(" ", "@") ]
      let filterDateString =  `&firstdatelimit=${tempDates[0]}&finaldatelimit=${tempDates[1]}`
  
      console.log("http://localhost:3001/showservicevisits?" + filterServicesString + filterCostString + filterDateString)
  
      fetch("http://localhost:3001/showservicevisits?" + filterServicesString + filterCostString + filterDateString)
      .then(res => res.json())
      .then(data => setServicesArray(data))
      .catch(err => console.log(err))
    }

    const clickService = (serv) => {
      if(filterServices.includes(serv)) {
        const temp = filterServices.filter(val => val !== serv);
        setFilterServices(temp)
      }
      else {
        const temp = filterServices.concat([serv]);
        setFilterServices(temp)
      }
    }

    const serviceFilter = () => {
      return allServices.map((serv, i) => {
        return <div onClick={() => clickService(serv)} className="Service-Button">
          <div className="Service-Box" >
            {
              filterServices.includes(serv)
              ?
              <div className="Service-Box-On" >
              </div>  
              :
              null
            }
          </div>
          <div className="Service-Name">{serv}</div>
        </div>
      })
    }

    const onType0 = (event) => {
      if(!isNaN(event.nativeEvent.data)){
        setFilterCost([ event.target.value, filterCost[1]]) 
      }
    }

    const onType1 = (event) => {
      if(!isNaN(event.nativeEvent.data)){
        setFilterCost([filterCost[0], event.target.value]) 
      }
    }

    const onDateChange0 = (event) => {
      setFilterDate([event, filterDate[1]]) 
    }


    const onDateChange1 = (event) => {
      // // console.log(event, dateToMysqlFormat(event))
      // const temp = dateToMysqlFormat(event);
      setFilterDate([filterDate[0], event]) 
    }





    return(
        <div className="Body-Container">
            <div className="Mode-Toggle" >
              <div onClick={getServices} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 0 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show Services
              </div> 
              <div onClick={getServiceVisits} className="Mode-Toggle-Button" style={modeToggleFirstScreen === 1 ?{backgroundColor: "#214358", color:"white"} : {}} >
                Show Visits
              </div> 
            </div> 
            <div className="Table-And-Filters">
              {
                modeToggleFirstScreen === 0
                ?
                  null
                :
                <div className="Filters-Container" >
                  <div className="Filters-Title">Filters</div>
                  <div className="Service-Filter">
                    <div className="Subtitle">Services</div>  
                    {serviceFilter()}
                  </div>
                  <div className="Service-Filter">
                    <div className="Subtitle">Costs</div>  
                    <div style={{color:"white"}} className="Cost-Selector" >
                      From:  <input style={{width:60,backgroundColor:"#AEB8C4", borderRadius:5, marginLeft:15}} value={filterCost[0]} onChange={onType0} /> 
                    </div>
                    <div style={{color:"white"}} className="Cost-Selector" >
                    To: <input style={{width:60,backgroundColor:"#AEB8C4", borderRadius:5, marginLeft:15}} value={filterCost[1]} onChange={onType1} />
                    </div>
                  </div>
                  <div className="Service-Filter">
                    <div className="Subtitle">Dates</div>  
                    <div className="Date-Selector" >
                      From:  
                      <DateTimePicker
                                className="Date-Time-Picker"
                                onChange={onDateChange0}
                                value={filterDate[0]}
                                openWidgetsOnFocus={false}
                                maxDetail={"second"}
                              />
                    </div>
                    <div className="Date-Selector" >
                    To:
                    <DateTimePicker
                                className="Date-Time-Picker"
                                onChange={onDateChange1}
                                
                                value={filterDate[1]}
                                openWidgetsOnFocus={false}
                                maxDetail={"second"}
                              />
                    </div>
                  </div>
                </div>
              }
              <div className="Table-Container" >
                <Table data={servicesArray} columns={modeToggleFirstScreen === 0 ? columns1 : columns2} />
              </div>
            </div> 
        </div>
    )
    
}

export default FirstScreen;
