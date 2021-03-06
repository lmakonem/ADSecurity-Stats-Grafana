# ADSecurity-Stats-Grafana.  
![grafana stats](https://github.com/lmakonem/ADSecurity-Stats-Grafana/blob/main/grafana-ad-stats.png)

You can use this repo to monitor your AD Accounts stats as in this video: https://www.youtube.com/watch?v=lJBGwzfGhwI&feature=youtu.be\
  
  1)Download the powershell script and save it in your documents folder (or whatever location you choose)\
  2)Copy the telegraf.conf contents to your C:/Program Files/telegraf location (overrite the existing one) and update with your influxdb url,user and password and the location of the script\
  3)The metrics will be shipped to grafana, import the dashbord above from grafana here: https://grafana.com/grafana/dashboards/13195

### Install Telegraf in Windows steps

#  Important, run powershell as administrator
Go to the downloads folder  
`cd Downloads`

Then download telegraf zipped file and output to telegraf.zip  

`Invoke-WebRequest https://dl.influxdata.com/telegraf/releases/telegraf-1.15.3_windows_amd64.zip -OutFile telegraf.zip`

If step above fails, fix TLS error in powershell.  
`Net.ServicePointManager]::SecurityProtocol =[Net.SecurityProtocolType]::Tls12`

Extract the zipped file to C:/Program Files  
`Expand-Archive .\telegraf.zip 'C:\Program Files\'`

Go to 'C:\Program Files\'  
`cd 'C:\Program Files\'`

Rename the telegraf-1.15.3 to telegraf by right clicking and choosing rename option

Update the telegraf.conf file inside telegraf with information from my telegraf.conf in this repo. Make sure your influxdb ip address, user and password are set correctly. Also add the last part where i add the script as the video showed

Test telegraf configuration

`.\telegraf --config-directory 'C:\Program Files\telegraf\telegraf.conf' --test`

Install telegraf  
`.\telegraf --service install --config-directory 'C:\Program Files\telegraf\telegraf.conf'`
