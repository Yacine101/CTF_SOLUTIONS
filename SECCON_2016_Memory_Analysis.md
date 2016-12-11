
# Memory Analysis 
# [SECCON Japan 2016 Online Qualifications] [Forensics] 

TASK :

![Alt text](/images/TASK_FOR100.png?raw=true "Optional Title")

Solution:

First thing we do is see the Process List with Volatility :

![Alt text](/images/PSLIST.png?raw=true "Optional Title")

One of the svcHOST.exe processes is a Fake , we have to execute more commands to be able to make a guess .
We search for the command to prints Process Arguments : 

![Alt text](/images/DISPLAY_ARGS.png?raw=true "Optional Title")

All the "svcHOST.exe"s are followed by an argument , only the one with PID 1776 is not :

![Alt text](/images/FAKE_SVCHOST.png?raw=true "Optional Title")

So we export it to inspect it :

![Alt text](/images/DUMP_SVCHOST.png?raw=true "Optional Title")

We pull the strings out of this process and we see that it's calling the internet explorer process , loading a page as it's said in the Task hint .

![Alt text](/images/WEBSITE_RUN.png?raw=true "Optional Title")

The website link is : "http://crattack.tistory.com/entry/Data-Science-import-pandas-as-pd" , but there's no FLAG in it .

We need to look in the hosts file , we bring it's memory address :

![Alt text](/images/GET_ADDRESS.png?raw=true "Optional Title")

Then we dump it :

![Alt text](/images/HOSTS_DUMPING.png?raw=true "Optional Title")

We open it to figure out the IP address's mapping for the DN "crattack.tistory.com" :

![Alt text](/images/HOSTS.png?raw=true "Optional Title")

We change the URL to be "http://153.127.200.178/entry/Data-Science-import-pandas-as-pd" and we get out FLAG .

Bingo .



