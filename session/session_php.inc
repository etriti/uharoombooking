<?php
namespace mrbs;

/*****************************************************************************\
*                                                                             *
*   File name       session_php.inc                                           *
*                                                                             *
*   Description     Use PHP built-in sessions handling                        *
*                                                                             *
*   Notes           To use this authentication scheme, set in                 *
*                   config.inc.php:                                           *
*                       $auth["session"]  = "php";                            *
*                                                                             *
\*****************************************************************************/

global $PHP_SELF, $auth;

// Get non-standard form variables
$Action = get_form_var('Action', 'string');
$NewUserName = get_form_var('NewUserName', 'string');
$NewUserPassword = get_form_var('NewUserPassword', 'string');
$TargetURL = get_form_var('TargetURL', 'string');
$returl = get_form_var('returl', 'string');

if (isset($cookie_path_override))
{
  $cookie_path = $cookie_path_override;
}
else
{
  $cookie_path = $PHP_SELF;
  // Strip off everything after the last '/' in $PHP_SELF
  $cookie_path = preg_replace('/[^\/]*$/', '', $cookie_path);
}

if (!isset($auth["session_php"]["session_expire_time"]))
{
  // Default to the behaviour of previous versions of mrbs, use only
  // session cookies - no persistent cookie.
  $auth["session_php"]["session_expire_time"] = 0;
}

session_name("mrbs_SESSID");  // call before session_set_cookie_params() - see PHP manual
session_set_cookie_params($auth["session_php"]["session_expire_time"],
                          $cookie_path);

// Checking the result of session_start() is not very reliable.   Before PHP 5.3.0
// it always returned TRUE.   Even after 5.3.0 it seems to return TRUE even if the
// session_save_path is not writable.  A warning is generated, but session_start()
// still returns TRUE.
if (FALSE === session_start())
{
  trigger_error("mrbs: could not start session", E_USER_WARNING);
  fatal_error("mrbs: server configuration error.");
}

// Check to see if we've been inactive for longer than allowed and if so logout
// the user
if (!empty($auth["session_php"]["inactivity_expire_time"]))
{
  if (isset($_SESSION['LastActivity']) &&
      ((time() - $_SESSION['LastActivity']) > $auth["session_php"]["inactivity_expire_time"]))
  {
    unset($_SESSION["UserName"]);
  }
  // Ajax requests don't count as activity, unless it's the special Ajax request used
  // to record client side activity
  $ajax = get_form_var('ajax', 'int');
  $activity = get_form_var('activity', 'int');
  if ($activity || !$ajax || !isset($_SESSION['LastActivity']))
  {
    $_SESSION['LastActivity'] = time();
  }
}

/*
  Target of the form with sets the URL argument "Action=SetName".
  Will eventually return to URL argument "TargetURL=whatever".
*/
if (isset($Action) && ($Action == "SetName"))
{
  /* First make sure the password is valid */
  if ($NewUserName == "")
  {

    // Unset the session variables
    session_unset();
    session_destroy();
  }
  else
  {
    if (!authValidateUser($NewUserName, $NewUserPassword))
    {
      print_header(0, 0, 0, 0, "");
      echo "<div class='alert alert-danger' role='alert'>";
      echo "<span class='sr-only'>Error:</span>";
      echo "<p>"."<span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span> ".get_vocab('unknown_user')."</p>\n";
      echo "</div>";

      printLoginForm($TargetURL);
      exit();
    }

    $_SESSION["UserName"] = $NewUserName;
  }
  // preserve the original $HTTP_REFERER by sending it as a GET parameter
  if (!empty($returl))
  {
    // check to see whether there's a query string already
    if (strpos($TargetURL, '?') === false)
    {
      $TargetURL .= "?returl=" . urlencode($returl);
    }
    else
    {
      $TargetURL .= "&returl=" . urlencode($returl);
    }
  }
  // Problems have been reported on Windows IIS with session data not being
  // written out without a call to session_write_close()
  session_write_close();
  header ("Location: $TargetURL"); /* Redirect browser to initial page */
  /* Note HTTP 1.1 mandates an absolute URL. Most modern browsers support relative URLs,
    which allows to work around problems with DNS inconsistencies in the server name.
    Anyway, if the browser cannot redirect automatically, the manual link below will work. */
  print_header(0, 0, 0, 0, "");
  echo "<br>\n";
  echo "<p>Please click <a href=\"".htmlspecialchars($TargetURL)."\">here</a> if you're not redirected automatically to the page you requested.</p>\n";

  // Print footer and exit
  print_footer(TRUE);
}

