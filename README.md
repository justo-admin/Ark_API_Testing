# Ark_API_Testing
 

How to Run
-----------

On Windows:
------------
./runRobot.cmd 1 test E2E smoke false


Arguments:
-----------
arg1 = providerType (1/4/6/7/8)

arg2 = Env (test/dev/azuretest/tn)

arg3 = Test Suite Name (without .robot ext)

arg4 = smoke or reg

arg5 = headless mode true/false

arg6 =confId (not mandatory) (specify if you are using SendTPR or SMAApprove test suites)


More elaborated commands:
--------------------------

Windows:

python -m robot --variable Browser:Chrome --variable ProvType:1 --name "Smoke Suite for Provider 1" --variable fein:yes  --variable Env:test --variable Remote:false --variable headless:false --variable extConfId:xxxx --loglevel INFO --include smokeANDtestAND1 --exitonfailure --outputdir Output .\src\TestSuites\E2E.robot


Mac:

python3 -m robot --variable Browser:Chrome --variable ProvType:1 --name "Smoke Suite for Provider 1" --variable fein:yes  --variable Env:test --variable Remote:false --variable headless:false --variable extConfId:xxxx --loglevel INFO --include smokeANDtestAND1 --exitonfailure --outputdir Output ./src/TestSuites/E2E.robot


Installation on Windows:
-------------------------
Install Python 3.7 and add it to the PATH.

 Then run below command
 
 ./setup.cmd


Installation for Mac:-
-------------
Install Python 3.8 and add it to the PATH.

 Then run below command
 
 ./setup.sh


with pabot:
-------------
pabot --processes 2 --command python -m robot --variable Browser:Chrome --variable ProvType:1 --variable fein:yes --variable Env:test --variable Remote:false --variable headless:false --include smkANDMT --end-command --verbose --outputdir ./ ./src/Demo/DemoTestSuite.robot, ./src/TestSuites/ProviderEnrollment.robot
