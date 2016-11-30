

This challenge is about Linux/Unix File System , after mapping the image.bin we find ourselves with  3 important files :

  1- The check_32 that checks if the permissions are well set .
  2- The user permission matrix . 
  3- The passwd that maps each user in the matrix with the UID .

The three files look like this :

    Execution of check_32 as root :
	
	![Alt text](/images/EXECUTION_ROOT.png?raw=true "Optional Title")


    Matrix of permissions :
	
	![Alt text](https://raw.githubusercontent.com/Yacine101/CTF_SOLUTIONS/master/images/ACCESS_MATRIX.png "Optional Title")
  
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

The solution B goes like this : 

      We open GDB , set a breakpoint on the setfsuid32 function (that changes the userID before checking for permissions) and change files ownership before each check and each change of UID . Before this all files must have read access for their owner so we do a :
      "chmod 400 * "
      
      Here are the ScreenShot :
      
      
	

  
  
