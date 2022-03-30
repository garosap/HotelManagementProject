import './Table.css';
import React, { useState } from 'react';


function Table({ data, columns }) {

    const createFirstRow = () => {
        // const keys = Object.keys(data[0]);
        // console.log(keys)

        return columns.map((col, i) => {
            return <div style={{width: (100/columns.length).toString() + "%", borderLeft: i=== 0 ? 0 : null }} className="First-Row-Box">{col}</div>
        }) 
    }
    
    const showData = () => {
        // console.log("data is", data)
        return data.map((item, i) => {
            return <div id={(i%2) !== 0 ? "dark" : "" } className="Row-Container">
                    {createRow(item)}
                </div>
        })
    }

    function twoDigits(d) {
        if(0 <= d && d < 10) return "0" + d.toString();
        if(-10 < d && d < 0) return "-0" + (-1*d).toString();
        return d.toString();
    }
  
    

    const dateToMysqlFormat = (date) => {
        // return date.toISOString().split('T')[0] + ' ' + date.toTimeString().split(' ')[0];
        return date.getUTCFullYear() + "-" + twoDigits(1 + date.getUTCMonth()) + "-" + twoDigits(date.getUTCDate()) + " " + twoDigits(date.getUTCHours()) + ":" + twoDigits(date.getUTCMinutes()) + ":" + twoDigits(date.getUTCSeconds());
      }

    const convertDateToMysql = (date) => {
        let temp = new Date(date);
        return dateToMysqlFormat(temp)
    }


    function isValidDate(value) {
        if(typeof value != 'string' && !(value instanceof String)) return false
        return value.charAt(4) == '-' && value.charAt(7) == '-' && value.charAt(10) == 'T'
    }
    

    const createRow = (row) => {

        return columns.map((col, i) => {
            let data = row[col];
            if(isValidDate(data)) data = convertDateToMysql(data)
            return <div style={{width: (100/columns.length).toString() + "%", borderLeft: i=== 0 ? 0 : null }} className="Row-Box">{data}</div>
        }) 
    }


    return (
        <div  className="Container">
            <div id="dark" className="Row-Container">
                    {createFirstRow()}
                </div>
            <div className="Scroll">
                {showData()}
            </div>
        </div>    
    )
}

export default Table;
