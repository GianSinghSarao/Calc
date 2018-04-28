#! /bin/bash
printf 'This Script Will Create Binary Executable Files Of The Calculator App, For Use On Linux Systems. \n'
printf '\033[0;34m==> \033[0mVerifying NPM Is Installed In The Path \n'
function path {
  local return_=0
  type $1 >/dev/null 2>&1 || { local return_=1; }
  echo $return_
}
if [[ $(path npm) == 0 ]] 
then 
  printf 'NPM Is Installed In The Path \n'
  NPM='npm'
else 
  printf '\033[0;31mError: \033[0mNPM Isn'\''t In The Path!! \n'
  printf 'NPM Is Required To Get This Apps'\'' Dependencies \n'
  printf 'If NPM Is Installed Maybe It Got Displaced From The Path \n'
  read -p 'If So, Enter The Path To NPM. Or Leave It Blank To Exit: ' temp
  printf '\n'
  if [[ $temp ]] 
  then 
    NPM=$temp
  else
    printf 'Exiting Script... \n'
    exit
  fi
fi 
while [ true ]
do
  printf '\033[0;34m==> \033[0mVerifying NPM Version => 5.6.0 \n'
  temp=$($NPM -v)
  temp=${temp:0:3}
  printf $temp'\n'
  if [[ $(printf '$temp 5.6' | awk '{print ($1 >= $2)}') ]] 
  then
    printf 'NPM Version Is => 5.6.0 \n'
    printf '\033[0;32m==> \033[0mInstalling Dev Dependencies \n'
    printf '\033[1;33m[Output From NPM] \033[0m\n' 
    $NPM i -g electron-packager
    printf '\033[0;32m==> \033[0mInstalling App Dependencies \n'
    printf '\033[1;33m[Output From NPM] \033[0m\n'
    cd src
    $NPM i
    printf '\033[0;32m==> \033[0mCreating Binary Files For \033[0;32mCalculator \033[0m\n'
    printf '\033[1;33m[Output From Electron Packager] \033[0m\n'
    electron-packager . --arch="all" --asar --out="../bin/" --executableName="Calc" --overwrite
    cd ..
    break
  else
    printf 'NPM Is Too Old! \n'
    read -p 'Update NPM? (y)/n' temp
    if [ ${temp:0:1} == 'y' || $temp == '' ]
    then
      printf 'Updating NPM. \n'
      printf '\033[1;33m[Output From NPM] \033[0m\n'
      $NPM i npm -g
      continue 
    else
      printf 'Exiting Script... \n'
      exit
    fi
  fi
done