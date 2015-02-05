echo Removing old repository...
rm -rf .git
echo Renaming project to $1...
cd ..
mv gulp-starter $1
cd $1
echo pwd

echo "Initialing new project as $1"
git init
git add .
git commit -m "Initial commit of a new project"
git remote add origin git@github.com:adampash/$1.git
git push -u origin master
npm install