/*
  Display the login form. Used by two routines below.
  Will eventually return to $TargetURL.
*/
function printLoginForm($TargetURL)
{
  global $HTTP_REFERER;
  global $returl;
?>
<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
<div class="panel panel-default bordure-panel">
  <div class="panel-heading panel-head"><h3 class="page-titre"><?php echo get_vocab("please_login") ?></h3></div>
<div class="panel-body panel-corp" >
<form class="form_general" id="logon" method="post" action="<?php echo htmlspecialchars(this_page()) ?>">

    <div class="form-group">
      <label for="NewUserName"><?php echo get_vocab("users.name") ?>:</label>
      <input class="form-control" type="text" id="NewUserName" name="NewUserName" required>
    </div>
    <div class="form-group">
      <label for="NewUserPassword"><?php echo get_vocab("users.password") ?>:</label>
      <input class="form-control" type="password" id="NewUserPassword" name="NewUserPassword" required>
    </div>
    <?php
    // We need to preserve the original calling page, so that it's there when we eventually get
    // to the TargetURL (especially if that's edit_entry.php).  If this is the first time through then $HTTP_REFERER holds
    // the original caller.    If this is the second time through we will have stored it in $returl.
    if (!isset($returl))
    {
      $returl = isset($HTTP_REFERER) ? $HTTP_REFERER : "";
    }
    echo "<input type=\"hidden\" name=\"returl\" value=\"" . htmlspecialchars($returl) . "\">\n";
    ?>
    <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
    <input type="hidden" name="Action" value="SetName">
    <div class="col-md-12 text-right" id="logon_submit">
      <input class="btn btn-primary" type="submit" value=" <?php echo get_vocab('login') ?> ">
    </div>
</form>
</div>
</div>
</div>
</div>
<?php
  echo "</div>";  // Close of the contents div
  // Print footer and exit
  print_footer(TRUE);
}

/*
  Target of the form with sets the URL argument "Action=QueryName".
  Will eventually return to URL argument "TargetURL=whatever".
*/
if (isset($Action) && ($Action == "QueryName"))
{
  print_header(0, 0, 0, 0, "");
  printLoginForm($TargetURL);
  exit();
}

/* authGet()
 *
 * Request the user name/password
 *
 * Returns: Nothing
 */
function authGet()
{
  global $PHP_SELF, $QUERY_STRING;

  print_header(0, 0, 0, 0, "");

  echo "<div class='alert alert-danger' role='alert'>";
  echo "<span class='sr-only'>Error:</span>";
  echo "<p>"."<span class='glyphicon glyphicon-exclamation-sign' aria-hidden='true'></span> ".get_vocab("norights")."</p>\n";
  echo "</div>";


  $TargetURL = this_page();
  if (isset($QUERY_STRING))
  {
    $TargetURL = $TargetURL . "?" . $QUERY_STRING;
  }
  printLoginForm($TargetURL);

  exit();
}

function getUserName()
{
  if (isset($_SESSION["UserName"]) && ($_SESSION["UserName"] !== ''))
  {
    return $_SESSION["UserName"];
  }

  return NULL;
}

// Print the logon entry on the top banner.
function PrintLogonBox()
{
  global $PHP_SELF, $QUERY_STRING, $user_list_link, $day, $month, $year;

  $TargetURL = this_page();
  if (isset($url_base) && ($url_base !== ''))
  {
    $TargetURL = $url_base . '/' . $TargetURL;
  }
  if (isset($QUERY_STRING))
  {
    $TargetURL = $TargetURL . "?" . $QUERY_STRING;
  }
  $user=getUserName();
  if (isset($user))
  {
    // words 'you are xxxx' becomes a link to the
    // report page with only entries created by xxx. Past entries are not
    // displayed but this can be changed
    $search_string = "report.php?from_day=$day&amp;from_month=$month&amp;".
      "from_year=$year&amp;to_day=1&amp;to_month=12&amp;to_year=2030&amp;areamatch=&amp;".
      "roommatch=&amp;namematch=&amp;descrmatch=&amp;summarize=1&amp;sortby=r&amp;display=d&amp;".
      "sumby=d&amp;creatormatch=".urlencode($user); ?>
          <div class='youare_user'>
                <a href="edit_users.php" class="text-youare_user" href="<?php echo "$search_string\" title=\""
         . get_vocab('show_my_entries') . "\">" . get_vocab('you_are')." "
         . htmlspecialchars($user) ?></a>
                <form method="post" action="admin.php">
                  <div>
                    <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
                    <input type="hidden" name="Action" value="SetName">
                    <input type="hidden" name="NewUserName" value="">
                    <input type="hidden" name="NewUserPassword" value="">
                    <input class='btn btn-primary'type="submit" value=" <?php echo get_vocab('logoff') ?> ">
                  </div>
                </form>
          </div>
<?php
  }
  else
  {
?>
          <div class='youare_user'>
                <a class="text-youare_user" href="edit_users.php"><?php echo get_vocab('unknown_user'); ?></a>
                <form method="post" action="admin.php">
                  <div>
                    <input type="hidden" name="TargetURL" value="<?php echo htmlspecialchars($TargetURL) ?>">
                    <input type="hidden" name="Action" value="QueryName">
                    <input class='btn btn-primary' type="submit" value=" <?php echo get_vocab('login')?>">
                  </div>
                </form>
          </div>
<?php
  }
  if (isset($user_list_link))
  {
    print "<a class='user_list_link' id=\"user_list_link\" href=\"$user_list_link\">" . get_vocab('user_list') . "</a>\n";
  }
}
