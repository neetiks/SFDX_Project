#!groovy
import groovy.json.JsonSlurperClassic

  @NonCPS
    def jsonParse(def json) 
    {
   	 	  new groovy.json.JsonSlurperClassic().parseText(json)
	  }

node {

	def toolbelt = tool 'toolbelt'
        def SFDX_AUTOUPDATE_DISABLE=true
        def BUILD_NUMBER=env.BUILD_NUMBER
        def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
                 
       def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
	
	def METATDATA_API_DIR= "mdapioutput"

      stage('checkout')
      {
	// when running in multi-branch job, one must issue this command      
        checkout scm
      }
          
      withCredentials([file(credentialsId: JWT_CRED_ID_FOR_PRIVATE_KEY_FILE, variable: 'jwt_key_file')]) 
          { 
             stage('Authorize hub org and set default CI scratch org')
               {              
		      rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:auth:jwt:grant --clientid ${HUB_ORG_CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG_USER_NAME} --jwtkeyfile '${jwt_key_file}' --setdefaultdevhubusername --instanceurl ${SFDC_LOGIN_URL}"
		      //rc=0	
		      if (rc != 0) { error 'hub org authorization failed' }	

		      // need to pull out assigned username
		     // rmsg = sh returnStdout: true, script: "'${toolbelt}/sfdx' force:org:create --definitionfile config/project-scratch-def.json --json --setdefaultusername"
		     rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:auth:sfdxurl:store -f CIScratchOrgLogin.txt -d -a CI"	
		      //def robj =jsonParse(rmsg)	   

		      //if (robj.status != 0) { error 'org creation failed: ' + robj.message }

		      //error 'robj.username: ' + robj.toString() + '  '+ robj.result.username+ '  ' + robj.result.orgId

		      robj = null                 
                                  	          
                          
            } //end of stage('Authorize hub org and set default CI scratch org')

            stage('Push To CI Scratch org') 
                {
                    rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:source:push -u CI"
                    //rc=0
                    if (rc != 0) 
                    {
                        error 'push to CI scratch org failed'
                    }
                    
                    // assign permission set
                    //rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:user:permset:assign --permsetname ${PERMISSION_SET} -u CI"
                    rc=0
                    if (rc != 0) 
                    {
                        error 'permission set assignment failed'
                    }
			
                }// end of stage('Push To CI Scratch org') 

		stage('Import Data To CI Scratch org') 
                {
                    rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:data:tree:import --sobjecttreefiles data/Account.json -u CI"
                    //rc=0
                    if (rc != 0) 
                    {
                        error 'Import Data  to CI scratch org failed'
                    }                    
                
                }// end of stage('Import Data To CI Scratch org') 
		  
                stage('Run Apex Test') 
                {
                    sh "mkdir -p ${RUN_ARTIFACT_DIR}"
                    timeout(time: 120, unit: 'SECONDS') 
                    {
                       rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:apex:test:run --testlevel RunLocalTests --outputdir '${RUN_ARTIFACT_DIR}' --wait 5 --codecoverage --resultformat human -u CI"
                       //rc=0
			if (rc != 0) 
                        {
                            error 'Apex Test run failed'
                        }
                    }
                }// end of  stage('Run Apex Test')

                stage('collect results') 
                {
                   junit keepLongStdio: true, testResults: 'tests/**/*-junit.xml'
             
		}// end of stage('collect results')  
                
                /*
                stage('Open the CI Scratch org') 
                {
                    rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:org:open -u CI"
                    if (rc != 0) 
                    {
                        error 'Opening of CI Scratch org failed'
                    }
                }// end of stage('Open the CI Scratch org')  
                */
		/*  
                stage('Delete CI Scratch org') 
                {

                  timeout(time: 120, unit: 'SECONDS') 
                  {         
                        rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:org:delete -u CI --noprompt"
                        rc=0
			if (rc != 0) 
                        {
                            error 'org deletion request failed'
                        }                    
                  }// end of timeout
               }// end of stage('Delete Test Org')   
	    */
		  
           stage('Convert App Using Metadata API') 
                {
                  timeout(time: 120, unit: 'SECONDS') 
                  {    
			rc = sh returnStatus: true, script: "mkdir ${METATDATA_API_DIR} || true"
			if (rc != 0) 
                        {
                            error 'Directory creation failed'
                        }  
			  
 			rc = sh returnStatus: true, script: "rm -rf ${METATDATA_API_DIR}/* || true"
			if (rc != 0) 
                        {
                            error 'Directory creation failed'
                        }  
			rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:source:convert -d ${METATDATA_API_DIR}/"
			if (rc != 0) 
                        {
                            error 'Artifacts to Metadata conversion failed'
                        } 			  
                  }// end of timeout
               }// end of stage('Convert App Using Metadata API')
		  
	    stage('Deploy To QA Environment') 
                {
                  timeout(time: 120, unit: 'SECONDS') 
                  {         
                        rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:auth:sfdxurl:store -f QALogin.txt -d -a QA"	
		       
		       if (rc != 0) 
                        {
                            error 'QA Enviromnent login failed'
                        }   
			  
			//rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:org:list --all"
			rc=0
			if (rc != 0) 
                        {
                            error 'Org listing failed'
                        }     
			  
			  rc = sh returnStatus: true, script: "'${toolbelt}/sfdx' force:mdapi:deploy -d ${METATDATA_API_DIR}/ -u QA -w 2"
			if (rc != 0) 
                        {
                            error 'Deployment To QA environment failed'
                        }     		  
                  }// end of timeout
               }// end of stage('Deploy To QA Environment')
		  
	 
 	}// end of withCredentials
	
	 
	
}// end of node
