<?php
namespace mrbs;

// At the moment mrbs\Exception is identical to \Exception and only exists to catch
// code throwing a new Exception within the mrbs namespace.   However it does allow
// us to do mrbs specific exception handling in the future.

class Exception extends \Exception
{
}
