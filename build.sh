buildPackage(){
    rm package.zip
    zip -r9 package.zip index.py
    base=`pwd`
    # Don't have python 3.6 installed? You should! That's what AWS are using.
    cd `which pip | xargs dirname`
    cd ../lib/python3.6/site-packages
    zip -rg $base/package.zip ./* --exclude "wheel/*" "setuptools/*" "pkg_resources/*" "pip/*" "easy_install.py" "__pycache__/*" "*.dist-info/*" "./**/__pycache__/*"
    cd $base
}
buildPackage
