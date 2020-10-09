node ('master')
{
   stage('continuous download')
   {
       git 'https://github.com/bmanoj0509/BMK_NEW.git'
   }
   stage('continuous build')
   {
       sh 'mvn package '
   }
   stage('continuous deployment')
   {
       sh 'scp /home/ubuntu/.jenkins/workspace/DeclarativePipeline/webapp/target/webapp.war ubuntu@172.31.37.156:/var/lib/tomcat9/webapps/testapp.war'
   }
    stage('continuous testing')
   {
       git 'https://github.com/intelliqittrainings/FunctionalTesting.git'
       sh 'java -jar /home/ubuntu/.jenkins/workspace/ScriptedPipeline/testing.jar'
   }
   stage('continuous delivery')
   {
       sh 'scp /home/ubuntu/.jenkins/workspace/ScriptedPipeline/webapp/target/webapp.war ubuntu@172.31.42.244:/var/lib/tomcat9/webapps/prodapp.war'
   }
}
