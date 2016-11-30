#  SOLUTION A : 

This challenge is about Linux/Unix File System , after mapping the image.bin we find ourselves with  3 important files :

  1- The check_32 that checks if the permissions are well set .
  2- The user permission matrix . 
  3- The passwd that maps each user in the matrix with the UID .

The three files look like this :

Execution of check_32 as root :
	
![Alt text](/images/EXECUTION_ROOT.png?raw=true "Optional Title")


Matrix of permissions :
	
![Alt text](/images/ACCESS_MATRIX.png?raw=true "Optional Title")
  
Passwd : 

![Alt text](/images/PASSWD.png?raw=true "Optional Title")

 
Before going into how the check_32 file works and how it checks for the permissions , one of the solutions is to : 

- Create groups for each combination of users , example : group10101 has only mabel stan and saas to it , while group01100 has wendy and stan in it only .
- Give to all the files group reading permission with : "chmod g+r *" 

On execution of check_32 we find that no user has access to the files , why ? Maybe the program checks for file read capability judging by the file owner . If this is true , Linux can't give 2 people ownership !! This will be a problem .

We need to confirm this first :

  We run strace "sudo strace ./check_32" to see the functions used .
  The functions are : "setfsuid32" then "access" then "open" . 
  
After checking for the outputs and the functions used , it seems that the group solution should've worked , without further sticking to the 1st solution we'll go for the second ! using GDB !

# SOLUTION B :

The solution B goes like this : 

We open GDB , set a breakpoint on the setfsuid32 function (that changes the userID before checking for permissions) and change files ownership , in other words :  breaking before checks to change files ownerships . 
Before this all files must have read access for their owner so we do a : "chmod 400 * "
      
1- We open the check_32 ELF file with gdb and list the functions of the program :

![Alt text](/images/OPEN_FILE.png?raw=true "Optional Title")

2- We set a breakpoint in the function : 
      
![Alt text](/images/BREAKPOINT.png?raw=true "Optional Title")

3- We run the program until the breakpoint :

![Alt text](/images/RUNBP.png?raw=true "Optional Title")

4- We change the owner of the file to the user of the UID in the breakpoint (first time 1004) , then we let the program check .

![Alt text](/images/CHOWN1.png?raw=true "Optional Title")

![Alt text](/images/CHECK1.png?raw=true "Optional Title")

5- Repeat for userID:1005 and 1006 and 1007 .

![Alt text](/images/FINALCHOWN.png?raw=true "Optional Title")

6- Finally we get our flag !!
![Alt text](/images/OUR_FLAG.png?raw=true "Optional Title")


	

  
  
