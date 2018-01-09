<?php
namespace mrbs;

require_once "systemdefaults.inc.php";
require_once "config.inc.php";
require_once "Themes/default/styling.inc";
@include_once "Themes/$theme/styling.inc";   // overwrite the default with the specified styling if it exists
