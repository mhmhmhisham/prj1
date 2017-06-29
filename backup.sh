#!/bin/sh
## Backup script #######
## authur mh ##



### Function for checking Backup existance########
ckp() 
{
d=$(date +%F)
echo $d
echo "Checking whether backup directory exist or not"
sleep 2

if [ -d /backup/$name-$d ] 
 then 
 echo "Backup directory exist.. Checking whether valid backup exist or not.."
 sleep 2

  if [ -s /backup/$name-$d/$name.tar.gz ]
   then 
   echo "Backup exist.. Do you wish to overwrite it:"
   overwrite $name $d
  else
   echo "Backup Location doesn't exist..Proceeding..."
   sleep 1
   bkp $name $d  
  fi

else
 echo "Backup directory doesn't exit.. Proceeding with creation"
 sleep 1
 bkp $name $d
fi  
}


### Function for overwriting existing backup######
overwrite()
{
echo "Enter your option y/n:"
read option
  case $option in 
   y)
   echo "Overwriting existing backup as requested..."
   sleep 1
   bkp $name $d
   ;;
   n) 
   echo "Exiting as requested.."
   sleep 1
   ;;
   *)
   echo "sorry wrong option..Please try again:"
   overwrite
   ;; 
  esac

} 

### Function for backup generation ####
bkp()
{
#d=$(date +%F)
echo "argument:" $name
rm -rf /backup/$name-$d
mkdir /backup/$name-$d
tar -czf /backup/$name-$d/$1.tar.gz $name
echo "Backup created successfully..check the below details"
sleep 2
ls -ld /backup/$name-$d
ls -la /backup/$name-$d/
}



val()
{
 echo "Thankyou, please wait while we confirm existance of the given file/directory..."
 sleep 2
 if [ -d $name ]
  then 
  echo "Directory exit, Proceeding with backup generation..."
  sleep 1
## function name
  ckp $name
 elif [ -s $name ]
  then 
  echo "File exist, Proceeding with bakcup generation..."
  sleep 1
### function name
  ckp $name
 else
  echo "No such file/directory..Sorry existing"
  exit     
 fi 
}

echo "argumetns:" $#
if [ $# != 1 ]
 then
 echo "Not given any file/directory name to be backuped"
 echo "Please enter the name of file/directory you wish to backup as below:"
 read name
 val $name
else
 name=$1
 val $name
fi
