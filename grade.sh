CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grader

git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -e ListExamples.java ]]
then 
    echo 'File found!'
else 
    echo 'File not found!'
    exit 1
fi

echo 'Testing file...'

cd ..

mkdir grader
cp student-submission/ListExamples.java grader
cp TestListExamples.java grader

cd grader 

javac -cp $CPATH *.java
if [[ $? -ne 0 ]]
then 
    echo 'Compiling failed!'
    exit 1
else
    echo 'Successfully compiled!'
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > out.txt 2>&1 

if [[ $? -ne 0 ]]
then 
    echo 'Tests failed!'
    exit 1
else 
    echo 'All tests passed!'
fi

