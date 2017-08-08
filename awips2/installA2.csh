#!/bin/csh -f
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
echo "Copying the AWIPS-2 16.2.2 repo"
echo "=================================================================================="

cd $awipstarget

tar xvfz $mydir/a2update_16_2_2.tgz

#Moving the repo file into the yum.repos.d folder

if (-f /etc/yum.repos.d/awips2update.repo) then
	rm /etc/yum.repos.d/awips2update.repo
endif

cp a2update_16_2_2/awips2update.repo /etc/yum.repos.d/.

echo "=================================================================================="
echo "Installing 16.2.2 AWIPS-2"
echo "=================================================================================="

yum clean all

yum -y groupinstall "AWIPS II Visualize" --disablerepo='*' --enablerepo=awips2update'*'
echo "Installing Complete"

echo "Changing directory permissions"
chown -R awips:fxalpha /awips2
echo "Change Complete"

echo "Installing Probsevere and Tracking Meteogram Features"

/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ edu.wisc.ssec.cimss.viz.convectprob.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ gov.noaa.nws.viz.mdl.trackingmeteogram.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ gov.noaa.nws.mdl.viz.boundaryTool.common.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ gov.noaa.gsd.viz.ensemble.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ com.raytheon.uf.viz.bmh.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ com.raytheon.uf.viz.satellite.goesr.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ com.raytheon.uf.viz.dataplugin.nswrc.feature
/awips2/cave/caveInstall.sh /a2install/a2update_16_2_2/awips2/eclipse-repository/ com.raytheon.uf.viz.ohd.feature


echo "Checking for 16.2.2 NSHARP cave.ini parameter"

set cavecheck = `cat /awips2/cave/cave.ini | grep -Djna.nosys=true`

if ($cavecheck != "-Djna.nosys=true") then
	echo "NSHARP fix for cave.ini needs to be applied"
	sed -i '$ a -Djna.nosys=true' /awips2/cave/cave.ini
else
	echo "cave.ini parameters includes NSHARP fix"
endif


echo "=================================================================================="
echo "Installation complete, now you may begin the 16.2.2 WES-2 Bridge Installation"
echo "=================================================================================="

cd

rm -rf $awipstarget

yum clean all

