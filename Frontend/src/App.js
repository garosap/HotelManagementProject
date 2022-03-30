import './App.css';
import React, { useState } from 'react';
import FirstScreen from './FirstScreen/FirstScreen.js';
import SecondScreen from './SecondScreen/SecondScreen.js';
import ThirdScreen from './ThirdScreen/ThirdScreen.js';
import FourthScreen from './FourthScreen/FourthScreen.js';


function App() {

  const [page, setPage] = useState(0);


  return (
    <div className="App">
      <div className="Header">
          <div className="NavBar">
            <div onClick={() => setPage(0)} style={{color: page === 0 ? "#071330" : ""}} className="NavButton">
              Services & visits
            </div>  
            <div onClick={() => setPage(1)} style={{color: page === 1 ? "#071330" : ""}} className="NavButton">
             Views
            </div> 
            <div onClick={() => setPage(2)} style={{color: page === 2 ? "#071330" : ""}} className="NavButton">
            Covid tracing
            </div> 
            <div onClick={() => setPage(3)} style={{color: page === 3 ? "#071330" : ""}} className="NavButton">
            Data per age group
            </div> 
          </div>  
      </div>
        {
          page === 0
          ?    
          <FirstScreen />
          :
          null
        }
        {
          page === 1
          ?    
          <SecondScreen />          :
          null
        }
        {
          page === 2
          ?    
          <ThirdScreen />
          :
          null
        }
        {
          page === 3
          ?    
          <FourthScreen />
          :
          null
        }
        
    </div>
  );
}

export default App;
