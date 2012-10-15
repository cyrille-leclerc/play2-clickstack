# Play 2 ClickStack

## Creating an app and database

For this to work, you will need to have the CloudBees SDK installed. 
Here, we simply create a new application and database on CloudBees.

    bees app:create APP_NAME
    bees db:create DB_NAME
    bees app:bind -a APP_NAME -db DB_NAME -as ALIAS

## Preparing your play 2 project

You will need to change your database configuration in 
conf/application.conf to the following:

    db.default.driver=com.mysql.jdbc.Driver
    db.default.url="jdbc:"${mysql_url_ALIAS}
    db.default.user=${mysql_username_ALIAS}
    db.default.password=${mysql_password_ALIAS}

We also need to get the MySQL driver. To do this, we change our 
appDependencies in project/Build.scala to:

    val appDependencies = Seq(
    	"mysql" % "mysql-connector-java" % "5.1.18"
    // And then your other dependencies, if you have any...
    )


## Building and deploying your Play 2 application

You're almost done! Now, in your Play 2 project directory, execute the 
following:

    play stage
    zip ../MYAPP.zip .
    bees app:deploy -t play2 -a APP_NAME ../MYAPP.zip

And your app is now running on the cloud! 
