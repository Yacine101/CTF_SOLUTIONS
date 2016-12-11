
# Memory Analysis 
# [SECCON Japan 2016 Online Qualifications] [Forensics] 

TASK :

Solution:

First thing we do is see the Process List with Volatility :

One of the svcHOST.exe processes is a Fake , we have to execute more commands to be able to make a guess .
We see the Arguments of each process :


All the "svcHOST.exe"s are followed by an argument , only the one with PID 1776 is not so we export it to inspect it :


We pull the strings out of this process and we see that it's calling the internet explorer process , loading a page as it's said in the Task hint .


The website link is : "http://crattack.tistory.com/entry/Data-Science-import-pandas-as-pd" , but there's not FLAG in it .

We need to look in the hosts file , we bring it's memory address :

Then we dump it :

We open it to figure out the IP address's mapping for the DN "crattack.tistory.com" :

We change the URL to be "" and we get out FLAG .

Bingo .



