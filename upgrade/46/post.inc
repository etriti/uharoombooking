<?php
namespace mrbs;

global $auth;

if ($auth["type"] == 'db')
{

?>

<script type="text/javascript">
//<![CDATA[
  alert('If you have just upgraded to mrbs 1.5.0 or later and had previously configured mrbs with the \'config\' authentication scheme, please be aware that the default authentication scheme has now changed to \'db\'. Put "$auth["type"] = \'config\';" in config.inc.php to go back to the \'config\' scheme.');
//]];
</script>

<?php

}
