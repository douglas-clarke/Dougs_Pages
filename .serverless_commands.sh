#!/bin/bash
#sls print to see resolved yaml

slsh(){
    if [ $1 == 'new' ]
        then
        if [ $2 == 'function' ]
        then
            parent=$(cd ../ && pwd) 
            parent=${parent##*/}
            functionPath=""
            testPath=""
            if [ $parent == "services" ]
            then 
                functionPath = "src/functions"
                testPath = "src/tests/"
            elif [ pwd == "services"]
            then
                PS3='Select the service you would like to add this function to:'
                select serviceName in $(find -maxdepth 1 -type d)                 
                functionPath = "$serviceName/src/functions"
                testPath = "$serviceName/src/tests/"
            fi
            if [ $functionPath != "" ]
            then
                sls create function --function $3 --handler "$functionPath/$3.$3" --path $testPath
                echo "Created $3 function in $functionPath"
                echo "Created $3 function test in $testPath"
            else
                echo "This command must be used in a service directory or the services directory"
            fi        
        fi
        if [ $2 == 'service' ]
        then
            servicePath=""
            if [ pwd == "backend" ]
            then
                servicePath = "services/$3"
                serviceTemplatePath = "servicetemplate"
            elif [ pwd == "services" ]
            then
                servicePath = "$3"
                serviceTemplatePath = "../servicetemplate"
            fi
            if [ servicePath != ""]
            then
                sls create --template-path $serviceTemplatePath --path $servicePath
                rm -r $servicePath/templates/
                echo "Created $3 service in $servicePath" 
            fi
        fi
    fi
    if [ $1 == "test" ]
        then npx mocha src/tests
    fi
}