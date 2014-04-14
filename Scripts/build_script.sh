appname="sample1234"
target_name="$appname"
sdk="iphoneos"
certificate="iPhone Distribution: HCL Technologies Ltd"
project_dir="$1/$appname"
build_location="/Users/admin/Documents/Builds/$appname"

function deployToTestFlight    
{
curl http://testflightapp.com/api/builds.json -F file=@$build_location/$appname.ipa -F dsym=@$build_location/sym.root/Release-iphoneos/$appname.app.dSYM.zip -F api_token='439d831c7e49dbda0210fcc2821ac279_MTc2MzA5NTIwMTQtMDQtMDIgMDk6MjY6MzIuODYyNTg1' -F team_token='4eec8f2464f97aa31e333520338d7197_MzYyMjkzMjAxNC0wNC0wMiAwOTo0Mjo0Mi4xMzcxMTQ' -F notes='$appname uploaded via the testflight upload API' -F notify=True
}
function buildApp 
{

#!/bin/sh


if [ ! -d "$build_location" ]; then
mkdir -p "$build_location"/
fi


cd /Users/admin/Documents/sample1234/
xcodebuild -target "sample1234" OBJROOT="$build_location/obj.root" SYMROOT="$build_location/sym.root"


  
xcrun -sdk iphoneos PackageApplication -v "$build_location/sym.root/Release-iphoneos/sample1234.app" -o "$build_location/sample1234.ipa" --sign "$certificate"   

deployToTestFlight

}


buildApp
