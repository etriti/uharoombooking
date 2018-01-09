<?php
namespace mrbs;

/************************************************************************/

/**********
 * Timezone
 **********/

// A list of valid timezones can be found at http://php.net/manual/timezones.php

$timezone = "Europe/Paris";


/*******************
 * Database settings
 ******************/
// Which database system: "pgsql"=PostgreSQL, "mysql"=MySQL
$dbsys = "mysql";
// Hostname of database server. For pgsql, can use "" instead of localhost
// to use Unix Domain Sockets instead of TCP/IP. For mysql "localhost"
// tells the system to use Unix Domain Sockets, and $db_port will be ignored;
// if you want to force TCP connection you can use "127.0.0.1".
$db_host = "localhost";
// If you need to use a non standard port for the database connection you
// can uncomment the following line and specify the port number
// $db_port = 1234;
// Database name:
$db_database = "mrbs";

$db_login = "root";
// Database login password:
$db_password = '';
// Prefix for table names.  This will allow multiple installations where only
// one database is available
$db_tbl_prefix = "mrbs_";

$db_persist = FALSE;

$auth["type"]="db";


//$auth["admin"] [] = "etrit";
//$auth["admin"] [] = "florent";
//$auth["session"] = "php";
//$auth["type"] = "config";
//$auth["user"] ["etrit"] = "halili";
//$auth["user"] ["florent"] = "123";
//$auth["user"] ["test"] = "123";
// ne pas supprimer ces lignes au cas ou (par malheur) il n'y aurait plus aucun admin

$mrbs_company = "UHA 4.0";
