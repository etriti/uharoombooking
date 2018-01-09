<?php
namespace mrbs;

global $using_rtl, $refresh_rate, $custom_css_url, $PHP_SELF;

if (DEBUG)
{
  ?>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="jquery/ui/css/zabuto_calendar.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/to-do.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/table-responsive.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/style-responsive.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/style.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/bootstrap.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/jquery-ui.structure.css" rel="stylesheet" type="text/css">
  <link href="jquery/ui/css/sunny/jquery-ui.theme.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/buttons.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/fixedColumns.dataTables.css" rel="stylesheet" type="text/css">
  <link href="jquery/datatables/css/colReorder.dataTables.css" rel="stylesheet" type="text/css">
  <?php
}
else
{
  ?>
  <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <link href="css/style.css" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link href="https://fonts.googleapis.com/css?family=Didact+Gothic|Dosis|Megrim|Quicksand" rel="stylesheet">
  <?php
}
?>


    <?php
    if ($using_rtl)
    {
      ?>
      <link rel="stylesheet" href="css/mrbs-rtl.css.php" type="text/css">
      <?php
    }
    ?>
    <link rel="stylesheet" media="print" href="css/mrbs-print.css.php" type="text/css">

    <?php
    if ($using_rtl)
    {
      ?>

      <?php
    }
    ?>
    <?php
    if (isset($custom_css_url))
    {
      ?>
      <link rel="stylesheet" href="<?php echo $custom_css_url ?>" type="text/css">
      <?php
    }
    ?>
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1,user-scalable=0"/>
<?php
if (($refresh_rate != 0) && preg_match("/(day|week|month)\.php/", $PHP_SELF))
{
  echo "<noscript>\n";
  echo "<meta http-equiv=\"Refresh\" content=\"$refresh_rate\">\n";
  echo "</noscript>\n";
}
