<?php
namespace mrbs;

require "defaultincludes.inc";


function generate_search_nav_html($search_pos, $total, $num_records, $search_str)
{
  global $day, $month, $year;
  global $search;

  $html = '';

  $has_prev = $search_pos > 0;
  $has_next = $search_pos < ($total-$search["count"]);

  if ($has_prev || $has_next)
  {
    $html .= "<div id=\"record_numbers\">\n";
    $html .= get_vocab("records") . ($search_pos+1) . get_vocab("through") . ($search_pos+$num_records) . get_vocab("of") . $total;
    $html .= "</div>\n";

    $html .= "<div id=\"record_nav\">\n";
    $base_query_string = "search_str=" . urlencode($search_str) . "&amp;" .
                         "total=$total&amp;" .
                         "from_year=$year&amp;" .
                         "from_month=$month&amp;" .
                         "from_day=$day";
    if($has_prev)
    {
      $query_string = $base_query_string . "&amp;search_pos=" . max(0, $search_pos-$search["count"]);
      $html .= "<a href=\"search.php?$query_string\">";
    }

    $html .= get_vocab("previous");

    if ($has_prev)
    {
      $html .= "</a>";
    }

    $html .= (" | ");

    if ($has_next)
    {
      $query_string = $base_query_string . "&amp;search_pos=" . max(0, $search_pos+$search["count"]);
      $html .= "<a href=\"search.php?$query_string\">";
    }

    $html .= get_vocab("next");

    if ($has_next)
    {
      $html .= "</a>";
    }
    $html .= "</div>\n";
  }

  return $html;
}


function output_row($row)
{
  global $ajax, $json_data;

  $values = array();
  // booking name
  $html_name = htmlspecialchars($row['name']);
  $values[] = "<a title=\"$html_name\" href=\"view_entry.php?id=" . $row['entry_id'] . "\">$html_name</a>";
  // created by
  $values[] = htmlspecialchars($row['create_by']);
  // start time and link to day view
  $date = getdate($row['start_time']);
  $link = "<a href=\"day.php?day=$date[mday]&amp;month=$date[mon]&amp;year=$date[year]&amp;area=".$row['area_id']."\">";
  if(empty($row['enable_periods']))
  {
    $link_str = time_date_string($row['start_time']);
  }
  else
  {
    list(,$link_str) = period_date_string($row['start_time']);
  }
  $link .= "$link_str</a>";
  //    add a span with the numeric start time in the title for sorting
  $values[] = "<span title=\"" . $row['start_time'] . "\"></span>" . $link;
  // description
  $values[] = htmlspecialchars($row['description']);

  if ($ajax)
  {
    $json_data['aaData'][] = $values;
  }
  else
  {
    echo "<tr>\n<td>\n";
    echo implode("</td>\n<td>", $values);
    echo "</td>\n</tr>\n";
  }
}

// Get non-standard form variables
$search_str = get_form_var('search_str', 'string');
$search_pos = get_form_var('search_pos', 'int');
$total = get_form_var('total', 'int');
$advanced = get_form_var('advanced', 'int');
$ajax = get_form_var('ajax', 'int');  // Set if this is an Ajax request
$datatable = get_form_var('datatable', 'int');  // Will only be set if we're using DataTables
// Get the start day/month/year and make them the current day/month/year
$day = get_form_var('from_day', 'int');
$month = get_form_var('from_month', 'int');
$year = get_form_var('from_year', 'int');

// If we haven't been given a sensible date then use today's
if (!isset($day) || !isset($month) || !isset($year) || !checkdate($month, $day, $year))
{
  $day   = date("d");
  $month = date("m");
  $year  = date("Y");
}

// Check the user is authorised for this page
checkAuthorised();

// Also need to know whether they have admin rights
$user = getUserName();
$is_admin =  (isset($user) && authGetUserLevel($user)>=2) ;


$ajax_capable = $datatable && function_exists('json_encode');

if ($ajax)
{
  $json_data['aaData'] = array();
}

if (!isset($search_str))
{
  $search_str = '';
}

if (!$ajax)
{
  print_header($day, $month, $year, $area, isset($room) ? $room : "");

  if (!empty($advanced))
  {
    ?>
    <div class="panel panel-info">
    <form class="form_general" id="search_form" method="get" action="search.php">

        <div class="panel-heading">
      <h2 class="panel-title"><?php echo get_vocab("advanced_search") ?></h2>
      </div>
      <div class="panel-body">
        <div id="div_search_str">
          <label for="search_str"><?php echo get_vocab("search_for") ?>:</label>
          <input class="form-control" placeholder="recherche avancée" aria-describedby="sizing-addon1" type="search" id="search_str" name="search_str" required>
        </div>
        <br>
        <div id="div_search_from">
          <?php
          echo "<label>" . get_vocab("from") . ":</label>\n";
          echo "<br>";
          echo "<div class='selection-date'>";
          genDateSelector ("from_", $day, $month, $year);
          echo "</div>";
          ?>
        </div>
        <br>
        <div id="search_submit">
          <input class="submit btn btn-primary recherche_avancee" type="submit" value="<?php echo get_vocab("search_button") ?>">
        </div>
        </div>

    </form>
    </div>
    <?php
    //output_trailer();
    exit;
  }

  if (!isset($search_str) || ($search_str == ''))
  {
    echo "<div class='panel panel-default'>";
    echo "<div class='panel-body'>";
    echo "<p class=\"error\">" . get_vocab("invalid_search") . "</p>";
    echo "</div>";
    echo "</div>";
    //output_trailer();
    exit;
  }

  // now is used so that we only display entries newer than the current time
  echo "<h3>";
  echo get_vocab("search_results") . ": ";
  echo "\"<span id=\"search_str\">" . htmlspecialchars($search_str) . "</span>\"";
  echo "</h3>\n";
}  // if (!$ajax)


