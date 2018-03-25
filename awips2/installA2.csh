#!/bin/csh -f
#
# Modified install script for the Public 17.1.1 version pulled from https://collaborate2.nws.noaa.gov/partners/17.1.1/17.1.1_rpms-NBL.tgz
#
# a2install_17_1_1_public.tgz tarball includes awips2update.repo next to the child "awips2" directory from 17.1.1_rpms-NBL.tgz. No modifications were performed on 17.1.1_rpms-NBL.tgz
#

set awipstarget = /a2install

set mydir = `pwd`

set mydirCheck = `echo $mydir | cut -f2 -d /`

set user = `whoami`


if ($user != 'root') then
   echo "you must be the root user to run this installer"
   exit
endif

echo "=================================================================================="
echo "Creating the /a2install Folder if it doesn't exist already"
echo "=================================================================================="

#Create the /a2install folder, take out in future installers

if (! -d /a2install) then
	mkdir /a2install
else
	echo "/a2install folder already exists!"
endif



echo "=================================================================================="
echo "Copying the AWIPS-2 17.1.1 Public Version repo"
echo "=================================================================================="

cd $awipstarget

tar xvfz $mydir/a2install_17_1_1_public.tgz

chown -R root:root a2install_17_1_1_public

#Moving the repo file into the yum.repos.d folder

if (-f /etc/yum.repos.d/awips2update.repo) then
	rm /etc/yum.repos.d/awips2update.repo
endif

cp a2install_17_1_1_public/awips2update.repo /etc/yum.repos.d/.


echo "=================================================================================="
echo "Installing 17.1.1 Public Version AWIPS-2"
echo "=================================================================================="

yum clean all

yum -y groupinstall "AWIPS II Visualize" --disablerepo='*' --enablerepo=awips2update'*'
echo "Installing Complete"

echo "Changing directory permissions"
chown -R awips:fxalpha /awips2
echo "Change Complete"


echo "Checking for 17.1.1 NSHARP cave.ini parameter"

set cavecheck = `cat /awips2/cave/cave.ini | grep Djna.nosys=true`

if ($cavecheck != "Djna.nosys=true") then
	echo "NSHARP fix for cave.ini needs to be applied"
	sed -i '$ a -Djna.nosys=true' /awips2/cave/cave.ini
else
	echo "cave.ini parameters includes NSHARP fix"
endif


echo "=================================================================================="
echo "Installation complete"
echo "=================================================================================="

cd

rm -rf $awipstarget

yum clean all

