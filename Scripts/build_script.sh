appname="sampleproject"
target_name="$appname"
sdk="iphoneos"
certificate="iPhone Distribution: HCL Technologies Ltd"
project_dir="$1/$appname"
build_location="/Users/admin/Documents/Builds/$appname"

function deployToTestFlight 
{
curl http://testflightapp.com/api/builds.json -F file=@$build_location/$appname.ipa -F dsym=@$build_location/sym.root/Release-iphoneos/$appname.app.dSYM.zip -F api_token='439d831c7e49dbda0210fcc2821ac279_MTc2MzA5NTIwMTQtMDQtMDIgMDk6MjY6MzIuODYyNTg1' -F team_token='4eec8f2464f97aa31e333520338d7197_MzYyMjkzMjAxNC0wNC0wMiAwOTo0Mjo0Mi4xMzcxMTQ' -F notes='$appname uploaded via the testflight upload API' -F notify=True
}
function testflight
{
git remote add origin https://github.com/gtech123/sample.git
git push -u origin master
git pull --rebase upstream master
}
function buildApp 

{
#!/bin/sh 


if [ ! -d "$build_location" ]; then
mkdir -p "$build_location"/
fi


cd /Users/admin/Documents/sampleproject/
xcodebuild -target "$appname" OBJROOT="$build_location/obj.root" SYMROOT="$build_location/sym.root"

#zip dYSM file for distribution 
cd "$build_location/sym.root/Release-iphoneos/" || die "no such directory"
rm -f "$appname.app.dSYM.zip"
zip -r "$appname.app.dSYM.zip" "$appname.app.dSYM"
  
xcrun -sdk iphoneos PackageApplication -v "$build_location/sym.root/Release-iphoneos/$appname.app" -o "$build_location/$appname.ipa" --sign "$certificate"   
deployToTestFlight
testflight

}


buildApp