$now = mktime(0, 0, 0, $month, $day, $year);



$sql_params = array();
$sql_pred = "(( " . db()->syntax_caseless_contains("E.create_by", $search_str, $sql_params)
  . ") OR (" . db()->syntax_caseless_contains("E.name", $search_str, $sql_params)
  . ") OR (" . db()->syntax_caseless_contains("E.description", $search_str, $sql_params). ")";

// Also need to search custom fields (but only those with character data,
// which can include fields that have an associative array of options)
$fields = db()->field_info($tbl_entry);
foreach ($fields as $field)
{
  if (!in_array($field['name'], $standard_fields['entry']))
  {
    // If we've got a field that is represented by an associative array of options
    // then we have to search for the keys whose values match the search string
    if (isset($select_options["entry." . $field['name']]) &&
        is_assoc($select_options["entry." . $field['name']]))
    {
      foreach($select_options["entry." . $field['name']] as $key => $value)
      {
        // We have to use strpos() rather than stripos() because we cannot
        // assume PHP5
        if (($key !== '') && (strpos(utf8_strtolower($value), utf8_strtolower($search_str)) !== FALSE))
        {
          $sql_pred .= " OR (E." . db()->quote($field['name']) . "=?)";
          $sql_params[] = $key;
        }
      }
    }
    elseif ($field['nature'] == 'character')
    {
      $sql_pred .= " OR (" . db()->syntax_caseless_contains("E." . db()->quote($field['name']), $search_str, $sql_params).")";
    }
  }
}

$sql_pred .= ") AND (E.end_time > ?)";
$sql_params[] = $now;
$sql_pred .= " AND (E.room_id = R.id) AND (R.area_id = A.id)";



if (!$is_admin)
{
  if (isset($user))
  {

    $sql_pred .= " AND (
                        (A.private_override='public') OR
                        (A.private_override='none') AND
                        (
                         (E.status&" . STATUS_PRIVATE . "=0) OR
                         (E.create_by = ?) OR
                         (
                          (A.private_override='private') AND (E.create_by = ?)
                         )
                        )
                       )";
    $sql_params[] = $user;
    $sql_params[] = $user;
  }
  else
  {

    $sql_pred .= " AND (
                        (A.private_override='public') OR
                        (
                         (A.private_override='none') AND (E.status&" . STATUS_PRIVATE . "=0)
                        )
                       )";
  }
}


if (!isset($total))
{
  $sql = "SELECT count(*)
          FROM $tbl_entry E, $tbl_room R, $tbl_area A
          WHERE $sql_pred";
  $total = db()->query1($sql, $sql_params);
}

if (($total <= 0) && !$ajax)
{
  echo "<div class='panel panel-default'>";
  echo "<div class='panel-body'>";
  echo "<p class='bg-info' id=\"nothing_found\">" . get_vocab("nothing_found") . "</p>\n";
  echo "</div>";
  echo "</div>";
  //output_trailer();
  exit;
}

if(!isset($search_pos) || ($search_pos <= 0))
{
  $search_pos = 0;
}
else if($search_pos >= $total)
{
  $search_pos = $total - ($total % $search["count"]);
}


if (!$ajax_capable || $ajax)
{

  $sql = "SELECT E.id AS entry_id, E.create_by, E.name, E.description, E.start_time,
                 R.area_id, A.enable_periods
            FROM $tbl_entry E, $tbl_room R, $tbl_area A
           WHERE $sql_pred
        ORDER BY E.start_time asc";

  if (!$ajax)
  {
    $sql .= " " . db()->syntax_limit($search["count"], $search_pos);
  }


  $result = db()->query($sql, $sql_params);
  $num_records = $result->count();
}

if (!$ajax_capable)
{
  echo generate_search_nav_html($search_pos, $total, $num_records, $search_str);
}

if (!$ajax)
{
  echo "<div class='panel panel-default'>";
  echo "<div class='panel-body'>";
  echo "<div id=\"search_output\" class=\"datatable_container\">\n";
  echo "<table id=\"search_results\" class=\"admin_table display table table-hover\">\n";
  echo "<thead>\n";
  echo "<tr>\n";
  // We give some columns a type data value so that the JavaScript knows how to sort them
  echo "<th>" . get_vocab("namebooker") . "</th>\n";
  echo "<th>" . get_vocab("createdby") . "</th>\n";
  echo "<th><span class=\"normal\" data-type=\"title-numeric\">" . get_vocab("start_date") . "</span></th>\n";
  echo "<th>" . get_vocab("description") . "</th>\n";

  echo "</tr>\n";
  echo "</thead>\n";
  echo "<tbody>\n";

}


if (!$ajax_capable || $ajax)
{
  for ($i = 0; ($row = $result->row_keyed($i)); $i++)
  {
    output_row($row);
  }
}

if ($ajax)
{
  header("Content-Type: application/json");
  echo json_encode($json_data);
}
else
{
  echo "</tbody>\n";
  echo "</table>\n";
  echo "</div>\n";
  echo "</div>";
  echo "</div>";

}
