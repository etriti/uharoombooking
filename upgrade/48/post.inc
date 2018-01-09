<?php
namespace mrbs;

$message = "If you have just upgraded to mrbs 1.5.1 or later please " .
           "note that the config setting '" . '$db_nopersist' . "' has been replaced " .
           "by '" . '$db_persist' . "'.  The default setting for mrbs is now *not* to " .
           "use persistent connections.";
?>

<script type="text/javascript">
//<![CDATA[
  alert("<?php echo $message?>");
//]];
</script>

<?php
