# Play 2 ClickStack

## Creating an app and database

For this to work, you will need to have the CloudBees SDK installed. 
Here, we simply create a new application and database on CloudBees.

    bees app:create APP_NAME
    bees db:create DB_NAME
    bees app:bind -a APP_NAME -db DB_NAME -as MYDB

Where `MYDB` is the name of your database alias. This name will be used for the System Properties exposed to the application with the database configuration details.

(if you don't want a DB, skip the last 2 lines, of course!)

## Preparing your play 2 project

If you are using CloudBees DBs, you will need to change your database 
configuration in conf/application.conf to the following (the ALIAS part
will always be upper case, and refers to the ALIAS specified with 
`bees app:bind`, as described above)

    db.default.driver=com.mysql.jdbc.Driver
    db.default.url="jdbc:"${DATABASE_URL_MYDB}
    db.default.user=${DATABASE_USERNAME_MYDB}
    db.default.password=${DATABASE_PASSWORD_MYDB}


The quotes must cover `"jdbc:"` and *not* the variable substitution part 
(Or otherwise it won't be substituted.)

We also need to get the MySQL driver. To do this, we change our 
appDependencies in project/Build.scala to:

    val appDependencies = Seq(
    	"mysql" % "mysql-connector-java" % "5.1.21"
    // And then your other dependencies, if you have any...
    )


## Building and deploying your Play 2 application

You're almost done! Now, in your Play 2 project directory, execute the 
following:

    play clean dist
    bees app:deploy -t play2 -a APP_NAME dist/*.zip

And your app is now running on the cloud! 
