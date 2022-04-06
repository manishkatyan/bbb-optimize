#!/usr/bin/env node

const { spawn } = require("child_process");
const yargs = require('yargs/yargs')
const { hideBin } = require('yargs/helpers');
const fs = require('fs-extra')
const argv = yargs(hideBin(process.argv)).argv  
let PATH = '/usr/lib/node_modules/bigbluebutton-optimize'

try {
    if( ! argv["env-file"] ){
        const error = `
bbb-optimize utility.
                
bbb-analytics [--env-file]

--env-file        Path of env file`
        console.log(error)
        process.exit()
    }

    if (argv["env-file"]) {
        excuteCmd([`${PATH}/bin/utils/optimize.sh`, fs.realpathSync( argv["env-file"])])
    } 

} catch (error) {
    console.log(error)
}

function excuteCmd(cmd) {
    const runScript = spawn("bash", cmd);
    runScript.stdout.on("data", data => {
        console.log(`${data}`);
    });
    runScript.stderr.on("data", data => {
        console.log(`${data}`);
    });
    runScript.on('error', (error) => {
        console.log(`error: ${error.message}`);
    });
}