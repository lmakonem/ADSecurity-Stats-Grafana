# ADSecurity-Stats-Grafana

#Fix TLS error in powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 

####Install Telegraf in Windows

## *** Important, run powershell as administrator
#Go to the downloads folder.  
cd Downloads

Then download telegraf zipped file and output to telegraf.zip
Invoke-WebRequest https://dl.influxdata.com/telegraf/releases/telegraf-1.15.3_windows_amd64.zip -OutFile telegraf.zip   

#Extract the zipped file to C:/Program Files.  
Expand-Archive .\telegraf.zip 'C:\Program Files\' 

#Go to 'C:\Program Files\'. 
cd 'C:\Program Files\' 

#Rename the telegraf-1.15.3 to telegraf by right clicking and choosing rename option. 

#Update the telegraf.conf file inside telegraf with information from my telegraf.conf in this repo. Make sure your influxdb ip address, user and password are set correctly. Also add the last part where i add the script as the video showed

#Test telegraf configuration.  

.\telegraf --config-directory 'C:\Program Files\telegraf\telegraf.conf' --test   
#Install telegraf.  
.\telegraf --service install --config-directory 'C:\Program Files\telegraf\telegraf.conf
