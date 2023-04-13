var ASPx = ASPx || {};
var dx = dx || {};
(function module(ASPx, dx) {
ASPx.modules = { Utils: module };
if(!ASPx.attachToReady)
 ASPx.attachToReady = function (callback) { ASPx.Evt.AttachEventToElement(window, "load", callback); };
if(!ASPx.attachToLoad)
 ASPx.attachToLoad = function(callback) { ASPx.Evt.AttachEventToDocumentCore("DOMContentLoaded", callback); };
ASPx.EmptyObject = { };
ASPx.FalseFunction = function() { return false; };
ASPx.SSLSecureBlankUrl = '/DXR.axd?r=1_85-OugLk';
ASPx.EmptyImageUrl = '/DXR.axd?r=1_86-OugLk';
ASPx.VersionInfo = 'Version=\'19.2.3.0\', File Version=\'19.2.3.0\', Date Modified=\'5/12/2020 7:07:53 AM\'';
ASPx.Platform = 'ASP';
ASPx.InvalidDimension = -10000;
ASPx.InvalidPosition = -10000;
ASPx.AbsoluteLeftPosition = -10000;
ASPx.EmptyGuid = "00000000-0000-0000-0000-000000000000";
ASPx.CallbackSeparator = ":";
ASPx.ItemIndexSeparator = "i";
ASPx.CallbackResultPrefix = "/*DX*/";
ASPx.StyleValueEncodedSemicolon = "DXsmcln";
ASPx.AccessibilityEmptyUrl = "javascript:;";
ASPx.AccessibilityPronounceTimeout = 500;
ASPx.MaxMobileWindowWidth = 576;
ASPx.PossibleNumberDecimalSeparators = [",", "."];
ASPx.CultureInfo = {
 twoDigitYearMax: 2029,
 ts: ":",
 ds: "/",
 am: "AM",
 pm: "PM",
 monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
 genMonthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
 abbrMonthNames: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
 abbrDayNames: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
 dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
 invariantCultureDecimalPoint: ".",
 numDecimalPoint: ".",
 numPrec: 2,
 numGroupSeparator: ",", 
 numGroups: [ 3 ],
 numNegPattern: 1,
 numPosInf: "Infinity", 
 numNegInf: "-Infinity", 
 numNan: "NaN",
 currency: "$",
 currDecimalPoint: ".",
 currPrec: 2,
 currGroupSeparator: ",",
 currGroups: [ 3 ],
 currPosPattern: 0,
 currNegPattern: 0,
 percentPattern: 0,
 shortTime: "h:mm tt",
 longTime: "h:mm:ss tt",
 shortDate: "M/d/yyyy",
 longDate: "dddd, MMMM d, yyyy",
 monthDay: "MMMM d",
 yearMonth: "MMMM yyyy"
};
ASPx.CultureInfo.genMonthNames = ASPx.CultureInfo.monthNames;
ASPx.Position = {
 Left: "Left",
 Right: "Right",
 Top: "Top",
 Bottom: "Bottom"
};
function setInnerHtmlInternal(el, trustedHtmlString) { 
 el.innerHTML = trustedHtmlString;
}
var DateUtils = { };
DateUtils.GetInvariantDateString = function(date) {
 if(!date)
  return "01/01/0001";
 var day = date.getDate();
 var month = date.getMonth() + 1;
 var year = date.getFullYear();
 var result = "";
 if(month < 10)
  result += "0";
 result += month.toString() + "/";
 if(day < 10)
  result += "0";
 result += day.toString() + "/";
 if(year < 1000)
  result += "0";
 result += year.toString();
 return result;
};
DateUtils.GetInvariantDateTimeString = function(date) {
 var dateTimeString = DateUtils.GetInvariantDateString(date);
 var time = {
  h: date.getHours(),
  m: date.getMinutes(),
  s: date.getSeconds()
 };
 for(var key in time) {
  if(time.hasOwnProperty(key)) {
   var str = time[key].toString();
   if(str.length < 2)
    str = "0" + str;
   time[key] = str;
  }
 }
 dateTimeString += " " + time.h + ":" + time.m + ":" + time.s;
 var msec = date.getMilliseconds();
 if(msec > 0)
  dateTimeString += "." + ("000" + msec.toString()).substr(-3);
 return dateTimeString;
};
DateUtils.ExpandTwoDigitYear = function(value) {
 value += 1900;
 if(value + 99 < ASPx.CultureInfo.twoDigitYearMax)
  value += 100;
 return value;  
};
DateUtils.GetTimeZoneOffsetDifference = function(firstDate, secondDate) {
 if(!secondDate)
  secondDate = DateUtils.GetUtcDate(firstDate);
 return 60000 * (firstDate.getTimezoneOffset() - secondDate.getTimezoneOffset());
};
DateUtils.GetTimeZoneOffset = function(date) {
 var isECMA262Support = ASPx.Browser.Chrome && ASPx.Browser.Version >= 67;
 if(!isECMA262Support)
  return date.getTimezoneOffset() * 60000;
 var utcDate = DateUtils.GetUtcDate(date);
 var utcTimezoneOffsetDifference = DateUtils.GetTimeZoneOffsetDifference(date);
 if(utcTimezoneOffsetDifference !== 0)
  utcDate.setTime(utcDate.valueOf() + utcTimezoneOffsetDifference);
 return utcDate - date;
};
DateUtils.GetUtcDate = function(date) {
 var utcFullYear = date.getUTCFullYear();
 var result = new Date(utcFullYear, date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds(), date.getUTCMilliseconds());
 if(utcFullYear < 100)
  result.setFullYear(utcFullYear);
 return result;
};
DateUtils.ToUtcTime = function(date) {
 var result = new Date();
 result.setTime(date.valueOf() + ASPx.DateUtils.GetTimeZoneOffset(date));
 return result;
};
DateUtils.ToLocalTime = function(date) {
 var result = new Date();
 result.setTime(date.valueOf() - ASPx.DateUtils.GetTimeZoneOffset(date));
 return result; 
};
DateUtils.AreDatesEqualExact = function(date1, date2) {
 if(date1 == null && date2 == null)
  return true;
 if(date1 == null || date2 == null)
  return false;
 return date1.getTime() == date2.getTime(); 
};
DateUtils.FixTimezoneGap = function(oldDate, newDate) {
 var diff = newDate.getHours() - oldDate.getHours();
 if(diff == 0)
  return;
 var sign = (diff == 1 || diff == -23) ? -1 : 1;
 var trial = new Date(newDate.getTime() + sign * 3600000);
 var isDateChangedAsExpected = newDate.getHours() - trial.getHours() === diff;
 if(isDateChangedAsExpected && (sign > 0 || trial.getDate() == newDate.getDate()))
  newDate.setTime(trial.getTime());
};
DateUtils.GetDecadeStartYear = function(year) {
 return 10 * Math.floor(year / 10);
};
DateUtils.GetCenturyStartYear = function(year) {
 return 100 * Math.floor(year / 100);
};
DateUtils.GetCorrectedYear = function(date, pickerType) {
 var year = date.getFullYear();
 return pickerType != ASPx.DatePickerType.Decades ? year : DateUtils.GetDecadeStartYear(year);
};
DateUtils.GetCorrectedMonth = function(date, pickerType) {
 return pickerType < ASPx.DatePickerType.Years ? date.getMonth() : 0;
};
DateUtils.GetCorrectedDay = function(date, pickerType) {
 return pickerType == ASPx.DatePickerType.Days ? date.getDate() : 1;
};
DateUtils.CorrectDateByPickerType = function(date, pickerType) {
 if(!ASPx.IsExists(pickerType))
  pickerType = ASPx.DatePickerType.Days;
 if(!date || pickerType == ASPx.DatePickerType.Days)
  return date;
 var correctedYear = DateUtils.GetCorrectedYear(date, pickerType);
 var result = new Date(
  correctedYear,
  DateUtils.GetCorrectedMonth(date, pickerType),
  DateUtils.GetCorrectedDay(date, pickerType),
  date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds()
 );
 result.setFullYear(correctedYear);
 return result;
};
DateUtils.GetYearRangeFormatString = function(startYear, rangeLength) {
 return startYear + " - " + (startYear + rangeLength - 1);
};
ASPx.DateUtils = DateUtils;
var Timer = { };
Timer.ClearTimer = function(timerID){
 if(timerID > -1)
  window.clearTimeout(timerID);
 return -1;
};
Timer.ClearInterval = function(timerID){
 if(timerID > -1)
  window.clearInterval(timerID);
 return -1;
};
var setControlBoundTimer = function(handler, control, setTimerFunction, clearTimerFunction, delay) {
 var timerId;
 var getTimerId = function() { return timerId; };
 var controlMainElement = control.GetMainElement();
 var boundHandler = function() {
  var controlExists = control && ASPx.GetControlCollection().Get(control.name) === control && control.GetMainElement() === controlMainElement;
  if(controlExists)
   handler.aspxBind(control)();
  else {
   clearTimerFunction(getTimerId());
   controlMainElement = null;
  }
 };
 timerId = setTimerFunction(boundHandler, delay);
 return timerId;
};
Timer.SetControlBoundTimeout = function(handler, control, delay) {
 return setControlBoundTimer(handler, control, window.setTimeout, Timer.ClearTimer, delay);
};
Timer.SetControlBoundInterval = function(handler, control, delay) {
 return setControlBoundTimer(handler, control, window.setInterval, Timer.ClearInterval, delay);
};
Timer.Throttle = function(func, delay) {
 var isThrottled = false,
   savedArgs,
   savedThis = this;
 function wrapper() {
  if(isThrottled) {
   savedArgs = arguments;
   savedThis = this;
   return;
  }
  func.apply(this, arguments);
  isThrottled = true;
  setTimeout(function() {
   isThrottled = false;
   if(savedArgs) {
    wrapper.apply(savedThis, savedArgs);
    savedArgs = null;
   }
  }, delay);
 }
 wrapper.cancel = function() {
  clearTimeout(delay);
  delay = savedArgs = savedThis = null;
 };
 return wrapper;
};
ASPx.Timer = Timer;
var Browser = { };
Browser.UserAgent = navigator.userAgent.toLowerCase();
Browser.Mozilla = false;
Browser.IE = false;
Browser.Firefox = false;
Browser.Netscape = false;
Browser.Safari = false;
Browser.Chrome = false;
Browser.Opera = false;
Browser.Edge = false;
Browser.Version = undefined; 
Browser.MajorVersion = undefined; 
Browser.WindowsPlatform = false;
Browser.MacOSPlatform = false;
Browser.MacOSMobilePlatform = false;
Browser.AndroidMobilePlatform = false;
Browser.PlaformMajorVersion = false;
Browser.WindowsPhonePlatform = false;
Browser.AndroidDefaultBrowser = false;
Browser.AndroidChromeBrowser = false;
Browser.SamsungAndroidDevice = false;
Browser.WebKitTouchUI = false;
Browser.MSTouchUI = false;
Browser.TouchUI = false;
Browser.WebKitFamily = false; 
Browser.NetscapeFamily = false; 
Browser.HardwareAcceleration = false;
Browser.VirtualKeyboardSupported = false;
Browser.Info = "";
Browser.IsQuirksMode = document.compatMode === "BackCompat";
function indentPlatformMajorVersion(userAgent) {
 var regex = /(?:(?:windows nt|macintosh|mac os|cpu os|cpu iphone os|android|windows phone|linux) )(\d+)(?:[-0-9_.])*/;
 var matches = regex.exec(userAgent);
 if(matches)
  Browser.PlaformMajorVersion = matches[1];
}
function getIECompatibleVersionString() {
 if(document.compatible) {
  for(var i = 0; i < document.compatible.length; i++)
   if(document.compatible[i].userAgent === "IE" && document.compatible[i].version)
    return document.compatible[i].version.toLowerCase();
 }
 return "";
}
Browser.IdentUserAgent = function(userAgent, ignoreDocumentMode) {
 var browserTypesOrderedList = [ "Mozilla", "IE", "Firefox", "Netscape", "Safari", "Chrome", "Opera", "Opera10", "Edge" ];
 var defaultBrowserType = "IE";
 var defaultPlatform = "Win";
 var defaultVersions = { Safari: 2, Chrome: 0.1, Mozilla: 1.9, Netscape: 8, Firefox: 2, Opera: 9, IE: 6, Edge: 12 };
 if(!userAgent || userAgent.length == 0) {
  fillUserAgentInfo(browserTypesOrderedList, defaultBrowserType, defaultVersions[defaultBrowserType], defaultPlatform);
  return;
 }
 userAgent = userAgent.toLowerCase();
 indentPlatformMajorVersion(userAgent);
 try {
  var platformIdentStrings = {
   "Windows": "Win",
   "Macintosh": "Mac",
   "Mac OS": "Mac",
   "Mac_PowerPC": "Mac",
   "cpu os": "MacMobile",
   "cpu iphone os": "MacMobile",
   "Android": "Android",
   "!Windows Phone": "WinPhone",
   "!WPDesktop": "WinPhone",
   "!ZuneWP": "WinPhone"
  };
  var optSlashOrSpace = "(?:/|\\s*)?";
  var version = "(\\d+)(?:\\.((?:\\d+?[1-9])|\\d)0*?)?";
  var optVersion = "(?:" + version + ")?";
  var patterns = {
   Safari: "applewebkit(?:.*?(?:version/" + version + "[\\.\\w\\d]*?(?:\\s+mobile\/\\S*)?\\s+safari))?",
   Chrome: "(?:chrome|crios)(?!frame)" + optSlashOrSpace + optVersion,
   Mozilla: "mozilla(?:.*rv:" + optVersion + ".*Gecko)?",
   Netscape: "(?:netscape|navigator)\\d*/?\\s*" + optVersion,
   Firefox: "firefox" + optSlashOrSpace + optVersion,
   Opera: "(?:opera|\sopr)" + optSlashOrSpace + optVersion,
   Opera10: "opera.*\\s*version" + optSlashOrSpace + optVersion,
   IE: "msie\\s*" + optVersion,
   Edge: "edge" + optSlashOrSpace + optVersion
  };
  var browserType;
  var version = -1;
  for(var i = 0; i < browserTypesOrderedList.length; i++) {
   var browserTypeCandidate = browserTypesOrderedList[i];
   var regExp = new RegExp(patterns[browserTypeCandidate], "i");
   if(regExp.compile)
    regExp.compile(patterns[browserTypeCandidate], "i");
   var matches = regExp.exec(userAgent);
   if(matches && matches.index >= 0) {
    if(browserType == "IE" && version >= 11 && browserTypeCandidate == "Safari") 
     continue;
    browserType = browserTypeCandidate;
    if(browserType == "Opera10")
     browserType = "Opera";
    var tridentPattern = "trident" + optSlashOrSpace + optVersion;
    version = Browser.GetBrowserVersion(userAgent, matches, tridentPattern, getIECompatibleVersionString());
    if(browserType == "Mozilla" && version >= 11)
     browserType = "IE";
   }
  }
  if(!browserType)
   browserType = defaultBrowserType;
  var browserVersionDetected = version != -1;
  if(!browserVersionDetected)
   version = defaultVersions[browserType];
  var platform;
  var minOccurenceIndex = Number.MAX_VALUE;
  for(var identStr in platformIdentStrings) {
   if(!platformIdentStrings.hasOwnProperty(identStr)) continue;
   var importantIdent = identStr.substr(0,1) == "!";
   var occurenceIndex = userAgent.indexOf((importantIdent ? identStr.substr(1) : identStr).toLowerCase());
   if(occurenceIndex >= 0 && (occurenceIndex < minOccurenceIndex || importantIdent)) {
    minOccurenceIndex = importantIdent ? 0 : occurenceIndex;
    platform = platformIdentStrings[identStr];
   }
  }
  var samsungPattern = "SM-[A-Z]";
  var matches = userAgent.toUpperCase().match(samsungPattern);
  var isSamsungAndroidDevice = matches && matches.length > 0;
  if(platform == "WinPhone" && version < 9)
   version = Math.floor(getVersionFromTrident(userAgent, "trident" + optSlashOrSpace + optVersion));
  if(!ignoreDocumentMode && browserType == "IE" && version > 7 && document.documentMode < version)
   version = document.documentMode;
  if(platform == "WinPhone")
   version = Math.max(9, version);
  if(!platform)
   platform = defaultPlatform;
  if(platform == platformIdentStrings["cpu os"] && !browserVersionDetected) 
   version = 4;
  fillUserAgentInfo(browserTypesOrderedList, browserType, version, platform, isSamsungAndroidDevice);
 } catch(e) {
  fillUserAgentInfo(browserTypesOrderedList, defaultBrowserType, defaultVersions[defaultBrowserType], defaultPlatform);
 }
};
function getVersionFromMatches(matches) {
 var result = -1;
 var versionStr = "";
 if(matches[1]) {
  versionStr += matches[1];
  if(matches[2])
   versionStr += "." + matches[2];
 }
 if(versionStr != "") {
  result = parseFloat(versionStr);
  if(isNaN(result))
   result = -1;
 }
 return result;
}
function getVersionFromTrident(userAgent, tridentPattern) {
 var tridentDiffFromVersion = 4;
 var matches = new RegExp(tridentPattern, "i").exec(userAgent);
 return getVersionFromMatches(matches) + tridentDiffFromVersion;
}
Browser.GetBrowserVersion = function(userAgent, matches, tridentPattern, ieCompatibleVersionString) {
 var version = getVersionFromMatches(matches);
 if(ieCompatibleVersionString) {
  var versionFromTrident = getVersionFromTrident(userAgent, tridentPattern);
  if(ieCompatibleVersionString === "edge" || parseInt(ieCompatibleVersionString) === versionFromTrident)
   return versionFromTrident;
 }
 return version;
};
function fillUserAgentInfo(browserTypesOrderedList, browserType, version, platform, isSamsungAndroidDevice) {
 for(var i = 0; i < browserTypesOrderedList.length; i++) {
  var type = browserTypesOrderedList[i];
  Browser[type] = type == browserType;
 }
 Browser.Version = Math.floor(10.0 * version) / 10.0;
 Browser.MajorVersion = Math.floor(Browser.Version);
 Browser.WindowsPlatform = platform == "Win" || platform == "WinPhone";
 Browser.MacOSPlatform = platform == "Mac";
 Browser.MacOSMobilePlatform = platform == "MacMobile";
 Browser.AndroidMobilePlatform = platform == "Android";
 Browser.WindowsPhonePlatform = platform == "WinPhone";
 Browser.WebKitFamily = Browser.Safari || Browser.Chrome || Browser.Opera && Browser.MajorVersion >= 15;
 Browser.NetscapeFamily = Browser.Netscape || Browser.Mozilla || Browser.Firefox;
 Browser.HardwareAcceleration = (Browser.IE && Browser.MajorVersion >= 9) || (Browser.Firefox && Browser.MajorVersion >= 4) || 
  (Browser.AndroidMobilePlatform && Browser.Chrome) || (Browser.Chrome && Browser.MajorVersion >= 37) || 
  (Browser.Safari && !Browser.WindowsPlatform) || Browser.Edge || (Browser.Opera && Browser.MajorVersion >= 46);
 Browser.WebKitTouchUI = Browser.MacOSMobilePlatform || Browser.AndroidMobilePlatform;
 var isIETouchUI = Browser.IE && Browser.MajorVersion > 9 && Browser.WindowsPlatform && Browser.UserAgent.toLowerCase().indexOf("touch") >= 0;
 Browser.MSTouchUI = isIETouchUI || (Browser.Edge && !!window.navigator.maxTouchPoints);
 Browser.TouchUI = Browser.WebKitTouchUI || Browser.MSTouchUI;
 Browser.MobileUI = Browser.WebKitTouchUI || Browser.WindowsPhonePlatform;
 Browser.AndroidDefaultBrowser = Browser.AndroidMobilePlatform && !Browser.Chrome;
 Browser.AndroidChromeBrowser = Browser.AndroidMobilePlatform && Browser.Chrome;
 if(isSamsungAndroidDevice)
  Browser.SamsungAndroidDevice = isSamsungAndroidDevice;
 if(Browser.MSTouchUI) {
  var isARMArchitecture = Browser.UserAgent.toLowerCase().indexOf("arm;") > -1;    
  Browser.VirtualKeyboardSupported = isARMArchitecture || Browser.WindowsPhonePlatform;   
 } else {
  Browser.VirtualKeyboardSupported = Browser.MobileUI || (Browser.Chrome && !!window.navigator.maxTouchPoints);
 }
 fillDocumentElementBrowserTypeClassNames(browserTypesOrderedList);
}
function fillDocumentElementBrowserTypeClassNames(browserTypesOrderedList) {
 var documentElementClassName = "";
 var browserTypeslist = browserTypesOrderedList.concat(["WindowsPlatform", "MacOSPlatform", "MacOSMobilePlatform", "AndroidMobilePlatform",
   "WindowsPhonePlatform", "WebKitFamily", "WebKitTouchUI", "MSTouchUI", "TouchUI", "AndroidDefaultBrowser", "MobileUI"]);
 for(var i = 0; i < browserTypeslist.length; i++) {
  var type = browserTypeslist[i];
  if(Browser[type])
   documentElementClassName += "dx" + type + " ";
 }
 documentElementClassName += "dxBrowserVersion-" + Browser.MajorVersion;
 if(document && document.documentElement) {
  if(document.documentElement.className != "")
   documentElementClassName = " " + documentElementClassName;
  document.documentElement.className += documentElementClassName;
  Browser.Info = documentElementClassName;
 }
}
Browser.SupportsStickyPositioning = function() {
 return this.Chrome && this.MajorVersion >= 56
  || this.Firefox && this.MajorVersion >= 32
  || this.Safari && this.MajorVersion >= 6 && this.Version !== "6"
  || this.Opera && this.MajorVersion >= 42;
};
Browser.IdentUserAgent(Browser.UserAgent);
ASPx.Browser = Browser;
ASPx.BlankUrl = Browser.IE ? ASPx.SSLSecureBlankUrl : (Browser.Opera ? "about:blank" : "");
var Data = { };
Data.ArrayInsert = function(array, element, position){
 if(0 <= position && position < array.length){
  for(var i = array.length; i > position; i --)
   array[i] = array[i - 1];
  array[position] = element;
 }
 else
  array.push(element);
};
Data.ArrayRemove = function(array, element){
 var index = Data.ArrayIndexOf(array, element);
 if(index > -1) Data.ArrayRemoveAt(array, index);
};
Data.ArrayRemoveAt = function(array, index){
 if(index >= 0  && index < array.length){
  for(var i = index; i < array.length - 1; i++)
   array[i] = array[i + 1];
  array.pop();
 }
};
Data.ArrayClear = function(array){
 while(array.length > 0)
  array.pop();
};
Data.ArrayIndexOf = function(array, element, comparer) {
 if(!comparer) {
  for(var i = 0; i < array.length; i++) {
   if(array[i] == element)
    return i;
  }
 } else {
  for(var i = 0; i < array.length; i++) {
   if(comparer(array[i], element))
    return i;
  }
 }
 return -1;
};
Data.ArrayContains = function(array, element) { 
 return Data.ArrayIndexOf(array, element) >= 0;
};
Data.ArrayEqual = function(array1, array2) {
 var count1 = array1.length;
 var count2 = array2.length;
 if(count1 != count2)
  return false;
 for(var i = 0; i < count1; i++)
  if(array1[i] != array2[i])
   return false;
 return true;
};
Data.ArraySame = function(array1, array2) {
 if(array1.length !== array2.length)
  return false;
 return array1.every(function(elem) { return Data.ArrayContains(array2, elem); });
};
Data.ArrayGetIntegerEdgeValues = function(array) {
 var arrayToSort = Data.CollectionToArray(array);
 Data.ArrayIntegerAscendingSort(arrayToSort);
 return {
  start: arrayToSort[0],
  end: arrayToSort[arrayToSort.length - 1]
 };
};
Data.ArrayIntegerAscendingSort = function(array){
 Data.ArrayIntegerSort(array);
};
Data.ArrayIntegerSort = function(array, desc) {
 array.sort(function(i1, i2) {
  var res = 0;
  if(i1 > i2)
   res = 1;
  else if(i1 < i2)
   res = -1;
  if(desc)
   res *= -1;
  return res;
 });
};
Data.CollectionsUnionToArray = function(firstCollection, secondCollection) {
 var result = [];
 var firstCollectionLength = firstCollection.length;
 var secondCollectionLength = secondCollection.length;
 for(var i = 0; i < firstCollectionLength + secondCollectionLength; i++) {
  if(i < firstCollectionLength)
   result.push(firstCollection[i]);
  else
   result.push(secondCollection[i - firstCollectionLength]);
 }
 return result;
};
Data.CollectionToArray = function(collection) {
 var array = [];
 for(var i = 0; i < collection.length; i++)
  array.push(collection[i]);
 return array;
};
Data.CreateHashTableFromArray = function(array) {
 var hash = [];
 for(var i = 0; i < array.length; i++)
  hash[array[i]] = 1;
 return hash;
};
Data.CreateIndexHashTableFromArray = function(array) {
 var hash = [];
 for(var i = 0; i < array.length; i++)
  hash[array[i]] = i;
 return hash;
};
Data.ArrayToHash = function(array, getKeyFunc, getValueFunc) {
 if(!(array instanceof Array)) 
  return { };
 return array.reduce(function(map, element, index) { 
  var key = getKeyFunc(element, index);
  var value = getValueFunc(element, index);
  map[key] = value;
  return map; 
 }, { });
};
Data.Sum = function(array, getValueFunc) {
 if(!(array instanceof Array)) 
  return 0;
 return array.reduce(function(prevValue, item) {
  var value = getValueFunc ? getValueFunc(item) : item;
  if(!ASPx.IsNumber(value))
   value = 0;
  return prevValue + value;
 }, 0);
};
Data.Min = function(array, getValueFunc) { return CalculateArrayMinMax(array, getValueFunc, false); };
Data.Max = function(array, getValueFunc) { return CalculateArrayMinMax(array, getValueFunc, true); };
var CalculateArrayMinMax = function(array, getValueFunc, isMax) {
 if(!(array instanceof Array)) 
  return 0;
 var startValue = isMax ? Number.NEGATIVE_INFINITY : Number.POSITIVE_INFINITY;
 return array.reduce(function(prevValue, item) {
  var value = getValueFunc ? getValueFunc(item) : item;
  if(!ASPx.IsNumber(value))
   value = startValue;
  var func = isMax ? Math.max : Math.min;
  return func(value, prevValue);
 }, startValue);
};
var defaultBinarySearchComparer = function(array, index, value) {
 var arrayElement = array[index];
 if(arrayElement == value)
  return 0;
 else
  return arrayElement < value ? -1 : 1;
};
Data.NearestLeftBinarySearchComparer = function(array, index, value) { 
 var arrayElement = array[index];
 var leftPoint = arrayElement < value;
 var lastLeftPoint = leftPoint && index == array.length - 1;
 var nearestLeftPoint = lastLeftPoint || (leftPoint && array[index + 1] >= value);
 if(nearestLeftPoint)
  return 0;
 else
  return arrayElement < value ? -1 : 1;
};
Data.ArrayBinarySearch = function(array, value, binarySearchComparer, startIndex, length) {
 if(!binarySearchComparer)
  binarySearchComparer = defaultBinarySearchComparer;
 if(!ASPx.IsExists(startIndex))
  startIndex = 0;
 if(!ASPx.IsExists(length))
  length = array.length - startIndex;
 var endIndex = (startIndex + length) - 1;
 while(startIndex <= endIndex) {
  var middle = (startIndex + ((endIndex - startIndex) >> 1));
  var compareResult = binarySearchComparer(array, middle, value);
  if(compareResult == 0)
   return middle;
  if(compareResult < 0)
   startIndex = middle + 1;
  else
   endIndex = middle - 1;
 }
 return -(startIndex + 1);
};
Data.ArrayFlatten = function(arrayOfArrays) {
 return [].concat.apply([], arrayOfArrays);
};
Data.GetDistinctArray = function(array) {
 var resultArray = [];
 for(var i = 0; i < array.length; i++) {
  var currentEntry = array[i];
  if(Data.ArrayIndexOf(resultArray, currentEntry) == -1) {
   resultArray.push(currentEntry);
  }
 }
 return resultArray;
};
Data.ForEach = function(arr, callback) {
 if(Array.prototype.forEach) {
  Array.prototype.forEach.call(arr, callback);
 } else {
  for(var i = 0, len = arr.length; i < len; i++) {
   callback(arr[i], i, arr);
  }
 }
};
Data.MergeHashTables = function(target, object) {
 if(!object || typeof (object) == "string")
  return target;
 if(!target)
  target = {};
 for(var key in object)
  if(key && !(key in target))
   target[key] = object[key];
 return target;
};
Data.Range = function(count, start) {
 count = parseInt(count) || 0;
 start = parseInt(start) || 0;
 if(count < 0) count = 0;
 if(start < 0) start = 0;
 return Array.apply(null, Array(count)).map(function(val, i) { return start + i; });
};
ASPx.Data = Data;
var Cookie = { };
Cookie.DelCookie = function(name){
 setCookieInternal(name, "", new Date(1970, 1, 1));
};
Cookie.GetCookie = function(name) {
 name = escape(name);
 var cookies = document.cookie.split(';');
 for(var i = 0; i < cookies.length; i++) {
  var cookie = Str.Trim(cookies[i]);
  if(cookie.indexOf(name + "=") == 0)
   return unescape(cookie.substring(name.length + 1, cookie.length));
  else if(cookie.indexOf(name + ";") == 0 || cookie === name)
   return "";
 }
 return null;
};
Cookie.SetCookie = function(name, value, expirationDate){
 if(!ASPx.IsExists(value)) {
  Cookie.DelCookie(name);
  return;
 }
 if(!ASPx.Ident.IsDate(expirationDate)) {
  expirationDate = new Date();
  expirationDate.setFullYear(expirationDate.getFullYear() + 1);
 }
 setCookieInternal(name, value, expirationDate);
};
function setCookieInternal(name, value, date){
 document.cookie = escape(name) + "=" + escape(value.toString()) + "; expires=" + date.toGMTString() + "; path=/";
}
ASPx.Cookie = Cookie;
ASPx.ImageUtils = {
 GetImageSrc: function (image){
  return image.src;
 },
 SetImageSrc: function(image, src){
  if(isSourceResetRequired())
   image.src = "";
  image.src = src;
 },
 SetSize: function(image, width, height){
  image.style.width = width + "px";
  image.style.height = height + "px";
 },
 GetSize: function(image, isWidth) {
  return (isWidth ? ASPx.GetElementOffsetWidth(image) : ASPx.GetElementOffsetHeight(image));
 }
};
var Str = { };
Str.ApplyReplacement = function(text, replecementTable) {
 if(typeof(text) != "string")
  text = text.toString();
 for(var i = 0; i < replecementTable.length; i++) {
  var replacement = replecementTable[i];
  text = text.replace(replacement[0], replacement[1]);
 }
 return text;
};
Str.CompleteReplace = function(text, regexp, newSubStr) {
 if(typeof(text) != "string")
  text = text.toString();
 var textPrev;
 do {
  textPrev = text;
  text = text.replace(regexp, newSubStr);
 } while(text != textPrev);
 return text;
};
Str.EncodeHtml = function(html) {
 return Str.ApplyReplacement(html, [
  [ /&amp;/g,  '&ampx;'  ], [ /&/g, '&amp;'  ],
  [ /&quot;/g, '&quotx;' ], [ /"/g, '&quot;' ],
  [ /&lt;/g,   '&ltx;'   ], [ /</g, '&lt;'   ],
  [ /&gt;/g,   '&gtx;'   ], [ />/g, '&gt;'   ]
 ]);
};
Str.DecodeHtml = function(html) {
 return Str.ApplyReplacement(html, [
  [ /&gt;/g,   '>' ], [ /&gtx;/g,  '&gt;'   ],
  [ /&lt;/g,   '<' ], [ /&ltx;/g,  '&lt;'   ],
  [ /&quot;/g, '"' ], [ /&quotx;/g,'&quot;' ],
  [ /&amp;/g,  '&' ], [ /&ampx;/g, '&amp;'  ]
 ]);
};
Str.DecodeHtmlViaTextArea = function(html) {
 var textArea = document.createElement("TEXTAREA");
 setInnerHtmlInternal(textArea, html);
 return textArea.value;
};
Str.TrimStart = function(str) { 
 return trimInternal(str, true);
};
Str.TrimEnd = function(str) { 
 return trimInternal(str, false, true);
};
Str.Trim = function(str) { 
 return trimInternal(str, true, true); 
};
Str.EscapeForRegEx = function(str) {
 return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
};
var whiteSpaces = { 
 0x0009: 1, 0x000a: 1, 0x000b: 1, 0x000c: 1, 0x000d: 1, 0x0020: 1, 0x0085: 1, 
 0x00a0: 1, 0x1680: 1, 0x180e: 1, 0x2000: 1, 0x2001: 1, 0x2002: 1, 0x2003: 1, 
 0x2004: 1, 0x2005: 1, 0x2006: 1, 0x2007: 1, 0x2008: 1, 0x2009: 1, 0x200a: 1, 
 0x200b: 1, 0x2028: 1, 0x2029: 1, 0x202f: 1, 0x205f: 1, 0x3000: 1
};
var caretWidth = 1;
function trimInternal(source, trimStart, trimEnd) {
 var len = source.length;
 if(!len)
  return source;
 var result = "";
 if(len < 0xBABA1) 
  result = trimSource(source, trimStart, trimEnd);
 else
  result = trimLargeSource(source, len, trimStart, trimEnd);
 return Str.ClearString(result);
}
function trimSource(source, trimStart, trimEnd) {
 var result = source;
 if(trimStart)
  result = result.replace(/^\s+/, "");
 if(trimEnd)
  result = result.replace(/\s+$/, "");
 return result;
}
function trimLargeSource(source, len, trimStart, trimEnd) {
 var start = 0;
 if(trimEnd) {
  while(len > 0 && whiteSpaces[source.charCodeAt(len - 1)]) {
   len--;
  }
 }
 if(trimStart && len > 0) {
  while(start < len && whiteSpaces[source.charCodeAt(start)]) {
   start++;
  }
 }
 return source.substring(start, len);
}
var inlineStringLength = 12;
Str.ClearString = function(str) { 
 if(!ASPx.Browser.Chrome)
  return str;
 return str.length < inlineStringLength ? str : JSON.parse(JSON.stringify(str));
};
Str.Insert = function(str, subStr, index) { 
 var leftText = str.slice(0, index);
 var rightText = str.slice(index);
 return leftText + subStr + rightText;
};
Str.InsertEx = function(str, subStr, startIndex, endIndex) { 
 var leftText = str.slice(0, startIndex);
 var rightText = str.slice(endIndex);
 return leftText + subStr + rightText;
};
var greekSLFSigmaChar = String.fromCharCode(962);
var greekSLSigmaChar = String.fromCharCode(963);
Str.PrepareStringForFilter = function(s){
 s = s.toLowerCase();
 if(ASPx.Browser.WebKitFamily) {
  return s.replace(new RegExp(greekSLFSigmaChar, "g"), greekSLSigmaChar);
 }
 return s;
};
Str.GetCoincideCharCount = function(text, filter, textMatchingDelegate) {
 var coincideText = ASPx.Str.PrepareStringForFilter(filter);
 var originText = ASPx.Str.PrepareStringForFilter(text);
 while(coincideText != "" && !textMatchingDelegate(originText, coincideText)) {
  coincideText = coincideText.slice(0, -1);
 }
 return coincideText.length;
};
ASPx.Str = Str;
var Xml = { };
Xml.Parse = function(xmlStr) {
 if(window.DOMParser) {
  var parser = new DOMParser();
  return parser.parseFromString(xmlStr, "text/xml");
 }
 else if(window.ActiveXObject) {
  var xmlDoc = new window.ActiveXObject("Microsoft.XMLDOM");
  if(xmlDoc) {
   xmlDoc.async = false;
   xmlDoc.loadXML(xmlStr);
   return xmlDoc;
  }
 }
 return null;
};
ASPx.Xml = Xml;
ASPx.Key = {
 F1     : 112,
 F2     : 113,
 F3     : 114,
 F4     : 115,
 F5     : 116,
 F6     : 117,
 F7     : 118,
 F8     : 119,
 F9     : 120,
 F10    : 121,
 F11    : 122,
 F12    : 123,
 Ctrl   : 17,
 Shift  : 16,
 Alt    : 18,
 Enter  : 13,
 Home   : 36,
 End    : 35,
 Left   : 37,
 Right  : 39,
 Up     : 38,
 Down   : 40,
 PageUp    : 33,
 PageDown  : 34,
 Esc    : 27,
 Space  : 32,
 Tab    : 9,
 Backspace : 8,
 Delete    : 46,
 Insert    : 45,
 ContextMenu  : 93,
 Windows   : 91,
 Decimal   : 110
};
ASPx.ModifierKey = {
 None: 0,
 Ctrl: 1 << (0 + 16),
 Shift: 1 << (2 + 16),
 Alt: 1 << (4 + 16),
 Meta: 1 << (8 + 16)
};
ASPx.KeyCode = {
 Backspace : 8,
 Tab    : 9,
 Enter  : 13,
 Pause  : 19,
 CapsLock  : 20,
 Esc    : 27,
 Space  : 32,
 PageUp    : 33,
 PageDown  : 34,
 End    : 35,
 Home   : 36,
 Left   : 37,
 Up     : 38,
 Right  : 39,
 Down   : 40,
 Insert    : 45,
 Delete    : 46,
 Key_0  : 48,
 Key_1  : 49,
 Key_2  : 50,
 Key_3  : 51,
 Key_4  : 52,
 Key_5  : 53,
 Key_6  : 54,
 Key_7  : 55,
 Key_8  : 56,
 Key_9  : 57,
 Key_a  : 65,
 Key_b  : 66,
 Key_c  : 67,
 Key_d  : 68,
 Key_e  : 69,
 Key_f  : 70,
 Key_g  : 71,
 Key_h  : 72,
 Key_i  : 73,
 Key_j  : 74,
 Key_k  : 75,
 Key_l  : 76,
 Key_m  : 77,
 Key_n  : 78,
 Key_o  : 79,
 Key_p  : 80,
 Key_q  : 81,
 Key_r  : 82,
 Key_s  : 83,
 Key_t  : 84,
 Key_u  : 85,
 Key_v  : 86,
 Key_w  : 87,
 Key_x  : 88,
 Key_y  : 89,
 Key_z  : 90,
 Windows   : 91,
 ContextMenu  : 93,
 Numpad_0  : 96,
 Numpad_1  : 97,
 Numpad_2  : 98,
 Numpad_3  : 99,
 Numpad_4  : 100,
 Numpad_5  : 101,
 Numpad_6  : 102,
 Numpad_7  : 103,
 Numpad_8  : 104,
 Numpad_9  : 105,
 Multiply  : 106,
 Add    : 107,
 Subtract  : 109,
 Decimal   : 110,
 Divide    : 111,
 F1     : 112,
 F2     : 113,
 F3     : 114,
 F4     : 115,
 F5     : 116,
 F6     : 117,
 F7     : 118,
 F8     : 119,
 F9     : 120,
 F10    : 121,
 F11    : 122,
 F12    : 123,
 NumLock   : 144,
 ScrollLock   : 145,
 Semicolon : 186,
 Equals    : 187,
 Comma  : 188,
 Dash   : 189,
 Period    : 190,
 ForwardSlash : 191,
 GraveAccent  : 192,
 OpenBracket  : 219,
 BackSlash : 220,
 CloseBracket : 221,
 SingleQuote  : 222
};
ASPx.ScrollBarMode = { Hidden: 0, Visible: 1, Auto: 2 };
ASPx.ColumnResizeMode = { None: 0, Control: 1, NextColumn: 2 };
var Selection = { };
Selection.Set = function(input, startPos, endPos, scrollToSelection, isApi) {
 if(!ASPx.IsExistsElement(input))
  return;
 var isInputFocused = ASPx.GetActiveElement() === input;
 var isInputNativeFocusLocked = ASPx.VirtualKeyboardUI.getInputNativeFocusLocked();
 if(!isApi && Browser.VirtualKeyboardSupported && (!isInputFocused || isInputNativeFocusLocked))
  return;
 var textLen = input.value.length;
 startPos = ASPx.GetDefinedValue(startPos, 0);
 endPos = ASPx.GetDefinedValue(endPos, textLen);
 if(startPos < 0)
  startPos = 0;
 if(endPos < 0 || endPos > textLen)
  endPos = textLen;
 if(startPos > endPos)
  startPos = endPos;
 var makeReadOnly = false;
 if(Browser.WebKitFamily && input.readOnly) {
  input.readOnly = false;
  makeReadOnly = true;
 }
 try {
  if(Browser.Firefox && Browser.Version >= 8) 
   input.setSelectionRange(startPos, endPos, "backward");
  else if(Browser.IE && input.createTextRange) {
   var range = input.createTextRange();
   range.collapse(true);
   range.moveStart("character", startPos);
   range.moveEnd("character", endPos - startPos);
   range.select();
  } else {
   forceScrollToSelectionRange(input, startPos, endPos);
   input.setSelectionRange(startPos, endPos);
  }
  if(Browser.Opera || Browser.Firefox || Browser.Chrome || Browser.Edge) 
   input.focus();
 } catch(e) { }
 if(scrollToSelection && input.tagName == 'TEXTAREA') {
  var scrollHeight = input.scrollHeight;
  var approxCaretPos = startPos;
  var scrollTop = Math.max(Math.round(approxCaretPos * scrollHeight / textLen  - input.clientHeight / 2), 0);
  input.scrollTop = scrollTop;
 }
 if(makeReadOnly)
  input.readOnly = true;
};
var getTextWidthBeforePos = function(input, pos) {
 return ASPx.GetSizeOfText(input.value.toString().substr(0, pos), ASPx.GetCurrentStyle(input)).width;
};
var forceScrollToSelectionRange = function(input, startPos, endPos) {
 if(endPos === input.value.length)
  input.scrollLeft = input.scrollWidth;
 else if(startPos === 0 && endPos === 0)
  input.scrollLeft = 0;
 else {
  var inputRawWidth = ASPx.GetElementOffsetWidth(input) - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(input);
  if(inputRawWidth < input.scrollWidth) {
   var widthBeforeEndPos = getTextWidthBeforePos(input, endPos) + caretWidth;
   if(input.scrollLeft < widthBeforeEndPos - inputRawWidth)
    input.scrollLeft = widthBeforeEndPos - inputRawWidth;
   else {
    var widthBeforeStartPos = getTextWidthBeforePos(input, startPos) - caretWidth;
    if(input.scrollLeft > widthBeforeStartPos)
     input.scrollLeft = widthBeforeStartPos;
   }
  }
 }
};
Selection.GetInfo = function(input) {
 var start, end;
 if(Browser.IE && Browser.Version < 9) {
  var range = document.selection.createRange();
  var rangeCopy = range.duplicate();
  range.move('character', -input.value.length);
  range.setEndPoint('EndToStart', rangeCopy);
  start = range.text.length;
  end = start + rangeCopy.text.length;
 } else {
  try {
   start = input.selectionStart;
   end = input.selectionEnd;
  } catch (e) {
  }
 }
 return { startPos: start, endPos: end };
};
Selection.GetExtInfo = function(input) {
 var start = 0, end = 0, textLen = 0;
 if(Browser.IE && Browser.Version < 9) {
  var normalizedValue;
  var range, textInputRange, textInputEndRange;
  range = document.selection.createRange();
  if(range && range.parentElement() == input) {
   textLen = input.value.length;
   normalizedValue = input.value.replace(/\r\n/g, "\n");
   textInputRange = input.createTextRange();
   textInputRange.moveToBookmark(range.getBookmark());
   textInputEndRange = input.createTextRange();
   textInputEndRange.collapse(false);
   if(textInputRange.compareEndPoints("StartToEnd", textInputEndRange) > -1) {
    start = textLen;
    end = textLen;
   } else {
    start = normalizedValue.slice(0, start).split("\n").length - textInputRange.moveStart("character", -textLen) -1;
    if(textInputRange.compareEndPoints("EndToEnd", textInputEndRange) > -1)
     end = textLen;
    else
     end = normalizedValue.slice(0, end).split("\n").length - textInputRange.moveEnd("character", -textLen) - 1;    
   }
  }
  return {startPos: start, endPos: end};
 }
 try {
  start = input.selectionStart;
  end = input.selectionEnd;
 } catch (e) {
 }
 return {startPos: start, endPos: end}; 
};
Selection.SetCaretPosition = function(input, caretPos) {
 if(typeof caretPos === "undefined" || caretPos < 0)
  caretPos = input.value.length;
 Selection.Set(input, caretPos, caretPos, true);
};
Selection.GetCaretPosition = function(element, isDialogMode) {
 var pos = 0;
 if("selectionStart" in element) {
  pos = element.selectionStart;
 } else if("selection" in document) {
  element.focus();
  var sel = document.selection.createRange(),
   selLength = document.selection.createRange().text.length;
  sel.moveStart("character", -element.value.length);
  pos = sel.text.length - selLength;
 }
 if(isDialogMode && !pos) {
  pos = element.value.length - 1;
 }
 return pos;
};
Selection.Clear = function() {
 try {
  if(window.getSelection) {
   window.getSelection().removeAllRanges();
  }
  else if(document.selection) {
   if(document.selection.empty)
    document.selection.empty();
   else if(document.selection.clear)
    document.selection.clear();
  }
 } catch(e) {
 }
};
Selection.ClearOnMouseMove = function(evt) {
 if(!Browser.IE || (evt.button != 0)) 
  Selection.Clear();
};
Selection.SetElementSelectionEnabled = function(element, value) {
 var userSelectValue = value ? "" : "none";
 var func = value ? Evt.DetachEventFromElement : Evt.AttachEventToElement;
 if(Browser.Firefox)
  element.style.MozUserSelect = userSelectValue;
 else if(Browser.WebKitFamily)
  element.style.webkitUserSelect = userSelectValue;
 else if(Browser.IE && Browser.Version > 10 || Browser.Edge)
  element.style.msUserSelect = userSelectValue;
 else if(Browser.Opera)
  func(element, "mousemove", Selection.Clear);
 else {
  func(element, "selectstart", ASPx.FalseFunction);
  func(element, "mousemove", Selection.Clear);
 }
};
Selection.SetElementAsUnselectable = function(element, isWithChild, recursive) {
 if(element && element.nodeType == 1) {
  element.unselectable = "on";
  if(Browser.NetscapeFamily)
   element.onmousedown = ASPx.FalseFunction;
  if((Browser.IE && Browser.Version >= 9) || Browser.WebKitFamily)
   Evt.AttachEventToElement(element, "mousedown", Evt.PreventEventAndBubble);
  if(isWithChild === true){
   for(var j = 0; j < element.childNodes.length; j ++)
    Selection.SetElementAsUnselectable(element.childNodes[j], (!!recursive ? true : false), (!!recursive));
  }
 }
};
Selection.AreEqual = function(selection1, selection2) {
 return selection1.startPos === selection2.startPos && selection1.endPos === selection2.endPos;
};
ASPx.Selection = Selection;
var MouseScroller = { };
MouseScroller.MinimumOffset = 10;
MouseScroller.Create = function(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
 var element = getElement();
 if(!element) 
  return;
 if(!element.dxMouseScroller)
  element.dxMouseScroller = new MouseScroller.Extender(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed);
 return element.dxMouseScroller;
};
MouseScroller.Extender = function(getElement, getScrollXElement, getScrollYElement, needPreventScrolling, vertRecursive, onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
 this.getElement = getElement;
 this.getScrollXElement = getScrollXElement;
 this.getScrollYElement = getScrollYElement;
 this.needPreventScrolling = needPreventScrolling;
 this.vertRecursive = !!vertRecursive;
 this.createHandlers(onMouseDown || function() { }, onMouseMove || function() { }, onMouseUp || function() { }, onMouseUpMissed || function() { });
 this.update();
};
MouseScroller.Extender.prototype = {
 update: function() {
  if(this.element)
   Evt.DetachEventFromElement(this.element, ASPx.TouchUIHelper.touchMouseDownEventName, this.mouseDownHandler);
  this.element = this.getElement();
  Evt.AttachEventToElement(this.element, ASPx.TouchUIHelper.touchMouseDownEventName, this.mouseDownHandler);  
  Evt.AttachEventToElement(this.element, "click", this.mouseClickHandler);   
  if(Browser.MSTouchUI && this.element.className.indexOf(ASPx.TouchUIHelper.msTouchDraggableClassName) < 0)
   this.element.className += " " + ASPx.TouchUIHelper.msTouchDraggableClassName;
  this.scrollXElement = this.getScrollXElement();
  this.scrollYElement = this.getScrollYElement();
 },
 createHandlers: function(onMouseDown, onMouseMove, onMouseUp, onMouseUpMissed) {
  var mouseDownCounter = 0;
  this.onMouseDown = onMouseDown;
  this.onMouseMove = onMouseMove;
  this.onMouseUp = onMouseUp;  
  this.mouseDownHandler = function(e) {
   if(mouseDownCounter++ > 0) {
    this.finishScrolling();
    onMouseUpMissed();
   }
   var eventSource = Evt.GetEventSource(e);
   var requirePreventCustonScroll = ASPx.IsExists(ASPx.TouchUIHelper.RequirePreventCustomScroll) && ASPx.TouchUIHelper.RequirePreventCustomScroll(eventSource, this.element);
   this.requirePreventScroll = requirePreventCustonScroll || this.needPreventScrolling && this.needPreventScrolling(eventSource);
   if(this.requirePreventScroll)
    return;
   this.scrollableTreeLine = this.GetScrollableElements();
   this.firstX = this.prevX = Evt.GetEventX(e);
   this.firstY = this.prevY = Evt.GetEventY(e);
   Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
   this.onMouseDown(e);
  }.aspxBind(this);
  this.mouseMoveHandler = function(e) {
   if(ASPx.TouchUIHelper.isGesture)
    return;
   var x = Evt.GetEventX(e);
   var y = Evt.GetEventY(e);
   var xDiff = this.prevX - x;
   var yDiff = this.prevY - y;
   if(this.vertRecursive) {
    var isTopDirection = yDiff < 0;
    this.scrollYElement = this.GetElementForVertScrolling(isTopDirection, this.prevIsTopDirection, this.scrollYElement);
    this.prevIsTopDirection = isTopDirection;
   }
   if(this.scrollXElement && xDiff != 0)
    this.scrollXElement.scrollLeft += xDiff;
   if(this.scrollYElement && yDiff != 0) {
    this.scrollYElement.scrollTop += yDiff;
    var isOuterScrollableElement = this.scrollableTreeLine[this.scrollableTreeLine.length - 1] == this.scrollYElement;
    if(isOuterScrollableElement)
     y += yDiff;
   }
   this.prevX = x;
   this.prevY = y;
   Evt.PreventEvent(e);
   this.onMouseMove(e);
  }.aspxBind(this);
  this.mouseUpHandler = function(e) {
   this.finishScrolling();
   this.onMouseUp(e);
  }.aspxBind(this);
  this.mouseClickHandler = function(e){
   if(this.requirePreventScroll)
    return;
   var xDiff = this.firstX - Evt.GetEventX(e);
   var yDiff = this.firstY - Evt.GetEventY(e);
   if(xDiff > MouseScroller.MinimumOffset || yDiff > MouseScroller.MinimumOffset)
    return Evt.PreventEventAndBubble(e);
  }.aspxBind(this);
  this.finishScrolling = function() {
   Evt.DetachEventFromDocument(ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   Evt.DetachEventFromDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
   this.scrollableTreeLine = [];
   this.prevIsTopDirection = null;
   mouseDownCounter--;
  };
 },
 GetScrollableElements: function() {
  if(!this.vertRecursive) return [ ];
  var isHtmlScrollableElement = !ASPx.Browser.IsQuirksMode && !ASPx.Browser.Safari;
  var outerScrollableElementTag = isHtmlScrollableElement ? "HTML" : "BODY";
  return ASPx.GetElementTreeLine(this.element, null, function(el) { return el == document; })
   .filter(function(el) {
    var tagName = el.tagName;
    if(isHtmlScrollableElement && tagName == "BODY")
     return false;
    return ASPx.IsScrollableElement(el, false, true) || tagName == outerScrollableElementTag || el.dxScrollable;
   }.bind(this));
 },
 GetElementForVertScrolling: function(currentIsTop, prevIsTop, prevElement) {
  if(prevElement && currentIsTop === prevIsTop && this.GetVertScrollExcess(prevElement, currentIsTop) > 0)
   return prevElement;
  for(var i = 0; i < this.scrollableTreeLine.length; i++) {
   var element = this.scrollableTreeLine[i];
   var excess = this.GetVertScrollExcess(element, currentIsTop);
   if(excess > 0)
    return element;
  }
  return null;
 },
 GetVertScrollExcess: function(element, isTop) {
  if(isTop)
   return element.scrollTop;
  var isDocument = element.tagName == "HTML" || ASPx.Browser.Safari && !ASPx.Browser.IsQuirksMode && element.tagName == "BODY";
  var clientHeight = isDocument ? ASPx.GetDocumentClientHeight() : element.clientHeight;
  return element.scrollHeight - clientHeight - element.scrollTop;
 }
};
ASPx.MouseScroller = MouseScroller;
var Evt = { };
Evt.GetEvent = function(evt){
 return (typeof(event) != "undefined" && event != null && Browser.IE) ? event : evt; 
};
Evt.IsEventPrevented = function(evt) {
 return evt.defaultPrevented || evt.returnValue === false;
};
Evt.PreventEvent = function(evt){
 if(evt.preventDefault) {
  if(evt.cancelable)
   evt.preventDefault();
 }
 else
  evt.returnValue = false;
 return false;
};
Evt.PreventEventAndBubble = function(evt){
 Evt.PreventEvent(evt);
 if(evt.stopPropagation)
  evt.stopPropagation();
 evt.cancelBubble = true;
 return false;
};
Evt.CancelBubble = function(evt){
 evt.stopPropagation();
 return false;
};
Evt.PreventImageDragging = function(image) {
 if(image)
  image.ondragstart = function() { return false; };
};
Evt.PreventDragStart = function(evt) {
 evt = Evt.GetEvent(evt);
 var element = Evt.GetEventSource(evt);
 if(element.releaseCapture)
  element.releaseCapture(); 
 return false;
};
Evt.PreventElementDrag = function(element) {
 if(Browser.IE)
  Evt.AttachEventToElement(element, "dragstart", Evt.PreventEvent);
 else
  Evt.AttachEventToElement(element, "mousedown", Evt.PreventEvent);
};
Evt.PreventElementDragAndSelect = function(element, skipMouseMove, skipIESelect){
 if(Browser.WebKitFamily)
  Evt.AttachEventToElement(element, "selectstart", Evt.PreventEventAndBubble);
 if(Browser.IE){
  if(!skipIESelect)
   Evt.AttachEventToElement(element, "selectstart", ASPx.FalseFunction);
  if(!skipMouseMove)
   Evt.AttachEventToElement(element, "mousemove", Selection.ClearOnMouseMove);
  Evt.AttachEventToElement(element, "dragstart", Evt.PreventDragStart);
 }
};
Evt.GetEventSource = function(evt){
 if(!ASPx.IsExists(evt)) return null; 
 return evt.srcElement ? evt.srcElement : evt.target;
};
Evt.GetKeyCode = function(srcEvt) {
 return Browser.NetscapeFamily || Browser.Opera ? srcEvt.which : srcEvt.keyCode;
};
function clientEventRequiresDocScrollCorrection() {
 var isSafariVerLess3 = Browser.Safari && Browser.Version < 3,
  isMacOSMobileVerLess51 = Browser.MacOSMobilePlatform && Browser.Version < 5.1;
 return Browser.AndroidDefaultBrowser || Browser.AndroidChromeBrowser || !(isSafariVerLess3 || isMacOSMobileVerLess51);
}
Evt.GetEventX = function(evt){
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return ASPx.TouchUIHelper.getEventX(evt);
 return evt.clientX + (clientEventRequiresDocScrollCorrection() ? ASPx.GetDocumentScrollLeft() : 0);
};
Evt.GetEventY = function(evt){
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return ASPx.TouchUIHelper.getEventY(evt);
 return evt.clientY + (clientEventRequiresDocScrollCorrection() ? ASPx.GetDocumentScrollTop() : 0 );
};
Evt.IsLeftButtonPressed = function(evt) {
 if(ASPx.TouchUIHelper.isTouchEvent(evt))
  return true;
 evt = Evt.GetEvent(evt);
 if(!evt) return false;
 if(Browser.IE && Browser.Version < 11) {
  if(Browser.MSTouchUI)
   return true;
  return evt.button % 2 == 1; 
 } else if(Browser.WebKitFamily) {
  if(evt.type === "pointermove")
   return evt.buttons === 1;
  return evt.which == 1;
 } else if(Browser.NetscapeFamily || Browser.Edge || (Browser.IE && Browser.Version >= 11)) {
  if(evt.type === ASPx.TouchUIHelper.touchMouseMoveEventName)
   return evt.buttons === 1;
  return evt.which == 1;
 } else if(Browser.Opera)
  return evt.button == 0;
 return true;
};
Evt.IsRightButtonPressed = function(evt){
 evt = Evt.GetEvent(evt);
 if(!ASPx.IsExists(evt)) return false;
 if(Browser.IE || Browser.Edge) {
  if(evt.type === "pointermove")
   return evt.buttons === 2;
  return evt.button == 2;
 }
 else if(Browser.NetscapeFamily || Browser.WebKitFamily)
  return evt.which == 3;
 else if (Browser.Opera)
  return evt.button == 1;
 return true;
};
Evt.GetWheelDelta = function(evt) {
 var ret;
 if(Browser.NetscapeFamily && Browser.MajorVersion < 17)
  ret = -evt.detail;
 else if(Browser.Safari)
  ret = evt.wheelDelta;
 else
  ret = -evt.deltaY;
 if(Browser.Opera && Browser.Version < 9)
  ret = -ret;
 return ret;
};
Evt.IsWheelEventWithDirection = function(evt) {
 return ASPx.Data.ArrayContains(["wheel", "mousewheel"], evt.type);
};
Evt.GetWheelDeltaX = function(evt) {
 if(evt.type === "wheel")
  return -evt.deltaX;
 if(evt.type === "mousewheel")
  return evt.wheelDeltaX;
};
Evt.GetWheelDeltaY = function(evt) {
 if(evt.type === "wheel")
  return -evt.deltaY;
 if(evt.type === "mousewheel")
  return evt.wheelDeltaY;
};
Evt.IsPassiveListenersSupported = function() {
 if(Browser.Chrome && Browser.MajorVersion > 69 || Browser.Edge && Browser.MajorVersion > 15 || Browser.Firefox && Browser.MajorVersion > 62)
  return true;
 if(Evt.isPassiveListenersSupported === undefined) {
  Evt.isPassiveListenersSupported = false;
  try {
   var options = Object.defineProperty({}, "passive", { get: function() { Evt.isPassiveListenersSupported = true; } });
   window.addEventListener("test", options, options);
   window.removeEventListener("test", options, options);
  }
  catch(err) { Evt.isPassiveListenersSupported = false; }
 }
 return !!Evt.isPassiveListenersSupported;
};
Evt.AttachEventToElement = function(element, eventName, func, onlyBubbling, passive) {
 if(element.addEventListener)
  element.addEventListener(eventName, func, Evt.IsPassiveListenersSupported() ? { capture: !onlyBubbling, passive: !!passive } : !onlyBubbling);
 else
  element.attachEvent("on" + eventName, func);
};
Evt.DetachEventFromElement = function(element, eventName, func, onlyBubbling) {
 if(element.removeEventListener)
  element.removeEventListener(eventName, func, Evt.IsPassiveListenersSupported() ? { capture: !onlyBubbling } : !onlyBubbling);
 else
  element.detachEvent("on" + eventName, func);
};
Evt.AttachEventToDocument = function(eventName, func) {
 var attachingAllowed = ASPx.TouchUIHelper.onEventAttachingToDocument(eventName, func);
 if(attachingAllowed)
  Evt.AttachEventToDocumentCore(eventName, func);
};
Evt.AttachEventToDocumentCore = function(eventName, func) {
 Evt.AttachEventToElement(document, eventName, func);
};
Evt.DetachEventFromDocument = function(eventName, func) {
 Evt.DetachEventFromDocumentCore(eventName, func);
 ASPx.TouchUIHelper.onEventDettachedFromDocument(eventName, func);
};
Evt.DetachEventFromDocumentCore = function(eventName, func){
 Evt.DetachEventFromElement(document, eventName, func);
};
Evt.GetMouseWheelEventName = function() {
 if(Browser.Safari)
  return "mousewheel";
 if(Browser.NetscapeFamily && Browser.MajorVersion < 17)
  return "DOMMouseScroll";
 return "wheel";
};
Evt.AttachMouseEnterToElement = function (element, onMouseOverHandler, onMouseOutHandler) {
 Evt.AttachEventToElement(element, ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerOverEventName : "mouseover", function (evt) { mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler); });
 Evt.AttachEventToElement(element, ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerOutEventName : "mouseout", function (evt) { mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler); });
};
Evt.GetEventRelatedTarget = function(evt, isMouseOverEvent) {
 return evt.relatedTarget || (isMouseOverEvent ? evt.srcElement : evt.toElement);
};
function mouseEnterHandler(evt, element, onMouseOverHandler, onMouseOutHandler) {
 var isMouseOverExecuted = !!element.dxMouseOverExecuted;
 var isMouseOverEvent = (evt.type == "mouseover" || evt.type == ASPx.TouchUIHelper.pointerOverEventName);
 if(isMouseOverEvent && isMouseOverExecuted || !isMouseOverEvent && !isMouseOverExecuted)
  return;
 var source = Evt.GetEventRelatedTarget(evt, isMouseOverEvent);
 if(!ASPx.GetIsParent(element, source)) {
  element.dxMouseOverExecuted = isMouseOverEvent;
  if(isMouseOverEvent)
   onMouseOverHandler(element);
  else
   onMouseOutHandler(element);
 }
 else if(isMouseOverEvent && !isMouseOverExecuted) {
  element.dxMouseOverExecuted = true;
  onMouseOverHandler(element);
 }
}
Evt.DispatchEvent = function(target, eventName, canBubble, cancellable) {
 var event;
 if(Browser.IE && Browser.Version < 9) {
  eventName = "on" + eventName;
  if(eventName in target) {
   event = document.createEventObject();
   target.fireEvent("on" + eventName, event);
  }
 } else {
  event = document.createEvent("Event");
  event.initEvent(eventName, canBubble || false, cancellable || false);
  target.dispatchEvent(event);
 }
};
Evt.EmulateDocumentOnMouseDown = function(evt) {
 Evt.EmulateOnMouseDown(document, evt);
};
Evt.EmulateOnMouseDown = function(element, evt) {
 if(Browser.IE && Browser.Version < 9)
  element.fireEvent("onmousedown", evt);
 else if(!Browser.WebKitFamily){
  var emulatedEvt = document.createEvent("MouseEvents");
  emulatedEvt.initMouseEvent("mousedown", true, true, window, 0, evt.screenX, evt.screenY, 
   evt.clientX, evt.clientY, evt.ctrlKey, evt.altKey, evt.shiftKey, false, 0, null);
  element.dispatchEvent(emulatedEvt);
 }
};
Evt.EmulateOnMouseEvent = function (type, element, evt) {
 evt.type = type;
 var emulatedEvt = document.createEvent("MouseEvents");
 emulatedEvt.initMouseEvent(type, true, true, window, 0, evt.screenX, evt.screenY,
  evt.clientX, evt.clientY, evt.ctrlKey, evt.altKey, evt.shiftKey, false, 0, null);
 emulatedEvt.target = element;
 element.dispatchEvent(emulatedEvt);
};
Evt.EmulateMouseClick = function (element, evt) {
 var x = ASPx.GetElementOffsetWidth(element) / 2;
 var y = ASPx.GetElementOffsetHeight(element) / 2;
 if (!evt)
  evt = {
   bubbles: true,
   cancelable: true,
   view: window,
   detail: 1,
   screenX: 0,
   screenY: 0,
   clientX: x,
   clientY: y,
   ctrlKey: false,
   altKey: false,
   shiftKey: false,
   metaKey: false,
   button: 0,
   relatedTarget: null
  };
 Evt.EmulateOnMouseEvent("mousedown", element, evt);
 Evt.EmulateOnMouseEvent("mouseup", element, evt);
 Evt.EmulateOnMouseEvent("click", element, evt);
};
Evt.DoElementClick = function(element) {
 try{
  element.click();
 }
 catch(e){ 
 }
};
Evt.IsActionKeyPressed = function(evt) {
 return evt.keyCode === ASPx.Key.Space ||
     evt.keyCode === ASPx.Key.Enter ||
    (evt.keyCode === ASPx.Key.Down && evt.altKey);
};
Evt.InvokeMouseClickByKeyDown = function(evt, handler) {
 if(Evt.IsActionKeyPressed(evt)) {
  ASPx.Evt.PreventEvent(evt); 
  if(!handler)
   ASPx.Evt.GetEventSource(evt).onclick();
  else
   handler(evt);
 }
};
Evt.AttachContextMenuToElement = function (element, handler, onlyBubbling) {
 if (ASPx.TouchUIHelper.useLongTapHelper())
  element.detachContextMenuEventHandler = ASPx.TouchUIHelper.attachLongTapHandler(element, handler, onlyBubbling);
 else
  Evt.AttachEventToElement(element, "contextmenu", handler, onlyBubbling);
};
Evt.DetachContextMenuFromElement = function (element, handler) {
 if (element.detachContextMenuEventHandler)
  element.detachContextMenuEventHandler();
 else
  Evt.DetachEventFromElement(element, "contextmenu", handler);
};
Evt.PreventContextMenuOnElement = function(element) {
 Evt.AttachContextMenuToElement(element, function(evt) {
  Evt.PreventEvent(evt);
 });
};
ASPx.Evt = Evt;
var Attr = { };
Attr.GetAttribute = function(obj, attrName){
 if(obj.getAttribute)
  return obj.getAttribute(attrName);
 else if(obj.getPropertyValue) {
  if(Browser.Firefox) { 
   try {
    return obj.getPropertyValue(attrName);
   } catch(e) {
    return obj[attrName];
   }
  }
  return obj.getPropertyValue(attrName);
 }
 return null;
};
Attr.SetAttribute = function(obj, attrName, value){
 if(obj.setAttribute) {
  if(isSourceResetRequired() && attrName.toLowerCase() === "src") 
   obj.setAttribute(attrName, "");
  obj.setAttribute(attrName, value);
 } else if(obj.setProperty)
  obj.setProperty(attrName, value, "");
};
Attr.ToggleAttribute = function(obj, attrName, value, condition) {
 if(condition)
  Attr.SetAttribute(obj, attrName, value);
 else
  Attr.RemoveAttribute(obj, attrName);
};
Attr.RemoveAttribute = function(obj, attrName){
 if(obj.removeAttribute)
  obj.removeAttribute(attrName);
 else if(obj.removeProperty)
  obj.removeProperty(attrName);
};
Attr.IsExistsAttribute = function(obj, attrName){
 var value = Attr.GetAttribute(obj, attrName);
 return (value != null) && (value !== "");
};
Attr.SetOrRemoveAttribute = function(obj, attrName, value) {
 if(!value)
  Attr.RemoveAttribute(obj, attrName);
 else
  Attr.SetAttribute(obj, attrName, value);
};
Attr.SaveAttribute = function(obj, attrName, savedObj, savedAttrName){
 if(!Attr.IsExistsAttribute(savedObj, savedAttrName)){
  var oldValue = Attr.IsExistsAttribute(obj, attrName) ? Attr.GetAttribute(obj, attrName) : ASPx.EmptyObject;
  Attr.SetAttribute(savedObj, savedAttrName, oldValue);
 }
};
Attr.SaveStyleAttribute = function(obj, attrName){
 Attr.SaveAttribute(obj.style, attrName, obj, "saved" + attrName);
};
Attr.ChangeAttributeExtended = function(obj, attrName, savedObj, savedAttrName, newValue){
 Attr.SaveAttribute(obj, attrName, savedObj, savedAttrName);
 Attr.SetAttribute(obj, attrName, newValue);
};
Attr.ChangeAttribute = function(obj, attrName, newValue){
 Attr.ChangeAttributeExtended(obj, attrName, obj, "saved" + attrName, newValue);
};
Attr.ChangeStyleAttribute = function(obj, attrName, newValue){
 Attr.ChangeAttributeExtended(obj.style, attrName, obj, "saved" + attrName, newValue);
};
Attr.ResetAttributeExtended = function(obj, attrName, savedObj, savedAttrName){
 Attr.SaveAttribute(obj, attrName, savedObj, savedAttrName);
 Attr.SetAttribute(obj, attrName, "");
 Attr.RemoveAttribute(obj, attrName);
};
Attr.ResetAttribute = function(obj, attrName){
 Attr.ResetAttributeExtended(obj, attrName, obj, "saved" + attrName);
};
Attr.ResetStyleAttribute = function(obj, attrName){
 Attr.ResetAttributeExtended(obj.style, attrName, obj, "saved" + attrName);
};
Attr.RestoreAttributeExtended = function(obj, attrName, savedObj, savedAttrName){
 if(Attr.IsExistsAttribute(savedObj, savedAttrName)){
  var oldValue = Attr.GetAttribute(savedObj, savedAttrName);
  if(oldValue != ASPx.EmptyObject)
   Attr.SetAttribute(obj, attrName, oldValue);
  else
   Attr.RemoveAttribute(obj, attrName);
  Attr.RemoveAttribute(savedObj, savedAttrName);
  return true;
 }
 return false;
};
Attr.RestoreAttribute = function(obj, attrName){
 return Attr.RestoreAttributeExtended(obj, attrName, obj, "saved" + attrName);
};
Attr.RestoreStyleAttribute = function(obj, attrName){
 return Attr.RestoreAttributeExtended(obj.style, attrName, obj, "saved" + attrName);
};
Attr.CopyAllAttributes = function(sourceElem, destElement) {
 var attrs = sourceElem.attributes;
 for(var n = 0; n < attrs.length; n++) {
  var attr = attrs[n];
  if(attr.specified) {
   var attrName = attr.nodeName;
   var attrValue = sourceElem.getAttribute(attrName, 2);
   if(attrValue == null)
    attrValue = attr.nodeValue;
   destElement.setAttribute(attrName, attrValue, 0); 
  }
 }
 if(sourceElem.style.cssText !== '')
  destElement.style.cssText = sourceElem.style.cssText;
};
Attr.RemoveAllAttributes = function(element, excludedAttributes) {
 var excludedAttributesHashTable = {};
 if(excludedAttributes)
  excludedAttributesHashTable = Data.CreateHashTableFromArray(excludedAttributes);
 if(element.attributes) {
  var attrArray = element.attributes;
  for(var i = 0; i < attrArray.length; i++) {
   var attrName = attrArray[i].name;
   if(!ASPx.IsExists(excludedAttributesHashTable[attrName.toLowerCase()])) {
    try {
     attrArray.removeNamedItem(attrName);
    } catch (e) { }
   }
  }
 }
};
Attr.RemoveStyleAttribute = function(element, attrName) {
 if(element.style) {
  if(Browser.Firefox && element.style[attrName]) 
   element.style[attrName] = "";
  if(element.style.removeAttribute && element.style.removeAttribute != "")
   element.style.removeAttribute(attrName);
  else if(element.style.removeProperty && element.style.removeProperty != "")
   element.style.removeProperty(attrName);
 }
};
Attr.RemoveAllStyles = function(element) {
 if(element.style) {
  for(var key in element.style)
   Attr.RemoveStyleAttribute(element, key);
    Attr.RemoveAttribute(element, "style");
 }
};
Attr.GetTabIndexAttributeName = function(){
 return Browser.IE  ? "tabIndex" : "tabindex";
};
Attr.ChangeTabIndexAttribute = function(element){
 var attribute = Attr.GetTabIndexAttributeName(); 
 if(Attr.GetAttribute(element, attribute) != -1)
    Attr.ChangeAttribute(element, attribute, -1);
};
Attr.SaveTabIndexAttributeAndReset = function(element) {
 var attribute = Attr.GetTabIndexAttributeName();
 Attr.SaveAttribute(element, attribute, element, "saved" + attribute);
 Attr.SetAttribute(element, attribute, -1);
};
Attr.RestoreTabIndexAttribute = function(element){
 var attribute = Attr.GetTabIndexAttributeName();
 if(Attr.IsExistsAttribute(element, attribute)) {
  if(Attr.GetAttribute(element, attribute) == -1) {
   if(Attr.IsExistsAttribute(element, "saved" + attribute)){
    var oldValue = Attr.GetAttribute(element, "saved" + attribute);
    if(oldValue != ASPx.EmptyObject)
     Attr.SetAttribute(element, attribute, oldValue);
    else {
     if(Browser.WebKitFamily) 
      Attr.SetAttribute(element, attribute, 0); 
     Attr.RemoveAttribute(element, attribute);   
    }
    Attr.RemoveAttribute(element, "saved" + attribute); 
   }
  }
 }
};
Attr.ChangeAttributesMethod = function(enabled){
 return enabled ? Attr.RestoreAttribute : Attr.ResetAttribute;
};
Attr.InitiallyChangeAttributesMethod = function(enabled){
 return enabled ? Attr.ChangeAttribute : Attr.ResetAttribute;
};
Attr.ChangeStyleAttributesMethod = function(enabled){
 return enabled ? Attr.RestoreStyleAttribute : Attr.ResetStyleAttribute;
};
Attr.InitiallyChangeStyleAttributesMethod = function(enabled){
 return enabled ? Attr.ChangeStyleAttribute : Attr.ResetStyleAttribute;
};
Attr.ChangeEventsMethod = function(enabled){
 return enabled ? Evt.AttachEventToElement : Evt.DetachEventFromElement;
};
Attr.ChangeDocumentEventsMethod = function(enabled){
 return enabled ? Evt.AttachEventToDocument : Evt.DetachEventFromDocument;
};
Attr.ChangeCellSpanCount = function(cell, value, isColumnSpan) {
 if(!cell) return;
 var propertyKey = isColumnSpan ? "colSpan" : "rowSpan";
 var prevValue = cell[propertyKey];
 if(value > 1)
  cell[propertyKey] = value;
 else if(prevValue !== 1)
  Attr.RemoveAttribute(cell, propertyKey);
};
function isSourceResetRequired() {
 return Browser.IE && Browser.MajorVersion >= 11;
}
ASPx.Attr = Attr;
var Aria = {
 atomic: "aria-atomic",
 checked: "aria-checked",
 descendant: "aria-activedescendant",
 described: "aria-describedby",
 disabled: "aria-disabled",
 expanded: "aria-expanded",
 haspopup: "aria-haspopup",
 invalid: "aria-invalid",
 label: "aria-label",
 labelled: "aria-labelledby",
 level: "aria-level",
 owns: "aria-owns",
 posinset: "aria-posinset",
 role: "role",
 selected: "aria-selected",
 setsize: "aria-setsize",
 valuemax: "aria-valuemax",
 valuemin: "aria-valuemin",
 valuenow: "aria-valuenow"
};
Aria.SetOrRemoveDescendant = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.descendant, value);
};
Aria.SetOrRemoveLabel = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.label, value);
};
Aria.AppendLabel = function(obj, value, checkExists) {
 var currentValue = ASPx.Attr.GetAttribute(obj, Aria.label) || "";
 var resultParts = [ ];
 if(currentValue)
  resultParts.push(currentValue);
 var needAppendValue = value && (!checkExists || currentValue.indexOf(value) == -1);
 if(needAppendValue)
  resultParts.push(value);
 ASPx.Attr.SetAttribute(obj, Aria.label, resultParts.join(" "));
};
Aria.SetOrRemoveLabelled = function(obj, value) {
 ASPx.Attr.SetOrRemoveAttribute(obj, Aria.labelled, value);
};
Aria.SetApplicationRole = function(obj) {
  ASPx.Attr.SetAttribute(obj, Aria.role, "application");
};
Aria.SetSilence = function(obj) {
 ASPx.Attr.SetAttribute(obj, Aria.label, ";");
};
Aria.SetExpanded = function(obj, expanded) {
 if(!obj || !ASPx.Attr.GetAttribute(obj, Aria.expanded)) return;
 Aria.SetBoolAttribute(obj, Aria.expanded, expanded);
};
Aria.SetAtomic = function(obj, value) {
 Aria.SetBoolAttribute(obj, Aria.atomic, value);
};
Aria.SetBoolAttribute = function(obj, attribute, value) {
 if(value)
  ASPx.Attr.SetAttribute(obj, attribute, true);
 else 
  ASPx.Attr.SetAttribute(obj, attribute, false);
};
ASPx.Attr.Aria = Aria;
var Color = { };
function _aspxToHex(d) {
 return (d < 16) ? ("0" + d.toString(16)) : d.toString(16);
}
Color.RGBRegexp = /rgb\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*\)/;
Color.RGBARegexp = /rgba?\s*\(\s*([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\s*,?\s*([0-9]*\.?[0-9]*)\s*\)/;
Color.ColorToHexadecimal = function(colorValue, isRGBA) {
 if(typeof(colorValue) == "number") {
  var r = colorValue & 0xFF;
  var g = (colorValue >> 8) & 0xFF;
  var b = (colorValue >> 16) & 0xFF;
  return "#" + _aspxToHex(r) + _aspxToHex(g) + _aspxToHex(b);
 }
 if(colorValue && (colorValue.substr(0, 3).toLowerCase() == "rgb")) {
  var regResult = colorValue.toLowerCase().match(isRGBA ? Color.RGBARegexp : Color.RGBRegexp);
  if(regResult) {
   var r = parseInt(regResult[1]);
   var g = parseInt(regResult[2]);
   var b = parseInt(regResult[3]);
   if (isRGBA)
    return { r: r, g: g, b: b, a: regResult[4] !== undefined ? parseFloat(regResult[4]) : 1 };
   return "#" + _aspxToHex(r) + _aspxToHex(g) + _aspxToHex(b);
  }
  return null;
 } 
 if(colorValue && (colorValue.charAt(0) == "#"))
  return colorValue;
 return null;
};
Color.Names = {
 AddColorNames: function(stringResourcesObj) {
  if(stringResourcesObj) {
   for(var key in stringResourcesObj)
    if(stringResourcesObj.hasOwnProperty(key))
     this[key] = stringResourcesObj[key];
  }
 }
};
ASPx.Color = Color;
var Url = { };
Url.Navigate = function(url, target) {
 var javascriptPrefix = "javascript:";
 if(!url || url === "")
  return;
 else if(url.indexOf(javascriptPrefix) != -1) 
  eval(url.substr(javascriptPrefix.length));
 else {
  try{
   if(target != "")
    navigateTo(url, target);
   else
    location.href = url;
  }
  catch(e){
  }
 }
};
Url.NavigateByLink = function(linkElement) {
 Url.Navigate(Attr.GetAttribute(linkElement, "href"), linkElement.target);
};
Url.GetAbsoluteUrl = function(url) {
 if(url)
  url = Url.getURLObject(url).href;
 return url;
};
Url.Redirect = function(url) {
 if(!ASPx.Browser.IE)
  window.location.href = url;
 else { 
  var fakeLink = document.createElement("a");
  fakeLink.href = url;
  document.body.appendChild(fakeLink);
  try { fakeLink.click(); } catch(e) { } 
 }
};
var absolutePathPrefixes = 
 [ "about:", "file:///", "ftp://", "gopher://", "http://", "https://", "javascript:", "mailto:", "news:", "res://", "telnet://", "view-source:" ];
Url.isAbsoluteUrl = function(url) {
 if (url) {
  for (var i = 0; i < absolutePathPrefixes.length; i++) {
   if(url.indexOf(absolutePathPrefixes[i]) == 0)
    return true;
  }
 }
 return false;
};
Url.getURLObject = function(url) {
 var link = document.createElement('A');
 link.href = url || "";
 return { 
  href: link.href,
  protocol: link.protocol,
  host: link.host,
  port: link.port,
  pathname: link.pathname,
  search: link.search,
  hash: link.hash
 }; 
};
Url.getRootRelativeUrl = function(url) {
 return getRelativeUrl(url, !Url.isRootRelativeUrl(url), true); 
};
Url.getPathRelativeUrl = function(url) {
 return getRelativeUrl(url, !Url.isPathRelativeUrl(url), false);
};
function getRelativeUrl(url, isValid, isRootRelative) {
 if(url && !(/data:([^;]+\/?[^;]*)(;charset=[^;]*)?(;base64,)/.test(url)) && isValid) {
  var urlObject = Url.getURLObject(url);
  var baseUrlObject = Url.getURLObject();
  if(!Url.isAbsoluteUrl(url) || urlObject.host === baseUrlObject.host && urlObject.protocol === baseUrlObject.protocol) {
   url = urlObject.pathname;
   if(!isRootRelative)
    url = getPathRelativeUrl(baseUrlObject.pathname, url);
   url = url + urlObject.search + urlObject.hash;
  }
 }
 return url;   
}
function getPathRelativeUrl(baseUrl, url) {
 var requestSegments = getSegments(baseUrl, false);
 var urlSegments = getSegments(url, true);
 return buildPathRelativeUrl(requestSegments, urlSegments, 0, 0, "");
}
function getSegments(url, addTail) {
 var segments = [];
 var startIndex = 0;
 var endIndex = -1;
 while ((endIndex = url.indexOf("/", startIndex)) != -1) {
  segments.push(url.substring(startIndex, ++endIndex));
  startIndex = endIndex;
 }
 if(addTail && startIndex < url.length)
  segments.push(url.substring(startIndex, url.length)); 
 return segments;
}
function buildPathRelativeUrl(requestSegments, urlSegments, reqIndex, urlIndex, buffer) {
 if(urlIndex >= urlSegments.length)
  return buffer;
 if(reqIndex >= requestSegments.length)
  return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex, urlIndex + 1, buffer + urlSegments[urlIndex]);
 if(requestSegments[reqIndex] === urlSegments[urlIndex] && urlIndex === reqIndex)
  return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex + 1, urlIndex + 1, buffer);
 return buildPathRelativeUrl(requestSegments, urlSegments, reqIndex + 1, urlIndex, buffer + "../");
}
Url.isPathRelativeUrl = function(url) {
 return !!url && !Url.isAbsoluteUrl(url) && url.indexOf("/") != 0;  
};
Url.isRootRelativeUrl = function(url) {
 return !!url && !Url.isAbsoluteUrl(url) && url.indexOf("/") == 0 && url.indexOf("//") != 0;
};
function navigateTo(url, target) {
 var lowerCaseTarget = target.toLowerCase();
 if("_top" == lowerCaseTarget)
  top.location.href = url;
 else if("_self" == lowerCaseTarget)
  location.href = url;
 else if("_search" == lowerCaseTarget)
  openInNewWindow(url);
 else if("_media" == lowerCaseTarget)
  openInNewWindow(url);
 else if("_parent" == lowerCaseTarget)
  window.parent.location.href = url;
 else if("_blank" == lowerCaseTarget)
  openInNewWindow(url);
 else {
  var frame = getFrame(top.frames, target);
  if(frame != null)
   frame.location.href = url;
  else
   openInNewWindow(url);
 }
}
function openInNewWindow(url) {
 if(ASPx.Browser.Safari)
  openInNewWindowViaIframe(url);
 else {
  var newWindow = window.open();
  newWindow.opener = null;
  newWindow.location = url;
 }
}
function openInNewWindowViaIframe(url) {
 var iframe = document.createElement('iframe');
 iframe.style.display = 'none';
 document.body.appendChild(iframe);
 var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
 var openArgs = '"' + url + '"';
 var script = iframeDoc.createElement('script');
 script.type = 'text/javascript';
 script.text = 'window.parent = null; ' +
  'window.top = null;' +
  'window.frameElement = null;' +
  'var child = window.open(' + openArgs + ');' +
  'child.opener = null';
 iframeDoc.body.appendChild(script);
 document.body.removeChild(iframe);
}
ASPx.Url = Url;
var Json = { };
function isValid(JsonString) {
 return !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(JsonString.replace(/"(\\.|[^"\\])*"/g, '')));
}
Json.Eval = function(jsonString, controlName) {
 if(isValid(jsonString))
  return eval("(" + jsonString + ")");
 else
  throw new Error(controlName + " received incorrect JSON-data: " + jsonString);
};
Json.ToJson = function(param, skipEncodeHtml){
 var paramType = typeof(param);
 if((paramType == "undefined") || (param == null))
  return null;
 if((paramType == "object") && (typeof(param.__toJson) == "function"))
  return param.__toJson();
 if((paramType == "number") || (paramType == "boolean"))
  return param;
 if(param.constructor == Date)
  return dateToJson(param);
 if(paramType == "string") {
  var result = param.replace(/\\/g, "\\\\");
  result = result.replace(/"/g, "\\\"");
  result = result.replace(/\n/g, "\\n");
  result = result.replace(/\r/g, "\\r");
  if(!skipEncodeHtml) {
   result = result.replace(/</g, "\\u003c");
   result = result.replace(/>/g, "\\u003e");
  }
  return "\"" + result + "\"";
 }
 if(param.constructor == Array){
  var values = [];
  for(var i = 0; i < param.length; i++) {
   var jsonValue = Json.ToJson(param[i], skipEncodeHtml);
   if(jsonValue === null)
    jsonValue = "null";
   values.push(jsonValue);
  }
  return "[" + values.join(",") + "]";
 }
 var exceptKeys = {};
 if(ASPx.Ident.IsArray(param.__toJsonExceptKeys))
  exceptKeys = Data.CreateHashTableFromArray(param.__toJsonExceptKeys);
 exceptKeys["__toJsonExceptKeys"] = 1;
 var values = [];
 for(var key in param) {
  if(param.hasOwnProperty(key)) {
   if(ASPx.IsFunction(param[key]))
    continue;
   if(exceptKeys[key] == 1)
    continue;
   values.push(Json.ToJson(key) + ":" + Json.ToJson(param[key], skipEncodeHtml));
  }
 }
 return "{" + values.join(",") + "}";
};
function dateToJson(date) {
 var result = [ 
  date.getFullYear(),
  date.getMonth(),
  date.getDate()
 ];
 var time = {
  h: date.getHours(),
  m: date.getMinutes(),
  s: date.getSeconds(),
  ms: date.getMilliseconds()
 };
 if(time.h || time.m || time.s || time.ms)
  result.push(time.h);
 if(time.m || time.s || time.ms)
  result.push(time.m);
 if(time.s || time.ms)
  result.push(time.s);
 if(time.ms)
  result.push(time.ms);
 return "new Date(" + result.join() + ")";
}
ASPx.Json = Json;
ASPx.CreateClass = function(parentClass, properties) {
 if(arguments.length == 1) {
  properties = parentClass;
  parentClass = null;
 }
 var ret = function() {
  if(ret.preparing) 
   return delete(ret.preparing);
  if(ret.constr) {
   this.constructor = ret;
   ret.constr.apply(this, arguments);
  }
 };
 ret.prototype = {};
 if(parentClass) {
  parentClass.preparing = true;
  for(var name in parentClass) {
   if(parentClass.hasOwnProperty(name) && name != 'constr' && ASPx.IsFunction(parentClass[name]) && !ret[name])
    ret[name] = parentClass[name].aspxBind(parentClass);
  }
  ret.prototype = new parentClass;
  ret.prototype.constructor = parentClass;
  ret.constr = parentClass;
 }
 if(properties) {
  var constructorName = "constructor";
  for(var name in properties) {
   if(!properties.hasOwnProperty(name)) 
    continue;
   var getter = Object.getOwnPropertyDescriptor(properties, name).get;
   var setter = Object.getOwnPropertyDescriptor(properties, name).set;
   if(getter || setter)
    Object.defineProperty(ret.prototype, name, {
     set: setter,
     get: getter,
     enumerable: true,
     configurable: true
    });
   if(name != constructorName && !getter && !setter)
    ret.prototype[name] = properties[name];
  }
  if(properties[constructorName] && properties[constructorName] != Object)
   ret.constr = properties[constructorName];
 }
 return ret;
};
var registeredMixins = {};
ASPx.GetMixin = function (name, baseClass) {
 var mixinCache = baseClass._mixins || (baseClass._mixins = {});
 var resultClass = mixinCache[name];
 if (!resultClass) {
  var mixinCodeBuilder = registeredMixins[name];
  if (!mixinCodeBuilder)
   throw new Error("mixin with the '" + name + "' is not registered");
  var mixinCode = mixinCodeBuilder(baseClass);
  mixinCode.mixinName = name;
  resultClass = ASPx.CreateClass(baseClass, mixinCode);
  mixinCache[name] = resultClass;
 }
 return resultClass;
};
ASPx.RegisterMixin = function() {
 var name = arguments.length == 1 ? "mixin_" + ASPx.CreateGuid() : arguments[0];
 var mixinCodeBuilder = arguments[arguments.length - 1];
 if (registeredMixins[name])
  throw new Error("mixin with the '" + name + "' name is already defined");
 registeredMixins[name] = mixinCodeBuilder;
 return function(baseClass) { return ASPx.GetMixin(name, baseClass); };
};
ASPx.FormatCallbackArg = function(prefix, arg) {
 if(prefix == null && arg == null)
  return ""; 
 if(prefix == null) prefix = "";
 if(arg == null) arg = "";
 if(arg != null && !ASPx.IsExists(arg.length) && ASPx.IsExists(arg.value))
  arg = arg.value;
 arg = arg.toString();
 return [prefix, '|', arg.length, '|' , arg].join('');
};
ASPx.FormatCallbackArgs = function(callbackData) {
 var sb = [ ];
 for(var i = 0; i < callbackData.length; i++)
  sb.push(ASPx.FormatCallbackArg(callbackData[i][0], callbackData[i][1]));
 return sb.join("");
};
ASPx.ParseShortcutString = function(shortcutString) {
 if(!shortcutString)
  return 0;
 var isCtrlKey = false;
 var isShiftKey = false;
 var isAltKey = false;
 var isMetaKey = false;
 var keyCode = null;
 var shcKeys = shortcutString.toString().split("+");
 if(shcKeys.length > 0) {
  for(var i = 0; i < shcKeys.length; i++) {
   var key = Str.Trim(shcKeys[i].toUpperCase());
   switch (key) {
    case "CONTROL":
    case "CONTROLKEY":
    case "CTRL":
     isCtrlKey = true;
     break;
    case "SHIFT":
    case "SHIFTKEY":
     isShiftKey = true;
     break;
    case "ALT":
     isAltKey = true;
     break;
    case "CMD":
     isMetaKey = true;
     break;
    case "F1": keyCode = ASPx.Key.F1; break;
    case "F2": keyCode = ASPx.Key.F2; break;
    case "F3": keyCode = ASPx.Key.F3; break;
    case "F4": keyCode = ASPx.Key.F4; break;
    case "F5": keyCode = ASPx.Key.F5; break;
    case "F6": keyCode = ASPx.Key.F6; break;
    case "F7": keyCode = ASPx.Key.F7; break;
    case "F8": keyCode = ASPx.Key.F8; break;
    case "F9": keyCode = ASPx.Key.F9; break;
    case "F10":   keyCode = ASPx.Key.F10; break;
    case "F11":   keyCode = ASPx.Key.F11; break;
    case "F12":   keyCode = ASPx.Key.F12; break;
    case "RETURN":
    case "ENTER": keyCode = ASPx.Key.Enter; break;
    case "HOME":  keyCode = ASPx.Key.Home; break;
    case "END":   keyCode = ASPx.Key.End; break;
    case "LEFT":  keyCode = ASPx.Key.Left; break;
    case "RIGHT": keyCode = ASPx.Key.Right; break;
    case "UP": keyCode = ASPx.Key.Up; break;
    case "DOWN":  keyCode = ASPx.Key.Down; break;
    case "PAGEUP": keyCode = ASPx.Key.PageUp; break;
    case "PAGEDOWN": keyCode = ASPx.Key.PageDown; break;
    case "SPACE": keyCode = ASPx.Key.Space; break;
    case "TAB":   keyCode = ASPx.Key.Tab; break;
    case "BACKSPACE": 
    case "BACK": keyCode = ASPx.Key.Backspace; break;
    case "CONTEXT": keyCode = ASPx.Key.ContextMenu; break;
    case "ESCAPE":
    case "ESC":
     keyCode = ASPx.Key.Esc;
     break;
    case "DELETE":
    case "DEL":
     keyCode = ASPx.Key.Delete;
     break;
    case "INSERT":
    case "INS":
     keyCode = ASPx.Key.Insert;
     break;
    case "PLUS":
     keyCode = "+".charCodeAt(0);
     break;
    default:
     keyCode = key.charCodeAt(0);
     break;
   }
  }
 } else
  ASPx.ShowErrorAlert("Invalid shortcut");
 return ASPx.GetShortcutCode(keyCode, isCtrlKey, isShiftKey, isAltKey, isMetaKey);
};
ASPx.GetShortcutCode = function(keyCode, isCtrlKey, isShiftKey, isAltKey, isMetaKey) {
 var value = keyCode;
 value |= isCtrlKey ? ASPx.ModifierKey.Ctrl : 0;
 value |= isShiftKey ? ASPx.ModifierKey.Shift : 0;
 value |= isAltKey ? ASPx.ModifierKey.Alt : 0;
 value |= isMetaKey ? ASPx.ModifierKey.Meta : 0;
 return value;
};
ASPx.GetShortcutCodeByEvent = function(evt) {
 return ASPx.GetShortcutCode(Evt.GetKeyCode(evt), evt.ctrlKey, evt.shiftKey, evt.altKey, ASPx.Browser.MacOSPlatform ? evt.metaKey : false);
};
ASPx.IsPasteShortcut = function(evt) {
 if(evt.type === "paste")
  return true;
 var keyCode = Evt.GetKeyCode(evt);
 if(Browser.NetscapeFamily && evt.which == 0)  
  keyCode = evt.keyCode;
 return (evt.ctrlKey && (keyCode == 118  || (keyCode == 86))) ||
     (evt.shiftKey && !evt.ctrlKey && !evt.altKey &&
     (keyCode == ASPx.Key.Insert)) ;
};
var NotPrintableKeyCodes = null;
ASPx.IsPrintableKey = function(keyCode) {
 if (!NotPrintableKeyCodes)
  NotPrintableKeyCodes = Object.keys(ASPx.Key).map(function(key) { return ASPx.Key[key]; });
 return !ASPx.Data.ArrayContains(NotPrintableKeyCodes, keyCode);
};
ASPx.SetFocus = function(element, selectAction) {
 function focusCore(element, selectAction){
  try {
    element.focus();
    if(Browser.IE && document.activeElement != element)
     element.focus();
    if(selectAction) {
     var currentSelection = Selection.GetInfo(element);
     if(currentSelection.startPos == currentSelection.endPos) {
      switch(selectAction) {
       case "start":
        Selection.SetCaretPosition(element, 0);
        break;
       case "all":
        Selection.Set(element);
        break;
      }
     }
    }
   } catch (e) {
  }
 }
 if(ASPxClientUtils.iOSPlatform) 
  focusCore(element, selectAction);
 else {
  window.setTimeout(function() { 
   focusCore(element, selectAction);
  }, 100);
 }
};
ASPx.IsFocusableCore = function(element, skipContainerVisibilityCheck) {
 var current = element;
 while(current && current.nodeType == 1) {
  if(current == element || !skipContainerVisibilityCheck(current)) {
   var tagName = current.tagName.toUpperCase();
   if(tagName == "BODY")
    return true;
   var disabledElementTags = ["INPUT", "BUTTON", "TEXTAREA", "SELECT", "OPTION"];
   if(disabledElementTags.indexOf(tagName) !== -1 && current.disabled || !ASPx.GetElementDisplay(current) || !ASPx.GetElementVisibility(current))
    return false;
  }
  current = current.parentNode;
 }
 return true;
};
ASPx.IsFocusable = function(element) {
 return ASPx.IsFocusableCore(element, ASPx.FalseFunction);
};
ASPx.IsActionElement = function(element) {
 if(!ASPx.IsExistsElement(element))
  return false;
 var tabIndex = parseInt(ASPx.Attr.GetAttribute(element, ASPx.Attr.GetTabIndexAttributeName()));
 var hasTabIndex = !isNaN(tabIndex);
 var hasNonNegativeTabIndex = hasTabIndex && tabIndex > -1;
 var hasNegativeTabIndex = hasTabIndex && tabIndex < 0;
 var tagName = element.tagName;
 var focusableElementTags = ["BUTTON", "SELECT", "TEXTAREA", "OPTION", "IFRAME"];
 var isFocusableCore = ASPx.IsFocusable(element);
 var isFocusableTag = focusableElementTags.indexOf(tagName) !== -1;
 var isFocusableLink = tagName === "A" && (!!element.href || hasNonNegativeTabIndex);
 var isFocusableInput = tagName === "INPUT" && element.type.toLowerCase() !== "hidden";
 var isFocusableByTabIndex = tagName !== "INPUT" && hasNonNegativeTabIndex;
 var isEditableDiv = tagName == "DIV" && element.contentEditable === "true";
 return isFocusableCore && !hasNegativeTabIndex && (isFocusableTag || isFocusableLink || isFocusableInput || isFocusableByTabIndex || isEditableDiv);
};
ASPx.GetCanBeActiveElementsInContainer = function(container) {
 var canBeActiveTags = ["INPUT", "A", "UL", "BUTTON", "TEXTAREA", "SELECT", "IFRAME"],
  canBeActiveElements = [];
 Data.ForEach(canBeActiveTags, function(tag) {
  var elements = container.getElementsByTagName(tag);
  canBeActiveElements = canBeActiveElements.concat([].slice.call(elements));
 });
 return canBeActiveElements;
};
function isActionElementAllowedByPredicate(element, predicate) {
  var allowedByPredicate = !predicate || predicate(element);
  return allowedByPredicate && ASPx.IsActionElement(element);
}
ASPx.FindChildActionElements = function(container, predicate) {
 return ASPx.GetNodes(container, function(el) {
  return isActionElementAllowedByPredicate(el, predicate);
 });
};
ASPx.FindAllSortedActionElements = function(container, predicate) {
 var result = [ ];
 if(!container || !container.getElementsByTagName) return result;
 var actionElements = ASPx.FindChildActionElements(container, predicate);
 var getTabOrderValue = function(el) {
  var tabIndex = parseInt(ASPx.Attr.GetAttribute(el, ASPx.Attr.GetTabIndexAttributeName()));
  return isNaN(tabIndex) ? 0 : tabIndex;
 };
 var positiveTabIndexElements = actionElements.filter(function(x) { return getTabOrderValue(x) > 0; });
 var nonPositiveTabIndexElements = actionElements.filter(function(x) { return getTabOrderValue(x) === 0; });
 var sortedTabIndexElements = positiveTabIndexElements.sort(function(x, y) { return getTabOrderValue(x) - getTabOrderValue(y); });
 result = sortedTabIndexElements.concat(nonPositiveTabIndexElements);
 return result;
};
ASPx.FindFirstChildActionElement = function(container, predicate) {
 if(!container || isActionElementAllowedByPredicate(container, predicate))
  return !container ? null : container;
 var sortedActionElements = ASPx.FindAllSortedActionElements(container, predicate);
 return sortedActionElements[0];
};
ASPx.FindLastChildActionElement = function(container, predicate) {
 if(!container)
  return null;
 var sortedActionElements = ASPx.FindAllSortedActionElements(container, predicate);
 var actionElement = sortedActionElements[sortedActionElements.length - 1];
 if(!actionElement && isActionElementAllowedByPredicate(container, predicate))
  actionElement = container;
 return actionElement;
};
ASPx.GetParentClientControls = function(name) {
 var nameParts = name.split("_");
 var result = [ ];
 var controlCollection = ASPx.GetControlCollection();
 for(var i = 1; i <= nameParts.length; i++) {
  var controlName = nameParts.slice(0, i).join("_");
  var control = controlCollection.Get(controlName);
  if(control)
   result.push(control);
 }
 return result;
};
ASPx.GetRootClientControl = function(childControlName) {
 var parentControls = ASPx.GetParentClientControls(childControlName);
 return parentControls[0];
};
ASPx.GetClientControlByElementID = function(elementID) {
 var parentControls = ASPx.GetParentClientControls(elementID);
 return parentControls[parentControls.length - 1];
};
ASPx.IsExists = function(obj){
 return (typeof(obj) != "undefined") && (obj != null);
};
ASPx.IsFunction = function(obj){
 return typeof(obj) == "function";
};
ASPx.IsNumber = function(str) {
 return !isNaN(parseFloat(str)) && isFinite(str);
};
ASPx.GetDefinedValue = function(value, defaultValue){
 return (typeof(value) != "undefined") ? value : defaultValue;
};
ASPx.CorrectJSFloatNumber = function(number) {
 var ret = 21; 
 var numString = number.toPrecision(21);
 numString = numString.replace("-", ""); 
 var integerDigitsCount = numString.indexOf(ASPx.PossibleNumberDecimalSeparators[0]);
 if(integerDigitsCount < 0)
  integerDigitsCount = numString.indexOf(ASPx.PossibleNumberDecimalSeparators[1]);
 var floatDigitsCount = numString.length - integerDigitsCount - 1;
 if(floatDigitsCount < 10)
  return number;
 if(integerDigitsCount > 0) {
  ret = integerDigitsCount + 12;
 }
 var toPrecisionNumber = Math.min(ret, 21);
 var newValueString = number.toPrecision(toPrecisionNumber);
 return parseFloat(newValueString, 10);
};
ASPx.CorrectRounding = function(number, step) { 
 var regex = /[,|.](.*)/,
  isFloatValue = regex.test(number),
  isFloatStep = regex.test(step);
 if(isFloatValue || isFloatStep) {
  var valueAccuracy = (isFloatValue) ? regex.exec(number)[0].length - 1 : 0,
   stepAccuracy = (isFloatStep) ? regex.exec(step)[0].length - 1 : 0,
   accuracy = Math.max(valueAccuracy, stepAccuracy);
  var multiplier = Math.pow(10, accuracy);
  number = Math.round((number + step) * multiplier) / multiplier;
  return number;
 }
 return number + step;
};
ASPx.GetActiveElement = function() {
 try{ return document.activeElement; } catch(e) { return null; }
};
var verticalScrollBarWidth;
ASPx.GetVerticalScrollBarWidth = function() {
 if(typeof(verticalScrollBarWidth) == "undefined") {
  var container = document.createElement("DIV");
  container.style.cssText = "position: absolute; top: 0px; left: 0px; visibility: hidden; width: 200px; height: 150px; overflow: hidden; box-sizing: content-box";
  document.body.appendChild(container);
  var child = document.createElement("P");
  container.appendChild(child);
  child.style.cssText = "width: 100%; height: 200px;";
  var widthWithoutScrollBar = child.offsetWidth;
  container.style.overflow = "scroll";
  var widthWithScrollBar = child.offsetWidth;
  if(widthWithoutScrollBar == widthWithScrollBar)
   widthWithScrollBar = container.clientWidth;
  verticalScrollBarWidth = widthWithoutScrollBar - widthWithScrollBar;
  document.body.removeChild(container);
 }
 return verticalScrollBarWidth;
};
function hideScrollBarCore(element, scrollName) {
 if(element.tagName == "IFRAME") {
  if((element.scrolling == "yes") || (element.scrolling == "auto")) {
   Attr.ChangeAttribute(element, "scrolling", "no");
   return true;
  }
 }
 else if(element.tagName == "DIV") {
  if((element.style[scrollName] == "scroll") || (element.style[scrollName] == "auto")) {
   Attr.ChangeStyleAttribute(element, scrollName, "hidden");
   return true;
  }
 }
 return false;
}
function restoreScrollBarCore(element, scrollName) {
 if(element.tagName == "IFRAME")
  return Attr.RestoreAttribute(element, "scrolling");
 else if(element.tagName == "DIV")
  return Attr.RestoreStyleAttribute(element, scrollName);
 return false;
}
ASPx.SetScrollBarVisibilityCore = function(element, scrollName, isVisible) {
 return isVisible ? restoreScrollBarCore(element, scrollName) : hideScrollBarCore(element, scrollName);
};
ASPx.SetScrollBarVisibility = function(element, isVisible) {
 if(ASPx.SetScrollBarVisibilityCore(element, "overflow", isVisible)) 
  return true;
 var result = ASPx.SetScrollBarVisibilityCore(element, "overflowX", isVisible)
  || ASPx.SetScrollBarVisibilityCore(element, "overflowY", isVisible);
 return result;
};
ASPx.SetInnerHtml = function(element, html) {
 if(Browser.IE) {
  setInnerHtmlInternal(element, "<em>&nbsp;</em>" + html);
  element.removeChild(element.firstChild);
 } else
  setInnerHtmlInternal(element, html);
};
ASPx.GetInnerText = function(container) {
 if(Browser.Safari && Browser.MajorVersion <= 5) {
  var filter = getHtml2PlainTextFilter();
  setInnerHtmlInternal(filter, container.innerHTML);
  ASPx.SetElementDisplay(filter, true);
  var innerText = filter.innerText;
  ASPx.SetElementDisplay(filter, false);
  return innerText;
 } else if(Browser.NetscapeFamily || Browser.WebKitFamily || (Browser.IE && Browser.Version >= 9) || Browser.Edge) {
  return container.textContent;
 } else
  return container.innerText;
};
ASPx.RemoveComment = function(text) {
 var result = text;
 var commentStart = "<!--";
 var commentEnd = "//-->";
 var positionStart = result.indexOf(commentStart);
 while(positionStart > -1) {
  var positionEnd = result.indexOf(commentEnd);
  var startStr = result.substring(0, positionStart);
  var endStr = result.substring(positionEnd + commentEnd.length);
  result = startStr + endStr;
  positionStart = result.indexOf(commentStart);
 }
 return result;
};
var html2PlainTextFilter = null;
function getHtml2PlainTextFilter() {
 if(html2PlainTextFilter == null) {
  html2PlainTextFilter = document.createElement("DIV");
  html2PlainTextFilter.style.width = "0";
  html2PlainTextFilter.style.height = "0";
  html2PlainTextFilter.style.overflow = "visible";
  ASPx.SetElementDisplay(html2PlainTextFilter, false);
  document.body.appendChild(html2PlainTextFilter);
 }
 return html2PlainTextFilter;
}
ASPx.CreateHiddenField = function(name, id, parent) {
 var input = document.createElement("INPUT");
 input.setAttribute("type", "hidden");
 if(name)
  input.setAttribute("name", name);
 if(id)
  input.setAttribute("id", id);
 if(parent)
  parent.appendChild(input);
 return input;
};
ASPx.CloneObject = function(srcObject) {
 if(typeof(srcObject) != 'object' || srcObject == null)
  return srcObject;
 var newObject = {};
 for(var i in srcObject)
  newObject[i] = srcObject[i];
 return newObject;
};
ASPx.InsertRowsBefore = function(table, rowsHtml, index) {
 var row = null;
 if(index >= 0 && index < table.rows.length)
  row = table.rows[index];
 var func = ASPx.Browser.IE && ASPx.Browser.Version < 10 ? insertRowsBefore_IE9 : insertRowsBefore;
 func(table, rowsHtml, row);
};
var insertRowsBefore = function(table, rowsHtml, row) {
 if(!row && table.tBodies.length > 0) {
  row = document.createElement("TR");
  table.tBodies[0].appendChild(row);
  row.shouldRemove = true;
 }
 if(row) {
  row.insertAdjacentHTML("beforeBegin", rowsHtml);
  if(row.shouldRemove)
   ASPx.RemoveElement(row);
 }
};
var insertRowsBefore_IE9 = function(table, rowsHtml, nextRow) {
 var row = document.createElement("TR");
 var cell = document.createElement("TD");
 setInnerHtmlInternal(cell, "<table><tbody>" + rowsHtml + "</tbody></table>");
 var tbody = table.tBodies[0];
 tbody.appendChild(row);
 row.appendChild(cell);
 var newTable = ASPx.GetNodeByTagName(cell, "TABLE", 0);
 var rowCount = newTable.rows.length;
 for(var i = rowCount - 1; i >= 0; i--) {
  var newRow = newTable.rows[i];
  if(nextRow == null)
   tbody.appendChild(newRow);
  else
   tbody.insertBefore(newRow, nextRow);
  nextRow = newRow;
 }
 ASPx.RemoveElement(row);
};
ASPx.IsPercentageSize = function(size) {
 return size && size.indexOf('%') != -1;
};
ASPx.GetElementById = function(id) {
 if(document.getElementById)
  return document.getElementById(id);
 else
  return document.all[id];
};
ASPx.GetInputElementById = function(id) {
 var elem = ASPx.GetElementById(id);
 if(!Browser.IE)
  return elem;
 if(elem) {
  if(elem.id == id)
   return elem;
  else {
   for(var i = 1; i < document.all[id].length; i++) {
    if(document.all[id][i].id == id)
     return document.all[id][i];
   }
  }
 }
 return null;
};
ASPx.GetElementByIdInDocument = function(documentObj, id) {
 if(documentObj.getElementById)
  return documentObj.getElementById(id);
 else
  return documentObj.all[id];
};
ASPx.GetIsParent = function(parentElement, element) {
 if(!parentElement || !element)
  return false;
 while(element){
  if(element === parentElement)
   return true;
  if(element.tagName === "BODY")
   return false;
  element = element.parentNode;
 }
 return false;
};
ASPx.GetParentById = function(element, id) {
 element = element.parentNode;
 while(element){
  if(element.id === id)
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParentByPartialId = function(element, idPart){
 while(element && element.tagName != "BODY") {
  if(element.id && element.id.match(idPart)) 
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParentByTagName = function(element, tagName) {
 tagName = tagName.toUpperCase();
 while(element) {
  if(element.tagName === "BODY")
   return null;
  if(element.tagName === tagName)
   return element;
  element = element.parentNode;
 }
 return null;
};
function getParentByCondition(element, conditionArg, condition) {
 while(element != null) {
  if(element.tagName == "BODY" || element.nodeName == "#document")
   return null;
  if (condition(element, conditionArg))
   return element;
  element = element.parentNode;
 }
 return null;
}
ASPx.GetParentByPartialClassName = function(element, className) {
 return getParentByCondition(element, className, ASPx.ElementContainsCssClass);
};
ASPx.GetParentByClassName = function(element, className) {
 return getParentByCondition(element, className, ASPx.ElementHasCssClass);
};
ASPx.GetParentBySelector = function (element, selector) {
 return getParentByCondition(element, selector, ASPx.ElementMatchesSelector);
};
ASPx.GetParentByTagNameAndAttributeValue = function(element, tagName, attrName, attrValue) {
 tagName = tagName.toUpperCase();
 while(element != null) {
  if(element.tagName == "BODY")
   return null;
  if(element.tagName == tagName && element[attrName] == attrValue)
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetParent = function(element, testFunc){
 if (!ASPx.IsExists(testFunc)) return null;
 while(element != null && element.tagName != "BODY"){
  if(testFunc(element))
   return element;
  element = element.parentNode;
 }
 return null;
};
ASPx.GetElementTreeLine = function(element, stopTagName, stopFunc) {
 var result = [];
 stopTagName = stopTagName || "BODY";
 while(element != null) {
  if(!stopFunc && element.tagName == stopTagName)
   break;
  if(stopFunc && stopFunc(element))
   break;
  result.push(element);
  element = element.parentNode;
 }
 return result;
};
ASPx.IsScrollableElement = function(element, isHorzScrollable, isVertScrollable) {
 isHorzScrollable = ASPx.IsExists(isHorzScrollable) ? isHorzScrollable : true;
 isVertScrollable = ASPx.IsExists(isVertScrollable) ? isVertScrollable : true;
 var style = ASPx.GetCurrentStyle(element);
 var overflowStyleNames = ["overflow"];
 if(isHorzScrollable)
  overflowStyleNames.push("overflowX");
 if(isVertScrollable)
  overflowStyleNames.push("overflowY");
 for(var i = 0; i < overflowStyleNames.length; i++)
  if(style[overflowStyleNames[i]] == "scroll" || style[overflowStyleNames[i]] == "auto")
   return true;
 return false;
};
ASPx.GetPreviousSibling = function(el) {
 if(el.previousElementSibling) {
  return el.previousElementSibling;
 } else {
  while(el = el.previousSibling) {
   if(el.nodeType === 1)
    return el;
  }
 }
};
ASPx.ElementMatchesSelector = (function (e) {
 return (function (matches) {
  return function (el, selector) { return !!el && !!selector && matches.call(el, selector); };
 })(e.matches || e.matchesSelector || e.webkitMatchesSelector || e.mozMatchesSelector || e.msMatchesSelector || e.oMatchesSelector);
})(Element.prototype);
ASPx.ElementHasCssClass = function(element, className) {
 try {
  var elementClasses;
  var classList = ASPx.GetClassNameList(element);
  if(!classList) {
   var elementClassName = ASPx.GetClassName(element);
   if(!elementClassName) {
    return false;
   }
   elementClasses = elementClassName.split(" ");
  }
  var classNames = className.split(" ");
  for(var i = classNames.length - 1; i >= 0; i--) {
   if(classList) {
    if(classList.indexOf(classNames[i]) === -1)
     return false;
    continue;
   }
   if(Data.ArrayIndexOf(elementClasses, classNames[i]) < 0)
    return false;
  }
  return true;
 } catch(e) {
  return false;
 }
};
ASPx.ElementContainsCssClass = function(element, className) {
 try {
  var elementClassName = ASPx.GetClassName(element);
  if(!elementClassName) {
   return false;
  }
  return elementClassName.indexOf(className) != -1;
 } catch(e) {
  return false;
 }
};
ASPx.AddClassNameToElement = function (element, className) {
 if(!element || typeof(className) !== "string" ) return;
 className = className.trim();
 if(!ASPx.ElementHasCssClass(element, className) && className !== "") {
  var oldClassName = ASPx.GetClassName(element);
  ASPx.SetClassName(element, (oldClassName === "") ? className : oldClassName + " " + className);
 }
};
ASPx.RemoveClassNameFromElement = function(element, className) {
 if(!element) return;
 var elementClassName = ASPx.GetClassName(element);
 var updClassName = " " + elementClassName + " ";
 var newClassName = updClassName.replace(" " + className + " ", " ");
 if(updClassName.length != newClassName.length)
  ASPx.SetClassName(element, Str.Trim(newClassName));  
};
ASPx.RemoveClassNamesFromElement = function(element, classNames) {
 if(!element) return;
 for(var i = 0; i < classNames.length; i++) {
  var className = classNames[i];
  if(ASPx.Browser.IE && ASPx.Browser.Version < 10)
   ASPx.RemoveClassNameFromElement(element, className);
  else
   element.classList.remove(className);
 }
};
ASPx.ToggleClassNameToElement = function(element, className, toggleState) {
 if(!toggleState)
  ASPx.RemoveClassNameFromElement(element, className);
 if(toggleState && !ASPx.ElementHasCssClass(element, className))
  ASPx.AddClassNameToElement(element, className);
};
ASPx.GetClassNameList = function(element) {
 var result = [];
 if(element) {
  if(element.tagName === "svg") {
   result = ASPx.GetClassName(element).replace(/^\s+|\s+$/g, '').split(/\s+/);
  }
  else {
   result = element.classList ? [].slice.call(element.classList) : ASPx.GetClassName(element).replace(/^\s+|\s+$/g, '').split(/\s+/);
  }
 }
 return result;
};
ASPx.GetClassName = function(element) {
 var result = "";
 if(element) {
  if(element.tagName === "svg") {
   result = element.className.baseVal;
  }
  else {
   result = element.className ? element.className : "";
  }
 }
 return result;
};
ASPx.SetClassName = function(element, className) {
 if(element.tagName === "svg") {
  element.className.baseVal = Str.Trim(className);
 }
 else {
  element.className = Str.Trim(className);
 }
};
ASPx.GetElementOffsetWidth = function(element) {
 if(element.tagName === "svg") {
  return element.getBoundingClientRect().width;
 }
 else {
  return element.offsetWidth;
 }
};
ASPx.GetElementOffsetHeight = function(element) {
 if(element.tagName === "svg") {
  return element.getBoundingClientRect().height;
 }
 else {
  return element.offsetHeight;
 }
};
function nodeListToArray(nodeList, filter) {
 var result = [];
 for(var i = 0, element; element = nodeList[i]; i++) {
  if(filter && !filter(element))
   continue;
  result.push(element);
 }
 return result;
}
ASPx.NodeListToArray = nodeListToArray;
function getItemByIndex(collection, index) {
 if(!index) index = 0;
 if(collection != null && collection.length > index)
  return collection[index];
 return null;
}
ASPx.GetChildNodesByQuerySelector = function (parent, selector) {
 return nodeListToArray(parent.querySelectorAll(selector), function (el) { return el.parentNode === parent; });
};
ASPx.GetChildNodesByClassName = function(parent, className) {
 if(!parent) return [];
 if(parent.querySelectorAll) {
  var children = parent.querySelectorAll('.' + className);
  return nodeListToArray(children, function(element) { 
   return element.parentNode === parent;
  });
 }
 return ASPx.GetChildNodes(parent, function(elem) { return elem.className && ASPx.ElementHasCssClass(elem, className); });
};
ASPx.GetChildNodesByPartialClassName = function(element, className) {
 return ASPx.GetChildElementNodesByPredicate(element,
  function(child) {
   return ASPx.ElementContainsCssClass(child, className);
  });
};
ASPx.GetChildByPartialClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByPartialClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildByClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetNodesByPartialClassName = function(element, className) {
 if(element.querySelectorAll) {
  var list = element.querySelectorAll('*[class*=' + className + ']');
  return nodeListToArray(list);
 }
 var collection = element.all || element.getElementsByTagName('*');
 var ret = [ ];
 if(collection != null) {
  for(var i = 0; i < collection.length; i ++) {
   if(ASPx.ElementContainsCssClass(collection[i], className))
    ret.push(collection[i]);
  }
 }
 return ret;
};
ASPx.GetNodesByClassName = function(parent, className) {
 if(parent.querySelectorAll) {
  var children = parent.querySelectorAll('.' + className);
  return nodeListToArray(children);
 }
 return ASPx.GetNodes(parent, function(elem) { return elem.className && ASPx.ElementHasCssClass(elem, className); });
};
ASPx.GetNodeByClassName = function(element, className, index) {
 if(element != null){    
  var collection = ASPx.GetNodesByClassName(element, className);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildById = function(element, id) {
 if(element.all) {
  var child = element.all[id];
  if(!child) {
   child = element.all(id); 
   if(!child)
    return Browser.IE ? document.getElementById(id) : null; 
  } 
  if(!ASPx.IsExists(child.length)) 
   return child;
  else
   return ASPx.GetElementById(id);
 }
 else
  return ASPx.GetElementById(id);
};
ASPx.GetNodesByPartialId = function(element, partialName, list) {
 if(element.id && element.id.indexOf(partialName) > -1) 
  list.push(element);
 if(element.childNodes) {
  for(var i = 0; i < element.childNodes.length; i ++) 
   ASPx.GetNodesByPartialId(element.childNodes[i], partialName, list);
 }
};
ASPx.GetNodesByTagName = function(element, tagName) {
 var tagNameToUpper = tagName.toUpperCase();
 var result = null;
 if(element) {
  if(element.getElementsByTagName) {
   result = element.getElementsByTagName(tagNameToUpper);
   if(result.length === 0) {
    result = element.getElementsByTagName(tagName);
   }
  }
  else if(element.all && element.all.tags !== undefined)
   result = Browser.Netscape ? element.all.tags[tagNameToUpper] : element.all.tags(tagNameToUpper);
 }
 return result;
};
ASPx.GetNodeByTagName = function(element, tagName, index) {
 if(element != null){    
  var collection = ASPx.GetNodesByTagName(element, tagName);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetChildNodesByTagName = function(parent, tagName) {
 return ASPx.GetChildNodes(parent, function (child) { return child.tagName === tagName; });
};
ASPx.GetChildByTagName = function(element, tagName, index) {
 if(element != null){    
  var collection = ASPx.GetChildNodesByTagName(element, tagName);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.RetrieveByPredicate = function(scourceCollection, predicate) {
 var result = [];
 for(var i = 0; i < scourceCollection.length; i++) {
  var element = scourceCollection[i];
  if(!predicate || predicate(element)) 
   result.push(element);
 }
 return result;
};
ASPx.GetChildNodes = function(parent, predicate) {
 return ASPx.RetrieveByPredicate(parent.childNodes, predicate);
};
ASPx.GetNodes = function(parent, predicate) {
 var c = parent.all || parent.getElementsByTagName('*');
 return ASPx.RetrieveByPredicate(c, predicate);
};
ASPx.GetChildElementNodes = function(parent) {
 if(!parent) return null;
 return ASPx.GetChildNodes(parent, function(e) { return e.nodeType == 1; });
};
ASPx.GetChildElementNodesByPredicate = function(parent, predicate) {
 if(!parent) return null;
 if(!predicate) return ASPx.GetChildElementNodes(parent);
 return ASPx.GetChildNodes(parent, function(e) { return e.nodeType == 1 && predicate(e); });
};
ASPx.GetTextNode = function(element, index) {
 if(element != null){
  var collection = [ ];
  ASPx.GetTextNodes(element, collection);
  return getItemByIndex(collection, index);
 }
 return null;
};
ASPx.GetTextNodes = function(element, collection) {
 if(element.tagName === "svg")
  return;
 for(var i = 0; i < element.childNodes.length; i ++){
  var childNode = element.childNodes[i];
  if(ASPx.IsExists(childNode.nodeValue))
   collection.push(childNode);
  ASPx.GetTextNodes(childNode, collection);
 }
};
ASPx.GetNormalizedTextNode = function(element, index) {
 var textNode = ASPx.GetTextNode(element, index);
 if(textNode != null)
  ASPx.MergeAdjacentTextNodes(textNode);
 return textNode;
};
ASPx.MergeAdjacentTextNodes = function(firstTextNode) {
 if(!ASPx.IsExists(firstTextNode.nodeValue))
  return;
 var textNode = firstTextNode;
 while(textNode.nextSibling && ASPx.IsExists(textNode.nextSibling.nodeValue)) {
  textNode.nodeValue += textNode.nextSibling.nodeValue;
  textNode.parentNode.removeChild(textNode.nextSibling);
 }
};
ASPx.GetElementDocument = function(element) {
 return element.document || element.ownerDocument;
};
ASPx.RemoveElement = function(element) {
 if(element && element.parentNode)
  element.parentNode.removeChild(element);
};
ASPx.ReplaceTagName = function(element, newTagName, cloneChilds) {
 if(element.nodeType != 1)
  return null;
 if(element.nodeName == newTagName)
  return element;
 cloneChilds = cloneChilds !== undefined ? cloneChilds : true;
 var doc = element.ownerDocument;
 var newElem = doc.createElement(newTagName);
 Attr.CopyAllAttributes(element, newElem);
 if(cloneChilds) {
  for(var i = 0; i < element.childNodes.length; i++)
   newElem.appendChild(element.childNodes[i].cloneNode(true));
 }
 else {
  for(var child; child = element.firstChild; )
   newElem.appendChild(child);
 }
 element.parentNode.replaceChild(newElem, element);
 return newElem;
};
ASPx.RemoveOuterTags = function(element) {
 if(ASPx.Browser.IE) {
  element.insertAdjacentHTML( 'beforeBegin', element.innerHTML ) ;
  ASPx.RemoveElement(element);
 } else {
  var docFragment = element.ownerDocument.createDocumentFragment();
  for(var i = 0; i < element.childNodes.length; i++)
   docFragment.appendChild(element.childNodes[i].cloneNode(true));
  element.parentNode.replaceChild(docFragment, element);
 }
};
ASPx.WrapElementInNewElement = function(element, newElementTagName) { 
 var wrapElement = null;
 if(Browser.IE) {
  var wrapElement = element.ownerDocument.createElement(newElementTagName);
  wrapElement.appendChild(element.cloneNode(true));
  element.parentNode.insertBefore(wrapElement, element);
  element.parentNode.removeChild(element);
 } else {
  var docFragment = element.ownerDocument.createDocumentFragment();
  wrapElement = element.ownerDocument.createElement(newElementTagName);
  docFragment.appendChild(wrapElement);
  wrapElement.appendChild(element.cloneNode(true));
  element.parentNode.replaceChild(docFragment, element);
 }
 return wrapElement;
};
ASPx.InsertElementAfter = function(newElement, targetElement) {
 var parentElem = targetElement.parentNode;
 if(parentElem.childNodes[parentElem.childNodes.length - 1] == targetElement)
  parentElem.appendChild(newElement);
 else if(newElement !== targetElement.nextSibling)
  parentElem.insertBefore(newElement, targetElement.nextSibling);
};
ASPx.SetElementOpacity = function(element, value) {
  var useOpacityStyle = !Browser.IE || Browser.Version > 8;
  if(useOpacityStyle){
   element.style.opacity = value;
  } else {
   if(typeof(element.filters) === "object" && element.filters["DXImageTransform.Microsoft.Alpha"])
    element.filters.item("DXImageTransform.Microsoft.Alpha").Opacity = value*100;
   else
   element.style.filter = "alpha(opacity=" + (value * 100) + ")";
  }
};
ASPx.GetElementOpacity = function(element) {
 var useOpacityStyle = !Browser.IE || Browser.Version > 8;
 if(useOpacityStyle)
  return parseFloat(ASPx.GetCurrentStyle(element).opacity);
 else {
  if(typeof(element.filters) === "object" && element.filters["DXImageTransform.Microsoft.Alpha"]){
   return element.filters.item("DXImageTransform.Microsoft.Alpha").Opacity / 100;
  } else {
   var alphaValue = ASPx.GetCurrentStyle(element).filter;
   var value = alphaValue.replace("alpha(opacity=", "");
   value = value.replace(")", "");
   return parseInt(value) / 100;
  }
  return 100;
 }
};
ASPx.HiddenChangable = "dx-hc";
ASPx.DefaultDisplayNoneSelectors = [ "dxmodalSys" ];
ASPx.DefaultDisplaySelectors = ["show"];
function getIsDefaultDisplayNone(element) {
 for(var i = 0; i < ASPx.DefaultDisplayNoneSelectors.length; i++) {
  if(ASPx.ElementHasCssClass(element, ASPx.DefaultDisplayNoneSelectors[i]))
   return true;
 }
 return false;
}
ASPx.GetElementDisplay = function(element, isCurrentStyle) {
 if(isCurrentStyle)
  return ASPx.GetCurrentStyle(element).display != "none";
 if(getIsDefaultDisplayNone(element))
  return element.style.display != "none" && element.style.display != "" || ASPx.DefaultDisplaySelectors.some(function(s) { return ASPx.ElementHasCssClass(element, s); });
 return element.style.display != "none" && !ASPx.ElementHasCssClass(element, ASPx.HiddenChangable);
};
ASPx.SetElementDisplay = function(element, value) {
 if(!element) return;
 if(ASPx.ElementHasCssClass(element, ASPx.HiddenChangable))
  ASPx.RemoveClassNameFromElement(element, ASPx.HiddenChangable);
 if(typeof(value) === "string")
  element.style.display = value;
 else if(getIsDefaultDisplayNone(element))
  element.style.display = value ? (element.tagName === "TABLE" ? "table" : "block") : "";
 else if(!value)
  element.style.display = "none";
 else
  element.style.display = "";
};
ASPx.GetElementVisibility = function(element, isCurrentStyle) {
 if(isCurrentStyle)
  return ASPx.GetCurrentStyle(element).visibility != "hidden";
 return element.style.visibility != "hidden";
};
ASPx.SetElementVisibility = function(element, value) {
 if(!element) return;
 if(typeof(value) === "string")
  element.style.visibility = value;
 else
  element.style.visibility = value ? "visible" : "hidden";
};
ASPx.IsElementVisible = function(element, isCurrentStyle) {
 while(element && element.tagName != "BODY") {
  if(!ASPx.GetElementDisplay(element, isCurrentStyle) || (!ASPx.GetElementVisibility(element, isCurrentStyle) && !Attr.IsExistsAttribute(element, "errorFrame")))
     return false;
  element = element.parentNode;
 }
 return true;
};
ASPx.IsElementDisplayed = function(element) {
 while(element && element.tagName != "BODY") {
  if(!ASPx.GetElementDisplay(element))
     return false;
  element = element.parentNode;
 }
 return true;
};
ASPx.GetElementInitializedFlag = function(element) {
 return element["dxinit"];
};
ASPx.SetElementInitializedFlag = function(element) {
 element["dxinit"] = true;
};
ASPx.AddStyleSheetLinkToDocument = function(doc, linkUrl) {
 var newLink = createStyleLink(doc, linkUrl);
 var head = ASPx.GetHeadElementOrCreateIfNotExist(doc);
 head.appendChild(newLink);
 return newLink;
};
ASPx.GetHeadElementOrCreateIfNotExist = function(doc) {
 var elements = ASPx.GetNodesByTagName(doc, "head");
 var head = null;
 if(elements.length == 0) {
  head = doc.createElement("head");
  head.visibility = "hidden";
  doc.insertBefore(head, doc.body);
 } else
  head = elements[0];
 return head;
};
function createStyleLink(doc, url) {
 var newLink = doc.createElement("link");
 Attr.SetAttribute(newLink, "href", url);
 Attr.SetAttribute(newLink, "type", "text/css");
 Attr.SetAttribute(newLink, "rel", "stylesheet");
 return newLink;
}
ASPx.GetCurrentStyle = function(element) {
 if(document.defaultView && document.defaultView.getComputedStyle) { 
  var result = document.defaultView.getComputedStyle(element, null);
  if(!result && Browser.Firefox && window.frameElement) {
   var changes = [];
   var curElement = window.frameElement;
   while(!(result = document.defaultView.getComputedStyle(element, null))) {
    changes.push([curElement, curElement.style.display]);
    ASPx.SetStylesCore(curElement, "display", "block", true);
    curElement = curElement.tagName == "BODY" ? curElement.ownerDocument.defaultView.frameElement : curElement.parentNode;
   }
   result = ASPx.CloneObject(result);
   for(var ch, i = 0; ch = changes[i]; i++)
    ASPx.SetStylesCore(ch[0], "display", ch[1]);
   var dummy = document.body.offsetWidth; 
  }
  if(Browser.Firefox && Browser.MajorVersion >= 62 && window.frameElement && result.length === 0) { 
   result = ASPx.CloneObject(result);
   result.display = element.style.display;
  }
  return result;
 }
 return window.getComputedStyle(element, null);
};
ASPx.CreateStyleSheetInDocument = function(doc) {
 if(doc.createStyleSheet) {
  try {
   return doc.createStyleSheet();
  }
  catch(e) {
   var message = "The CSS link limit (31) has been exceeded. Please enable CSS merging or reduce the number of CSS files on the page. For details, see http://www.devexpress.com/Support/Center/p/K18487.aspx.";
   throw new Error(message);
  }
 }
 else {
  var styleSheet = doc.createElement("STYLE");
  ASPx.GetNodeByTagName(doc, "HEAD", 0).appendChild(styleSheet);
  return styleSheet.sheet;
 }
};
ASPx.currentStyleSheet = null;
ASPx.GetCurrentStyleSheet = function() {
 if(!ASPx.currentStyleSheet)
  ASPx.currentStyleSheet = ASPx.CreateStyleSheetInDocument(document);
 return ASPx.currentStyleSheet;
};
function getStyleSheetRules(styleSheet){
 try {
  if (styleSheet.href && styleSheet.href.indexOf("file:///") === 0)
   return null;
  return Browser.IE && Browser.Version == 8 ? styleSheet.rules : styleSheet.cssRules;
 }
 catch(e) {
  return null;
 }
}
ASPx.cachedCssRules = { };
ASPx.GetStyleSheetRules = function (className, stylesStorageDocument) {
 if(ASPx.cachedCssRules[className]) {
  if(ASPx.cachedCssRules[className] != ASPx.EmptyObject)
   return ASPx.cachedCssRules[className];
  return null;
 }
 var result = iterateStyleSheetRules(stylesStorageDocument, function(rule) {
  if(rule.selectorText == "." + className){
   ASPx.cachedCssRules[className] = rule;
   return rule;
  }
 });
 if(ASPx.IsExists(result))
  return result;
 ASPx.cachedCssRules[className] = ASPx.EmptyObject;
 return null;
};
function iterateStyleSheetRules(stylesStorageDocument, callback) {
 var doc = stylesStorageDocument || document;
 for(var i = 0; i < doc.styleSheets.length; i ++){
  var styleSheet = doc.styleSheets[i];
  var rules = getStyleSheetRules(styleSheet);
  if(rules != null){
   for(var j = 0; j < rules.length; j ++) {
    var result = callback(rules[j]);
    if(result !== undefined)
     return result;
   }
  }
 }
}
ASPx.ProcessStyleSheetRules = function(prefix, callback) {
 iterateStyleSheetRules(null, function(rule) {
  if(!!rule.selectorText && rule.selectorText.indexOf(prefix) === 0) {
   var name = rule.selectorText.substring(prefix.length);
   var result = callback(name, rule.style, rule);
   if(result !== undefined)
    return result;
  }
 });
};
ASPx.ClearCachedCssRules = function(){
 ASPx.cachedCssRules = { };
};
var styleCount = 0;
var styleNameCache = { };
ASPx.CreateImportantStyleRule = function(styleSheet, cssText, postfix, prefix) {
 styleSheet = styleSheet || ASPx.GetCurrentStyleSheet();
 var cacheKey = (postfix ? postfix + "||" : "") + cssText + (prefix ? "||" + prefix : "");
 if(styleNameCache[cacheKey])
  return styleNameCache[cacheKey];
 prefix = prefix ? prefix + " " : "";
 var className = "dxh" + styleCount + (postfix ? postfix : "");
 ASPx.AddStyleSheetRule(styleSheet, prefix + "." + className, ASPx.CreateImportantCssText(cssText));
 styleCount++;
 styleNameCache[cacheKey] = className;
 return className; 
};
ASPx.CreateImportantCssText = function(cssText) {
 var newText = "";
 var hasEncodedSemicolon = cssText.indexOf(ASPx.StyleValueEncodedSemicolon) > -1;
 var attributes = cssText.split(";");
 for(var i = 0; i < attributes.length; i++) {
  var rule = attributes[i];
  if(rule != "")
   newText += ASPx.CreateImportantCssRule(rule, hasEncodedSemicolon);
 }
 return newText;
};
ASPx.CreateImportantCssRule = function(rule, hasEncodedSemicolon) {
 var result = rule;
 if(hasEncodedSemicolon) {
  var regex = new RegExp(ASPx.StyleValueEncodedSemicolon, "g");
  result = result.replace(regex, ";");
 }
 result = result + " !important;";
 return result;
};
ASPx.AddStyleSheetRule = function(styleSheet, selector, cssText){
 if(!cssText) return;
 var index = styleSheet.cssRules.length;
 styleSheet.insertRule(selector + " { " + cssText + " }", index);
 return styleSheet.cssRules[index];
};
ASPx.GetPointerCursor = function() {
 return "pointer";
};
ASPx.SetPointerCursor = function(element) {
 if(element.style.cursor == "")
  element.style.cursor = ASPx.GetPointerCursor();
};
ASPx.SetElementFloat = function(element, value) {
 if(ASPx.IsExists(element.style.cssFloat))
  element.style.cssFloat = value;
 else if(ASPx.IsExists(element.style.styleFloat))
  element.style.styleFloat = value;
 else
  Attr.SetAttribute(element.style, "float", value);
};
ASPx.GetElementFloat = function(element) {
 var currentStyle = ASPx.GetCurrentStyle(element);
 if(ASPx.IsExists(currentStyle.cssFloat))
  return currentStyle.cssFloat;
 if(ASPx.IsExists(currentStyle.styleFloat))
  return currentStyle.styleFloat;
 return Attr.GetAttribute(currentStyle, "float");
};
function getElementDirection(element) {
 return ASPx.GetCurrentStyle(element).direction;
}
ASPx.IsElementRightToLeft = function(element) {
 return getElementDirection(element) == "rtl";
};
ASPx.AdjustVerticalMarginsInContainer = function(container) {
 var containerBorderAndPaddings = ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 var flowElements = [], floatElements = [], floatTextElements = [];
 var maxHeight = 0, maxFlowHeight = 0;
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  ASPx.ClearVerticalMargins(element);
 }
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  var float = ASPx.GetElementFloat(element);
  var isFloat = (float === "left" || float === "right");
  if(isFloat)
   floatElements.push(element);
  else {
   flowElements.push(element);
   if(element.tagName !== "IMG"){
    if(!ASPx.IsTextWrapped(element))
     element.style.verticalAlign = 'baseline'; 
    floatTextElements.push(element);
   }
   if(element.tagName === "DIV")
    Attr.ChangeStyleAttribute(element, "float", "left"); 
  }
  if(element.offsetHeight > maxHeight) 
   maxHeight = element.offsetHeight;
  if(!isFloat && element.offsetHeight > maxFlowHeight) 
   maxFlowHeight = element.offsetHeight;
 }
 for(var i = 0; i < flowElements.length; i++) 
  Attr.RestoreStyleAttribute(flowElements[i], "float");
 var containerBorderAndPaddings = ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 var containerHeight = container.offsetHeight - containerBorderAndPaddings;
 if(maxHeight == containerHeight) {
  var verticalAlign = ASPx.GetCurrentStyle(container).verticalAlign;
  for(var i = 0; i < floatTextElements.length; i++)
   floatTextElements[i].style.verticalAlign = '';
  containerHeight = container.offsetHeight - containerBorderAndPaddings;
  for(var i = 0; i < floatElements.length; i++)
   adjustVerticalMarginsCore(floatElements[i], containerHeight, verticalAlign, true);
  for(var i = 0; i < flowElements.length; i++) {
   if(maxFlowHeight != maxHeight)
    adjustVerticalMarginsCore(flowElements[i], containerHeight, verticalAlign);
  }
 }
};
ASPx.AdjustVerticalMargins = function(element) {
 ASPx.ClearVerticalMargins(element);
 var parentElement = element.parentNode;
 var parentHeight = parentElement.getBoundingClientRect().height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(parentElement);
 adjustVerticalMarginsCore(element, parentHeight, ASPx.GetCurrentStyle(parentElement).verticalAlign);
};
function adjustVerticalMarginsCore(element, parentHeight, verticalAlign, toBottom) {
 var marginTop;
 if(verticalAlign == "top")
  marginTop = 0;
 else if(verticalAlign == "bottom")
  marginTop = parentHeight - element.getBoundingClientRect().height;
 else
  marginTop = (parentHeight - element.getBoundingClientRect().height) / 2;
 if(marginTop !== 0){
  element.style.marginTop = marginTop + "px";
 }
}
ASPx.ClearVerticalMargins = function(element) {
 element.style.marginTop = "";
 element.style.marginBottom = "";
};
ASPx.AdjustHeightInContainer = function(container) {
 var height = container.offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(container);
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  ASPx.ClearHeight(element);
 }
 var elements = [];
 var childrenHeight = 0;
 for(var i = 0; i < container.childNodes.length; i++) {
  var element = container.childNodes[i];
  if(!element.offsetHeight) continue;
  childrenHeight += element.offsetHeight + ASPx.GetTopBottomMargins(element);
  elements.push(element);
 }
 if(elements.length > 0 && childrenHeight < height) {
  var correctedHeight = 0;
  for(var i = 0; i < elements.length; i++) {
   var elementHeight = 0;
   if(i < elements.length - 1){
    var elementHeight = Math.floor(height / elements.length);
    correctedHeight += elementHeight;
   }
   else{
    var elementHeight = height - correctedHeight;
    if(elementHeight < 0) elementHeight = 0;
   }
   adjustHeightCore(elements[i], elementHeight);
  }
 }
};
ASPx.AdjustHeight = function(element) {
 ASPx.ClearHeight(element);
 var parentElement = element.parentNode;
 var height = parentElement.getBoundingClientRect().height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(parentElement);
 adjustHeightCore(element, height);
};
function adjustHeightCore(element, height) {
 var height = height - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
 if(height < 0) height = 0;
 element.style.height = height + "px";
}
ASPx.ClearHeight = function(element) {
 element.style.height = "";
};
ASPx.ShrinkWrappedTextInContainer = function(container) {
 if(!container) return;
 for(var i = 0; i < container.childNodes.length; i++){
  var child = container.childNodes[i];
  if(child.style && ASPx.IsTextWrapped(child)) {
   Attr.ChangeStyleAttribute(child, "width", "1px");
   child.shrinkedTextContainer = true;
  }
 }
};
ASPx.AdjustWrappedTextInContainer = function(container) {
 if(!container) return;
 var textContainer, leftWidth = 0, rightWidth = 0;
 for(var i = 0; i < container.childNodes.length; i++){
  var child = container.childNodes[i];
  if(child.tagName === "BR")
   return;
  if(!child.tagName)
   continue;
  if(child.tagName !== "IMG"){
   textContainer = child;
   if(ASPx.IsTextWrapped(textContainer)){
    if(!textContainer.shrinkedTextContainer)
     textContainer.style.width = "";
    textContainer.style.marginRight = "";
   }
  }
  else {
   if(ASPx.GetElementOffsetWidth(child)=== 0)
    Evt.AttachEventToElement(child, "load", function(evt) { ASPx.AdjustWrappedTextInContainer(container); });
   else {
    var width = ASPx.GetElementOffsetWidth(child) + ASPx.GetLeftRightMargins(child);
    if(textContainer)
     rightWidth += width;
    else
     leftWidth += width;
   }
  }
 }
 if(textContainer && ASPx.IsTextWrapped(textContainer)) {
  var containerWidth = ASPx.GetElementOffsetWidth(container) - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(container);
  if(textContainer.shrinkedTextContainer) {
   Attr.RestoreStyleAttribute(textContainer, "width");
   Attr.ChangeStyleAttribute(container, "width", containerWidth + "px");
  }
  if(ASPx.GetElementOffsetWidth(textContainer) + leftWidth + rightWidth >= containerWidth) {
    if(rightWidth > 0 && !textContainer.shrinkedTextContainer)
    textContainer.style.width = (containerWidth - rightWidth) + "px";
   else if(leftWidth > 0){
    if(ASPx.IsElementRightToLeft(container))
     textContainer.style.marginLeft = leftWidth + "px";
    else
     textContainer.style.marginRight = leftWidth + "px";
   }
  }
 }
};
ASPx.IsTextWrapped = function(element) {
 return element && ASPx.GetCurrentStyle(element).whiteSpace !== "nowrap";
};
ASPx.IsValidPosition = function(pos){
 return pos != ASPx.InvalidPosition && pos != -ASPx.InvalidPosition;
};
ASPx.getSpriteMainElement = function(element) {
 var cssClassMarker = "dx-acc";
 if(ASPx.ElementContainsCssClass(element, cssClassMarker))
  return element;
 if(element.parentNode && ASPx.ElementContainsCssClass(element.parentNode, cssClassMarker))
  return element.parentNode;
 return element;
};
ASPx.GetAbsoluteX = function(curEl){
 return ASPx.GetAbsolutePositionX(curEl);
};
ASPx.GetAbsoluteY = function(curEl){
 return ASPx.GetAbsolutePositionY(curEl);
};
ASPx.SetAbsoluteX = function(element, x){
 element.style.left = ASPx.PrepareClientPosForElement(x, element, true) + "px";
};
ASPx.SetAbsoluteY = function(element, y){
 element.style.top = ASPx.PrepareClientPosForElement(y, element, false) + "px";
};
ASPx.GetAbsolutePositionX = function(element){
 if(Browser.IE)
  return getAbsolutePositionX_IE(element);
 else if(Browser.Firefox && Browser.Version >= 3)
  return getAbsolutePositionX_FF3(element);
 else if(Browser.Opera)
  return getAbsolutePositionX_Opera(element);
 else if(Browser.NetscapeFamily && (!Browser.Firefox || Browser.Version < 3))
  return getAbsolutePositionX_NS(element);
 else if(Browser.WebKitFamily || Browser.Edge)
  return getAbsolutePositionX_FF3(element);
 else
  return getAbsolutePositionX_Other(element);
};
function getAbsolutePositionX_Opera(curEl){
 var isFirstCycle = true;
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, true);
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle)
   pos -= curEl.scrollLeft;
  curEl = curEl.offsetParent;
  isFirstCycle = false;
 }
 pos += document.body.scrollLeft;
 return pos;
}
function getAbsolutePositionX_IE(element){
 if(element == null || Browser.IE && element.parentNode == null) return 0; 
 return element.getBoundingClientRect().left + ASPx.GetDocumentScrollLeft();
}
function getAbsolutePositionX_FF3(element){
 if(element == null) return 0;
 var x = element.getBoundingClientRect().left + ASPx.GetDocumentScrollLeft();
 return x;
}
function getAbsolutePositionX_NS(curEl){
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, true);
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollLeft;
  if(!isFirstCycle && Browser.Firefox){
   var style = ASPx.GetCurrentStyle(curEl);
   if(curEl.tagName == "DIV" && style.overflow != "visible")
    pos += ASPx.PxToInt(style.borderLeftWidth);
  }
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function getAbsolutePositionX_Other(curEl){
 var pos = 0;
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetLeft;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollLeft;
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
ASPx.GetAbsolutePositionY = function(element){
 if(Browser.IE)
  return getAbsolutePositionY_IE(element);
 else if(Browser.Firefox && Browser.Version >= 3)
  return getAbsolutePositionY_FF3(element);
 else if(Browser.Opera)
  return getAbsolutePositionY_Opera(element);
 else if(Browser.NetscapeFamily && (!Browser.Firefox || Browser.Version < 3))
  return getAbsolutePositionY_NS(element);
 else if(Browser.WebKitFamily || Browser.Edge)
  return getAbsolutePositionY_FF3(element);
 else
  return getAbsolutePositionY_Other(element);
};
function getAbsolutePositionY_Opera(curEl){
 var isFirstCycle = true;
 if(curEl && curEl.tagName == "TR" && curEl.cells.length > 0)
  curEl = curEl.cells[0];
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, false);
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle)
   pos -= curEl.scrollTop;
  curEl = curEl.offsetParent;
  isFirstCycle = false;
 }
 pos += document.body.scrollTop;
 return pos;
}
function getAbsolutePositionY_IE(element){
 if(element == null || Browser.IE && element.parentNode == null) return 0; 
 return element.getBoundingClientRect().top + ASPx.GetDocumentScrollTop();
}
function getAbsolutePositionY_FF3(element){
 if(element == null) return 0;
 var y = element.getBoundingClientRect().top + ASPx.GetDocumentScrollTop();
 return y;
}
function getAbsolutePositionY_NS(curEl){
 var pos = getAbsoluteScrollOffset_OperaFF(curEl, false);
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollTop;
  if(!isFirstCycle && Browser.Firefox){
   var style = ASPx.GetCurrentStyle(curEl);
   if(curEl.tagName == "DIV" && style.overflow != "visible")
    pos += ASPx.PxToInt(style.borderTopWidth);
  }
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function getAbsoluteScrollOffset_OperaFF(curEl, isX) {
 var pos = 0;   
 var isFirstCycle = true;
 while(curEl != null) {
  if(curEl.tagName == "BODY")
   break;
  var style = ASPx.GetCurrentStyle(curEl);
  if(style.position == "absolute")
   break;
  if(!isFirstCycle && curEl.tagName == "DIV" && (style.position == "" || style.position == "static"))
   pos -= isX ? curEl.scrollLeft : curEl.scrollTop;
  curEl = curEl.parentNode;
  isFirstCycle = false;
 }
 return pos; 
}
function getAbsolutePositionY_Other(curEl){
 var pos = 0;
 var isFirstCycle = true;
 while(curEl != null) {
  pos += curEl.offsetTop;
  if(!isFirstCycle && curEl.offsetParent != null)
   pos -= curEl.scrollTop;
  isFirstCycle = false;
  curEl = curEl.offsetParent;
 }
 return pos;
}
function createElementMock(element) {
 var div = document.createElement('DIV');
 div.style.top = "0px";
 div.style.left = "0px";
 div.visibility = "hidden";
 div.style.position = ASPx.GetCurrentStyle(element).position;
 return div;
}
ASPx.PrepareClientPosElementForOtherParent = function(pos, element, otherParent, isX) {
 if(element.parentNode == otherParent)
  return ASPx.PrepareClientPosForElement(pos, element, isX);
 var elementMock = createElementMock(element);
 otherParent.appendChild(elementMock); 
 var preparedPos = ASPx.PrepareClientPosForElement(pos, elementMock, isX);
 otherParent.removeChild(elementMock);
 return preparedPos;
};
ASPx.PrepareClientPosForElement = function(pos, element, isX) {
 pos -= ASPx.GetPositionElementOffset(element, isX);
 return pos;
};
function getExperimentalPositionOffset(element, isX) {
 var div = createElementMock(element);
 if(div.style.position == "static")
  div.style.position = "absolute";
 element.parentNode.appendChild(div); 
 var realPos = isX ? ASPx.GetAbsoluteX(div) : ASPx.GetAbsoluteY(div);
 element.parentNode.removeChild(div);
 return realPos;
}
ASPx.GetPositionElementOffset = function(element, isX) {
 return getExperimentalPositionOffset(element, isX);
};
ASPx.GetSizeOfText = function(text, textCss) {
 var testContainer = document.createElement("tester");
 var defaultLineHeight = ASPx.Browser.Firefox ? "1" : "";
 testContainer.style.fontSize = textCss.fontSize;
 testContainer.style.fontFamily = textCss.fontFamily;
 testContainer.style.fontWeight = textCss.fontWeight;
 testContainer.style.letterSpacing = textCss.letterSpacing;
 testContainer.style.lineHeight = textCss.lineHeight || defaultLineHeight;
 testContainer.style.position = "absolute";
 testContainer.style.top = ASPx.InvalidPosition + "px";
 testContainer.style.left = ASPx.InvalidPosition + "px";
 testContainer.style.width = "auto";
 testContainer.style.whiteSpace = "nowrap";
 testContainer.appendChild(document.createTextNode(text));
 var testElement = document.body.appendChild(testContainer);
 var size = {
  "width": testElement.offsetWidth,
  "height": testElement.offsetHeight
 };
 document.body.removeChild(testElement);
 return size;
};
ASPx.PointToPixel = function(points, addPx) {  
 var result = 0;
 try {
  var indexOfPt = points.toLowerCase().indexOf("pt");
  if(indexOfPt > -1)
   result = parseInt(points.substr(0, indexOfPt)) * 96 / 72;
  else
   result = parseInt(points) * 96 / 72;
  if(addPx)
   result = result + "px";
 } catch(e) {}
 return result;
};
ASPx.PixelToPoint = function(pixels, addPt) { 
 var result = 0;
 try {
  var indexOfPx = pixels.toLowerCase().indexOf("px");
  if(indexOfPx > -1)
   result = parseInt(pixels.substr(0, indexOfPx)) * 72 / 96;
  else
   result = parseInt(pixels) * 72 / 96;
  if(addPt)
   result = result + "pt";
 } catch(e) {}
 return result;         
};
ASPx.PxToInt = function(px) {
 return pxToNumber(px, parseInt);
};
ASPx.PxToFloat = function(px) {
 return pxToNumber(px, parseFloat);
};
function pxToNumber(px, parseFunction) {
 var result = 0;
 if(px != null && px != "") {
  try {
   var indexOfPx = px.indexOf("px");
   if(indexOfPx > -1)
    result = parseFunction(px.substr(0, indexOfPx));
  } catch(e) { }
 }
 return result;
}
ASPx.PercentageToFloat = function(perc) {
 var result = 0;
 if(perc != null && perc != "") {
  try {
   var indexOfPerc = perc.indexOf("%");
   if(indexOfPerc > -1)
    result = parseFloat(perc.substr(0, indexOfPerc)) / 100;
  } catch(e) { }
 }
 return result;
};
ASPx.CreateGuid = function() {
 return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) { 
   var r = Math.random()*16|0,v=c=='x'?r:r&0x3|0x8;
  return v.toString(16);
 });
};
ASPx.GetLeftRightBordersAndPaddingsSummaryValue = function(element, currentStyle) {
 return ASPx.GetLeftRightPaddings(element, currentStyle) + ASPx.GetHorizontalBordersWidth(element, currentStyle);
};
ASPx.GetTopBottomBordersAndPaddingsSummaryValue = function(element, currentStyle) {
 return ASPx.GetTopBottomPaddings(element, currentStyle) + ASPx.GetVerticalBordersWidth(element, currentStyle);
};
ASPx.GetVerticalBordersWidth = function(element, style) {
 if(!ASPx.IsExists(style))
  style = (Browser.IE && Browser.MajorVersion != 9 && window.getComputedStyle) ? window.getComputedStyle(element) : ASPx.GetCurrentStyle(element);
 var res = 0;
 if(style.borderTopStyle != "none") {
  res += ASPx.PxToFloat(style.borderTopWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderTopWidth);
 }
 if(style.borderBottomStyle != "none") {
  res += ASPx.PxToFloat(style.borderBottomWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderBottomWidth);
 }
 return res;
};
ASPx.GetHorizontalBordersWidth = function(element, style) {
 if(!ASPx.IsExists(style))
  style = (Browser.IE && window.getComputedStyle) ? window.getComputedStyle(element) : ASPx.GetCurrentStyle(element);
 var res = 0;
 if(style.borderLeftStyle != "none") {
  res += ASPx.PxToFloat(style.borderLeftWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderLeftWidth);
 }
 if(style.borderRightStyle != "none") {
  res += ASPx.PxToFloat(style.borderRightWidth);
  if(Browser.IE && Browser.MajorVersion < 9)
   res += getIe8BorderWidthFromText(style.borderRightWidth);
 }
 return res;
};
function getIe8BorderWidthFromText(textWidth) {
 var availableWidth = { "thin": 1, "medium" : 3, "thick": 5 };
 var width = availableWidth[textWidth];
 return width ? width : 0;
}
ASPx.GetTopBottomPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingTop) + ASPx.PxToInt(currentStyle.paddingBottom);
};
ASPx.GetTopPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingTop);
};
ASPx.GetBottomPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingBottom);
};
ASPx.GetLeftRightPaddings = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.paddingLeft) + ASPx.PxToInt(currentStyle.paddingRight);
};
ASPx.GetTopBottomMargins = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.marginTop) + ASPx.PxToInt(currentStyle.marginBottom);
};
ASPx.GetLeftRightMargins = function(element, style) {
 var currentStyle = style ? style : ASPx.GetCurrentStyle(element);
 return ASPx.PxToInt(currentStyle.marginLeft) + ASPx.PxToInt(currentStyle.marginRight);
};
ASPx.GetClearClientWidth = function(element) {
 return ASPx.GetElementOffsetWidth(element)- ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element);
};
ASPx.GetClearClientHeight = function(element) {
 return ASPx.GetElementOffsetHeight(element) - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
};
ASPx.SetOffsetWidth = function(element, widthValue, currentStyle) {
 if(!ASPx.IsExists(currentStyle))
  currentStyle = ASPx.GetCurrentStyle(element);
 var value = widthValue - ASPx.PxToInt(currentStyle.marginLeft) - ASPx.PxToInt(currentStyle.marginRight);
  value -= ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element, currentStyle);
 if(value > -1)
  element.style.width = value + "px";
};
ASPx.SetOffsetHeight = function(element, heightValue, currentStyle) {
 if(!ASPx.IsExists(currentStyle))
  currentStyle = ASPx.GetCurrentStyle(element);
 var value = heightValue - ASPx.PxToInt(currentStyle.marginTop) - ASPx.PxToInt(currentStyle.marginBottom);
  value -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element, currentStyle);
 if(value > -1)
  element.style.height = value + "px";
};
ASPx.FindOffsetParent = function(element) {
 var currentElement = element.parentNode;
 while(ASPx.IsExistsElement(currentElement) && currentElement.tagName != "BODY") {
  if(ASPx.GetElementOffsetWidth(currentElement) > 0 && ASPx.GetElementOffsetHeight(currentElement) > 0)
   return currentElement;
  currentElement = currentElement.parentNode;
 }
 return document.body;
};
ASPx.GetDocumentScrollTop = function(){
 var isScrollBodyIE = Browser.IE && ASPx.GetCurrentStyle(document.body).overflow == "hidden" && document.body.scrollTop > 0;
 if(Browser.WebKitFamily || Browser.Edge || isScrollBodyIE) {
  if(Browser.MacOSMobilePlatform) 
   return window.pageYOffset;
  if(Browser.WebKitFamily)
   return document.documentElement.scrollTop || document.body.scrollTop;
  return document.body.scrollTop;
 }
 else
  return document.documentElement.scrollTop;
};
ASPx.SetDocumentScrollTop = function(scrollTop) {
 if(Browser.WebKitFamily && Browser.Version < 60 || Browser.Edge)
  document.body.scrollTop = scrollTop;
 else
  document.documentElement.scrollTop = scrollTop;
};
ASPx.GetDocumentScrollLeft = function(){
 var isScrollBodyIE = Browser.IE && ASPx.GetCurrentStyle(document.body).overflow == "hidden" && document.body.scrollLeft > 0;
 if(Browser.Edge || isScrollBodyIE)
  return document.body ? document.body.scrollLeft : document.documentElement.scrollLeft;
 if(Browser.WebKitFamily)
  return document.documentElement.scrollLeft || document.body.scrollLeft;
 return document.documentElement.scrollLeft;
};
ASPx.SetDocumentScrollLeft = function (scrollLeft) {
 if(Browser.WebKitFamily && Browser.Version < 60 || Browser.Edge)
  document.body.scrollLeft = scrollLeft;
 else
  document.documentElement.scrollLeft = scrollLeft;
};
ASPx.GetDocumentClientWidth = function(){
 if(document.documentElement.clientWidth == 0)
  return document.body.clientWidth;
 else
  return document.documentElement.clientWidth;
};
ASPx.GetDocumentClientHeight = function() {
 if(Browser.Firefox && window.innerHeight - document.documentElement.clientHeight > ASPx.GetVerticalScrollBarWidth()) {
  return window.innerHeight;
 } else if(Browser.Opera && Browser.Version < 9.6 || document.documentElement.clientHeight == 0) {
   return document.body.clientHeight;
 }
 return document.documentElement.clientHeight;
};
ASPx.GetDocumentWidth = function(){
 var bodyWidth = document.body.offsetWidth;
 var docWidth = Browser.IE ? document.documentElement.clientWidth : document.documentElement.offsetWidth;
 var bodyScrollWidth = document.body.scrollWidth;
 var docScrollWidth = document.documentElement.scrollWidth;
 return getMaxDimensionOf(bodyWidth, docWidth, bodyScrollWidth, docScrollWidth);
};
ASPx.GetDocumentHeight = function(){
 var bodyHeight = document.body.offsetHeight;
 var docHeight = Browser.IE ? document.documentElement.clientHeight : document.documentElement.offsetHeight;
 var bodyScrollHeight = document.body.scrollHeight;
 var docScrollHeight = document.documentElement.scrollHeight;
 var maxHeight = getMaxDimensionOf(bodyHeight, docHeight, bodyScrollHeight, docScrollHeight);
 if(Browser.Opera && Browser.Version >= 9.6){
  if(Browser.Version < 10)
   maxHeight = getMaxDimensionOf(bodyHeight, docHeight, bodyScrollHeight);
  var visibleHeightOfDocument = document.documentElement.clientHeight;
  if(maxHeight > visibleHeightOfDocument)
   maxHeight = getMaxDimensionOf(window.outerHeight, maxHeight);
  else
   maxHeight = document.documentElement.clientHeight;
  return maxHeight;
 }
 return maxHeight;
};
ASPx.GetDocumentMaxClientWidth = function(){
 var bodyWidth = document.body.offsetWidth;
 var docWidth = document.documentElement.offsetWidth;
 var docClientWidth = document.documentElement.clientWidth;
 return getMaxDimensionOf(bodyWidth, docWidth, docClientWidth);
};
ASPx.GetDocumentMaxClientHeight = function(){
 var bodyHeight = document.body.offsetHeight;
 var docHeight = document.documentElement.offsetHeight;
 var docClientHeight = document.documentElement.clientHeight;
 return getMaxDimensionOf(bodyHeight, docHeight, docClientHeight);
};
ASPx.verticalScrollIsNotHidden = null;
ASPx.horizontalScrollIsNotHidden = null;
ASPx.GetVerticalScrollIsNotHidden = function() {
 if(!ASPx.IsExists(ASPx.verticalScrollIsNotHidden))
  ASPx.verticalScrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowY !== "hidden"
   && ASPx.GetCurrentStyle(document.documentElement).overflowY !== "hidden";
 return ASPx.verticalScrollIsNotHidden;
};
ASPx.GetHorizontalScrollIsNotHidden = function() {
 if(!ASPx.IsExists(ASPx.horizontalScrollIsNotHidden))
  ASPx.horizontalScrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowX !== "hidden"
   && ASPx.GetCurrentStyle(document.documentElement).overflowX !== "hidden";
 return ASPx.horizontalScrollIsNotHidden;
};
ASPx.GetCurrentDocumentWidth = function() {
 var result = ASPx.GetDocumentClientWidth();
 if(!ASPx.Browser.Safari && ASPx.GetVerticalScrollIsNotHidden() && ASPx.GetDocumentHeight() > ASPx.GetDocumentClientHeight())
  result += ASPx.GetVerticalScrollBarWidth();
 return result;
};
ASPx.GetCurrentDocumentHeight = function() {
 var result = ASPx.GetDocumentClientHeight();
 if(!ASPx.Browser.Safari && ASPx.GetHorizontalScrollIsNotHidden() && ASPx.GetDocumentWidth() > ASPx.GetDocumentClientWidth())
  result += ASPx.GetVerticalScrollBarWidth();
 return result;
};
function getMaxDimensionOf(){
 var max = ASPx.InvalidDimension;
 for(var i = 0; i < arguments.length; i++){
  if(max < arguments[i])
   max = arguments[i];
 }
 return max;
}
ASPx.GetClientLeft = function(element) {
 return ASPx.IsExists(element.clientLeft) ? element.clientLeft : (ASPx.GetElementOffsetWidth(element)- element.clientWidth) / 2;
};
ASPx.GetClientTop = function(element) {
 return ASPx.IsExists(element.clientTop) ? element.clientTop : (ASPx.GetElementOffsetHeight(element) - element.clientHeight) / 2;
};
var requestAnimationFrameFunc = window.requestAnimationFrame || function(callback) { callback(); };
var cancelAnimationFrameFunc = window.cancelAnimationFrame || function(id) { };
ASPx.CancelAnimationFrame = function(id) { cancelAnimationFrameFunc(id); };
ASPx.RequestAnimationFrame = function (callback) { return requestAnimationFrameFunc(callback); };
ASPx.SetStyles = function(element, styles, makeImportant) {
 if(ASPx.IsExists(styles.cssText))
  element.style.cssText = styles.cssText;
 if(ASPx.IsExists(styles.className)) {
  ASPx.SetClassName(element, styles.className);
 }
 for(var property in styles) {
  if(!styles.hasOwnProperty(property))
   continue;
  var value = styles[property];
  switch (property) {
   case "cssText":
   case "className":
    break;
   case "float":
    ASPx.SetElementFloat(element, value);
    break;
   case "opacity":
    ASPx.SetElementOpacity(element, value);
    break;
   case "zIndex":
    ASPx.SetStylesCore(element, property, value, makeImportant);
    break;
   case "fontWeight":
    if(ASPx.Browser.IE && ASPx.Browser.Version < 9 && typeof(styles[property]) == "number")
     value = styles[property].toString();
   default:
    ASPx.SetStylesCore(element, property, value + (typeof (value) == "number" ? "px" : ""), makeImportant);
  }
 }
};
ASPx.SetStylesCore = function(element, property, value, makeImportant) {
 if(makeImportant) {
  var index = property.search("[A-Z]");
  if(index != -1)
   property = property.replace(property.charAt(index), "-" + property.charAt(index).toLowerCase());
  if(element.style.setProperty)
   element.style.setProperty(property, value, "important");
  else 
   element.style.cssText += ";" + property + ":" + value + "!important";
 }
 else
  element.style[property] = value;
};
ASPx.RemoveBordersAndShadows = function(el) {
 if(!el || !el.style)
  return;
 el.style.borderWidth = 0;
 if(ASPx.IsExists(el.style.boxShadow))
  el.style.boxShadow = "none";
 else if(ASPx.IsExists(el.style.MozBoxShadow))
  el.style.MozBoxShadow = "none";
 else if(ASPx.IsExists(el.style.webkitBoxShadow))
  el.style.webkitBoxShadow = "none";
};
ASPx.GetCellSpacing = function(element) {
 var val = parseInt(element.cellSpacing);
 if(!isNaN(val)) return val;
 val = parseInt(ASPx.GetCurrentStyle(element).borderSpacing);
 if(!isNaN(val)) return val;
 return 0;
};
ASPx.GetInnerScrollPositions = function(element) {
 var scrolls = [];
 getInnerScrollPositionsCore(element, scrolls);
 return scrolls;
};
function getInnerScrollPositionsCore(element, scrolls) {
 for(var child = element.firstChild; child; child = child.nextSibling) {
  var scrollTop = child.scrollTop,
   scrollLeft = child.scrollLeft;
  if(scrollTop > 0 || scrollLeft > 0)
   scrolls.push([child, scrollTop, scrollLeft]);
  getInnerScrollPositionsCore(child, scrolls);
 }
}
ASPx.RestoreInnerScrollPositions = function(scrolls) {
 for(var i = 0, scrollArr; scrollArr = scrolls[i]; i++) {
  if(scrollArr[1] > 0)
   scrollArr[0].scrollTop = scrollArr[1];
  if(scrollArr[2] > 0)
   scrollArr[0].scrollLeft = scrollArr[2];
 }
};
ASPx.GetOuterScrollPosition = function(element) {
 while(element && element.tagName !== "BODY") {
  var scrollTop = element.scrollTop,
   scrollLeft = element.scrollLeft;
  if(scrollTop > 0 || scrollLeft > 0) {
   return {
    scrollTop: scrollTop,
    scrollLeft: scrollLeft,
    element: element
   };
  }
  element = element.parentNode;
 }
 return {
  scrollTop: ASPx.GetDocumentScrollTop(),
  scrollLeft: ASPx.GetDocumentScrollLeft()
 };
};
ASPx.RestoreOuterScrollPosition = function(scrollInfo) {
 if(scrollInfo.element) {
  if(scrollInfo.scrollTop > 0)
   scrollInfo.element.scrollTop = scrollInfo.scrollTop;
  if(scrollInfo.scrollLeft > 0)
   scrollInfo.element.scrollLeft = scrollInfo.scrollLeft;
 }
 else {
  if(scrollInfo.scrollTop > 0)
   ASPx.SetDocumentScrollTop(scrollInfo.scrollTop);
  if(scrollInfo.scrollLeft > 0)
   ASPx.SetDocumentScrollLeft(scrollInfo.scrollLeft);
 }
};
ASPx.ChangeElementContainer = function(element, container, savePreviousContainer) {
 if(element.parentNode != container) {
  var parentNode = element.parentNode;
  parentNode.removeChild(element);
  container.appendChild(element);
  if(savePreviousContainer)
   element.previousContainer = parentNode;
 }
};
ASPx.RestoreElementContainer = function(element) {
 if(element.previousContainer) {
  ASPx.ChangeElementContainer(element, element.previousContainer, false);
  element.previousContainer = null;
 }
};
ASPx.MoveChildrenToElement = function(sourceElement, destinationElement){
 while(sourceElement.childNodes.length > 0)
  destinationElement.appendChild(sourceElement.childNodes[0]);
};
ASPx.GetScriptCode = function(script) {
 var useFirstChildElement = Browser.Chrome && Browser.Version < 11 || Browser.Safari && Browser.Version < 5; 
 var text = useFirstChildElement ? script.firstChild.data : script.text;
 var comment = "<!--";
 var pos = text.indexOf(comment);
 if(pos > -1)
  text = text.substr(pos + comment.length);
 return text;
};
ASPx.AppendScript = function(script) {
 var parent = document.getElementsByTagName("head")[0];
 if(!parent)
  parent = document.body;
 if(parent)
  parent.appendChild(script);
};
function getFrame(frames, name) {
 if(frames[name])
  return frames[name];
 for(var i = 0; i < frames.length; i++) {
  try {
   var frame = frames[i];
   if(frame.name == name) 
    return frame; 
   frame = getFrame(frame.frames, name);
   if(frame != null)   
    return frame; 
  } catch(e) {
  } 
 }
 return null;
}
ASPx.IsValidElement = function(element) {
 if(!element) 
  return false;
 if(!(Browser.Firefox && Browser.Version < 4)) {
  if(element.ownerDocument && element.ownerDocument.body && element.ownerDocument.body.compareDocumentPosition)
   return element.ownerDocument.body.compareDocumentPosition(element) % 2 === 0;
 }
 if(!Browser.Opera && !(Browser.IE && Browser.Version < 9) && element.offsetParent && element.parentNode.tagName)
  return true;
 while(element != null){
  if(element.tagName == "BODY")
   return true;
  element = element.parentNode;
 }
 return false;
};
ASPx.IsValidElements = function(elements) {
 if(!elements)
  return false; 
 for(var i = 0; i < elements.length; i++) {
  if(elements[i] && !ASPx.IsValidElement(elements[i]))
   return false;
 }
 return true;
};
ASPx.IsExistsElement = function(element) {
 return element && ASPx.IsValidElement(element);
};
ASPx.CreateHtmlElementFromString = function(str) {
 var dummy = ASPx.CreateHtmlElement();
 setInnerHtmlInternal(dummy, str);
 return dummy.firstChild;
};
ASPx.CreateHtmlElement = function(tagName, styles) {
 var element = document.createElement(tagName || "DIV");
 if(styles)
  ASPx.SetStyles(element, styles);
 return element;
};
ASPx.RestoreElementOriginalWidth = function(element) {
 if(!ASPx.IsExistsElement(element)) 
  return;
 element.style.width = element.dxOrigWidth = ASPx.GetElementOriginalWidth(element);
};
ASPx.GetElementOriginalWidth = function(element) {
 if(!ASPx.IsExistsElement(element)) 
  return null;
 var width;
 if(!ASPx.IsExists(element.dxOrigWidth)) {
  width = String(element.style.width).length > 0
   ? element.style.width
   : ASPx.GetElementOffsetWidth(element) + "px";
 } else {
  width = element.dxOrigWidth;
 }
 return width;
};
ASPx.DropElementOriginalWidth = function(element) {
 if(ASPx.IsExists(element.dxOrigWidth))
  element.dxOrigWidth = null;
};
ASPx.GetObjectKeys = function(obj) {
 if(!obj) return [ ];
 if(Object.keys)
  return Object.keys(obj);
 var keys = [ ];
 for(var key in obj) {
  if(obj.hasOwnProperty(key))
   keys.push(key);
 }
 return keys;
};
ASPx.ShowErrorAlert = function(message) {
 message = ASPx.Str.DecodeHtmlViaTextArea(message);
 if(ASPx.IsExists(message) && message !== "")
  alert(message);
};
ASPx.ShowKBErrorMessage = function(text, kbid) {
 ASPx.ShowErrorMessage(text + "https://www.devexpress.com/kbid=" + kbid + ".");
};
ASPx.ShowErrorMessage = function(errorMessage) {
 var console = window.console;
 if(!console || !ASPx.IsFunction(console.error))
  return;
 console.error(errorMessage);
};
ASPx.IsInteractiveControl = function(element, extremeParent) { 
 return Data.ArrayIndexOf(["A", "INPUT", "SELECT", "OPTION", "TEXTAREA", "BUTTON", "IFRAME"], element.tagName) > -1;
};
ASPx.IsUrlContainsClientScript = function(url) {
 return url.toLowerCase().indexOf("javascript:") !== -1;
};
ASPx.GetMSAjaxRequestManager = function() {
 if(window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager && Sys.WebForms.PageRequestManager.getInstance)
  return Sys.WebForms.PageRequestManager.getInstance();
 return null;
};
Function.prototype.aspxBind = function(scope) {
 var func = this;
 return function() {
  return func.apply(scope, arguments);
 };
};
var FilteringUtils = { };
FilteringUtils.EventKeyCodeChangesTheInput = function(evt) {
 if(ASPx.IsPasteShortcut(evt))
  return true;
 else if(evt.ctrlKey && !evt.altKey)
  return false;
 if(ASPx.Browser.AndroidMobilePlatform || ASPx.Browser.MacOSMobilePlatform) return true; 
 var keyCode = ASPx.Evt.GetKeyCode(evt);
 var isSystemKey = ASPx.Key.Windows <= keyCode && keyCode <= ASPx.Key.ContextMenu;
 var isFKey = ASPx.Key.F1 <= keyCode && keyCode <= 127; 
 return ASPx.Key.Delete <= keyCode && !isSystemKey && !isFKey || keyCode == ASPx.Key.Backspace || keyCode == ASPx.Key.Space;
};
FilteringUtils.FormatCallbackArg = function(prefix, arg) {
 return (ASPx.IsExists(arg) ? prefix + "|" + arg.length + ';' + arg + ';' : "");
};
ASPx.FilteringUtils = FilteringUtils;
var FormatStringHelper = { };
FormatStringHelper.PlaceHolderTemplateStruct = function(startIndex, length, index, placeHolderString){
 this.startIndex = startIndex;
 this.realStartIndex = 0;
 this.length = length;
 this.realLength = 0;
 this.index = index;
 this.placeHolderString = placeHolderString;
};
FormatStringHelper.GetPlaceHolderTemplates = function(formatString){
 formatString = this.CollapseDoubleBrackets(formatString);
 var templates = this.CreatePlaceHolderTemplates(formatString);
 return templates;
};
FormatStringHelper.CreatePlaceHolderTemplates = function(formatString){
 var templates = [];
 var templateStrings = formatString.match(/{[^}]+}/g);
 if(templateStrings != null){
  var pos = 0;
  for(var i = 0; i < templateStrings.length; i++){
   var tempString = templateStrings[i];
   var startIndex = formatString.indexOf(tempString, pos);
   var length = tempString.length;
   var indexString = tempString.slice(1).match(/^[0-9]+/);
   var index = parseInt(indexString);
   templates.push(new this.PlaceHolderTemplateStruct(startIndex, length, index, tempString));
   pos = startIndex + length;
  }
 }
 return templates;
};
FormatStringHelper.CollapseDoubleBrackets = function(formatString){
 formatString = this.CollapseOpenDoubleBrackets(formatString);
 formatString = this.CollapseCloseDoubleBrackets(formatString);
 return formatString;
};
FormatStringHelper.CollapseOpenDoubleBrackets = function(formatString){
 return formatString.replace(/{{/g, "_");
};
FormatStringHelper.CollapseCloseDoubleBrackets = function(formatString){
 while(true){
  var index = formatString.lastIndexOf("}}");
  if(index == -1) 
   break;
  else
   formatString = formatString.substr(0, index) + "_" + formatString.substr(index + 2);
 }
 return formatString;
};
ASPx.FormatStringHelper = FormatStringHelper;
var StartWithFilteringUtils = { };
StartWithFilteringUtils.HighlightSuggestedText = function(input, suggestedText, control, onChangeInput){
 if(this.NeedToLockAndoidKeyEvents(control))
  control.LockAndroidKeyEvents();
 var selInfo = ASPx.Selection.GetInfo(input);
 var currentTextLenght = ASPx.Str.GetCoincideCharCount(suggestedText, input.value, 
  function(text, filter) { 
   return text.indexOf(filter) == 0;
  });
 var suggestedTextLenght = suggestedText.length;
 var isSelected = selInfo.startPos == 0 && selInfo.endPos == currentTextLenght && 
  selInfo.endPos == suggestedTextLenght && input.value == suggestedText;
 if(!isSelected) { 
  input.value = suggestedText;
  if(onChangeInput)
   onChangeInput();
  if(this.NeedToLockAndoidKeyEvents(control)) {
   window.setTimeout(function() {
    this.SelectText(input, currentTextLenght, suggestedTextLenght);
    control.UnlockAndroidKeyEvents();
   }.aspxBind(this), control.adroidSamsungBugTimeout);
  } else
   this.SelectText(input, currentTextLenght, suggestedTextLenght);
 }
};
StartWithFilteringUtils.SelectText = function(input, startPos, stopPos) {
 if(startPos < stopPos)
  ASPx.Selection.Set(input, startPos, stopPos);
};
StartWithFilteringUtils.RollbackOneSuggestedChar = function(input){
 var currentText = input.value;
 var cutText = currentText.slice(0, -1);
 if(cutText != currentText)
  input.value = cutText;
};
StartWithFilteringUtils.NeedToLockAndoidKeyEvents = function(control) {
 return ASPx.Browser.AndroidMobilePlatform && control && control.LockAndroidKeyEvents;
};
ASPx.StartWithFilteringUtils = StartWithFilteringUtils;
var ContainsFilteringUtils = { };
ContainsFilteringUtils.ColumnSelectionStruct = function(index, startIndex, length){
 this.index = index;
 this.length = length;
 this.startIndex = startIndex;
};
ContainsFilteringUtils.IsFilterCrossPlaseHolder = function(filterStartIndex, filterEndIndex, template) {
 var left = Math.max(filterStartIndex, template.realStartIndex);
 var right = Math.min(filterEndIndex,  template.realStartIndex + template.realLength);
 return left < right;
};
ContainsFilteringUtils.GetColumnSelectionsForItem = function(itemValues, formatString, filterString) {
 if(formatString == "") 
  return this.GetSelectionForSingleColumnItem(itemValues, filterString); 
 var result = [];
 var formatedString = ASPx.Formatter.Format(formatString, itemValues);
 var filterStartIndex = ASPx.Str.PrepareStringForFilter(formatedString).indexOf(ASPx.Str.PrepareStringForFilter(filterString));
 if(filterStartIndex == -1) return result;
 var filterEndIndex = filterStartIndex + filterString.length;
 var templates = FormatStringHelper.GetPlaceHolderTemplates(formatString);
 this.SupplyTemplatesWithRealValues(itemValues, templates);
 for(var i = 0; i < templates.length ; i++) {
  if(this.IsFilterCrossPlaseHolder(filterStartIndex, filterEndIndex, templates[i])) 
   result.push(this.GetColumnSelectionsForItemValue(templates[i], filterStartIndex, filterEndIndex));
 }
 return result;
};
ContainsFilteringUtils.GetColumnSelectionsForItemValue = function(template, filterStartIndex, filterEndIndex) {
 var selectedTextStartIndex = filterStartIndex < template.realStartIndex ? 0 :
  filterStartIndex - template.realStartIndex;
 var selectedTextEndIndex = filterEndIndex >  template.realStartIndex + template.realLength ? template.realLength :
  filterEndIndex - template.realStartIndex;
 var selectedTextLength = selectedTextEndIndex - selectedTextStartIndex;
 return new this.ColumnSelectionStruct(template.index, selectedTextStartIndex, selectedTextLength);
};
ContainsFilteringUtils.GetSelectionForSingleColumnItem = function(itemValues, filterString) {
 var selectedTextStartIndex = ASPx.Str.PrepareStringForFilter(itemValues[0]).indexOf(ASPx.Str.PrepareStringForFilter(filterString));
 var selectedTextLength = filterString.length;
 return [new this.ColumnSelectionStruct(0, selectedTextStartIndex, selectedTextLength)];
};
ContainsFilteringUtils.ResetFormatStringIndex = function(formatString, index) {
 if(index != 0)
  return formatString.replace(index.toString(), "0");
 return formatString;
};
ContainsFilteringUtils.SupplyTemplatesWithRealValues = function(itemValues, templates) {
 var shift = 0;
 for(var i = 0; i < templates.length; i++) {
  var formatString = this.ResetFormatStringIndex(templates[i].placeHolderString, templates[i].index);
  var currentItemValue = itemValues[templates[i].index];
  templates[i].realLength = ASPx.Formatter.Format(formatString, currentItemValue).length;
  templates[i].realStartIndex  += templates[i].startIndex + shift; 
  shift += templates[i].realLength - templates[i].placeHolderString.length; 
 }
};
ContainsFilteringUtils.PrepareElementText = function(itemText) {
 return itemText ? itemText.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;") : '';
};
ContainsFilteringUtils.UnselectContainsTextInElement = function(element, selection, highlightTagName) {
 var currentText =  ASPx.Attr.GetAttribute (element, "DXText");
 if(ASPx.IsExists(currentText)) {
  currentText = ContainsFilteringUtils.PrepareElementText(currentText);
  ASPx.Security.setInnerHtml(element, currentText === "" ? "&nbsp;" : currentText, ASPx.Security.DataType.Trusted);
 }
};
ContainsFilteringUtils.ReselectContainsTextInElement = function(element, selection, highlightTagName) {
 var currentText = ASPx.GetInnerText(element);
 if(!highlightTagName)
  highlightTagName = "em";
 highlightTagName = highlightTagName.toLowerCase();
 if(currentText.indexOf("</" + highlightTagName + ">") != -1)
  ContainsFilteringUtils.UnselectContainsTextInElement(element, selection, highlightTagName);
 return ContainsFilteringUtils.SelectContainsTextInElement(element, selection, highlightTagName);
};
ContainsFilteringUtils.SelectContainsTextInElement = function(element, selection, highlightTagName) {
 if(selection.startIndex == -1)
  return;
 var currentText =  ASPx.Attr.GetAttribute (element, "DXText");
 if(!ASPx.IsExists(currentText)) ASPx.Attr.SetAttribute (element, "DXText", ASPx.GetInnerText(element));
 if(!highlightTagName)
  highlightTagName = "em";
 highlightTagName = highlightTagName.toLowerCase();
 var oldInnerText = ASPx.GetInnerText(element);
 var newInnerText = ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(0, selection.startIndex)) + "<" + highlightTagName + ">" +
      ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(selection.startIndex, selection.length)) + "</" + highlightTagName + ">" +
      ContainsFilteringUtils.PrepareElementText(oldInnerText.substr(selection.startIndex + selection.length));
 ASPx.Security.setInnerHtml(element, newInnerText, ASPx.Security.DataType.Trusted);
};
ASPx.ContainsFilteringUtils = ContainsFilteringUtils;
ASPx.MakeEqualControlsWidth = function(name1, name2){
 var control1 = ASPx.GetControlCollection().Get(name1);
 var control2 = ASPx.GetControlCollection().Get(name2);
 if(control1 && control2){
  var width = Math.max(control1.GetWidth(), control2.GetWidth());
  control1.SetWidth(width);
  control2.SetWidth(width);
 }
};
ASPx.HighContrastForeColorHighlightColorMap = {
 "#ffff00" : "#008000",
 "#00ff00" : "#0000ff",
 "#ffffff" : "#00838f",
 "#000000" : "#a347ff"
};
var BadgeManagerBase = ASPx.CreateClass(null, {
 createBadge: function(text, iconCssClass) {
  var badge = document.createElement("SPAN");
  ASPx.SetClassName(badge, this.getBadgeClassName());
  if(iconCssClass && iconCssClass.length)
   this.setBadgeIconCssClass(badge, iconCssClass);
  if(text && text.length)
   this.setBadgeText(badge, text);
  return badge;
 },
 findBadge: function(element) {
  if(!element)
   return null;
  return element.querySelector("." + this.getBadgeClassName());
 },
 setBadgeIconCssClass: function(badge, iconCssClass) {
  if(!badge || iconCssClass === undefined)
   return;
  var iconElement = this.getBadgeIconElement(badge);
  if(!iconCssClass) {
   if(iconElement)
    badge.removeChild(iconElement);
  }
  else {
   if(!iconElement) {
    iconElement = document.createElement("SPAN");
    badge.insertBefore(iconElement, badge.childNodes[0]);
   }
   ASPx.SetClassName(iconElement, iconCssClass + " " + this.getBadgeIconDefaultClassName());
  }
 },
 getBadgeIconCssClass: function(element) {
  var badge = this.findBadge(element);
  if(badge) {
   var iconElement = this.getBadgeIconElement(badge);
   var regEx = new RegExp("(?:^|\\s)" + this.getBadgeIconDefaultClassName() + "(?!\\S)");
   return iconElement ? ASPx.Str.Trim(ASPx.GetClassName(iconElement).replace(regEx, "")) : "";
  }
  return "";
 },
 setBadgeText: function(badge, text) {
  if(!badge || text === undefined)
   return;
  var textElement = this.getBadgeTextElement(badge);
  if(!text) {
   if(textElement)
    badge.removeChild(textElement);
  }
  else {
   if(!textElement) {
    textElement = document.createElement("SPAN");
    badge.appendChild(textElement);
   }
   ASPx.Security.setInnerHtml(textElement, text, ASPx.Security.DataType.Trusted);
  }
 },
 getBadgeText: function(element) {
  var badge = this.findBadge(element);
  if(badge) {
   var textElement = this.getBadgeTextElement(badge);
   return textElement ? ASPx.GetInnerText(textElement) : "";
  }
  return "";
 },
 getBadgeClassName: function() {
  return "";
 },
 getBadgeIconDefaultClassName: function() {
  return "";
 },
 getBadgeIconElement: function(badge) {
  return badge.childNodes.length ? badge.querySelector("." + this.getBadgeIconDefaultClassName()) : null;
 },
 getBadgeTextElement: function(badge) {
  return badge.childNodes.length ? badge.querySelector("span:not(." + this.getBadgeIconDefaultClassName() + ")") : null;
 }
});
ASPx.BadgeManagerBase = BadgeManagerBase;
var BadgeManager = ASPx.CreateClass(BadgeManagerBase, {
 getBadgeClassName: function() {
  return "dxBadge";
 },
 getBadgeIconDefaultClassName: function() {
  return "dxBadgeImage";
 }
});
ASPx.BadgeManager = new BadgeManager();
var AccessibilityUtils = {
 isInitialized: false,
 highContrastCssClassMarker: "dxHighContrast",
 highContrastBackgroundCssClassMarker: "dxHCB",
 highContrastDefaultBackgroundColor: "#a347ff",
 highContrastThemeActive: false,
 accessibleBackgroundCssMarker: ".dx-runtime-background",
 createAccessibleBackgrounds: function(control) {
  if(!this.highContrastThemeActive || control.accessibleBackgroundsCreated || !control.accessibilityCompliant)
   return;
  var className = this.accessibleBackgroundCssMarker;
  var styleSheetRuleNames = [];
  iterateStyleSheetRules(null, function(rule) {
   var selectorTxt = rule.selectorText;
   if(selectorTxt && selectorTxt.indexOf(className) > -1)
    styleSheetRuleNames.push(ASPx.Str.CompleteReplace(selectorTxt, className, "")); 
  });
  for(var i = 0; i < styleSheetRuleNames.length; i++) {
   var name = styleSheetRuleNames[i];
   var rule = ASPx.GetStyleSheetRules(name.substring(1));
   if(rule && rule.style && rule.style.backgroundImage)
    this.createAccessibleBackground(control.GetMainElement(), rule.style, name);
  }
  control.accessibleBackgroundsCreated = true;
 },
 createAccessibleBackground: function(container, style, selector) {
  if(!container)
   return;
  var backgroundUrl = style.backgroundImage.substring(5, style.backgroundImage.length - 2);
  var elements = container.querySelectorAll(selector);
  var accessibleBackgroundClassName = "dx-acc-bi";
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   if(ASPx.ElementHasCssClass(element, accessibleBackgroundClassName))
    continue;
   var image = null;
   if(element.tagName !== "IMG") {
    ASPx.AddClassNameToElement(element, accessibleBackgroundClassName);
    image = element.ownerDocument.createElement("IMG");
    ASPx.SetStyles(image, { width: "100%", height: "100%" });
    if(element.firstChild)
     element.insertBefore(image, element.firstChild);
    else
     element.appendChild(image);
   } else
    image = element;
   image.src = backgroundUrl;
  }
 },
 createHighContrastBackgroundStyle: function() {
  var style = document.createElement('style');
  style.type = 'text/css';
  var styleContent = [
   "." + this.highContrastCssClassMarker + " ." + this.highContrastBackgroundCssClassMarker + ":after {",
   "border-image: url(" + this.getHighContrastBackgroundUrl() + ") 0 1 0 0 round;",
   "}",
  ];
  setInnerHtmlInternal(style, styleContent.join('\n'));
  document.getElementsByTagName('head')[0].appendChild(style);
 },
 getHighContrastBackgroundUrl: function() {
  var canvas = document.createElement("canvas"),
  ctx = canvas.getContext('2d');
  canvas.width = 1;
  canvas.height = 1;
  ctx.fillStyle = this.getHighContrastBackgroundColor();
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  return canvas.toDataURL();
 },
 getHighContrastBackgroundColor: function() {
  var foreColor = ASPx.GetCurrentStyle(document.body).color;
  var hexColor = ASPx.Color.ColorToHexadecimal(foreColor);
  return ASPx.HighContrastForeColorHighlightColorMap[hexColor] || this.highContrastDefaultBackgroundColor;
 },
 initialize: function() {
  if(this.isInitialized)
   return;
  this.isInitialized = true;
  this.detectHighContrastTheme();
  if(this.highContrastThemeActive)
   this.createHighContrastBackgroundStyle();
 },
 detectHighContrastTheme: function() {
  var testElement = document.createElement("DIV");
  ASPx.SetStyles(testElement, {
   backgroundImage: "url('" + ASPx.EmptyImageUrl + "')",
   display: "none"
  }, true);
  var docElement = document.documentElement;
  docElement.appendChild(testElement);
  var actualBackgroundImg = ASPx.GetCurrentStyle(testElement).backgroundImage;
  docElement.removeChild(testElement);
  if(actualBackgroundImg === "none") {
   this.highContrastThemeActive = true;
   ASPx.AddClassNameToElement(docElement, this.highContrastCssClassMarker);
  }
 }
};
ASPx.AccessibilityUtils = AccessibilityUtils;
ASPx.AccessibilityUtils.SendMessageToAssistiveTechnology = function(message) {
 var messageParts = ASPx.Ident.IsArray(message) ? message : [message];
 var args = new ASPxClientControlBeforePronounceEventArgs(messageParts, null);
 ASPx.AccessibilityPronouncer.EnsureInitialize();
 ASPx.AccessibilityPronouncer.Pronounce(args, ASPx.AccessibilityPronouncerType.live);
};
ASPx.AccessibilityUtils.SetFocusAccessible = function(focusableElement) {
 if(!focusableElement)
  return;
 var elementId = focusableElement.id;
 if(!elementId) {
  var namedParent = ASPx.GetParent(focusableElement, function(element) {
   return !!element.id;
  });
  if(ASPx.IsExists(namedParent))
   elementId = namedParent.id;
 }
 var focusableControl = ASPx.GetClientControlByElementID(elementId);
 if(focusableControl && focusableControl.OnAssociatedLabelClick)
  focusableControl.OnAssociatedLabelClick(focusableElement);
 else
  window.setTimeout(function() {
   ASPx.AccessibilityUtils.SetFocusAccessibleCore(focusableElement);
  }, 0);
};
ASPx.AccessibilityUtils.SetFocusAccessibleCore = function(focusableElement) {
 if(!ASPx.IsExists(focusableElement))
  return;
 if(!ASPx.IsValidElement(focusableElement) && focusableElement.id)
  focusableElement = ASPx.GetElementById(focusableElement.id);
 if(!ASPx.IsActionElement(focusableElement))
  focusableElement = ASPx.RestoreFocusHelper.findNeighbourFocusElement(focusableElement, document.body);
 if(ASPx.IsExistsElement(focusableElement))
  focusableElement.focus();
};
var Security = {
 setInnerHtml: function(el, html, dataType) {
  if(!html) {
   while(el.firstChild)
    ASPx.RemoveElement(el.firstChild);
  } else
   Security.setData(html, function(d) { ASPx.SetInnerHtml.call(window, el, d); }, dataType);
 },
 setText: function(control, text, dataType) { Security.setData(text, control.SetText.aspxBind(control), dataType); },
 safeEncodeHtml: function(html) { return ASPx.Str.EncodeHtml(ASPx.Str.DecodeHtml(html)); },
 setData: function(data, dataSetter, dataType) {
  if(dataType === undefined)
   throw new Error("Specify the dataType");
  if(dataType == Security.DataType.Untrusted)
   data = Security.safeEncodeHtml(data);
  dataSetter(data);
 }
};
Security.DataType = {
 Trusted: 0,
 Untrusted: 1
};
ASPx.EnableCssAnimation = true;
var AnimationTransitionBase = ASPx.CreateClass(null, {
 constructor: function(element, options) {
  if(element) {
   AnimationTransitionBase.Cancel(element);
   this.element = element;
   this.element.aspxTransition = this;
  }
  this.duration = options.duration || AnimationConstants.Durations.DEFAULT;
  this.transition = options.transition || AnimationConstants.Transitions.SINE;
  this.property = options.property;
  this.unit = options.unit || "";
  this.onComplete = options.onComplete;
  this.to = null;
  this.from = null;
 },
 Start: function(from, to) {
  if(to != undefined) {
   this.to = to;
   this.from = from;
   this.SetValue(this.from);
  }
  else
   this.to = from;
 },
 Cancel: function() {
  if(!this.element)
   return;
  try {
   delete this.element.aspxTransition;
  } catch(e) {
   this.element.aspxTransition = undefined;
  }
 },
 GetValue: function() {
  return this.getValueInternal(this.element, this.property);
 },
 SetValue: function(value) {
  this.setValueInternal(this.element, this.property, this.unit, value);
 },
 setValueInternal: function(element, property, unit, value) {
  if(property == "opacity")
   AnimationUtils.setOpacity(element, value);
  else
   element.style[property] = value + unit;
 },
 getValueInternal: function(element, property) {
  if(property == "opacity")
   return ASPx.GetElementOpacity(element);
  var value = parseFloat(element.style[property]);
  return isNaN(value) ? 0 : value;
 },
 performOnComplete: function() {
  if(this.onComplete)
   this.onComplete(this.element);
 },
 getTransition: function() {
  return this.transition;
 }
});
AnimationTransitionBase.Cancel = function(element) {
 if(element.aspxTransition)
  element.aspxTransition.Cancel();
};
var AnimationConstants = {};
AnimationConstants.Durations = {
 SHORT: 200,
 DEFAULT: 400,
 LONG: 600
};
AnimationConstants.Transitions = {
 LINER: {
  Css: "cubic-bezier(0.250, 0.250, 0.750, 0.750)",
  Js: function(progress) { return progress; }
 },
 SINE: {
  Css: "cubic-bezier(0.470, 0.000, 0.745, 0.715)",
  Js: function(progress) { return Math.sin(progress * 1.57); }
 },
 POW: {
  Css: "cubic-bezier(0.755, 0.050, 0.855, 0.060)",
  Js: function(progress) { return Math.pow(progress, 4); }
 },
 POW_EASE_OUT: {
  Css: "cubic-bezier(0.165, 0.840, 0.440, 1.000)",
  Js: function(progress) { return 1 - AnimationConstants.Transitions.POW.Js(1 - progress); }
 },
 RIPPLE: {
  Css: "cubic-bezier(0.47, 0.06, 0.23, 0.99)",
  Js: function(progress) {
   return Math.pow((progress), 3) * 0.47 + 3 * progress * Math.pow((1 - progress), 2) * 0.06 + 3 * Math.pow(progress, 2) *
    (1 - progress) * 0.23 + 0.99 * Math.pow(progress, 3);
  }
 }
};
var JsAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.onStep = options.onStep;
  this.fps = 60;
  this.startTime = null;
 },
 Start: function(from, to) {
  if(from == to) {
   this.from = this.to = from;
   setTimeout(this.complete.aspxBind(this), 0);
  }
  else {
   AnimationTransitionBase.prototype.Start.call(this, from, to);
   if(to == undefined)
    this.from = this.GetValue();
   this.initTimer();
  }
 },
 Cancel: function() {
  AnimationTransitionBase.prototype.Cancel.call(this);
  if(this.timerId)
   clearInterval(this.timerId);
 },
 initTimer: function() {
  this.startTime = new Date();
  this.timerId = window.setInterval(function() { this.onTick(); }.aspxBind(this), 1000 / this.fps);
 },
 onTick: function() {
  var progress = (new Date() - this.startTime) / this.duration;
  if(progress >= 1)
   this.complete();
  else {
   this.update(progress);
   if(this.onStep)
    this.onStep();
  }
 },
 update: function(progress) {
  this.SetValue(this.gatCalculatedValue(this.from, this.to, progress));
 },
 complete: function() {
  this.Cancel();
  this.update(1);
  this.performOnComplete();
 },
 gatCalculatedValue: function(from, to, progress) {
  if(progress == 1)
   return to;
  return from + (to - from) * this.getTransition()(progress);
 },
 getTransition: function() {
  return this.transition.Js;
 }
});
var SimpleAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
 constructor: function(options) {
  this.constructor.prototype.constructor.call(this, null, options);
  this.transition = options.transition || AnimationConstants.Transitions.POW_EASE_OUT;
  this.onUpdate = options.onUpdate;
  this.lastValue = 0;
 },
 SetValue: function(value) {
  this.onUpdate(value - this.lastValue);
  this.lastValue = value;
 },
 GetValue: function() {
  return this.lastValue;
 },
 performOnComplete: function() {
  if(this.onComplete)
   this.onComplete();
 }
});
var MultipleJsAnimationTransition = ASPx.CreateClass(JsAnimationTransition, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.properties = {};
 },
 Start: function(properties) {
  this.initProperties(properties);
  this.initTimer();
 },
 initProperties: function(properties) {
  this.properties = properties;
  for(var propName in this.properties)
   if(properties[propName].from == undefined)
    properties[propName].from = this.getValueInternal(this.element, propName);
 },
 update: function(progress) {
  for(var propName in this.properties) {
   if(this.properties.hasOwnProperty(propName)) {
    var property = this.properties[propName];
    if(property.from != property.to)
     this.setValueInternal(this.element, propName, property.unit, this.gatCalculatedValue(property.from, property.to, progress));
   }
  }
 }
});
var CssAnimationTransition = ASPx.CreateClass(AnimationTransitionBase, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.transitionPropertyName = AnimationUtils.CurrentTransition.property;
  this.eventName = AnimationUtils.CurrentTransition.event;
 },
 Start: function(from, to) {
  AnimationTransitionBase.prototype.Start.call(this, from, to);
  this.startTimerId = window.setTimeout(function() {
   if(this.from == this.to)
    this.onTransitionEnd();
   else {
    var isHidden = ASPx.GetElementOffsetHeight(this.element) == 0 && ASPx.GetElementOffsetWidth(this.element) == 0; 
    if(!isHidden)
     this.prepareElementBeforeAnimation();
    this.SetValue(this.to);
    if(isHidden)
     this.onTransitionEnd();
   }
  }.aspxBind(this), 0);
 },
 Cancel: function() {
  window.clearTimeout(this.startTimerId);
  AnimationTransitionBase.prototype.Cancel.call(this);
  ASPx.Evt.DetachEventFromElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
  this.setValueInternal(this.element, this.transitionPropertyName, "", "");
  this.stopAnimation();
 },
 prepareElementBeforeAnimation: function() {
  ASPx.Evt.AttachEventToElement(this.element, this.eventName, CssAnimationTransition.transitionEnd);
  var dummy = this.element.offsetHeight;
  this.element.style[this.transitionPropertyName] = this.getTransitionCssString();
  if(ASPx.Browser.Safari && ASPx.Browser.MacOSMobilePlatform && ASPx.Browser.MajorVersion >= 8) 
   setTimeout(function() {
    if(this.element && this.element.aspxTransition) {
     this.element.style[this.transitionPropertyName] = "";
     this.element.aspxTransition.onTransitionEnd();
    }
   }.aspxBind(this), this.duration + 100);
 },
 stopAnimation: function() {
  this.SetValue(ASPx.GetCurrentStyle(this.element)[this.property]);
 },
 onTransitionEnd: function() {
  this.Cancel();
  this.performOnComplete();
 },
 getTransition: function() {
  return this.transition.Css;
 },
 getTransitionCssString: function() {
  return this.getTransitionCssStringInternal(this.getCssName(this.property));
 },
 getTransitionCssStringInternal: function(cssProperty) {
  return cssProperty + " " + this.duration + "ms " + this.getTransition();
 },
 getCssName: function(property) {
  switch(property) {
   case "marginLeft":
    return "margin-left";
   case "marginTop":
    return "margin-top";
  }
  return property;
 }
});
var MultipleCssAnimationTransition = ASPx.CreateClass(CssAnimationTransition, {
 constructor: function(element, options) {
  this.constructor.prototype.constructor.call(this, element, options);
  this.properties = null;
 },
 Start: function(properties) {
  this.properties = properties;
  this.forEachProperties(function(property, propName) {
   if(property.from !== undefined)
    this.setValueInternal(this.element, propName, property.unit, property.from);
  }.aspxBind(this));
  this.prepareElementBeforeAnimation();
  window.setTimeout(function() {
   this.forEachProperties(function(property, propName) {
    this.setValueInternal(this.element, propName, property.unit, property.to);
   }.aspxBind(this));
  }.aspxBind(this), 0);
 },
 stopAnimation: function() {
  var style = ASPx.GetCurrentStyle(this.element);
  this.forEachProperties(function(property, propName) {
   this.setValueInternal(this.element, propName, "", style[propName]);
  }.aspxBind(this));
 },
 getTransitionCssString: function() {
  var str = "";
  this.forEachProperties(function(property, propName) {
   str += this.getTransitionCssStringInternal(this.getCssName(propName)) + ",";
  }.aspxBind(this));
  str = str.substring(0, str.length - 1);
  return str;
 },
 forEachProperties: function(func) {
  for(var propName in this.properties) {
   if(this.properties.hasOwnProperty(propName)) {
    var property = this.properties[propName];
    if(property.from == undefined)
     property.from = this.getValueInternal(this.element, propName);
    if(property.from != property.to)
     func(property, propName);
   }
  }
 }
});
CssAnimationTransition.transitionEnd = function(evt) {
 var element = evt.target;
 if(element && element.aspxTransition)
  element.aspxTransition.onTransitionEnd();
};
var AnimationUtils = {
 CanUseCssTransition: function() { return ASPx.EnableCssAnimation && this.CurrentTransition; },
 CanUseCssTransform: function() { return this.CanUseCssTransition() && this.CurrentTransform; },
 CurrentTransition: (function() {
  if(ASPx.Browser.IE) 
   return null;
  var transitions = [
   { property: "webkitTransition", event: "webkitTransitionEnd" },
   { property: "MozTransition", event: "transitionend" },
   { property: "OTransition", event: "oTransitionEnd" },
   { property: "transition", event: "transitionend" }
  ];
  var fakeElement = document.createElement("DIV");
  for(var i = 0; i < transitions.length; i++)
   if(transitions[i].property in fakeElement.style)
    return transitions[i];
 })(),
 CurrentTransform: (function() {
  var transforms = ["transform", "MozTransform", "-webkit-transform", "msTransform", "OTransform"];
  var fakeElement = document.createElement("DIV");
  for(var i = 0; i < transforms.length; i++)
   if(transforms[i] in fakeElement.style)
    return transforms[i];
 })(),
 SetTransformValue: function(element, position, isTop) {
  if(this.CanUseCssTransform())
   element.style[this.CurrentTransform] = this.GetTransformCssText(position, isTop);
  else
   element.style[!isTop ? "left" : "top"] = position + "px";
 },
 GetTransformValue: function(element, isTop) {
  if(this.CanUseCssTransform()) {
   var cssValue = element.style[this.CurrentTransform];
   return cssValue && cssValue != "none" ? Number(cssValue.replace('matrix(1, 0, 0, 1,', '').replace(')', '').split(',')[!isTop ? 0 : 1]) : 0;
  }
  else
   return !isTop ? element.offsetLeft : element.offsetTop;
 },
 GetTransformCssText: function(position, isTop) {
  if(!position)
   return "none";
  return "matrix(1, 0, 0, 1," + (!isTop ? position : 0) + ", " + (!isTop ? 0 : position) + ")";
 },
 createMultipleAnimationTransition: function (element, options) {
  return this.CanUseCssTransition() && !options.onStep ? new MultipleCssAnimationTransition(element, options) : new MultipleJsAnimationTransition(element, options);
 },
 createSimpleAnimationTransition: function(options) {
  return new SimpleAnimationTransition(options);
 },
 createJsAnimationTransition: function(element, options) {
  return new JsAnimationTransition(element, options);
 },
 createCssAnimationTransition: function(element, options) {
  return new CssAnimationTransition(element, options);
 },
 setOpacity: function(element, value) {
  ASPx.SetElementOpacity(element, value);
 }
};
var AsyncTracker = function() {
 var currentToken,
  lockedTokens,
  onDoneDelegates,
  lockedDelegates;
 function clearState() {
  currentToken = 1;
  lockedTokens = [];
  onDoneDelegates = [];
  lockedDelegates = {};
 }
 clearState();
 var log = function(msg) { };
 function setLog(delegate){
  log = delegate;
 }
 function getLockToken() {
  if(onDoneDelegates.length === 0)
   return -1;
  var token = currentToken++;
  lockedTokens.push(token);
  lockedDelegates[token] = [];
  for (var i = 0; i < onDoneDelegates.length; i++) {
   lockedDelegates[token].push(onDoneDelegates[i]);
  }
  log("module locks token " + token);
  return token;
 }
 function releaseToken(token) {
  if(token < 0) return;
  log("module releasing token " + token);
  ASPx.Data.ArrayRemove(lockedTokens, token);
  delete lockedDelegates[token];
  invokeUnlockedDelegates();
  if(lockedTokens.length === 0)
   clearState();
  log("module released token " + token);
 }
 function invokeUnlockedDelegates() {
  var onDoneDelegate;
  for (var i = onDoneDelegates.length - 1; i >= 0; i--) {
   if(onDoneDelegates[i] && !isDelegateLocked(onDoneDelegates[i])) {
    onDoneDelegate = onDoneDelegates[i];
    delete onDoneDelegates[i];
    onDoneDelegate();
   }
  }
 }
 function isDelegateLocked(delegate) {
  for (var i = lockedTokens.length - 1; i >= 0; i--) {
   var token = lockedTokens[i];
   var delegates = lockedDelegates[token];
   if(delegates) {
    for (var j = delegates.length - 1; j >= 0; j--) {
     if(delegates[j] && delegates[j] === delegate)
      return true;
    }
   }
  }
  return false;
 }
 function track(doDelegate, onDoneDelegate) {
  if(onDoneDelegate)
   onDoneDelegates.push(onDoneDelegate);
  doDelegate();
  if(onDoneDelegate)
   invokeUnlockedDelegates();
 }
 return {
  getLockToken: getLockToken,
  releaseToken: releaseToken,
  track: track,
  setLog:setLog,
 };
};
var GetEditorValuesInContainer = function(containerOrId, processInvisibleEditors, needSerialize) {
 var container = typeof(containerOrId) === "string" ? ASPx.GetElementById(containerOrId) : containerOrId;
 var result = {};
 if(!ASPx.ProcessEditorsInContainer) 
  return result;
 ASPx.ProcessEditorsInContainer(container, function(editor){
  result[editor.name] = GetCorrectedByTypeValue(ASPx.GetEditorValueByControl(editor), needSerialize);
 }, null, null, processInvisibleEditors, false);
 return result;
};
var SetEditorValues = function(values) {
 for(var controlName in values) {
  if(values.hasOwnProperty(controlName)) {
   var trackedControl = ASPxClientControl.GetControlCollection().Get(controlName);
   if(!trackedControl)
    continue;
   var setValueMethod = trackedControl.SetTokenCollection || trackedControl.SelectValues || trackedControl.SetValue;
   if(setValueMethod === trackedControl.SelectValues)
    trackedControl.UnselectAll();
   setValueMethod.call(trackedControl, values[controlName]);
  }
 }
};
var GetCorrectedByTypeValue = function(value, needSerialize){
 if(ASPx.Ident.IsArray(value))
  for(var i = 0; i < value.length; i++)
   value[i] = GetCorrectedByTypeValue(value[i]);
 if(needSerialize && ASPx.Ident.IsDate(value))
  return ASPx.DateUtils.GetInvariantDateTimeString(value);
 return value;
};
var ListBoxTemporaryCache = ASPx.CreateClass(null, {
 constructor: function() { 
  this.cache = { };
  this.invalidateTimerID = -1;
 },
 Get: function(key, getObjectFunc, context, args) {
  if(this.invalidateTimerID < 0) {
   this.invalidateTimerID = window.setTimeout(function() {
    this.Invalidate();
   }.aspxBind(this), 0);
  }
  if(!ASPx.IsExists(this.cache[key])) {
   if(!ASPx.IsExists(args))
    args = [ ];
   this.cache[key] = getObjectFunc.apply(context, args);
  }
  return this.cache[key];
 },
 Invalidate: function() {
  this.cache = { };
  this.invalidateTimerID = ASPx.Timer.ClearTimer(this.invalidateTimerID);
 }
});
ASPx.GetEditorValueByControl = function(control, needSerialize) {
 var result;
 if(ASPx.IsMultipleValueOwner(control))
  result = control.GetSelectedValues();
 if(ASPx.IsTokenBox(control)) {
  if(needSerialize)
   result = control.GetTokenValuesCollection();
  else
   result = control.GetTokenCollection();
 }
 return result || control.GetValue();
};
ASPx.IsMultipleValueOwner = function(control) {
 return ASPx.IsListBox(control) || ASPx.IsCheckBoxList(control);
};
ASPx.IsCheckBoxList = function(control) {
 return control && typeof(ASPxClientCheckBoxList) != "undefined" && control instanceof ASPxClientCheckBoxList;
};
ASPx.IsListBox = function(control) {
 return control && typeof(ASPxClientListBox) != "undefined" && control instanceof ASPxClientListBox;
};
ASPx.IsComboBox = function(control) {
 return control && typeof(ASPxClientComboBox) != "undefined" && control instanceof ASPxClientComboBox;
};
ASPx.IsTokenBox = function(control) {
 return control && typeof(ASPxClientTokenBox) != "undefined" && control instanceof ASPxClientTokenBox;
};
ASPx.IsGridLookup = function(control) {
 return control && typeof(MVCxClientGridLookup) != "undefined" && control instanceof MVCxClientGridLookup;
};
ASPx.IsSpinEdit = function(control) {
 return control && typeof(ASPxClientSpinEdit) != "undefined" && control instanceof ASPxClientSpinEdit;
};
ASPx.DatePickerType = {
 Days: 0,
 Months: 1,
 Years: 2,
 Decades: 3
};
ASPx.FullScreenUtils = {
 subscribeChange: function(handler) {
  Evt.AttachEventToElement(document, "fullscreenchange", handler);
  Evt.AttachEventToElement(document, "msfullscreenchange", handler); 
  Evt.AttachEventToElement(document, "MSFullscreenChange", handler); 
  Evt.AttachEventToElement(document, "webkitfullscreenchange", handler);
  Evt.AttachEventToElement(document, "mozfullscreenchange", handler);
 },
 unsubscribeChange: function(handler) {
  Evt.DetachEventFromElement(document, "fullscreenchange", handler);
  Evt.DetachEventFromElement(document, "msfullscreenchange", handler);
  Evt.DetachEventFromElement(document, "MSFullscreenChange", handler);
  Evt.DetachEventFromElement(document, "webkitfullscreenchange", handler);
  Evt.DetachEventFromElement(document, "mozfullscreenchange", handler);
 },
 setFullscreen: function(on) {
  var element = window.self.document.body;
  if(on) {
   if(element.requestFullscreen) {
    element.requestFullscreen();
   } else if(element.mozRequestFullScreen) {
    element.mozRequestFullScreen();
   } else if(element.webkitRequestFullscreen) {
    element.webkitRequestFullscreen();
   } else if(element.msRequestFullscreen) {
    element.msRequestFullscreen();
   }
  } else {
   if(document.exitFullscreen) {
    document.exitFullscreen();
   } else if(document.mozCancelFullScreen) {
    document.mozCancelFullScreen();
   } else if(document.webkitCancelFullScreen) {
    document.webkitCancelFullScreen();
   } else if(document.msExitFullscreen) {
    document.msExitFullscreen();
   }
  }
 },
 inFullscreen: function() {
  var fullscreenElement = document.fullscreenElement || document.msFullscreenElement || document.webkitFullscreenElement;
  var isInFullscreen = fullscreenElement === document.body || document.webkitIsFullScreen;
  return !!isInFullscreen;
 }
 };
ASPx.InitializeSVGSprite = function () {
 if (ASPx.SVGSprites && ASPx.SVGSprites.length > 0) {
  var svgContainer = document.getElementById('svgContainer');
  var hasSvgContainer = !!svgContainer;
  if (!hasSvgContainer) {
   svgContainer = document.createElement('div');
   svgContainer.id = 'svgContainer';
   svgContainer.style.display = "none";
   document.body.appendChild(svgContainer);
  }
  for (var i = 0; i < ASPx.SVGSprites.length; i++) {
   svgContainer.innerHTML += ASPx.SVGSprites[i];
  }
 }
};
var GridDynamicStyleSheetHelper = ASPx.CreateClass(null, {
 constructor: function() {
  this.styleSheet = {};
  this.rules = {};
  this.updateLock = 0;
 },
 Update: function(control, styleName, rules) {
  var key = control.name + "_" + styleName;
  this.BeginUpdate(key);
  this.ChangeRules(key, rules);
  this.EndUpdate(key);
 },
 ChangeRules: function(key, rules) {
  if(key && rules)
   this.rules[key] = rules;
 },
 BeginUpdate: function(key) {
  this.updateLock++;
  this.RemoveStyleSheetElement(key);
 },
 EndUpdate: function(key) {
  this.updateLock--;
  if(this.updateLock !== 0)
   return;
  var styleArgs = [];
  var controlRules = this.rules[key];
  for(var i = 0; i < controlRules.length; i++) {
   var rule = controlRules[i];
   styleArgs.push(rule.selector + " { " + rule.cssText + " } ");
  }
  this.styleSheet[key] = this.CreateStyleSheet(key, styleArgs.join(""));
 },
 CreateStyleSheet: function(key, cssText) {
  var container = document.createElement("DIV");
  ASPx.Security.setInnerHtml(container, "<style type='text/css' id='" + key + "'>" + cssText + "</style>", ASPx.Security.DataType.Trusted);
  styleSheet = ASPx.GetNodeByTagName(container, "style", 0);
  if(styleSheet)
   ASPx.GetNodeByTagName(document, "HEAD", 0).appendChild(styleSheet);
  return styleSheet;
 },
 ClearStyleSheet: function(control, styleName) {
  var key = control.name + "_" + styleName;
  this.RemoveStyleSheetElement(key);
 },
 RemoveStyleSheetElement: function(key) {
  if(this.styleSheet[key]) {
   ASPx.RemoveElement(this.styleSheet[key]);
   delete this.styleSheet[key];
  }
 }
});
GridDynamicStyleSheetHelper.Instance = new GridDynamicStyleSheetHelper();
ASPx.GridDynamicStyleSheetHelper = GridDynamicStyleSheetHelper;
ASPxClientUtils = {};
ASPxClientUtils.agent = Browser.UserAgent;
ASPxClientUtils.opera = Browser.Opera;
ASPxClientUtils.opera9 = Browser.Opera && Browser.MajorVersion == 9;
ASPxClientUtils.safari = Browser.Safari;
ASPxClientUtils.safari3 = Browser.Safari && Browser.MajorVersion == 3;
ASPxClientUtils.safariMacOS = Browser.Safari && Browser.MacOSPlatform;
ASPxClientUtils.chrome = Browser.Chrome;
ASPxClientUtils.ie = Browser.IE;
ASPxClientUtils.ie7 = Browser.IE && Browser.MajorVersion == 7;
ASPxClientUtils.firefox = Browser.Firefox;
ASPxClientUtils.firefox3 = Browser.Firefox && Browser.MajorVersion == 3;
ASPxClientUtils.mozilla = Browser.Mozilla;
ASPxClientUtils.netscape = Browser.Netscape;
ASPxClientUtils.browserVersion = Browser.Version;
ASPxClientUtils.browserMajorVersion = Browser.MajorVersion;
ASPxClientUtils.macOSPlatform = Browser.MacOSPlatform;
ASPxClientUtils.windowsPlatform = Browser.WindowsPlatform;
ASPxClientUtils.webKitFamily = Browser.WebKitFamily;
ASPxClientUtils.netscapeFamily = Browser.NetscapeFamily;
ASPxClientUtils.touchUI = Browser.TouchUI;
ASPxClientUtils.webKitTouchUI = Browser.WebKitTouchUI;
ASPxClientUtils.msTouchUI = Browser.MSTouchUI;
ASPxClientUtils.iOSPlatform = Browser.MacOSMobilePlatform;
ASPxClientUtils.androidPlatform = Browser.AndroidMobilePlatform;
ASPxClientUtils.ArrayInsert = Data.ArrayInsert;
ASPxClientUtils.ArrayRemove = Data.ArrayRemove;
ASPxClientUtils.ArrayRemoveAt = Data.ArrayRemoveAt;
ASPxClientUtils.ArrayClear = Data.ArrayClear;
ASPxClientUtils.ArrayIndexOf = Data.ArrayIndexOf;
ASPxClientUtils.AttachEventToElement = Evt.AttachEventToElement;
ASPxClientUtils.DetachEventFromElement = Evt.DetachEventFromElement;
ASPxClientUtils.GetEventSource = Evt.GetEventSource;
ASPxClientUtils.GetEventX = Evt.GetEventX;
ASPxClientUtils.GetEventY = Evt.GetEventY;
ASPxClientUtils.GetKeyCode = Evt.GetKeyCode;
ASPxClientUtils.PreventEvent = Evt.PreventEvent;
ASPxClientUtils.PreventEventAndBubble = Evt.PreventEventAndBubble;
ASPxClientUtils.PreventDragStart = Evt.PreventDragStart;
ASPxClientUtils.ClearSelection = Selection.Clear;
ASPxClientUtils.IsExists = ASPx.IsExists;
ASPxClientUtils.IsFunction = ASPx.IsFunction;
ASPxClientUtils.GetAbsoluteX = ASPx.GetAbsoluteX;
ASPxClientUtils.GetAbsoluteY = ASPx.GetAbsoluteY;
ASPxClientUtils.SetAbsoluteX = ASPx.SetAbsoluteX;
ASPxClientUtils.SetAbsoluteY = ASPx.SetAbsoluteY;
ASPxClientUtils.GetDocumentScrollTop = ASPx.GetDocumentScrollTop;
ASPxClientUtils.GetDocumentScrollLeft = ASPx.GetDocumentScrollLeft;
ASPxClientUtils.GetDocumentClientWidth = ASPx.GetDocumentClientWidth;
ASPxClientUtils.GetDocumentClientHeight = ASPx.GetDocumentClientHeight;
ASPxClientUtils.AddClassNameToElement = ASPx.AddClassNameToElement;
ASPxClientUtils.RemoveClassNameFromElement = ASPx.RemoveClassNameFromElement;
ASPxClientUtils.ToggleClassName = ASPx.ToggleClassNameToElement;
ASPxClientUtils.GetIsParent = ASPx.GetIsParent;
ASPxClientUtils.GetParentById = ASPx.GetParentById;
ASPxClientUtils.GetParentByTagName = ASPx.GetParentByTagName;
ASPxClientUtils.GetParentByClassName = ASPx.GetParentByPartialClassName;
ASPxClientUtils.GetChildById = ASPx.GetChildById;
ASPxClientUtils.GetChildByTagName = ASPx.GetChildByTagName;
ASPxClientUtils.SetCookie = Cookie.SetCookie;
ASPxClientUtils.GetCookie = Cookie.GetCookie;
ASPxClientUtils.DeleteCookie = Cookie.DelCookie;
ASPxClientUtils.GetShortcutCode = ASPx.GetShortcutCode; 
ASPxClientUtils.GetShortcutCodeByEvent = ASPx.GetShortcutCodeByEvent;
ASPxClientUtils.StringToShortcutCode = ASPx.ParseShortcutString;
ASPxClientUtils.Trim = Str.Trim; 
ASPxClientUtils.TrimStart = Str.TrimStart;
ASPxClientUtils.TrimEnd = Str.TrimEnd;
ASPxClientUtils.GetEditorValuesInContainer = GetEditorValuesInContainer;
ASPxClientUtils.SetEditorValues = SetEditorValues;
ASPxClientUtils.SendMessageToAssistiveTechnology = ASPx.AccessibilityUtils.SendMessageToAssistiveTechnology;
window.ASPxClientUtils = ASPxClientUtils;
window.ListBoxTemporaryCache = ListBoxTemporaryCache;
ASPx.AnimationUtils = AnimationUtils;
ASPx.AnimationTransitionBase = AnimationTransitionBase;
ASPx.AnimationConstants = AnimationConstants;
ASPx.AsyncTracker = AsyncTracker;
ASPx.Security = Security;
})(ASPx, dx);

(function module(ASPx, options) {
ASPx.modules.Classes = module;
ASPx.classesScriptParsed = false;
ASPx.documentLoaded = false; 
ASPx.CallbackType = {
 Data: "d",
 Common: "c"
};
ASPx.callbackState = {
 aborted: "aborted",
 inTurn: "inTurn",
 sent: "sent"
};
var ASPxClientEvent = ASPx.CreateClass(null, {
 constructor: function() {
  this.handlerInfoList = [];
  this.firingIndex = -1;
 },
 AddHandler: function(handler, executionContext) {
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  this.RemoveHandler(handler, executionContext);
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  this.handlerInfoList.push(handlerInfo);
 },
 RemoveHandler: function(handler, executionContext) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.handler == handler && 
    (!executionContext || handlerInfo.executionContext == executionContext);
  });
 },
 removeHandlerByCondition: function(predicate) {
   for(var i = this.handlerInfoList.length - 1; i >= 0; i--) {
   var handlerInfo = this.handlerInfoList[i];
   if(predicate(handlerInfo)) {
    ASPx.Data.ArrayRemoveAt(this.handlerInfoList, i);
    if(i <= this.firingIndex)
     this.firingIndex--;
   }
  }
 },
 removeHandlerByControlName: function(controlName) {
  this.removeHandlerByCondition(function(handlerInfo) {
   return handlerInfo.executionContext &&  
    handlerInfo.executionContext.name === controlName;
  });
 },
 ClearHandlers: function() {
  this.handlerInfoList.length = 0;
 },
 FireEvent: function(obj, args) {
  for(this.firingIndex = 0; this.firingIndex < this.handlerInfoList.length; this.firingIndex++) {
   var handlerInfo = this.handlerInfoList[this.firingIndex];
   handlerInfo.handler.call(handlerInfo.executionContext, obj, args);
  }
 },
 InsertFirstHandler: function(handler, executionContext){
  if(typeof(executionContext) == "undefined")
   executionContext = null;
  var handlerInfo = ASPxClientEvent.CreateHandlerInfo(handler, executionContext);
  ASPx.Data.ArrayInsert(this.handlerInfoList, handlerInfo, 0);
 },
 IsEmpty: function() {
  return this.handlerInfoList.length == 0;
 }
});
ASPxClientEvent.CreateHandlerInfo = function(handler, executionContext) {
 return {
  handler: handler,
  executionContext: executionContext
 };
};
var ASPxClientEventArgs = ASPx.CreateClass(null, {
 constructor: function() {
 }
});
ASPxClientEventArgs.Empty = new ASPxClientEventArgs();
var ASPxClientCancelEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.cancel = false;
 }
});
var ASPxClientProcessingModeEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this);
  this.processOnServer = !!processOnServer;
 }
});
var ASPxClientProcessingModeCancelEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer){
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.cancel = false;
 }
});
var OrderedMap = ASPx.CreateClass(null, {
 constructor: function(){
  this.entries = {};
  this.firstEntry = null;
  this.lastEntry = null;
 },
 add: function(key, element) {
  var entry = this.addEntry(key, element);
  this.entries[key] = entry;
 },
 remove: function(key) {
  var entry = this.entries[key];
  if(entry === undefined)
   return;
  this.removeEntry(entry);
  delete this.entries[key];
 },
 clear: function() {
  this.markAllEntriesAsRemoved();
  this.entries = {};
  this.firstEntry = null;
  this.lastEntry = null;
 },
 get: function(key) {
  var entry = this.entries[key];
  return entry ? entry.value : undefined;
 },
 forEachEntry: function(processFunc, context) {
  context = context || this;
  for(var entry = this.firstEntry; entry; entry = entry.next) {
   if(entry.removed)
    continue;
   if(processFunc.call(context, entry.key, entry.value))
    return;
  }
 },
 addEntry: function(key, element) {
  var entry = { key: key, value: element, next: null, prev: null };
  if(!this.firstEntry)
   this.firstEntry = entry;
  else {
   entry.prev = this.lastEntry;
   this.lastEntry.next = entry;
  }
  this.lastEntry = entry;
  return entry;
 },
 removeEntry: function(entry) {
  if(this.firstEntry == entry)
   this.firstEntry = entry.next;
  if(this.lastEntry == entry)
   this.lastEntry = entry.prev;
  if(entry.prev)
   entry.prev.next = entry.next;
  if(entry.next)
   entry.next.prev = entry.prev;
  entry.removed = true;
 },
 markAllEntriesAsRemoved: function() {
  for(var entry = this.firstEntry; entry; entry = entry.next)
   entry.removed = true;
 }
});
var CollectionBase = ASPx.CreateClass(null, {
 constructor: function(){
  this.elementsMap = new OrderedMap();
  this.isASPxClientCollection = true;
 },
 Add: function(key, element) {
  this.elementsMap.add(key, element);
 },
 Remove: function(key) {
  this.elementsMap.remove(key);
 },
 Clear: function(){
  this.elementsMap.clear();
 },
 Get: function(key){
  return this.elementsMap.get(key);
 }
});
(function garbageCollector(ASPx, options) {
 ASPx.modules.garbageCollector = garbageCollector;
 var interval = options.GCCheckInterval;
 window.setInterval(collectObjects, interval);
 function canCollectObjects() {
  if (!ASPx.GetControlCollection) return false;
  var collection = ASPx.GetControlCollection();
  return collection && !collection.InCallback();
 }
 function collectObjects() {
  if (!canCollectObjects()) return;
  ASPx.GetControlCollectionCollection().RemoveDisposedControls();
  if(typeof(ASPx.GetStateController) != "undefined")
   ASPx.GetStateController().RemoveDisposedItems();
  if(ASPx.TableScrollHelperCollection)
   ASPx.TableScrollHelperCollection.RemoveDisposedObjects();
  if(ASPx.Ident.scripts.ASPxClientRatingControl)
   ASPxClientRatingControl.RemoveDisposedElementUnderCursor();
  var postHandler = ASPx.GetPostHandler();
  if(postHandler)
   postHandler.RemoveDisposedFormsFromCache();
 }
})(ASPx, options);
var ControlTree = ASPx.CreateClass(null, {
 constructor: function(controlCollection, container, controlFilter) {
  this.container = container;
  this.domMap = { };
  this.rootNode = this.createNode(null, null);
  this.createControlTree(controlCollection, container, controlFilter);
 },
 createControlTree: function(controlCollection, container, controlFilter) {
  controlCollection.ProcessControlsInContainer(container, function(control) {
   control.RegisterInControlTree(this);
  }.aspxBind(this), controlFilter);
  var fixedNodes = [];
  var fixedNodesChildren = [];
  for(var domElementID in this.domMap) {
   if(!this.domMap.hasOwnProperty(domElementID)) continue;
   var node = this.domMap[domElementID];
   var controlOwner = node.control ? node.control.controlOwner : null;
   if(controlOwner && this.domMap[controlOwner.name])
    continue;
   if(this.isFixedNode(node))
    fixedNodes.push(node);
   else {
    var parentNode = this.findParentNode(domElementID);
    parentNode = parentNode || this.rootNode;
    if(this.isFixedNode(parentNode))
     fixedNodesChildren.push(node);
    else {
     var childNode = node.mainNode || node;
     this.addChildNode(parentNode, childNode);
    }
   }
  }
  for(var i = fixedNodes.length - 1; i >= 0; i--)
   this.insertChildNode(this.rootNode, fixedNodes[i], 0);
  for(var i = fixedNodesChildren.length - 1; i >= 0; i--)
   this.insertChildNode(this.rootNode, fixedNodesChildren[i], 0);
 },
 findParentNode: function(id) {
  var element = document.getElementById(id).parentNode;
  while(element && element.tagName !== "BODY") {
   if(element.id) {
    var parentNode = this.domMap[element.id];
    if(parentNode)
     return parentNode;
   }
   element = element.parentNode;
  }
  return null;
 },
 addChildNode: function(node, childNode) {
  if(!childNode.parentNode) {
   node.children.push(childNode);
   childNode.parentNode = node;
  }
 },
 insertChildNode: function(node, childNode, index) {
  if(!childNode.parentNode) {
   ASPx.Data.ArrayInsert(node.children, childNode, index);
   childNode.parentNode = node;
  }
 },
 addRelatedNode: function(node, relatedNode) {
  this.addChildNode(node, relatedNode);
  relatedNode.mainNode = node;
 },
 isFixedNode: function(node) {
  var control = node.mainNode ? node.mainNode.control : node.control;
  return control && control.HasFixedPosition();
 },
 createNode: function(domElementID, control) {
  var node = {
   control: control,
   children: [],
   parentNode: null,
   mainNode: null
  };
  if(domElementID)
   this.domMap[domElementID] = node;
  return node;
 }
});
var ControlAdjuster = ASPx.CreateClass(null, {
 constructor: function() {
 },
 adjustControlsInHierarchy: function(controlCollection, adjustFunc, container, collapseControls, controlFilter) {
  var controlTree = new ASPx.ControlTree(controlCollection, container, controlFilter);
  this.adjustControlsInTree(controlTree.rootNode, adjustFunc, container, collapseControls);
 },
 adjustControlsInTree: function(treeNode, adjustFunc, container, collapseControls) {
  var observer = _aspxGetDomObserver();
  observer.pause(container, true);
  var documentScrollInfo;
  if(collapseControls) {
   documentScrollInfo = ASPx.GetOuterScrollPosition(document.body);
   this.collapseControls(treeNode);
  }
  var adjustNodes = [], 
   autoHeightNodes = [];
  var requireReAdjust = this.forEachControlCore(treeNode, collapseControls, adjustFunc, adjustNodes, autoHeightNodes);
  if(requireReAdjust)
   this.forEachControlsBackward(adjustNodes, collapseControls, adjustFunc);
  else {
   for(var i = 0, node; node = autoHeightNodes[i]; i++)
    node.control.AdjustAutoHeight();
  }
  if(collapseControls)
   ASPx.RestoreOuterScrollPosition(documentScrollInfo);
  observer.resume(container, true);
 },
 forEachControlCore: function(node, collapseControls, processFunc, adjustNodes, autoHeightNodes) {
  var requireReAdjust = false,
   size, newSize;
  if(node.control) {
   var checkReadjustment = collapseControls && node.control.IsControlCollapsed() && node.control.CanCauseReadjustment();
   if(checkReadjustment)
    size = node.control.GetControlPercentMarkerSize(false, true);
   if(node.control.IsControlCollapsed() && !node.control.IsExpandableByAdjustment())
    node.control.ExpandControl();
   node.control.isInsideHierarchyAdjustment = true;
   processFunc(node.control);
   node.control.isInsideHierarchyAdjustment = false;
   if(checkReadjustment) {
    newSize = node.control.GetControlPercentMarkerSize(false, true);
    requireReAdjust = size.width !== newSize.width;
   }
   if(node.control.sizingConfig.supportAutoHeight)
    autoHeightNodes.push(node);
   node.control.ResetControlPercentMarkerSize();
  }
  for(var childNode, i = 0; childNode = node.children[i]; i++)
   requireReAdjust = this.forEachControlCore(childNode, collapseControls, processFunc, adjustNodes, autoHeightNodes) || requireReAdjust;
  adjustNodes.push(node);
  return requireReAdjust;
 },
 forEachControlsBackward: function(adjustNodes, collapseControls, processFunc) {
  for(var i = 0, node; node = adjustNodes[i]; i++)
   this.forEachControlsBackwardCore(node, collapseControls, processFunc);
 },
 forEachControlsBackwardCore: function(node, collapseControls, processFunc) {
  if(node.control)
   processFunc(node.control);
  if(node.children.length > 1) {
   for(var i = 0, childNode; childNode = node.children[i]; i++) {
    if(childNode.control)
     processFunc(childNode.control);
   }
  }
 },
 collapseControls: function(node) {
  for(var childNode, i = 0; childNode = node.children[i]; i++)
   this.collapseControls(childNode);
  if(node.control && node.control.NeedCollapseControl())
   node.control.CollapseControl();
 }
});
var controlAdjuster = null;
function GetControlAdjuster() {
 if(!controlAdjuster)
  controlAdjuster = new ControlAdjuster();
 return controlAdjuster;
}
function _aspxFunctionIsInCallstack(currentCallee, targetFunction, depthLimit) {
 var candidate = currentCallee;
 var depth = 0;
 while(candidate && depth <= depthLimit) {
  candidate = candidate.caller;
  if(candidate == targetFunction)
   return true;
  depth++;
 }
 return false;
}
ASPx.attachToReady(aspxClassesWindowOnLoad);
function aspxClassesWindowOnLoad(){
 ASPx.documentLoaded = true;
 _aspxMoveLinkElements();
 _aspxSweepDuplicatedLinks();
 ResourceManager.SynchronizeResources();
 var externalScriptProcessor = GetExternalScriptProcessor();
 if(externalScriptProcessor)
  externalScriptProcessor.ShowErrorMessages();
 ASPx.AccessibilityUtils.initialize();
 ASPx.GetControlCollection().Initialize();
 _aspxInitializeScripts();
 _aspxInitializeLinks();
 _aspxInitializeFocus();
 ASPx.GetControlCollection().FinalizeInitialization();
}
Ident = { };
Ident.IsDate = function(obj) {
 return obj && obj.constructor == Date;
};
Ident.IsRegExp = function(obj) {
 return obj && obj.constructor === RegExp;
};
Ident.IsArray = function(obj) {
 return obj && obj.constructor == Array;
};
Ident.IsASPxClientCollection = function(obj) {
 return obj && obj.isASPxClientCollection;
};
Ident.IsASPxClientControl = function(obj) {
 return obj && obj instanceof ASPxClientControlBase;
};
Ident.IsASPxClientEdit = function(obj) {
 return obj && obj.isASPxClientEdit;
};
Ident.IsFocusableElementRegardlessTabIndex = function (element) {
 var tagName = element.tagName;
 return tagName == "TEXTAREA" || tagName == "INPUT" || tagName == "A" ||
  tagName == "SELECT" || tagName == "IFRAME" || tagName == "OBJECT" || tagName == "BUTTON";
};
Ident.isDialogInvisibleControl = function(control) {
 return !!ASPx.Dialog && ASPx.Dialog.isDialogInvisibleControl(control);
};
Ident.isBatchEditUnusedEditor = function(control) {
 return !!ASPx.BatchEditHelper && ASPx.BatchEditHelper.isBatchEditUnusedEditor(control);
};
Ident.scripts = {};
if(ASPx.IsFunction(window.WebForm_InitCallbackAddField)) {
 (function() {
  var original = window.WebForm_InitCallbackAddField;
  window.WebForm_InitCallbackAddField = function(name, value) {
   if(typeof(name) == "string" && name)
    original.apply(null, arguments);
  };
 })();
}
ASPx.FireDefaultButton = function(evt, buttonID) {
 if(_aspxIsDefaultButtonEvent(evt, buttonID)) {
  var defaultButton = ASPx.GetElementById(buttonID);
  if(defaultButton && defaultButton.click) {
   if(ASPx.IsFocusable(defaultButton))
    defaultButton.focus();
   ASPx.Evt.DoElementClick(defaultButton);
   ASPx.Evt.PreventEventAndBubble(evt);
   return false;
  }
 }
 return true;
};
function _aspxIsDefaultButtonEvent(evt, defaultButtonID) {
 if(evt.keyCode != ASPx.Key.Enter)
  return false;
 var srcElement = ASPx.Evt.GetEventSource(evt);
 if(!srcElement || srcElement.id === defaultButtonID)
  return true;
 var tagName = srcElement.tagName;
 var type = srcElement.type;
 return tagName != "TEXTAREA" && tagName != "BUTTON" && tagName != "A" &&
  (tagName != "INPUT" || type != "checkbox" && type != "radio" && type != "button" && type != "submit" && type != "reset");
}
var PostHandler = ASPx.CreateClass(null, {
 constructor: function() {
  this.Post = new ASPxClientEvent();
  this.PostFinalization = new ASPxClientEvent();
  this.observableForms = [];
  this.dxCallbackTriggers = {};
  this.lastSubmitElementName = null;
  this.beforeOnSubmit = function() { };
  this.ReplaceGlobalPostFunctions();
  this.HandleDxCallbackBeginning();
  this.HandleMSAjaxRequestBeginning();
 },
 Update: function() {
  this.ReplaceFormsSubmit(true);
 },
 ProcessPostRequest: function(ownerID, isCallback, isMSAjaxRequest, isDXCallback) {
  this.cancelPostProcessing = false;
  this.isMSAjaxRequest = isMSAjaxRequest;
  if(this.SkipRaiseOnPost(ownerID, isCallback, isDXCallback))
   return;
  var args = new PostHandlerOnPostEventArgs(ownerID, isCallback, isMSAjaxRequest, isDXCallback);
  this.Post.FireEvent(this, args);
  this.cancelPostProcessing = args.cancel;
  if(!args.cancel)
   this.PostFinalization.FireEvent(this, args);
 },
 SkipRaiseOnPost: function(ownerID, isCallback, isDXCallback) { 
  if(!isCallback)
   return false;
  var dxOwner = isDXCallback && ASPx.GetControlCollection().GetByName(ownerID);
  if(dxOwner) {
   this.dxCallbackTriggers[dxOwner.uniqueID] = true;
   return false;
  }
  if(this.dxCallbackTriggers[ownerID]) {
   this.dxCallbackTriggers[ownerID] = false;
   return true;
  }
  return false;
 },
 ReplaceGlobalPostFunctions: function() {
  if(ASPx.IsFunction(window.__doPostBack))
   this.ReplaceDoPostBack();
  if(ASPx.IsFunction(window.WebForm_DoCallback))
   this.ReplaceDoCallback();
  if(ASPx.IsFunction(window.WebForm_ExecuteCallback))
   this.ReplaceExecuteCallback();
  this.ReplaceFormsSubmit();
 },
 HandleDxCallbackBeginning: function() {
  ASPx.GetControlCollection().BeforeInitCallback.AddHandler(function(s, e) {
   aspxRaisePostHandlerOnPost(e.callbackOwnerID, true, false, true); 
  });
 },
 HandleMSAjaxRequestBeginning: function() {
  var pageRequestManager = ASPx.GetMSAjaxRequestManager();
  if(pageRequestManager != null && Ident.IsArray(pageRequestManager._onSubmitStatements)) {
   pageRequestManager._onSubmitStatements.unshift(function() {
    var postbackSettings = Sys.WebForms.PageRequestManager.getInstance()._postBackSettings;
    var postHandler = aspxGetPostHandler();
    aspxRaisePostHandlerOnPost(postbackSettings.asyncTarget, true, true);
    return !postHandler.cancelPostProcessing;
   });
  }
 },
 ReplaceDoPostBack: function() {
  var original = __doPostBack;
  __doPostBack = function(eventTarget, eventArgument) {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost(eventTarget);
   if(postHandler.cancelPostProcessing)
    return;
   ASPxClientControl.postHandlingLocked = true;
   original(eventTarget, eventArgument);
   delete ASPxClientControl.postHandlingLocked;
  };
 },
 ReplaceDoCallback: function() {
  var original = WebForm_DoCallback;
  WebForm_DoCallback = function(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync) {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost(eventTarget, true);
   if(postHandler.cancelPostProcessing)
    return;
   return original(eventTarget, eventArgument, eventCallback, context, errorCallback, useAsync);
  };
 },
 ReplaceExecuteCallback: function() {
  var original = WebForm_ExecuteCallback;
  var handler = this;
  WebForm_ExecuteCallback = function(callbackObject) {
   var isDxCallback = callbackObject && callbackObject.context && ASPx.GetControlCollection().Get(callbackObject.context) !== null;
   ASPx.callbackProcessed = false;
   original(callbackObject);
   if(isDxCallback && !ASPx.callbackProcessed) {
    var request = callbackObject.xmlRequest;
    if(handler.HasAppErrorOnCallback(request) && ASPxClientUtils.IsExists(callbackObject.eventCallback))
     callbackObject.eventCallback(handler.GetServerErrorText(), callbackObject.context);
   }
  };
 },
 HasAppErrorOnCallback: function(request) {
  if(!request) return false;
  var isServerError = request.status && request.status == 500;
  var pattern = /<html[^>]*>([\w|\W]*)<\/html>/im;
  var text = request.responseText;
  return isServerError && !!text && pattern.test(text);
 },
 GetServerErrorText: function() {
  return "Internal Server Error";
 }, 
 ReplaceFormsSubmit: function(checkObservableCollection) {
  for(var i = 0; i < document.forms.length; i++) { 
   var form = document.forms[i];
   if(checkObservableCollection && ASPx.Data.ArrayIndexOf(this.observableForms, form) >= 0)
    continue;
   if(form.submit)
    this.ReplaceFormSubmit(form);
   this.ReplaceFormOnSumbit(form);
   this.observableForms.push(form);
  }
 },
 ReplaceFormSubmit: function(form) {
  var originalSubmit = form.submit;
  form.submit = function() {
   var postHandler = aspxGetPostHandler();
   aspxRaisePostHandlerOnPost();
   if(postHandler.cancelPostProcessing)
    return false;
   var callee = arguments.callee;
   this.submit = originalSubmit;
   var submitResult = this.submit();
   this.submit = callee;
   return submitResult;
  };
  form = null;
 },
 ReplaceFormOnSumbit: function(form) {
  var originalSubmit = form.onsubmit;
  form.onsubmit = function() {
   var postHandler = aspxGetPostHandler();
   postHandler.beforeOnSubmit();
   if(postHandler.isMSAjaxRequest)
    postHandler.isMsAjaxRequest = false;
   else
    aspxRaisePostHandlerOnPost(postHandler.GetLastSubmitElementName());
   if(postHandler.cancelPostProcessing)
    return false;
   return ASPx.IsFunction(originalSubmit)
    ? originalSubmit.apply(this, arguments)
    : true;
  };
  form = null;
 },
 SetBeforeOnSubmit: function(action) {
  this.beforeOnSubmit = action;
 },
 SetLastSubmitElementName: function(elementName) {
  this.lastSubmitElementName = elementName;
 },
 GetLastSubmitElementName: function() {
  return this.lastSubmitElementName;
 },
 RemoveDisposedFormsFromCache: function(){
  for(var i = 0; this.observableForms && i < this.observableForms.length; i++){
   var form = this.observableForms[i];
   if(!ASPx.IsExistsElement(form)){
    ASPx.Data.ArrayRemove(this.observableForms, form);
    i--;
   }
  }
 }
});
function aspxRaisePostHandlerOnPost(ownerID, isCallback, isMSAjaxRequest, isDXCallback) {
 if(ASPxClientControl.postHandlingLocked) return;
 var postHandler = aspxGetPostHandler();
 if(postHandler)
  postHandler.ProcessPostRequest(ownerID, isCallback, isMSAjaxRequest, isDXCallback);
}
var aspxPostHandler;
function aspxGetPostHandler() {
 if(!aspxPostHandler)
  aspxPostHandler = new PostHandler();
 return aspxPostHandler;
}
var PostHandlerOnPostEventArgs = ASPx.CreateClass(ASPxClientCancelEventArgs, {
 constructor: function(ownerID, isCallback, isMSAjaxCallback, isDXCallback){
  this.constructor.prototype.constructor.call(this);
  this.ownerID = ownerID;
  this.isCallback = !!isCallback;
  this.isDXCallback = !!isDXCallback;
  this.isMSAjaxCallback = !!isMSAjaxCallback;
 }
});
var ResourceManager = {
 HandlerStr: "DXR.axd?r=",
 ResourceHashes: {},
 SynchronizeResources: function(method){
  if(!method){
   method = function(name, resource) { 
    this.UpdateInputElements(name, resource); 
   }.aspxBind(this);
  }
  var resources = this.GetResourcesData();
  for(var name in resources)
   if(resources.hasOwnProperty(name))
    method(name, resources[name]);
 },
 GetResourcesData: function(){
  return {
   DXScript: this.GetResourcesElementsString(_aspxGetIncludeScripts(), "src", "DXScript"),
   DXCss: this.GetResourcesElementsString(_aspxGetLinks(), "href", "DXCss")
  };
 },
 ParseBundleSrc: function(elements, urlAttr){
  var timeStamp = "";
  var resourceUrlArray = [];
  for(var i = 0; i < elements.length; i++) {
   var resourceUrl = ASPx.Attr.GetAttribute(elements[i], urlAttr);
   if(resourceUrl) {
    var pos = resourceUrl.indexOf(this.HandlerStr);
    if(pos > -1){
     var list = resourceUrl.substr(pos + this.HandlerStr.length);
     var ampPos = list.lastIndexOf("-");
     if(ampPos > -1) {
      timeStamp = list.substr(ampPos);
      list = list.substr(0, ampPos);
     }
     var indexes = list.split(",");
     for(var j = 0; j < indexes.length; j++) {
      resourceUrlArray.push(indexes[j]);
     }
    }
    else
     resourceUrlArray.push(resourceUrl);
   }
  }
  return {
   'resourceUrlArray': resourceUrlArray,
   'timeStamp': timeStamp
  };
 },
 GetResourceHashes: function (id) {
  if (!this.ResourceHashes[id])
   this.ResourceHashes[id] = {};
  return this.ResourceHashes[id];
 },
 GetResourcesElementsString: function (elements, urlAttr, id) {
  var hash = this.GetResourceHashes(id);
  var resourceUrlArray = this.ParseBundleSrc(elements, urlAttr).resourceUrlArray;
  for(var i = 0; i < resourceUrlArray.length; i++) {
   hash[resourceUrlArray[i]] = resourceUrlArray[i];
  }
  var array = [];
  for(var key in hash)
   if(hash.hasOwnProperty(key))
    array.push(key);
  return array.join(",");
 },
 GetNewResourcesElementString: function (element, urlAttr, id) {
  var originalUrl = ASPx.Attr.GetAttribute(element, urlAttr);
  var handlerStrIndex = originalUrl.indexOf(this.HandlerStr);
  var dxResources = handlerStrIndex > -1;
  if(!dxResources) return element[urlAttr];
  var hash = this.GetResourceHashes(id);
  var srcInfo = this.ParseBundleSrc([element], urlAttr);
  var resourceUrlArray = srcInfo.resourceUrlArray;
  var timeStamp = srcInfo.timeStamp;
  var newResourceArray = [];
  for(var i = 0; i < resourceUrlArray.length; i++) {
    if(!hash[resourceUrlArray[i]])
    newResourceArray.push(resourceUrlArray[i]);
  }
  var newResources = "";
  if(newResourceArray.length > 0) {
   var baseUrl = originalUrl.substr(0, handlerStrIndex);
   newResources = baseUrl + this.HandlerStr + newResourceArray.join(",") + timeStamp;
  }
  return newResources;
 },
 UpdateInputElements: function(typeName, list){
  for(var i = 0; i < document.forms.length; i++){
   var inputElement = document.forms[i][typeName];
   if(!inputElement)
    inputElement = this.CreateInputElement(document.forms[i], typeName);
   inputElement.value = list;
  }
 },
 CreateInputElement: function(form, typeName){
  var inputElement = ASPx.CreateHiddenField(typeName);
  form.appendChild(inputElement);
  return inputElement;
 }
};
ASPx.includeScriptPrefix = "dxis_";
ASPx.startupScriptPrefix = "dxss_";
var includeScriptsCache = {};
var createdIncludeScripts = [];
var appendedScriptsCount = 0;
var callbackOwnerNames = [];
var scriptsRestartHandlers = { };
function _aspxIsKnownIncludeScript(script) {
 return !!includeScriptsCache[script.src];
}
function _aspxCacheIncludeScript(script) {
 includeScriptsCache[script.src] = 1;
}
function _aspxProcessScriptsAndLinks(ownerName, isCallback) {
 if(!ASPx.documentLoaded) return; 
 _aspxProcessScripts(ownerName, isCallback);
 getLinkProcessor().process();
 ASPx.ClearCachedCssRules();
}
function _aspxGetStartupScripts(container) {
 return _aspxGetScriptsCore(ASPx.startupScriptPrefix, container);
}
function _aspxGetIncludeScripts() {
 return _aspxGetScriptsCore(ASPx.includeScriptPrefix);
}
function _aspxGetScriptsCore(prefix, container) {
 var result = [];
 var scripts;
 if(ASPx.IsExists(container))
  scripts = ASPx.GetNodesByTagName(container, "SCRIPT");
 else
  scripts = document.getElementsByTagName("SCRIPT");
 for(var i = 0; i < scripts.length; i++) {
  if(scripts[i].id.indexOf(prefix) == 0)
   result.push(scripts[i]);
 }
 return result;
}
function _aspxGetLinks() {
 var result = [];
 var links = document.getElementsByTagName("LINK");
 for(var i = 0; i < links.length; i++) 
  result[i] = links[i];
 return result;
}
function _aspxIsLinksLoaded() {
 var links = _aspxGetLinks();
 for(var i = 0, link; link = links[i]; i++)
  if(link.readyState && link.readyState.toLowerCase() == "loading")
    return false;
 return true;
}
function _aspxInitializeLinks() {
 var links = _aspxGetLinks();
 for(var i = 0; i < links.length; i++)
  links[i].loaded = true; 
}
var scriptExecutedAttrName = "data-executed";
var scriptDelayedExecutionAttrName = "data-dx-delayedeval";
ASPx.MarkInnerScriptBlocksAsDelayedExecution = function(scriptsContainer) {
 var scripts = scriptsContainer.querySelectorAll("script[id^=" + ASPx.startupScriptPrefix + "]");
 for(var i = 0; i < scripts.length; i++)
  ASPx.Attr.SetAttribute(scripts[i], scriptDelayedExecutionAttrName, true);
};
function isScriptExecuted(script) {
 return ASPx.Attr.GetAttribute(script, scriptExecutedAttrName);
}
function markScriptAsExecuted(script) {
 if(ASPx.Attr.GetAttribute(script, scriptDelayedExecutionAttrName))
  ASPx.Attr.RemoveAttribute(script, scriptDelayedExecutionAttrName);
 else
  ASPx.Attr.SetAttribute(script, scriptExecutedAttrName, true);
}
function _aspxInitializeScripts() {
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++)
  _aspxCacheIncludeScript(scripts[i]);   
 var startupScripts = _aspxGetStartupScripts();
 for(var i = 0; i < startupScripts.length; i++)
  markScriptAsExecuted(startupScripts[i]);
}
function _aspxSweepDuplicatedLinks() {
 var hash = { };
 var links = _aspxGetLinks();
 for(var i = 0; i < links.length; i++) {
  var href = links[i].href;
  if(!href)
   continue;
  if(hash[href]){
   if((ASPx.Browser.IE || !hash[href].loaded) && links[i].loaded) {
    ASPx.RemoveElement(hash[href]);
    hash[href] = links[i];
   }
   else
    ASPx.RemoveElement(links[i]);
  }
  else
   hash[href] = links[i];
 }
}
function _aspxSweepDuplicatedScripts() {
 var hash = { };
 var scripts = _aspxGetIncludeScripts();
 for(var i = 0; i < scripts.length; i++) {
  var src = scripts[i].src;
  if(!src) continue;
  if(hash[src])
   ASPx.RemoveElement(scripts[i]);
  else
   hash[src] = scripts[i];
 }
}
function _aspxAreScriptsEqual(script1, script2) {
 return script1.src == script2.src;
}
function _aspxProcessScripts(ownerName, isCallback) {
 var scripts = _aspxGetIncludeScripts();
 var previousCreatedScript = null;
 var firstCreatedScript = null;
 for(var i = 0; i < scripts.length; i++) {
  var script = scripts[i];
  if(script.src == "") continue; 
  if(_aspxIsKnownIncludeScript(script))
   continue;
  var getOnlyNewResources = true;
  var onlyNewScripts = ResourceManager.GetNewResourcesElementString(script, "src", "DXScript", getOnlyNewResources);
  if (onlyNewScripts == "")
   continue;
  var createdScript = document.createElement("script");
  createdScript.type = "text/javascript";
  createdScript.src = onlyNewScripts;
  createdScript.id = script.id;
  if(ASPx.Data.ArrayIndexOf(createdIncludeScripts, createdScript, _aspxAreScriptsEqual) >= 0)
   continue;
  createdIncludeScripts.push(createdScript);
  ASPx.RemoveElement(script);
  if(ASPx.Browser.IE && ASPx.Browser.Version < 9) {
   createdScript.onreadystatechange = new Function("ASPx.OnScriptReadyStateChangedCallback(this, " + isCallback + ");");
  } else if(ASPx.Browser.Edge || ASPx.Browser.WebKitFamily || (ASPx.Browser.Firefox && ASPx.Browser.Version >= 4) || ASPx.Browser.IE && ASPx.Browser.Version >= 9) {
   createdScript.onload = new Function("ASPx.OnScriptLoadCallback(this, " + isCallback + ");");
   if(firstCreatedScript == null)
    firstCreatedScript = createdScript;
   createdScript.nextCreatedScript = null;
   if(previousCreatedScript != null)
    previousCreatedScript.nextCreatedScript = createdScript;
   previousCreatedScript = createdScript;
  } else {
   createdScript.onload = new Function("ASPx.OnScriptLoadCallback(this);");
   ASPx.AppendScript(createdScript);
   _aspxCacheIncludeScript(createdScript);
  }
 }
 if(firstCreatedScript != null) {
  ASPx.AppendScript(firstCreatedScript);
  _aspxCacheIncludeScript(firstCreatedScript);
 }
 if(isCallback)
  callbackOwnerNames.push(ownerName);
 if(createdIncludeScripts.length == 0) {
  var newLinks = ASPx.GetNodesByTagName(document.body, "link");
  var needProcessLinks = isCallback && newLinks.length > 0;
  if(needProcessLinks)
   needProcessLinks = getLinkProcessor().addLinks(newLinks);
  if(!needProcessLinks)
   ASPx.FinalizeScriptProcessing(isCallback);
 }
}
ASPx.FinalizeScriptProcessing = function(isCallback) {
 createdIncludeScripts = [];
 appendedScriptsCount = 0;
 var linkProcessor = getLinkProcessor();
 if(linkProcessor.hasLinks())
  _aspxSweepDuplicatedLinks();
 linkProcessor.reset();
 _aspxSweepDuplicatedScripts();
 ResourceManager.SynchronizeResources();
 _aspxRunStartupScripts(isCallback);
};
var startupScriptsRunning = false;
function _aspxRunStartupScripts(isCallback, container) {
 startupScriptsRunning = true;
 try {
  _aspxRunStartupScriptsCore(container);
 }
 finally {
  startupScriptsRunning = false;
 }
 if(ASPx.documentLoaded) {
  ASPx.GetControlCollection().ProcessActionByPredicate(
   function(collection) { collection.InitializeElements(isCallback); },
   function(control) { return !ASPx.IsExists(container) || ASPx.GetIsParent(container, control.GetMainElement()); }
  );
  for(var key in scriptsRestartHandlers)
   if(scriptsRestartHandlers.hasOwnProperty(key))
    scriptsRestartHandlers[key]();
  _aspxRunEndCallbackScript();
 }
}
function _aspxIsStartupScriptsRunning(isCallback) {
 return startupScriptsRunning;
}
function _aspxRunStartupScriptsCore(container) {
 var scripts = _aspxGetStartupScripts(container);
 var code;
 for(var i = 0; i < scripts.length; i++){
  var script = scripts[i];
  if(!isScriptExecuted(script)) {
   _aspxEnsureStartupScriptIsUnique(script.id); 
   code = ASPx.GetScriptCode(script);
   eval(code);
   markScriptAsExecuted(script);
  }
 }
}
function _aspxEnsureStartupScriptIsUnique(scriptId) {
 if(!scriptId)
  return;
 var scriptExecutedSelector = "script[" + scriptExecutedAttrName + "='true']#" + scriptId;
 ASPx.RemoveElement(document.querySelector(scriptExecutedSelector));
}
function _aspxRunEndCallbackScript() {
 while(callbackOwnerNames.length > 0) {
  var callbackOwnerName = callbackOwnerNames.pop();
  var callbackOwner = ASPx.GetControlCollection().Get(callbackOwnerName);
  if(callbackOwner)
   callbackOwner.DoEndCallback();
 }
}
ASPx.OnScriptReadyStateChangedCallback = function(scriptElement, isCallback) {
 if(scriptElement.readyState == "loaded") {
  _aspxCacheIncludeScript(scriptElement);
  for(var i = 0; i < createdIncludeScripts.length; i++) {
   var script = createdIncludeScripts[i];
   if(_aspxIsKnownIncludeScript(script)) {
    if(!isScriptExecuted(script)) {
     markScriptAsExecuted(script);
     ASPx.AppendScript(script);
     appendedScriptsCount++;
    }
   } else
    break;
  }
  if(createdIncludeScripts.length == appendedScriptsCount)
   ASPx.FinalizeScriptProcessing(isCallback);
 }
};
ASPx.OnScriptLoadCallback = function(scriptElement, isCallback) {
 appendedScriptsCount++;
 if(scriptElement.nextCreatedScript) {
  ASPx.AppendScript(scriptElement.nextCreatedScript);
  _aspxCacheIncludeScript(scriptElement.nextCreatedScript);
 }
 if(createdIncludeScripts.length == appendedScriptsCount)
  ASPx.FinalizeScriptProcessing(isCallback);
};
function _aspxAddScriptsRestartHandler(objectName, handler) {
 scriptsRestartHandlers[objectName] = handler;
}
function _aspxMoveLinkElements() {
 var head = ASPx.GetNodesByTagName(document, "head")[0];
 var bodyLinks = ASPx.GetNodesByTagName(document.body, "link");
 if(head && bodyLinks.length > 0){
  var headLinks = ASPx.GetNodesByTagName(head, "link");
  var dxLinkAnchor = head.firstChild;
  for(var i = 0; i < headLinks.length; i++){
   if(headLinks[i].href.indexOf(ResourceManager.HandlerStr) > -1)
    dxLinkAnchor = headLinks[i].nextSibling;
  }
  while(bodyLinks.length > 0) 
   head.insertBefore(bodyLinks[0], dxLinkAnchor);
 }
}
var LinkProcessor = ASPx.CreateClass(null, {
 constructor: function() {
  this.loadedLinkCount = 0;
  this.linkInfos = [];
  this.loadingObservationTimerID = -1;
 },
 process: function() {
  if(this.hasLinks()) {
   if(this.isLinkLoadEventSupported())
    this.processViaLoadEvent();
   else
    this.processViaTimer();
  }
  else
   _aspxSweepDuplicatedLinks();
  _aspxMoveLinkElements();
 },
 addLinks: function(links) {
  var prevLinkCount = this.linkInfos.length;
  for(var i = 0; i < links.length; i++) {
   var link = links[i];
   if(link.loaded || link.rel != "stylesheet" || link.type != "text/css" || link.href.toLowerCase().indexOf("dxr.axd?r=") == -1)
    continue;
   var linkInfo = {
    link: link,
    href: link.href
   };
   this.linkInfos.push(linkInfo);
  }
  return prevLinkCount != this.linkInfos.length;
 },
 hasLinks: function() {
  return this.linkInfos.length > 0;
 },
 reset: function() {
  this.linkInfos = [];
  this.loadedLinkCount = 0;
 },
 processViaLoadEvent: function() {
  var that = this;
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(ASPx.Browser.IE && ASPx.Browser.Version < 9)
    linkInfo.link.onreadystatechange = function() { that.onLinkReadyStateChanged(this); };
   else
    linkInfo.link.onload = this.onLinkLoad.aspxBind(this);
  }
 },
 isLinkLoadEventSupported: function() {
  return !(ASPx.Browser.Chrome && ASPx.Browser.MajorVersion < 19 || ASPx.Browser.Firefox && ASPx.Browser.MajorVersion < 9 ||
   ASPx.Browser.Safari && ASPx.Browser.MajorVersion < 6 || ASPx.Browser.AndroidDefaultBrowser && ASPx.Browser.MajorVersion < 4.4);
 },
 processViaTimer: function() {
  if(this.loadingObservationTimerID == -1)
   this.onLinksLoadingObserve();
 },
 onLinksLoadingObserve: function() {
  if(this.getIsAllLinksLoaded()) {
   this.loadingObservationTimerID = -1;
   this.onAllLinksLoad();
  }
  else
   this.loadingObservationTimerID = window.setTimeout(this.onLinksLoadingObserve.aspxBind(this), 100);
 },
 getIsAllLinksLoaded: function() {
  var styleSheets = document.styleSheets;
  var loadedLinkHrefs = { };
  for(var i = 0; i < styleSheets.length; i++) {
   var styleSheet = styleSheets[i];
   try {
    if(styleSheet.cssRules)
     loadedLinkHrefs[styleSheet.href] = 1;
   }
   catch(ex) { }
  }
  var loadedLinksCount = 0;
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(loadedLinkHrefs[linkInfo.href])
    loadedLinksCount++;
  }
  return loadedLinksCount == this.linkInfos.length;
 },
 onAllLinksLoad: function() {
  this.reset();
  _aspxSweepDuplicatedLinks();
  if(createdIncludeScripts.length == 0)
   ASPx.FinalizeScriptProcessing(true);
 },
 onLinkReadyStateChanged: function(linkElement) {
  if(linkElement.readyState == "complete")
   this.onLinkLoadCore(linkElement);
 },
 onLinkLoad: function(evt) {
  var linkElement = ASPx.Evt.GetEventSource(evt);
  this.onLinkLoadCore(linkElement);
 },
 onLinkLoadCore: function(linkElement) {
  if(!this.hasLinkElement(linkElement)) return;
  this.loadedLinkCount++;
  if(!ASPx.Browser.Firefox && this.loadedLinkCount == this.linkInfos.length || 
   ASPx.Browser.Firefox && this.loadedLinkCount == 2 * this.linkInfos.length) {
   this.onAllLinksLoad();
  }
 },
 hasLinkElement: function(linkElement) {
  for(var i = 0, linkInfo; linkInfo = this.linkInfos[i]; i++) {
   if(linkInfo.link == linkElement)
    return true;
  }
  return false;
 }
});
var linkProcessor = null;
function getLinkProcessor() {
 if(linkProcessor == null)
  linkProcessor = new LinkProcessor();
 return linkProcessor;
}
ASPx.LinkProcessor = LinkProcessor;
var IFrameHelper = ASPx.CreateClass(null, {
 constructor: function(params) {
  this.params = params || {};
  this.params.src = this.params.src || "";
  this.CreateElements();
 },
 CreateElements: function() {
  var elements = IFrameHelper.Create(this.params);
  this.containerElement = elements.container;
  this.iframeElement = elements.iframe;
  this.AttachOnLoadHandler(this, this.iframeElement);
  this.SetLoading(true);
  if(this.params.onCreate)
   this.params.onCreate(this.containerElement, this.iframeElement);
 },
 AttachOnLoadHandler: function(instance, element) {
  ASPx.Evt.AttachEventToElement(element, "load", function() {
   instance.OnLoad(element);
  });
 },
 OnLoad: function(element) {
  this.SetLoading(false, element);
  if(!element.preventCustomOnLoad && this.params.onLoad)
   this.params.onLoad();
 },
 IsLoading: function(element) {
  element = element || this.iframeElement;
  if(element)
   return element.loading;
  return false;
 },
 SetLoading: function(value, element) {
  element = element || this.iframeElement;
  if(element)
   element.loading = value;
 },
 GetContentUrl: function() {
  return this.params.src;
 },
 SetContentUrl: function(url, preventBrowserCaching) {
  if(url) {
   this.params.src = url;
   if(preventBrowserCaching)
    url = IFrameHelper.AddRandomParamToUrl(url);
   this.SetLoading(true);
   this.iframeElement.src = url;
  }
 },
 RefreshContentUrl: function() {
  if(this.IsLoading())
   return;
  this.SetLoading(true);
  var oldContainerElement = this.containerElement;
  var oldIframeElement = this.iframeElement;
  var postfix = "_del" + Math.floor(Math.random()*100000).toString();
  if(this.params.id)
   oldIframeElement.id = this.params.id + postfix;
  if(this.params.name)
   oldIframeElement.name = this.params.name + postfix;
  ASPx.SetStyles(oldContainerElement, { height: 0 });
  this.CreateElements();
  oldIframeElement.preventCustomOnLoad = true;
  oldIframeElement.src = ASPx.BlankUrl;
  window.setTimeout(function() {
   oldContainerElement.parentNode.removeChild(oldContainerElement);
  }, 10000); 
 }
});
IFrameHelper.Create = function(params) {
 var iframeHtmlStringParts = [ "<iframe frameborder='0'" ];
 if(params) {
  if(params.id)
   iframeHtmlStringParts.push(" id='", params.id, "'");
  if(params.name)
   iframeHtmlStringParts.push(" name='", params.name, "'");
  if(params.title)
   iframeHtmlStringParts.push(" title='", params.title, "'");
  if(params.scrolling)
   iframeHtmlStringParts.push(" scrolling='", params.scrolling, "'");
  if(params.src)
   iframeHtmlStringParts.push(" src='", params.src, "'");
 }
 iframeHtmlStringParts.push("></iframe>");
 var containerElement = ASPx.CreateHtmlElementFromString("<div style='border-width: 0px; padding: 0px; margin: 0px'></div>");
 var iframeElement = ASPx.CreateHtmlElementFromString(iframeHtmlStringParts.join(""));
 containerElement.appendChild(iframeElement);
 return {
  container: containerElement,
  iframe: iframeElement
 };
};
IFrameHelper.AddRandomParamToUrl = function(url) {
 var prefix = url.indexOf("?") > -1
  ? "&"
  : "?";
 var param = prefix + Math.floor(Math.random()*100000).toString();
 var anchorIndex = url.indexOf("#");
 return anchorIndex == -1
  ? url + param
  : url.substr(0, anchorIndex) + param + url.substr(anchorIndex);
};
IFrameHelper.GetWindow = function(name) {
 if(ASPx.Browser.IE)
  return window.frames[name].window;
 else{
  var frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentWindow : null;
 }
};
IFrameHelper.GetDocument = function(name) {
 var frameElement;
 if(ASPx.Browser.IE) {
  frameElement = window.frames[name];
  return (frameElement != null) ? frameElement.document : null;
 }
 else {
  frameElement = document.getElementById(name);
  return (frameElement != null) ? frameElement.contentDocument : null;
 }
};
IFrameHelper.GetDocumentBody = function(name) {
 var doc = IFrameHelper.GetDocument(name);
 return (doc != null) ? doc.body : null;
};
IFrameHelper.GetDocumentHead = function (name) {
 var doc = IFrameHelper.GetDocument(name);
 return (doc != null) ? doc.head || doc.getElementsByTagName('head')[0] : null;
};
IFrameHelper.GetElement = function(name) {
 if(ASPx.Browser.IE)
  return window.frames[name].window.frameElement;
 else
  return document.getElementById(name);
};
var KbdHelper = ASPx.CreateClass(null, {
 constructor: function(control) {
  this.control = control;
 },
 Init: function() {
  KbdHelper.GlobalInit();
  var elements = this.getFocusableElements();
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   element.tabIndex = Math.max(element.tabIndex, 0);
   ASPx.Evt.AttachEventToElement(element, "click", function(e) { this.HandleClick(e); }.aspxBind(this));
   ASPx.Evt.AttachEventToElement(element, "focus", function(e) {    
    return this.onElementFocus(e);
   }.aspxBind(this));
   ASPx.Evt.AttachEventToElement(element, "blur", function () { this.onBlur(); }.aspxBind(this)); 
  }   
 },
 onElementFocus: function(e) {
  if(!this.CanFocus(e))
   return true;
  KbdHelper.active = this;
 },
 getFocusableElements: function() {
  return [this.GetFocusableElement()]; 
 },
 GetFocusableElement: function() { return this.control.GetMainElement(); },
 canHandleNoFocusAction: function() { 
  var focusableElements = this.getFocusableElements();
  for(var i = 0; i < focusableElements.length; i++) {
   if(focusableElements[i] === _aspxGetFocusedElement())
    return false;
  }
  return true;
 },
 RequirePreventScrollOnFocus: function() { return false; },
 CanFocus: function(e) {
  var tag = ASPx.Evt.GetEventSource(e).tagName;
  return !(tag === "A" || tag === "TEXTAREA" || tag === "INPUT" || tag === "SELECT" || tag === "IFRAME" || tag === "OBJECT");
 },
 HandleClick: function(e) {
  if(!this.CanFocus(e))
   return;
  this.Focus();
 },
 Focus: function() {
  var preventScroll = this.RequirePreventScrollOnFocus() && !ASPx.Browser.IE; 
  var savedDocumentScrollTop = preventScroll ? ASPx.GetDocumentScrollTop() : -1;
  try {
   this.GetFocusableElement().focus({ preventScroll: preventScroll });
  } catch(e) { }
  if(preventScroll && !this.IsNativePreventScrollOnFocusSupported() && savedDocumentScrollTop !== ASPx.GetDocumentScrollTop())
   ASPx.SetDocumentScrollTop(savedDocumentScrollTop);
 },
 IsNativePreventScrollOnFocusSupported: function() {
  if(this.isNativePreventScrollOnFocusSupported === undefined)
   this.isNativePreventScrollOnFocusSupported = this.CalcIsNativePreventScrollOnFocusSupported();
  return this.isNativePreventScrollOnFocusSupported;
 },
 CalcIsNativePreventScrollOnFocusSupported: function() {
  var result = false;
  try {
   ASPx.GetActiveElement().focus(Object.defineProperty({}, "preventScroll", { get: function() { result = true; } }));
  } catch(e) { result = false; }
  return result;
 },
 onBlur: function(){
  delete KbdHelper.active;
 },
 HandleKeyDown: function(e) { }, 
 HandleKeyPress: function(e) { }, 
 HandleKeyUp: function (e) { },
 HandleNoFocusAction: function(e) { },
 FocusByAccessKey: function () { }
});
KbdHelper.GlobalInit = function() {
 if(KbdHelper.ready)
  return;
 ASPx.Evt.AttachEventToDocument("keydown", KbdHelper.OnKeyDown);
 ASPx.Evt.AttachEventToDocument("keypress", KbdHelper.OnKeyPress);
 ASPx.Evt.AttachEventToDocument("keyup", KbdHelper.OnKeyUp);
 KbdHelper.ready = true; 
};
KbdHelper.swallowKey = false;
KbdHelper.accessKeys = { };
KbdHelper.ProcessKey = function(e, actionName) {
 if(!KbdHelper.active) 
  return;
 if (KbdHelper.active.canHandleNoFocusAction()) {
  KbdHelper.active["HandleNoFocusAction"](e, actionName);
  return;
 }
 var ctl = KbdHelper.active.control;
 if(ctl !== ASPx.GetControlCollection().Get(ctl.name)) {
  delete KbdHelper.active;
  return;
 }
 if(!KbdHelper.swallowKey) 
  KbdHelper.swallowKey = KbdHelper.active[actionName](e);
 if(KbdHelper.swallowKey)
  ASPx.Evt.PreventEvent(e);
};
KbdHelper.OnKeyDown = function(e) {
 KbdHelper.swallowKey = false;
 if(KbdHelper.TryAccessKey(KbdHelper.getKeyName(e)))
  ASPx.Evt.PreventEvent(e);
 else 
  KbdHelper.ProcessKey(e, "HandleKeyDown"); 
};
KbdHelper.OnKeyPress = function(e) { KbdHelper.ProcessKey(e, "HandleKeyPress"); };
KbdHelper.OnKeyUp = function(e) { KbdHelper.ProcessKey(e, "HandleKeyUp"); };
KbdHelper.RegisterAccessKey = function(obj) {
 var key;
 if(obj.accessKey)
  key = "CtrlShift" + obj.accessKey;
 else if(obj.keyTipModeShortcut)
  key = obj.keyTipModeShortcut;
 if(!key) return;
 KbdHelper.accessKeys[key.toLowerCase()] = obj.name;
};
KbdHelper.TryAccessKey = function(code) {
 var key = code.toLowerCase ? code.toLowerCase() : String.fromCharCode(code).toLowerCase();
 var name = KbdHelper.accessKeys[key];
 if(!name) return false;
 var obj = ASPx.GetControlCollection().Get(name);
 return KbdHelper.ClickAccessKey(obj);
};
KbdHelper.ClickAccessKey = function (control) {
 if (!control) return false;
 var el = control.GetMainElement();
 if (!el) return false;
 el.focus();
 setTimeout(function () {
  if (KbdHelper.active && KbdHelper.active.FocusByAccessKey)
   KbdHelper.active.FocusByAccessKey();
 }.aspxBind(this), 100);
 return true;
};
KbdHelper.getKeyName = function(e) {
 var name = "";
 if(e.altKey)
  name += "Alt";
 if(e.ctrlKey)
  name += "Ctrl";
 if(e.shiftKey)
  name += "Shift";
 var keyCode = e.key || e.code || String.fromCharCode(ASPx.Evt.GetKeyCode(e));
 if(keyCode.match(/key/i))
  name += keyCode.replace(/key/i, "");
 else if(keyCode.match(/digit/i))
  name += keyCode.replace(/digit/i, "");
 else if(keyCode.match(/arrow/i))
  name += keyCode.replace(/arrow/i, "");
 else if(keyCode.match(/ins/i))
  name += "Ins";
 else if(keyCode.match(/del/i))
  name += "Del";
 else if(keyCode.match(/back/i))
  name += "Back";
 else if(!keyCode.match(/alt/i) && !keyCode.match(/control/i) && !keyCode.match(/shift/i))
  name += keyCode;
 return name.replace(/^a-zA-Z0-9/, "");
};
AccessKeysHelper = ASPx.CreateClass(KbdHelper, {
 constructor: function (control) {
  this.constructor.prototype.constructor.call(this, control);
  this.accessKeysVisible = false;
  this.activeKey = null;
  this.accessKey = control.createAccessKey ? control.createAccessKey(control.accessKey) : new AccessKey(control.accessKey);
  this.accessKeys = this.accessKey.accessKeys;
  this.charIndex = 0;
  this.onFocusByAccessKey = null;
  this.onClose = null;
  this.manualStopProcessing = false;
  this.isActive = false;
  this.areAccessKeysShown = false;
 },
 Init: function (control) {
  KbdHelper.prototype.Init.call(this);
  KbdHelper.RegisterAccessKey(control);   
 },
 Add: function (accessKey) {
  this.accessKey.Add(accessKey);
 },
 HandleKeyDown: function (e) {
  var keyCode = ASPx.Evt.GetKeyCode(e);
  var stopProcessing = this.processKeyDown(keyCode);
  if (stopProcessing.value) {
   this.stopProcessing();
   if(this.onClosedOnEscape && (keyCode == ASPx.Key.Esc || stopProcessing.fireEvent))
    this.onClosedOnEscape();
  }
  return stopProcessing;
 },
 HandleNoFocusAction: function (e, actionName) {
  var keyCode = ASPx.Evt.GetKeyCode(e);
  if (this.onClosedOnEscape && keyCode == ASPx.Key.Esc && actionName == "HandleKeyDown")
   this.onClosedOnEscape();
 },
 Activate: function () {
  KbdHelper.ClickAccessKey(this.control);
  this.areAccessKeysShown = true;
 },
 Stop: function() {
  this.stopProcessing();
 },
 stopProcessing: function () {
  this.HideAccessKeys();
  if (KbdHelper.active && this.isActive) {
   this.isActive = false;
   KbdHelper.active.control.GetMainElement().blur();
   delete KbdHelper.active;
  }
 },
 onBlur: function() {
  if (this.manualStopProcessing) {
   this.manualStopProcessing = false;
   return;
  }
  this.HideAccessKeys();
  KbdHelper.prototype.onBlur.call(this);
 },
 processKeyDown: function (keyCode) {
  switch (keyCode) {
   case ASPx.Key.Left:
    this.TryMoveFocusLeft();
    return { value: false };
   case ASPx.Key.Right:
    this.TryMoveFocusRight();
    return { value: false };
   case ASPx.Key.Esc:
    if(this.control.hideAllPopups)
     this.control.hideAllPopups(true, true);
    if(this.activeKey)
     this.activeKey = this.activeKey.Return();
    this.charIndex = 0;
    if (!this.activeKey)
     return { value: true };
    break;
   case ASPx.Key.Enter:
    return { value: true };
   default:
    if (!ASPx.IsPrintableKey(keyCode))
     return { value: false };
    var char = String.fromCharCode(keyCode).toUpperCase();
    var needToContinue = { value: false };
    var keyResult;
    if(this.activeKey)
     keyResult = this.activeKey.TryAccessKey(char, this.charIndex, needToContinue);
    if (needToContinue.value) {
     this.charIndex++;
     return { value: false };
    }
    this.charIndex = 0;
    if(keyResult !== undefined)
     this.activeKey = keyResult;
    else
     return { value: true, fireEvent: true };
    if (!this.activeKey || !this.activeKey.accessKeys || this.activeKey.accessKeys.length == 0) {
     if (this.activeKey && this.activeKey.manualStopProcessing) {
      this.manualStopProcessing = true;
      break;
     }
     return { value: true, fireEvent: true };
    }
  }
  return { value: false };
 },
 TryMoveFocusLeft: function (modifier) {},
 TryMoveFocusRight: function (modifier) {},
 TryMoveFocusUp: function (modifier) {},
 TryMoveFocusDown: function (modifier) {},
 FocusByAccessKey: function() {
  if (this.onFocusByAccessKey)
   this.onFocusByAccessKey();
  this.HideAccessKeys();
  KbdHelper.prototype.FocusByAccessKey.call(this);
  this.activeKey = this.accessKey;
  this.activeKey.execute();
  this.isActive = true;
  this.areAccessKeysShown = true;
 },
 HideAccessKeys: function() {
  this.areAccessKeysShown = false;
  this.hideAccessKeys(this.accessKey);
 },
 Update: function() {
  this.throttleMethod(this.refresh, 100);
 },
 refresh: function() {
  if(this.activeKey && this.areAccessKeysShown) {
   this.activeKey.execute();
  }
 },
 throttleMethod: function(method, delay) {
  clearTimeout(method.timerId);
  method.timerId = setTimeout(function() {
   method.call(this);
  }.aspxBind(this), delay);
 },
 AreAccessKeysShown: function() {
  return this.areAccessKeysShown;
 },
 hideAccessKeys: function (accessKey) {
  for (var i = 0, ak; ak = accessKey.accessKeys[i]; i++) {
   this.hideAccessKeys(ak);
  }
  if (accessKey)
   accessKey.hide();
 },
 HandleClick: function(e) {
  KbdHelper.prototype.HandleClick.call(this, e);
  this.stopProcessing();
 }
});
AccessKey = ASPx.CreateClass(null, {
 constructor: function (popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing) {
  this.key = key ? key : keyTipElement ? ASPxClientUtils.Trim(ASPx.GetInnerText(keyTipElement)) : null;
  this.popupItem = popupItem;
  this.getPopupElement = getPopupElement;
  this.keyTipElement = keyTipElement;
  this.accessKeys = [];
  this.needShowChilds = true;
  this.parent = null;
  this.onlyClick = onlyClick;
  this.manualStopProcessing = manualStopProcessing;
 },
 Add: function (accessKey) {
  this.accessKeys.push(accessKey);
  accessKey.parent = this;
 },
 TryAccessKey: function (char, index, needToContinue) {
  if (!this.accessKeys || this.accessKeys.length == 0)
   return;
  for (var i = 0, accessKey; accessKey = this.accessKeys[i]; i++) {
   if (accessKey.key[index] == char && accessKey.isVisible()) {
    if (accessKey.key[index + 1]) {
     needToContinue.value = true;
    }
    else {
     accessKey.execute();
     return accessKey;
    }
   } else {
    accessKey.hide();
   }
  }
  for (var i = 0, accessKey; accessKey = this.accessKeys[i]; i++) {
   var key = accessKey.TryAccessKey(char, index, needToContinue);
   if (key)
    return key;
  }
  return;
 },
 isVisible: function(){
  return ASPx.GetElementVisibility(this.keyTipElement);
 },
 Return: function () {
  this.hideChildAccessKeys();
  if (this.parent) {
   this.parent.showAccessKeys(true);
  }  
  return this.parent;
 },
 execute: function () {
  this.hideAll();
  if (this.popupItem && this.popupItem.accessKeyClick && !this.onlyClick)
   this.popupItem.accessKeyClick();
  if (this.getPopupElement && this.onlyClick)
   ASPx.Evt.EmulateMouseClick(this.getPopupElement(this.popupItem));
  if (this.accessKeys)
   setTimeout(function () {
    this.showAccessKeys(true);
   }.aspxBind(this), 100);
 },
 showAccessKeys: function(directShow) {
  if (!directShow && !this.needShowChilds)
   return;
  for (var i = 0; i < this.accessKeys.length; i++) {
   var accessKey = this.accessKeys[i];
   if (accessKey) {
    var popupElement = accessKey.getPopupElement ? accessKey.getPopupElement(accessKey.popupItem) : null;
    if (popupElement && this.isElementVisible(popupElement)) {
     this.show(accessKey);
    }
    accessKey.showAccessKeys();
   }
  }
 },
 isElementVisible: function (el) { return ASPx.IsElementVisible(el, true); },
 show: function(accessKey) {
  var keyTipElement = accessKey.keyTipElement;
  var popupElement = accessKey.getPopupElement(accessKey.popupItem);
  this.showKeyTipElement(keyTipElement, this.calculateCoordinates(accessKey, keyTipElement, popupElement));
 },
 showKeyTipElement: function (keyTipElement, coordinates) {
  ASPx.SetAbsoluteY(keyTipElement, coordinates.top);
  ASPx.SetAbsoluteX(keyTipElement, coordinates.left);
  ASPx.SetElementVisibility(keyTipElement, true); 
 },
 calculateCoordinates: function (accessKey, keyTipElement, popupElement) {
  var top = ASPx.GetAbsolutePositionY(popupElement);
  var left = ASPx.GetAbsolutePositionX(popupElement);
  if (accessKey.popupItem.getAccessKeyPosition)
   switch (accessKey.popupItem.getAccessKeyPosition()) {
    case "AboveRight":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top - keyTipElement.offsetHeight / 2;
     break;
    case "Right":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top + popupElement.offsetHeight / 2 - keyTipElement.offsetHeight / 2;
     break;
    case "BelowRight":
     left = left + popupElement.offsetWidth - keyTipElement.offsetWidth / 3;
     top = top + keyTipElement.offsetHeight / 2;
     break;
    default:
     top = top + popupElement.offsetHeight;
     left = left + popupElement.offsetWidth / 2 - keyTipElement.offsetWidth / 2;
     break;
   }
  else {
   top = top + popupElement.offsetHeight;
   left = left + popupElement.offsetWidth / 2 - keyTipElement.offsetWidth / 2;
  }
  return { top: top, left: left };
 },
 hide: function() {
  if (this.keyTipElement)
   ASPx.SetElementVisibility(this.keyTipElement, false);
 },
 hideChildAccessKeys: function () {
  this.hideAccessKeys(this.accessKeys);
 },
 hideAccessKeys: function (accessKeys) {
  if (accessKeys) {
   for (var i = 0, accessKey; accessKey = accessKeys[i]; i++) {
    if (accessKey.keyTipElement)
     accessKey.hide();
    accessKey.hideChildAccessKeys();
   }
  }
 },
 hideAll: function () {
  this.getRoot(this).hideChildAccessKeys();
 },
 getRoot: function (accessKey) {
  if (!accessKey.parent)
   return accessKey;
  return this.getRoot(accessKey.parent);
 }
});
var focusedElement = null;
function aspxOnElementFocused(evt) {
 evt = ASPx.Evt.GetEvent(evt);
 if(evt && evt.target)
  focusedElement = evt.target;
}
function _aspxInitializeFocus() {
 if(!ASPx.GetActiveElement())
  ASPx.Evt.AttachEventToDocument("focus", aspxOnElementFocused);
}
function _aspxGetFocusedElement() {
 var activeElement = ASPx.GetActiveElement();
 return activeElement ? activeElement : focusedElement;
}
CheckBoxCheckState = {
 Checked : "Checked",
 Unchecked : "Unchecked",
 Indeterminate : "Indeterminate"
};
CheckBoxInputKey = { 
 Checked : "C",
 Unchecked : "U",
 Indeterminate : "I"
};
var CheckableElementStateController = ASPx.CreateClass(null, {
 constructor: function(imageProperties) {
  this.checkBoxStates = [];
  this.imageProperties = imageProperties;
  this.customImageMarkerClassName = "dxcbCI";
 },
 GetValueByInputKey: function(inputKey) {
  return this.GetFirstValueBySecondValue("Value", "StateInputKey", inputKey);
 },
 GetInputKeyByValue: function(value) {
  return this.GetFirstValueBySecondValue("StateInputKey", "Value", value);
 },
 GetImagePropertiesNumByInputKey: function(value) {
  return this.GetFirstValueBySecondValue("ImagePropertiesNumber", "StateInputKey", value);
 },
 GetNextCheckBoxValue: function(currentValue, allowGrayed) {
  var currentInputKey = this.GetInputKeyByValue(currentValue);
  var nextInputKey = '';
  switch(currentInputKey) {
   case CheckBoxInputKey.Checked:
    nextInputKey = CheckBoxInputKey.Unchecked; break;
   case CheckBoxInputKey.Unchecked:
    nextInputKey = allowGrayed ? CheckBoxInputKey.Indeterminate : CheckBoxInputKey.Checked; break;
   case CheckBoxInputKey.Indeterminate:
    nextInputKey = CheckBoxInputKey.Checked; break;
  }
  return this.GetValueByInputKey(nextInputKey);
 },
 GetCheckStateByInputKey: function(inputKey) {
  switch(inputKey) {
   case CheckBoxInputKey.Checked: 
    return CheckBoxCheckState.Checked;
   case CheckBoxInputKey.Unchecked: 
    return CheckBoxCheckState.Unchecked;
   case CheckBoxInputKey.Indeterminate: 
    return CheckBoxCheckState.Indeterminate;
  }
 },
 GetValueByCheckState: function(checkState) {
  switch(checkState) {
   case CheckBoxCheckState.Checked: 
    return this.GetValueByInputKey(CheckBoxInputKey.Checked);
   case CheckBoxCheckState.Unchecked: 
    return this.GetValueByInputKey(CheckBoxInputKey.Unchecked);
   case CheckBoxCheckState.Indeterminate: 
    return this.GetValueByInputKey(CheckBoxInputKey.Indeterminate);
  }
 },
 GetFirstValueBySecondValue: function(firstValueName, secondValueName, secondValue) {
  return this.GetValueByFunc(firstValueName, 
   function(checkBoxState) { return checkBoxState[secondValueName] === secondValue; });
 },
 GetValueByFunc: function(valueName, func) {
  for(var i = 0; i < this.checkBoxStates.length; i++) {
   if(func(this.checkBoxStates[i]))
    return this.checkBoxStates[i][valueName];
  }  
 },
 AssignElementClassName: function(element, cssClassPropertyKey, disabledCssClassPropertyKey, assignedClassName) {
  var classNames = [ ];
  for(var i = 0; i < this.imageProperties[cssClassPropertyKey].length; i++) {
   classNames.push(this.imageProperties[disabledCssClassPropertyKey][i]);
   classNames.push(this.imageProperties[cssClassPropertyKey][i]);
  }
  var elementClassName = element.className;
  for(var i = 0; i < classNames.length; i++) {
   var className = classNames[i];
   var index = elementClassName.indexOf(className);
   if(index > -1)
    elementClassName = elementClassName.replace((index == 0 ? '' : ' ') + className, "");
  }
  elementClassName += " " + assignedClassName;
  element.className = elementClassName;
 },
 UpdateInternalCheckBoxDecoration: function(mainElement, inputKey, enabled) {
  var imagePropertiesNumber = this.GetImagePropertiesNumByInputKey(inputKey);
  for(var imagePropertyKey in this.imageProperties) {
   if(this.imageProperties.hasOwnProperty(imagePropertyKey)) {
    var propertyValue = this.imageProperties[imagePropertyKey][imagePropertiesNumber];
    propertyValue = propertyValue || !isNaN(propertyValue) ? propertyValue : "";
    switch(imagePropertyKey) {
     case "0" : mainElement.title = propertyValue; break;
     case "1" : mainElement.style.width = propertyValue + (propertyValue != "" ? "px" : ""); break;
     case "2" : mainElement.style.height = propertyValue + (propertyValue != "" ? "px" : ""); break;
    }
    if(enabled) {
     switch(imagePropertyKey) {
      case "3" : this.SetImageSrc(mainElement, propertyValue); break;
      case "4" : 
       this.AssignElementClassName(mainElement, "4", "8", propertyValue);
       break;
      case "5" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
      case "6" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
     }
    } else {
     switch(imagePropertyKey) {
      case "7" : this.SetImageSrc(mainElement, propertyValue); break;
      case "8" : 
       this.AssignElementClassName(mainElement, "4", "8", propertyValue);
       break;
      case "9" : this.SetBackgroundPosition(mainElement, propertyValue, true); break;
      case "10" : this.SetBackgroundPosition(mainElement, propertyValue, false); break;
     }
    }
   }
  }
 },
 SetImageSrc: function(mainElement, src) {
  if(src === ""){
   mainElement.style.backgroundImage = "";
   mainElement.style.backgroundPosition = "";
   ASPx.RemoveClassNameFromElement(mainElement, this.customImageMarkerClassName);
  }
  else{
   mainElement.style.backgroundImage = "url('" + src + "')";
   this.SetBackgroundPosition(mainElement, 0, true);
   this.SetBackgroundPosition(mainElement, 0, false);
   ASPx.AddClassNameToElement(mainElement, this.customImageMarkerClassName);
  }
 },
 SetBackgroundPosition: function(element, value, isX) {
  if(value === "") {
   element.style.backgroundPosition = value;
   return;
  }
  if(element.style.backgroundPosition === "")
   element.style.backgroundPosition = isX ? "-" + value.toString() + "px 0px" : "0px -" + value.toString() + "px";
  else {
   var position = element.style.backgroundPosition.split(' ');
   element.style.backgroundPosition = isX ? '-' + value.toString() + "px " + position[1] :  position[0] + " -" + value.toString() + "px";
  }
 },
 AddState: function(value, stateInputKey, imagePropertiesNumber) {
  this.checkBoxStates.push({
   "Value" : value, 
   "StateInputKey" : stateInputKey, 
   "ImagePropertiesNumber" : imagePropertiesNumber
  });
 },
 GetAriaCheckedValue: function(state) {
  switch(state) {
   case ASPx.CheckBoxCheckState.Checked: return "true";
   case ASPx.CheckBoxCheckState.Unchecked: return "false";
   case ASPx.CheckBoxCheckState.Indeterminate: return "mixed";
   default: return "";
  }
 }
});
CheckableElementStateController.Create = function(imageProperties, valueChecked, valueUnchecked, valueGrayed, allowGrayed) {
 var stateController = new CheckableElementStateController(imageProperties);
 stateController.AddState(valueChecked, CheckBoxInputKey.Checked, 0);
 stateController.AddState(valueUnchecked, CheckBoxInputKey.Unchecked, 1);
 if(typeof(valueGrayed) != "undefined")
  stateController.AddState(valueGrayed, CheckBoxInputKey.Indeterminate, allowGrayed ? 2 : 1);
 stateController.allowGrayed = allowGrayed;
 return stateController;
};
var CheckableElementHelper = ASPx.CreateClass(null, {
 InternalCheckBoxInitialize: function(internalCheckBox) {
  this.AttachToMainElement(internalCheckBox);
  this.AttachToInputElement(internalCheckBox);
 },
 AttachToMainElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.mainElement) {
    var toggleEvent = internalCheckBox.displaySwitch ? ASPx.TouchUIHelper.touchMouseDownEventName : "click";
    ASPx.Evt.AttachEventToElement(internalCheckBox.mainElement, toggleEvent,
    function (evt) {
     if(ASPx.Evt.IsRightButtonPressed(evt))
      return;
     instance.InvokeClick(internalCheckBox, evt);
     if(!internalCheckBox.disableCancelBubble)
      return ASPx.Evt.PreventEventAndBubble(evt);
    }
   );
   ASPx.Evt.AttachEventToElement(internalCheckBox.mainElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
   ASPx.Evt.PreventElementDragAndSelect(internalCheckBox.mainElement, true);
  }
 },
 AttachToInputElement: function(internalCheckBox) {
  var instance = this;
  if(internalCheckBox.inputElement && internalCheckBox.mainElement) {
   var checkableElement = internalCheckBox.accessibilityCompliant ? internalCheckBox.mainElement : internalCheckBox.inputElement;
   ASPx.Evt.AttachEventToElement(checkableElement, "focus",
    function (evt) { 
     if(!internalCheckBox.enabled)
      checkableElement.blur();
     else
      internalCheckBox.OnFocus();
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "blur", 
    function (evt) { 
     internalCheckBox.OnLostFocus();
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "keyup",
    function (evt) { 
     if(ASPx.Evt.GetKeyCode(evt) == ASPx.Key.Space)
      instance.InvokeClick(internalCheckBox, evt);
    }
   );
   ASPx.Evt.AttachEventToElement(checkableElement, "keydown",
    function (evt) { 
     if(ASPx.Evt.GetKeyCode(evt) == ASPx.Key.Space)
      return ASPx.Evt.PreventEvent(evt);
    }
   );
  }
 },
 IsKBSInputWrapperExist: function() {
  return ASPx.Browser.Opera || ASPx.Browser.WebKitFamily;
 },
 GetICBMainElementByInput: function(icbInputElement) {
  return this.IsKBSInputWrapperExist() ? icbInputElement.parentNode.parentNode : icbInputElement.parentNode;
 },
 RequirePreventFocus: function() { return false; },
 InvokeClick: function(internalCheckBox, evt) {
  if(internalCheckBox.enabled && !internalCheckBox.GetReadOnly()) {
   var inputElementValue = internalCheckBox.inputElement.value;
   var focusableElement = internalCheckBox.accessibilityCompliant ? internalCheckBox.mainElement : internalCheckBox.inputElement; 
   if(!this.RequirePreventFocus())
    focusableElement.focus();
   if(!ASPx.Browser.IE) 
    internalCheckBox.inputElement.value = inputElementValue;
   this.InvokeClickCore(internalCheckBox, evt);
   }
 },
 InvokeClickCore: function(internalCheckBox, evt) {
  internalCheckBox.OnClick(evt);
 }
});
CheckableElementHelper.Instance = new CheckableElementHelper();
var CheckBoxInternal = ASPx.CreateClass(null, {
 constructor: function(inputElement, stateController, allowGrayed, allowGrayedByClick, helper, container, storeValueInInput, key, disableCancelBubble,
  accessibilityCompliant, displaySwitch) {
  this.inputElement = inputElement;
  this.mainElement = helper.GetICBMainElementByInput(this.inputElement);
  this.name = (key ? key : this.inputElement.id) + CheckBoxInternal.GetICBMainElementPostfix();
  this.mainElement.id = this.name;
  this.stateController = stateController;
  this.container = container;
  this.allowGrayed = allowGrayed;
  this.allowGrayedByClick = allowGrayedByClick;
  this.autoSwitchEnabled = true;
  this.displaySwitch = displaySwitch;
  this.storeValueInInput = !!storeValueInInput;
  this.storedInputKey = !this.storeValueInInput ? this.inputElement.value : null;
  this.disableCancelBubble = !!disableCancelBubble;
  this.accessibilityCompliant = accessibilityCompliant;
  this.focusDecoration = null;
  this.focused = false;
  this.focusLocked = false;
  this.enabled = !this.mainElement.className.match(/dxWeb_\w+Disabled(\b|_)/);
  this.readOnly = false;
  this.preventFocus = helper.RequirePreventFocus();
  this.CheckedChanged = new ASPxClientEvent();
  this.Focus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  helper.InternalCheckBoxInitialize(this);
 },
 GetReadOnly: function() {
  return this.readOnly;
 },
 ChangeInputElementTabIndex: function() {  
  var changeMethod = this.enabled ? ASPx.Attr.RestoreTabIndexAttribute : ASPx.Attr.SaveTabIndexAttributeAndReset;
  changeMethod(this.inputElement);
 },
 CreateFocusDecoration: function(focusedStyle) {
   this.focusDecoration = new FocusedStyleDecoration(this);
   this.focusDecoration.AddStyle('F', focusedStyle[0], focusedStyle[1]);
   this.focusDecoration.AddPostfix("");
 },
 UpdateFocusDecoration: function() {
  this.focusDecoration.Update();
 },  
 StoreInputKey: function(inputKey) {
  if(this.storeValueInInput)
   this.inputElement.value = inputKey;
  else
   this.storedInputKey = inputKey;
 },
 GetStoredInputKey: function() {
  if(this.storeValueInInput)
   return this.inputElement.value;
  else
   return this.storedInputKey;
 },
 OnClick: function(e) {
  if(this.autoSwitchEnabled) {
   var currentValue = this.GetValue();
   var value = this.stateController.GetNextCheckBoxValue(currentValue, this.allowGrayedByClick && this.allowGrayed);
   this.SetValue(value);
  }
  this.CheckedChanged.FireEvent(this, e);
 },
 OnFocus: function() {
  if(!this.IsFocusLocked()) {
   this.focused = true;
   this.UpdateFocusDecoration();
   this.Focus.FireEvent(this, null);
  } else
   this.UnlockFocus();
 },
 OnLostFocus: function() {
  if(!this.IsFocusLocked()) {
   this.focused = false;
   this.UpdateFocusDecoration();
   this.LostFocus.FireEvent(this, null);
  }
 },
 Refocus: function() {
  if(this.preventFocus) return;
  if(this.focused) {
   this.LockFocus();
   this.inputElement.blur();
   if(ASPx.Browser.MacOSMobilePlatform) {
    window.setTimeout(function() {
     ASPx.SetFocus(this.inputElement);
    }, 100);
   } else {
    ASPx.SetFocus(this.inputElement);
   }
  }
 },
 LockFocus: function() {
  this.focusLocked = true;
 },
 UnlockFocus: function() {
  this.focusLocked = false;
 },
 IsFocusLocked: function() {
  if(!!ASPx.Attr.GetAttribute(this.mainElement, ASPx.Attr.GetTabIndexAttributeName()))
   return false;
  return this.focusLocked;
 },
 SetValue: function(value, force) {
  var currentValue = this.GetValue();
  if(currentValue !== value || force) {
   var newInputKey = this.stateController.GetInputKeyByValue(value);
   if(newInputKey) {
    this.StoreInputKey(newInputKey);   
    this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, newInputKey, this.enabled);
   }
  }
  if(this.accessibilityCompliant) {
   var state = this.GetCurrentCheckState();
   var value = this.stateController.GetAriaCheckedValue(state);
   if(this.mainElement.attributes["aria-checked"] !== undefined)
    this.mainElement.setAttribute("aria-checked", value); 
   if(this.mainElement.attributes["aria-selected"] !== undefined)
    this.mainElement.setAttribute("aria-selected", value); 
  }
 },
 GetValue: function() {
  return this.stateController.GetValueByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentCheckState: function() {
  return this.stateController.GetCheckStateByInputKey(this.GetCurrentInputKey());
 },
 GetCurrentInputKey: function() {
  return this.GetStoredInputKey();
 },
 GetChecked: function() {
  return this.GetCurrentInputKey() === CheckBoxInputKey.Checked;
 },
 SetChecked: function(checked) {
  var newValue = this.stateController.GetValueByCheckState(checked ? CheckBoxCheckState.Checked : CheckBoxCheckState.Unchecked);
  this.SetValue(newValue);
 },
 SetEnabled: function(enabled) {
  if(this.enabled != enabled) {
   this.enabled = enabled;
   this.stateController.UpdateInternalCheckBoxDecoration(this.mainElement, this.GetCurrentInputKey(), this.enabled);
   this.ChangeInputElementTabIndex();
  }
 },
 GetEnabled: function() {
  return this.enabled;
 }
});
CheckBoxInternal.GetICBMainElementPostfix = function() {
 return "_D";
};
var CheckBoxInternalCollection = ASPx.CreateClass(CollectionBase, {
 constructor: function(imageProperties, allowGrayed, storeValueInInput, helper, disableCancelBubble, accessibilityCompliant) {
  this.constructor.prototype.constructor.call(this);
  this.stateController = allowGrayed 
   ? CheckableElementStateController.Create(imageProperties, CheckBoxInputKey.Checked, CheckBoxInputKey.Unchecked, CheckBoxInputKey.Indeterminate, true)
   : CheckableElementStateController.Create(imageProperties, CheckBoxInputKey.Checked, CheckBoxInputKey.Unchecked);
  this.helper = helper || CheckableElementHelper.Instance;
  this.storeValueInInput = !!storeValueInInput;
  this.disableCancelBubble = !!disableCancelBubble;
  this.accessibilityCompliant = accessibilityCompliant;
 },
 Add: function(key, inputElement, container) {
  this.Remove(key);
  var checkBox = this.CreateInternalCheckBox(key, inputElement, container);
  CollectionBase.prototype.Add.call(this, key, checkBox);
  return checkBox;
 },
 SetImageProperties: function(imageProperties) {
  this.stateController.imageProperties = imageProperties;
 },
 CreateInternalCheckBox: function(key, inputElement, container) {
  return new CheckBoxInternal(inputElement, this.stateController, this.stateController.allowGrayed, false, this.helper, container, 
   this.storeValueInInput, key, this.disableCancelBubble, this.accessibilityCompliant);
 }
});
var FocusedStyleDecoration = ASPx.CreateClass(null, {
 constructor: function(editor) {
  this.editor = editor;
  this.postfixList = [];
  this.styles = {};
  this.innerStyles = {};
 },
 AddPostfix: function(value) {
  this.postfixList.push(value);
 },
 AddStyle: function(key, className, cssText) {
  this.styles[key] = this.CreateRule(className, cssText);
  this.innerStyles[key] = this.CreateRule("", this.FilterInnerCss(cssText));
 },
 CreateRule: function(className, cssText) {
  return ASPx.Str.Trim(className + " " + ASPx.CreateImportantStyleRule(this.GetStyleSheet(), cssText));
 },
 GetStyleSheet: function() {
  return ASPx.GetCurrentStyleSheet();
 },
 FilterInnerCss: function(css) {
  return css.replace(/(border|background-image)[^:]*:[^;]+/gi, "");
 },
 Update: function() {
  for(var i = 0; i < this.postfixList.length; i++) {
   var postfix = this.postfixList[i];
   var inner = postfix.length > 0;
   var element = this.GetElementByPostfix(postfix);
   if(element)
    this.ApplyStyles(element, inner);
  }
 },
 GetElementByPostfix: function(postfix) {
  return ASPx.GetElementById(this.editor.name + postfix);
 },
 ApplyStyles: function(element, inner) {
  this.ApplyFocusedStyle(element, inner);
 },
 ApplyFocusedStyle: function(element, inner) {
  if(this.HasDecoration("F"))
   this.ApplyDecoration("F", element, inner, this.editor.focused);
 },
 HasDecoration: function(key) {
  return !!this.styles[key];
 },
 ApplyDecoration: function(key, element, inner, active) {
  var value = inner ? this.innerStyles[key] : this.styles[key];
  this.RemoveDecoration(element, value);
  if(active) {
   ASPx.AddClassNameToElement(element, value);
   if(ASPx.Browser.IE && ASPx.Browser.Version > 10 && element.border != null) 
    this.EnsureElementBorder(element);
  }
 },
 RemoveDecoration: function(element, value) {
  ASPx.RemoveClassNameFromElement(element, value);
  if(ASPx.Browser.IE && ASPx.Browser.MajorVersion >= 11)
   var dummy = element.offsetWidth; 
 },
 ApplyDecorationCore: function() {
 },
 EnsureElementBorder: function(element) {
  var border = parseInt(element.border) || 0;
  element.border = 1;
  element.border = border;
 }
});
var EditorStyleDecoration = ASPx.CreateClass(FocusedStyleDecoration, {
 constructor: function(editor) {
  this.constructor.prototype.constructor.call(this, editor);
  this.lockUpdate = false;
 },
 LockUpdate: function() {
  this.lockUpdate = true;
 },
 UnlockUpdate: function() {
  this.lockUpdate = false;
 },
 IsUpdateLocked: function() {
  return this.lockUpdate;
 },
 Update: function () {
  if(this.IsUpdateLocked())
   return;
  ASPx.FocusedStyleDecoration.prototype.Update.call(this);
 },
 ApplyStyles: function (element, inner) {
  this.ApplyInvalidStyle(element, inner);
  ASPx.FocusedStyleDecoration.prototype.ApplyStyles.call(this, element, inner);
 },
 ApplyInvalidStyle: function (element, inner) {
  if(this.HasDecoration("I")) {
   var isValid = this.editor.GetIsValid();
   this.ApplyDecoration("I", element, inner, !isValid);
  }
 }
});
var TextEditorStyleDecoration = ASPx.CreateClass(EditorStyleDecoration, {
 constructor: function(editor) {
  this.constructor.prototype.constructor.call(this, editor);
  this.nullTextClassName = "";
 },
 ApplyStyles: function(element, inner) {
  ASPx.EditorStyleDecoration.prototype.ApplyStyles.call(this, element, inner);
  this.ApplyNullTextStyle(element, inner);
 },
 ApplyNullTextStyle: function(element, inner) {
  if(!this.HasDecoration("N"))
   return;
  var apply = !this.editor.focused && this.editor.CanApplyNullTextDecoration();
  this.EnsureSpellcheckAttribute(element, apply);
  this.ApplyDecoration("N", element, inner, apply);
 },
 EnsureSpellcheckAttribute: function(element, apply) {
  if(apply)
   ASPx.Attr.ChangeAttribute(element, "spellcheck", "false");
  else
   ASPx.Attr.RestoreAttribute(element, "spellcheck");
 },
 ApplyNullTextClassName: function(active) {
  var nullTextClassName = this.GetNullTextClassName();
  var editorMainElement = this.editor.GetMainElement();
  if(active)
   ASPx.AddClassNameToElement(editorMainElement, nullTextClassName);
  else
   ASPx.RemoveClassNameFromElement(editorMainElement, nullTextClassName);
 },
 GetNullTextClassName: function() {
  if (!this.nullTextClassName)
   this.InitializeNullTextClassName();
  return this.nullTextClassName;
 },
 InitializeNullTextClassName: function() {
  var nullTextStyle = this.styles["N"];
  if (nullTextStyle) {
   var nullTextStyleClassNames = nullTextStyle.split(" ");
   for (var i = 0; i < nullTextStyleClassNames.length; i++)
    if (nullTextStyleClassNames[i].match("dxeNullText"))
     this.nullTextClassName = nullTextStyleClassNames[i];
  }
 }
});
var TouchUIHelper = {
 isGesture: false,
 isMouseEventFromScrolling: false,
 isNativeScrollingAllowed: true,
 clickSensetivity: 10,
 documentTouchHandlers: {},
 documentEventAttachingAllowed: true,
 msTouchDraggableClassName: "dxMSTouchDraggable",
 touchMouseDownEventName: ASPx.Browser.WebKitTouchUI ? "touchstart" : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointerdown" : "mousedown"),
 touchMouseUpEventName:   ASPx.Browser.WebKitTouchUI ? "touchend"   : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointerup" : "mouseup"),
 touchMouseMoveEventName: ASPx.Browser.WebKitTouchUI ? "touchmove"  : (ASPx.Browser.Edge && ASPx.Browser.MSTouchUI && window.PointerEvent ? "pointermove" : "mousemove"),
 isTouchEvent: function(evt) {
  if(!evt) return false;
  return ASPx.Browser.WebKitTouchUI && ASPx.IsExists(evt.changedTouches); 
 },
 isTouchEventName: function(eventName) {
  return ASPx.Browser.WebKitTouchUI && (eventName.indexOf("touch") > -1 || eventName.indexOf("gesture") > -1);
 },
 getEventX: function(evt) {
  if(ASPx.Browser.IE)
   return evt.pageX;
  var touchPoint = null;
  if(evt.changedTouches.length > 0)
   touchPoint = evt.changedTouches;
  else if(evt.targetTouches.length > 0)
   touchPoint = evt.targetTouches;
  return touchPoint ? touchPoint[0].pageX : 0;
 },
 getEventY: function(evt) { 
  if(ASPx.Browser.IE)
   return evt.pageY;
  var touchPoint = null;
  if(evt.changedTouches.length > 0)
   touchPoint = evt.changedTouches;
  else if(evt.targetTouches.length > 0)
   touchPoint = evt.targetTouches;
  return touchPoint ? touchPoint[0].pageY : 0;
 },
 getWebkitMajorVersion: function(){
  if(!this.webkitMajorVersion){
   var regExp = new RegExp("applewebkit/(\\d+)", "i");
   var matches = regExp.exec(ASPx.Browser.UserAgent);
   if(matches && matches.index >= 1)
    this.webkitMajorVersion = matches[1];
  }
  return this.webkitMajorVersion;
 },
 getIsLandscapeOrientation: function(){
  if(ASPx.Browser.MacOSMobilePlatform || ASPx.Browser.AndroidMobilePlatform)
   return Math.abs(window.orientation) == 90;
  return ASPx.GetDocumentClientWidth() > ASPx.GetDocumentClientHeight();
 },
 nativeScrollingSupported: function() {
  var allowedSafariVersion = ASPx.Browser.Version >= 5.1 && ASPx.Browser.Version < 8; 
  var webkitMajorVersion = this.getWebkitMajorVersion();
  var allowedWebKitVersion = webkitMajorVersion > 533 && webkitMajorVersion < 600;
  return (ASPx.Browser.MacOSMobilePlatform && (allowedSafariVersion || allowedWebKitVersion))
   || (ASPx.Browser.AndroidMobilePlatform && ASPx.Browser.PlaformMajorVersion >= 3) || (ASPx.Browser.MSTouchUI && (!ASPx.Browser.WindowsPhonePlatform || !ASPx.Browser.IE));
 },
 makeScrollableIfRequired: function(element, options) {
  if(ASPx.Browser.WebKitTouchUI && element) {
   var overflow = ASPx.GetCurrentStyle(element).overflow;
   if(element.tagName == "DIV" &&  overflow != "hidden" && overflow != "visible" ){
    return this.MakeScrollable(element);
   }
  }
 },
 preventScrollOnEvent: function(evt){
 },
 handleFastTapIfRequired: function(evt, action, preventCommonClickEvents) {
  if(ASPx.Browser.WebKitTouchUI && evt.type == 'touchstart' && action) {
   this.FastTapHelper.HandleFastTap(evt, action, preventCommonClickEvents);
   return true;
  }
  return false;
 },
 ensureDocumentSizesCorrect: function (){
  return (document.documentElement.clientWidth - document.documentElement.clientHeight) / (screen.width - screen.height) > 0;
 },
 ensureOrientationChanged: function(onOrientationChangedFunction){
  if(ASPxClientUtils.iOSPlatform || this.ensureDocumentSizesCorrect())
   onOrientationChangedFunction();
  else {
   window.setTimeout(function(){
    this.ensureOrientationChanged(onOrientationChangedFunction);
   }.aspxBind(this), 100);
  }
 },
 onEventAttachingToDocument: function(eventName, func){
  if(ASPx.Browser.MacOSMobilePlatform && this.isTouchEventName(eventName)) {
   if(!this.documentTouchHandlers[eventName])
    this.documentTouchHandlers[eventName] = [];
   this.documentTouchHandlers[eventName].push(func);
   return this.documentEventAttachingAllowed;
  }
  return true;
 },
 onEventDettachedFromDocument: function(eventName, func){
  if(ASPx.Browser.MacOSMobilePlatform && this.isTouchEventName(eventName)) {
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers)
    ASPx.Data.ArrayRemove(handlers, func);
  }
 },
 processDocumentTouchEventHandlers: function(proc) {
  var touchEventNames = ["touchstart", "touchend", "touchmove", "gesturestart", "gestureend"];
  for(var i = 0; i < touchEventNames.length; i++) {
   var eventName = touchEventNames[i];
   var handlers = this.documentTouchHandlers[eventName];
   if(handlers) {
    for(var j = 0; j < handlers.length; j++) {
     proc(eventName,handlers[j]);
    }
   }
  }
 },
 removeDocumentTouchEventHandlers: function() {
  if(ASPx.Browser.MacOSMobilePlatform) {
   this.documentEventAttachingAllowed = false;
   this.processDocumentTouchEventHandlers(ASPx.Evt.DetachEventFromDocumentCore);
  }
 },
 restoreDocumentTouchEventHandlers: function () {
  if(ASPx.Browser.MacOSMobilePlatform) {
   this.documentEventAttachingAllowed = true;
   this.processDocumentTouchEventHandlers(ASPx.Evt.AttachEventToDocumentCore);
  }
 },
 IsNativeScrolling: function() {
  return TouchUIHelper.nativeScrollingSupported() && TouchUIHelper.isNativeScrollingAllowed;
 },
 pointerEnabled: !!(window.PointerEvent || window.MSPointerEvent),
 pointerDownEventName: window.PointerEvent ? "pointerdown" : "MSPointerDown",
 pointerUpEventName: window.PointerEvent ? "pointerup" : "MSPointerUp",
 pointerCancelEventName: window.PointerEvent ? "pointercancel" : "MSPointerCancel",
 pointerMoveEventName: window.PointerEvent ? "pointermove" : "MSPointerMove",
 pointerOverEventName: window.PointerEvent ? "pointerover" : "MSPointerOver",
 pointerOutEventName: window.PointerEvent ? "pointerout" : "MSPointerOut",
 pointerType: {
  Touch: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 2 : "touch",
  Pen: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 3 : "pen",
  Mouse: (ASPx.Browser.IE && ASPx.Browser.Version == 10) ? 4 : "mouse"
 },
 msGestureEnabled: !!(window.PointerEvent || window.MSPointerEvent) && typeof(MSGesture) != "undefined",
 msTouchCreateGesturesWrapper: function(element, onTap){
  if(!TouchUIHelper.msGestureEnabled) 
   return;
  var gesture = new MSGesture();
  gesture.target = element;
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.pointerDownEventName, function(evt){
   gesture.addPointer(evt.pointerId);
  });
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.pointerUpEventName, function(evt){
   gesture.stop();
  });
  if(onTap)
   ASPx.Evt.AttachEventToElement(element, "MSGestureTap", onTap);
  return gesture;
 },
 useLongTapHelper: function () {
  return ASPx.Browser.Safari && ASPx.Browser.TouchUI;
 },
 attachLongTapHandler: function(element, handler, onlyBubbling) {
  var timerID = -1;
  var timeout = 1000;
  var event = null;
  var preventClickEvent = false;
  var startX = -1;
  var startY = -1;
  var pixelLimit = 5;
  function onTouchMouseDown(evt) {
   abortWating();
   event = evt;
   startX = evt.pageX;
   startY = evt.pageY;
   preventClickEvent = false;
   timerID = window.setTimeout(onTimeout, timeout);
  }
  function onTouchMouseMove(evt) {
   if (!isUnderTouch())
    return;
   var shiftX = Math.abs(startX - evt.pageX),
    shiftY = Math.abs(startY - evt.pageY),
    maxShift = Math.max(shiftX, shiftY);
   if (maxShift > pixelLimit)
    abortWating();
  }
  function onTouchMouseUp(evt) {
   abortWating();
   if (preventClickEvent) {
    ASPx.Evt.PreventEventAndBubble(evt);
    preventClickEvent = false;
   }
  }
  function onTimeout() {
   handler(event);
   preventClickEvent = true;
   abortWatingInternal();
  }
  function isUnderTouch() {
   return timerID !== -1;
  }
  function abortWating() {
   if (isUnderTouch()) {
    window.clearTimeout(timerID);
    abortWatingInternal();
   }
  }
  function abortWatingInternal() {
   timerID = -1;
   event = null;
  }
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseDownEventName, onTouchMouseDown, onlyBubbling);
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseMoveEventName, onTouchMouseMove, onlyBubbling);
  ASPx.Evt.AttachEventToElement(element, TouchUIHelper.touchMouseUpEventName, onTouchMouseUp, onlyBubbling);
  element.style["-webkit-user-select"] = "none";
  return function () {
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseDownEventName, onTouchMouseDown);
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseMoveEventName, onTouchMouseMove);
   ASPx.Evt.DetachEventFromElement(element, TouchUIHelper.touchMouseUpEventName, onTouchMouseUp);
   element.style["-webkit-user-select"] = "";
  };
 }
};
var CacheHelper = {};
CacheHelper.GetCachedValueCore = function(obj, key, func, cacheObj, fillValueMethod) {
 if(!cacheObj)
  cacheObj = obj;
 if(!cacheObj.cache)
  cacheObj.cache = {};
 if(!key) 
  key = "default";
 fillValueMethod(obj, key, func, cacheObj);
 return cacheObj.cache[key];
};
CacheHelper.GetCachedValue = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsExists(cacheObj.cache[key]))
    cacheObj.cache[key] = func.apply(obj, []);
  });
};
CacheHelper.GetCachedElement = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsValidElement(cacheObj.cache[key]))
    cacheObj.cache[key] = func.apply(obj, []);
  });
};
CacheHelper.GetCachedElements = function(obj, key, func, cacheObj) {
 return CacheHelper.GetCachedValueCore(obj, key, func, cacheObj, 
  function(obj, key, func, cacheObj) {
   if(!ASPx.IsValidElements(cacheObj.cache[key])){
    var elements = func.apply(obj, []);
    if(!Ident.IsArray(elements))
     elements = [elements];
    cacheObj.cache[key] = elements;
   }
  });
};
CacheHelper.GetCachedElementById = function(obj, id, cacheObj) {
 return CacheHelper.GetCachedElement(obj, id, function() { return ASPx.GetElementById(id); }, cacheObj);
};
CacheHelper.GetCachedChildById = function(obj, parent, id, cacheObj) {
 return CacheHelper.GetCachedElement(obj, id, function() { return ASPx.GetChildById(parent, id); }, cacheObj);
};
CacheHelper.DropCachedValue = function(cacheObj, key) {
 cacheObj.cache[key] = null;
};  
CacheHelper.DropCache = function(cacheObj) {
 cacheObj.cache = null;
};  
var DomObserver = ASPx.CreateClass(null, {
 constructor: function() {
  this.items = { };
 },
 subscribe: function(elementID, callbackFunc) {
  var item = this.items[elementID];
  if(item)
   this.unsubscribe(elementID);
  item = {
   elementID: elementID,
   callbackFunc: callbackFunc,
   pauseCount: 0
  };
  this.prepareItem(item);
  this.items[elementID] = item;
 },
 prepareItem: function(item) {
 },
 unsubscribe: function(elementID) {
  this.items[elementID] = null;
 },
 getItemElement: function(item) {
  var element = this.getElementById(item.elementID);
  if(element)
   return element;
  this.unsubscribe(item.elementID);
  return null;
 },
 getElementById: function(elementID) {
  var element = document.getElementById(elementID);
  return element && ASPx.IsValidElement(element) ? element : null;
 },
 pause: function(element, includeSubtree) {
  this.changeItemsState(element, includeSubtree, true);
 },
 resume: function(element, includeSubtree) {
  this.changeItemsState(element, includeSubtree, false);
 },
 forEachItem: function(processFunc, context) {
  context = context || this;
  for(var itemName in this.items) {
   if(!this.items.hasOwnProperty(itemName))
    continue;
   var item = this.items[itemName];
   if(item) {
    var needBreak = processFunc.call(context, item);
    if(needBreak)
     return;
   }
  }
 },
 changeItemsState: function(element, includeSubtree, pause) {
  this.forEachItem(function(item) {
   if(!element)
    this.changeItemState(item, pause);
   else {
    var itemElement = this.getItemElement(item);
    if(itemElement && (element == itemElement || (includeSubtree && ASPx.GetIsParent(element, itemElement)))) {
     this.changeItemState(item, pause);
     if(!includeSubtree)
      return true;
    }
   }
  }.aspxBind(this));
 },
 changeItemState: function(item, pause) {
  if(pause)
   this.pauseItem(item);
  else
   this.resumeItem(item);
 },
 pauseItem: function(item) {
  item.paused = true;
  item.pauseCount++;
 },
 resumeItem: function(item) {
  if(item.pauseCount > 0) {
   if(item.pauseCount == 1)
    item.paused = false;
   item.pauseCount--;
  }
 }
});
DomObserver.IsMutationObserverAvailable = function() {
 return !!window.MutationObserver;
};
var TimerObserver = ASPx.CreateClass(DomObserver, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.timerID = -1;
  this.observationTimeout = 300;
 },
 subscribe: function(elementID, callbackFunc) {
  DomObserver.prototype.subscribe.call(this, elementID, callbackFunc);
  if(!this.isActivated())
   this.startObserving();
 },
 isActivated: function() {
  return this.timerID !== -1;
 },
 startObserving: function() {
  if(this.isActivated())
   window.clearTimeout(this.timerID);
  this.timerID = window.setTimeout(this.onTimeout, this.observationTimeout);
 },
 onTimeout: function() {
  var observer = _aspxGetDomObserver();
  observer.doObserve();
  observer.startObserving();
 },
 doObserve: function() {
  if(!ASPx.documentLoaded) return;
  this.forEachItem(function(item) {
   if(!item.paused)
    this.doObserveForItem(item);
  }.aspxBind(this));
 },
 doObserveForItem: function(item) {
  var element = this.getItemElement(item);
  if(element)
   item.callbackFunc.call(this, element);
 }
});
var MutationObserver = ASPx.CreateClass(DomObserver, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.callbackTimeout = 10;
 },
 prepareItem: function(item) {
  item.callbackTimerID = -1;
  var target = this.getElementById(item.elementID);
  if(!target)
   return;
  var observerCallbackFunc = function() {
   if(item.callbackTimerID === -1) {
    var timeoutHander = function() {
     item.callbackTimerID = -1;
     item.callbackFunc.call(this, target);
    }.aspxBind(this);
    item.callbackTimerID = window.setTimeout(timeoutHander, this.callbackTimeout);
   }
  }.aspxBind(this);
  var observer = new window.MutationObserver(observerCallbackFunc);
  var config = { attributes: true, childList: true, characterData: true, subtree: true };
  observer.observe(target, config);
  item.observer = observer;
  item.config = config;
 },
 unsubscribe: function(elementID) {
  var item = this.items[elementID];
  if(item) {
   item.observer.disconnect();
   item.observer = null;
  }
  DomObserver.prototype.unsubscribe.call(this, elementID);
 },
 pauseItem: function(item) {
  DomObserver.prototype.pauseItem.call(this, item);
  item.observer.disconnect();
 },
 resumeItem: function(item) {
  DomObserver.prototype.resumeItem.call(this, item);
  if(!item.paused) {
   var target = this.getItemElement(item);
   if(target)
    item.observer.observe(target, item.config);
  }
 }
});
var domObserver = null;
function _aspxGetDomObserver() {
 if(domObserver == null)
  domObserver = DomObserver.IsMutationObserverAvailable() ? new MutationObserver() : new TimerObserver();
 return domObserver;
}
var ControlUpdateWatcher = ASPx.CreateClass(null, {
 constructor: function() {
  this.helpers = { };
  this.clearLockerTimerID = -1;
  this.clearLockerTimerDelay = 15;
  this.postProcessing = false;
  this.init();
 },
 init: function() {
  var postHandler = aspxGetPostHandler();
  postHandler.Post.AddHandler(this.OnPost, this);
 },
 Add: function(helper) {
  this.helpers[helper.GetName()] = helper;
 },
 CanSendCallback: function(dxCallbackOwner, arg) {
  this.LockConfirmOnBeforeWindowUnload();
  var modifiedHelpers = this.FilterModifiedHelpersByDXCallbackOwner(this.GetModifiedHelpers(), dxCallbackOwner, arg);
  if(modifiedHelpers.length === 0) return true;
  var modifiedHelpersInfo = this.GetToConfirmAndToResetLists(modifiedHelpers, dxCallbackOwner.name);
  if(!modifiedHelpersInfo) return true;
  if(modifiedHelpersInfo.toConfirm.length === 0) {
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
   return true;
  }
  var helper = modifiedHelpersInfo.toConfirm[0];
  if(!confirm(helper.GetConfirmUpdateText()))
   return false;
  this.ResetClientChanges(modifiedHelpersInfo.toReset);
  return true;
 },
 OnPost: function(s, e) {
  if(this.isDxCallback(e))
   return;
  this.postProcessing = true;
  this.LockConfirmOnBeforeWindowUnload();
  var modifiedHelpersInfo = this.GetModifedHelpersInfo(e);
  if(!modifiedHelpersInfo)
   return;
  if(modifiedHelpersInfo.toConfirm.length === 0) {
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
   return;
  }
  var helper = modifiedHelpersInfo.toConfirm[0];
  if(!confirm(helper.GetConfirmUpdateText())) {
   e.cancel = true;
   this.finishPostProcessing();
  }
  if(!e.cancel)
   this.ResetClientChanges(modifiedHelpersInfo.toReset);
 },
 isDxCallback: function(e) {
  return e.isDXCallback || this.isInternalUploadControlCallback();
 },
 isInternalUploadControlCallback: function() {
  var isInCallback = false;
  for(var key in this.helpers) {
   if(this.helpers.hasOwnProperty(key)) {
    var helper = this.helpers[key];
    isInCallback = isInCallback || helper.isInUploadCallback();
   }
  }
  return isInCallback;
 },
 finishPostProcessing: function() {
  this.postProcessing = false;
 },
 GetModifedHelpersInfo: function(e) {
  var modifiedHelpers = this.FilterModifiedHelpers(this.GetModifiedHelpers(), e);
  if(modifiedHelpers.length === 0) return;
  return this.GetToConfirmAndToResetLists(modifiedHelpers, e && e.ownerID);
 },
 GetToConfirmAndToResetLists: function(modifiedHelpers, ownerID) {
  var resetList = [ ];
  var confirmList = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(!helper.GetConfirmUpdateText()) { 
    resetList.push(helper);
    continue;
   }
   if(helper.CanShowConfirm(ownerID)) { 
    resetList.push(helper);
    confirmList.push(helper);
   }
  }
  return { toConfirm: confirmList, toReset: resetList };
 },
 FilterModifiedHelpers: function(modifiedHelpers, e) {
  if(modifiedHelpers.length === 0)
   return [ ];
  if(this.RequireProcessUpdatePanelCallback(e))
   return this.FilterModifiedHelpersByUpdatePanels(modifiedHelpers);
  if(this.postProcessing)
   return this.FilterModifiedHelpersByPostback(modifiedHelpers);
  return modifiedHelpers;
 },
 FilterModifiedHelpersByDXCallbackOwner: function(modifiedHelpers, dxCallbackOwner, arg) {
  var result = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(helper.NeedConfirmOnCallback(dxCallbackOwner, arg))
    result.push(helper);
  }
  return result;
 },
 FilterModifiedHelpersByUpdatePanels: function(modifiedHelpers) {
  var result = [ ];
  var updatePanels = this.GetUpdatePanelsWaitedForUpdate();
  for(var i = 0; i < updatePanels.length; i++) {
   var panelID = updatePanels[i].replace(/\$/g, "_");
   var panel = ASPx.GetElementById(panelID);
   if(!panel) continue;
   for(var j = 0; j < modifiedHelpers.length; j++) {
    var helper = modifiedHelpers[j];
    if(ASPx.GetIsParent(panel, helper.GetControlMainElement()))
     result.push(helper);
   }
  }
  return result;
 },
 FilterModifiedHelpersByPostback: function(modifiedHelpers) {
  var result = [ ];
  for(var i = 0; i < modifiedHelpers.length; i++) {
   var helper = modifiedHelpers[i];
   if(helper.NeedConfirmOnPostback())
    result.push(helper);
  }
  return result;
 },
 RequireProcessUpdatePanelCallback: function(e) {
  var rManager = this.GetMSRequestManager();
  if(rManager && e && e.isMSAjaxCallback)
   return rManager._postBackSettings.async;
  return false;
 },
 GetUpdatePanelsWaitedForUpdate: function() {
  var rManager = this.GetMSRequestManager();
  if(!rManager) return [ ];
  var panelUniqueIDs = rManager._postBackSettings.panelsToUpdate || [ ];
  var panelClientIDs = [ ];
  for(var i = 0; i < panelUniqueIDs.length; i++) {
   var index = ASPx.Data.ArrayIndexOf(rManager._updatePanelIDs, panelUniqueIDs[i]);
   if(index >= 0)
    panelClientIDs.push(rManager._updatePanelClientIDs[index]);
  }
  return panelClientIDs;
 },
 GetMSRequestManager: function() {
  return ASPx.GetMSAjaxRequestManager();
 },
 GetModifiedHelpers: function() {
  var result = [ ];
  for(var key in this.helpers) { 
   if(this.helpers.hasOwnProperty(key)) {
    var helper = this.helpers[key];
    if(helper.HasChanges())
     result.push(helper);
   }
  }
  return result;
 },
 ResetClientChanges: function(modifiedHelpers) {
  for(var i = 0; i < modifiedHelpers.length; i++)
   modifiedHelpers[i].ResetClientChanges();
 },
 GetConfirmUpdateMessage: function() {
  if(this.confirmOnWindowUnloadLocked) return;
  var modifiedHelpersInfo = this.GetModifedHelpersInfo();
  if(!modifiedHelpersInfo || modifiedHelpersInfo.toConfirm.length === 0) 
   return;
  var helper = modifiedHelpersInfo.toConfirm[0];
  return helper.GetConfirmUpdateText();
 },
 LockConfirmOnBeforeWindowUnload: function() {
  this.confirmOnWindowUnloadLocked = true;
  this.clearLockerTimerID = ASPx.Timer.ClearTimer(this.clearLockerTimerID);
  this.clearLockerTimerID = window.setTimeout(function() {
   this.confirmOnWindowUnloadLocked = false;
  }.aspxBind(this), this.clearLockerTimerDelay);
 },
 OnWindowBeforeUnload: function(e) {
  var confirmMessage = this.GetConfirmUpdateMessage();
  if(confirmMessage)
   e.returnValue = confirmMessage;
  this.finishPostProcessing();
  return confirmMessage;
 },
 OnWindowUnload: function(e) {
  if(this.confirmOnWindowUnloadLocked) return;
  var modifiedHelpersInfo = this.GetModifedHelpersInfo();
  if(!modifiedHelpersInfo) return;
  this.ResetClientChanges(modifiedHelpersInfo.toReset);
 },
 OnMouseDown: function(e) {
  if(ASPx.Browser.IE)
   this.PreventBeforeUnloadOnLinkClick(e);
 },
 OnFocusIn: function(e) {
  if(ASPx.Browser.IE)
   this.PreventBeforeUnloadOnLinkClick(e);
 },
 PreventBeforeUnloadOnLinkClick: function(e) {
  if(ASPx.GetObjectKeys(this.helpers).length == 0)
   return;
  var link = ASPx.GetParentByTagName(ASPx.Evt.GetEventSource(e), "A");
  if(!link || link.dxgvLinkClickHanlderAssigned)
   return;
  var url = ASPx.Attr.GetAttribute(link, "href");
  if(!url || url.indexOf("javascript:") < 0)
   return;
  ASPx.Evt.AttachEventToElement(link, "click", function(ev) { return ASPx.Evt.PreventEvent(ev); });
  link.dxgvLinkClickHanlderAssigned = true;
 }
});
ControlUpdateWatcher.Instance = null;
ControlUpdateWatcher.getInstance = function () {
 if (!ControlUpdateWatcher.Instance) {
  ControlUpdateWatcher.Instance = new ControlUpdateWatcher();
  ASPx.Evt.AttachEventToElement(window, "beforeunload", function(e) {
   return ControlUpdateWatcher.Instance.OnWindowBeforeUnload(e);
  });
  ASPx.Evt.AttachEventToElement(window, "unload", function(e) {
   ControlUpdateWatcher.Instance.OnWindowUnload(e);
  });
  ASPx.Evt.AttachEventToDocument("mousedown", function(e) {
   ControlUpdateWatcher.Instance.OnMouseDown(e);
  });
  ASPx.Evt.AttachEventToDocument("focusin", function(e) {
   ControlUpdateWatcher.Instance.OnFocusIn(e);
  });
 }
 return ControlUpdateWatcher.Instance;
};
var UpdateWatcherHelper = ASPx.CreateClass(null, {
 constructor: function(owner) {
  this.owner = owner;
  this.ownerWatcher = ControlUpdateWatcher.getInstance();
  this.ownerWatcher.Add(this);
 },
 GetName: function() {
  return this.owner.name;
 },
 GetControlMainElement: function() {
  return this.owner.GetMainElement();
 },
 GetControlParentForm: function(){
  return ASPx.GetParentByTagName(this.GetControlMainElement(), "FORM");
 },
 CanShowConfirm: function(requestOwnerID) {
  return true;
 },
 HasChanges: function() {
  return false;
 },
 GetConfirmUpdateText: function() {
  return "";
 },
 NeedConfirmOnCallback: function(dxCallbackOwner) {
  return true;
 },
 NeedConfirmOnPostback: function() {
  if(ASPx.IsUploadSubmitRequest)
   return !ASPx.IsUploadSubmitRequest(this.GetControlParentForm());
  return true;
 },
 ResetClientChanges: function() {
 },
 ConfirmOnCustomControlEvent: function() {
  var confirmMessage = this.GetConfirmUpdateText();
  if(confirmMessage)
   return confirm(confirmMessage);
  return false;
 },
 isInUploadCallback: function() {
  return false;
 }
});
var ControlTabIndexManager = ASPx.CreateClass(null, {
 constructor: function() {
  this.elementsWithChangedTabIndex = {};
 },
 getChangedElementsForControlId: function(id) {
  if(!this.elementsWithChangedTabIndex[id])
   this.elementsWithChangedTabIndex[id] = [];
  return this.elementsWithChangedTabIndex[id];
 },
 isElementWithChangedIndex: function(element) {
  for(var key in this.elementsWithChangedTabIndex)
   if(this.elementsWithChangedTabIndex.hasOwnProperty(key))
    if(this.elementsWithChangedTabIndex[key].indexOf(element) !== -1)
     return true;
  return false;
 },
 changeTabIndexAttribute: function(element, id) {
  var elements = this.getChangedElementsForControlId(id);
  ASPx.Attr.ChangeTabIndexAttribute(element);
  if(elements.indexOf(element) === -1)
   elements.push(element);
 },
 restoreTabIndexAttribute: function(element, id) {
  var elements = this.getChangedElementsForControlId(id),
   index = elements.indexOf(element);
  if(index !== -1) {
   elements.splice(index, 1);
   if(!this.isElementWithChangedIndex(element))
    ASPx.Attr.RestoreTabIndexAttribute(element);
  }
 }
});
ControlTabIndexManager.Instance = null;
ControlTabIndexManager.getInstance = function() {
 if(!ControlTabIndexManager.Instance)
  ControlTabIndexManager.Instance = new ControlTabIndexManager();
 return ControlTabIndexManager.Instance;
};
var ControlCallbackHandlersQueue = ASPx.CreateClass(null, {
 constructor: function (owner) {
  this.owner = owner;
  this.handlerInfos = [];
 },
 addCallbackHandler: function(handlerInfo) {
  this.handlerInfos.push(handlerInfo);
 },
 executeCallbacksHandlers: function() {
  for(var i = 0, handlerInfo; handlerInfo = this.handlerInfos[i]; i++)
   handlerInfo.handler.call(this.owner, handlerInfo.result);
  this.handlerInfos = [];
 }
});
var ControlCallbackQueueHelper = ASPx.CreateClass(null, {
 constructor: function (owner) {
  this.owner = owner;
  this.pendingCallbacks = [];
  this.receivedCallbacks = [];
  this.attachEvents();
 },
 showLoadingElements: function () {
  this.owner.ShowLoadingDiv();
  if (this.owner.IsCallbackAnimationEnabled())
   this.owner.StartBeginCallbackAnimation();
  else
   this.owner.ShowLoadingElementsInternal();
 },
 attachEvents: function () {
  this.owner.EndCallback.AddHandler(this.onEndCallback.aspxBind(this));
  this.owner.CallbackError.AddHandler(this.onCallbackError.aspxBind(this));
 },
 detachEvents: function () {
  this.owner.EndCallback.RemoveHandler(this.onEndCallback);
  this.owner.CallbackError.RemoveHandler(this.onCallbackError);
 },
 onCallbackError: function (owner, result) {
  this.sendErrorToChildControl(result);
 },
 ignoreDuplicates: function () {
  return true;
 },
 hasDuplicate: function (arg) {
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].arg == arg && this.pendingCallbacks[i].state != ASPx.callbackState.aborted)
    return true;
  }
  return false;
 },
 getToken: function (halperContext, callbackInfo) {
  return {
   cancel: function () {
    if (callbackInfo.state == ASPx.callbackState.sent) {
     callbackInfo.state = ASPx.callbackState.aborted;
     halperContext.sendNext();
    }
    if (callbackInfo.state == ASPx.callbackState.inTurn)
     ASPx.Data.ArrayRemove(halperContext.pendingCallbacks, callbackInfo);
   },
   callbackId: -1
  };
 },
 sendCallback: function (arg, handlerContext, handler, commandName, onBeforeSend) {
  if (this.ignoreDuplicates() && this.hasDuplicate(arg))
   return false;
  var handlerContext = handlerContext || this.owner;
  var callbackInfo = {
   arg: arg,
   handlerContext: handlerContext,
   handler: handler || handlerContext.OnCallback,
   state: ASPx.callbackState.inTurn,
   callbackId: -1,
   onBeforeSend: onBeforeSend
  };
  this.pendingCallbacks.push(callbackInfo);
  if (!this.hasActiveCallback()) {
   this.createCallbackByCallbackInfo(callbackInfo, commandName);
  }
  return this.getToken(this, callbackInfo);
 },
 hasActiveCallback: function () {
  return this.getCallbacksInfoByState(ASPx.callbackState.sent).length > 0;
 },
 sendNext: function () {
  var nextCallbackInfo = this.getCallbacksInfoByState(ASPx.callbackState.inTurn)[0];
  if (nextCallbackInfo) {
   this.createCallbackByCallbackInfo(nextCallbackInfo);
   return nextCallbackInfo.callbackId;
  }
 },
 createCallbackByCallbackInfo: function(callbackInfo, commandName) {
  if(callbackInfo.onBeforeSend)
   callbackInfo.onBeforeSend();
  callbackInfo.callbackId = this.owner.CreateCallback(callbackInfo.arg, commandName);
  callbackInfo.state = ASPx.callbackState.sent;
 },
 onEndCallback: function () {
  if (!this.owner.isErrorOnCallback && this.hasPendingCallbacks()) {
   var curCallbackId;
   var curCallbackInfo;
   var handlerContext;
   for (var i in this.receivedCallbacks) {
    if(this.receivedCallbacks.hasOwnProperty(i)) {
     curCallbackId = this.receivedCallbacks[i];
     curCallbackInfo = this.getCallbackInfoById(curCallbackId);
     if (curCallbackInfo.state != ASPx.callbackState.aborted) {
      handlerContext = curCallbackInfo.handlerContext;
      if (handlerContext.OnEndCallback)
       handlerContext.OnEndCallback();
      this.sendNext();
     }
     ASPx.Data.ArrayRemove(this.pendingCallbacks, curCallbackInfo);
    }
   }
   ASPx.Data.ArrayClear(this.receivedCallbacks);
  }
 },
 hasPendingCallbacks: function () {
  return this.pendingCallbacks && this.pendingCallbacks.length && this.pendingCallbacks.length > 0;
 },
 processCallback: function (result, callbackId) {
  this.receivedCallbacks.push(callbackId);
  if (this.hasPendingCallbacks()) {
   var callbackInfo = this.getCallbackInfoById(callbackId);
   if (callbackInfo.state != ASPx.callbackState.aborted)
    callbackInfo.handler.call(callbackInfo.handlerContext, result);
  }
 },
 getCallbackInfoById: function (id) {
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].callbackId == id)
    return this.pendingCallbacks[i];
  }
 },
 getCallbacksInfoByState: function (state) {
  var result = [];
  for (var i in this.pendingCallbacks) {
   if (this.pendingCallbacks[i].state == state)
    result.push(this.pendingCallbacks[i]);
  }
  return result;
 },
 sendErrorToChildControl: function (callbackObj) {
  if (!this.hasPendingCallbacks())
   return;
  var callbackInfo = this.getCallbackInfoById(callbackObj.callbackId || 0);
  if (!callbackInfo)
   return;
  var hasChildControlHandler = (callbackInfo.handlerContext != this.owner) && callbackInfo.handlerContext.OnCallbackError;
  if (hasChildControlHandler)
   callbackInfo.handlerContext.OnCallbackError.call(callbackInfo.handlerContext, callbackObj.message, callbackObj.data);
 }
});
var AccessibilityHelperBase = ASPx.CreateClass(null, {
 constructor: function(control) {
  this.control = control;
  this.timerID = -1;
  this.pronounceMessageTimeout = 500;
  this.activeItem = this.getItems()[0];
  this.pronounceIsStarted = false;
 },
 PronounceMessage: function(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement) {   
  this.timerID = ASPx.Timer.ClearTimer(this.timerID);
  this.pronounceIsStarted = true;
  this.timerID = window.setTimeout(function() {
   this.PronounceMessageCore(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement);
  }.aspxBind(this), this.getPronounceTimeout());
 },
 PronounceMessageCore: function(text, activeItemArgs, inactiveItemArgs, mainElementArgs, ownerMainElement) {
  if(!this.getItems())
   return;
  this.toogleItem();
  var mainElement = this.getMainElement();
  var activeItem = this.getItem(true);
  var inactiveItem = this.getItem();
  if(ASPx.Attr.GetAttribute(mainElement, "role") != "application")
   mainElementArgs = this.addArguments(mainElementArgs, { "aria-activedescendant" : activeItem.id });
  var messageAttrObj = {};
  var activeItemRole = ASPx.Attr.GetAttribute(activeItem, "role");
  var attrName = activeItemRole == "combobox" ? "aria-label" : "innerHtml";
  messageAttrObj[attrName] = ASPx.Str.EncodeHtml(text);
  activeItemArgs = this.addArguments(activeItemArgs, messageAttrObj);
  messageAttrObj[attrName] = "";
  inactiveItemArgs = this.addArguments(inactiveItemArgs, messageAttrObj);
  var errorTextElement = null;
  if(this.control.GetErrorCell()) {
   errorTextElement = this.getAriaExplanatoryTextManager().GetErrorTextElement();
   activeItemArgs = this.addArguments(activeItemArgs,   {"aria-invalid"  : !this.control.isValid ? "true" : "" });
   mainElementArgs = this.addArguments(mainElementArgs, { "aria-invalid" : "" });
   inactiveItemArgs = this.addArguments(inactiveItemArgs,  { "aria-invalid" : "" });
  }
  this.changeActivityAttributes(activeItem, activeItemArgs);
  if(errorTextElement) {
   this.getAriaExplanatoryTextManager().SetOrRemoveText([activeItem], errorTextElement, !this.control.isValid, false, true);
   this.getAriaExplanatoryTextManager().SetOrRemoveText([mainElement, inactiveItem], errorTextElement, false, false, false);
  }
  this.changeActivityAttributes(mainElement, mainElementArgs);
  if(!!ownerMainElement && ASPx.Attr.GetAttribute(ownerMainElement, "role") != "application")
   this.changeActivityAttributes(ownerMainElement, { "aria-activedescendant": activeItem.id });
  this.changeActivityAttributes(inactiveItem, inactiveItemArgs);
  this.pronounceIsStarted = false;
 },
 GetActiveElement: function(inputIsMainElement) {
  if(this.pronounceIsStarted) return null;
  var mainElement = inputIsMainElement ? this.control.GetInputElement() : this.getMainElement();
  var activeElementId = ASPx.Attr.GetAttribute(mainElement, 'aria-activedescendant');
  return activeElementId ? ASPx.GetElementById(activeElementId) : mainElement;
 },
 getMainElement: function() {
  if(!ASPx.IsExistsElement(this.mainElement))
   this.mainElement = this.control.GetAccessibilityAssistantElement();
  return this.mainElement;
 },
 getItems: function() {
  if(!ASPx.IsExistsElement(this.items))
   this.items = ASPx.GetChildElementNodes(this.getMainElement());
  return this.items;
 },
 getItem: function(isActive) {
  if(isActive)
   return this.activeItem;
  var items = this.getItems();
  return items[0] === this.activeItem ? items[1] : items[0];
 },
 getAriaExplanatoryTextManager: function() { return this.control.ariaExplanatoryTextManager; },
 getPronounceTimeout: function() { return this.pronounceMessageTimeout; },
 toogleItem: function() {
  this.activeItem = this.getItem();
 },
 addArguments: function(targetArgs, newArgs) {
  if(!targetArgs) targetArgs = { };
  for(var key in newArgs) {
   if(newArgs.hasOwnProperty(key) && !targetArgs.hasOwnProperty(key))
    targetArgs[key] = newArgs[key];
  }
  return targetArgs;
 },
 changeActivityAttributes: function(element, args) {
  if(!element)
   return;
  for(var key in args) {
   if(args.hasOwnProperty(key)) {
    var value = args[key];
    if(key == "innerHtml")
     ASPx.SetInnerHtml(element, value);
    else {
     var action = value !== "" ? ASPx.Attr.SetAttribute : ASPx.Attr.RemoveAttribute;
     action(element, key, value);
    }
   }
  }
 }
});
var AccessibilityPronouncer = ASPx.CreateClass(null, {
 constructor: function() {
  this.pronouncerId = "dxPronouncer";
  this.initialized = false;
  this.focusableMessageElement = null;
  this.messageElement = null;
  this.pronouncers = {
   live: new AccessibilityLivePronouncer(this),
   descendant: new AccessibilityDescendantPronouncer(this)
  };
 },
 Pronounce: function(args, type) {
  this.pronouncers[type].Pronounce(args);
 },
 EnsureInitialize: function() {
  if(!this.initialized)
   this.initialize();
 },
 RemoveState: function() {
  for(var pronouncer in this.pronouncers)
   if(this.pronouncers.hasOwnProperty(pronouncer))
    pronouncer.RemoveState();
 },
 RestoreControlState: function(type, mainElement) {
  this.pronouncers[type].RestoreControlState(mainElement);
 },
 RestoreElementsState: function(type, elements) {
  this.pronouncers[type].RestoreElementsState(elements);
 },
 RestoreElementState: function(type, element) {
  this.pronouncers[type].RestoreElementState(element);
 },
 initialize: function() {
  this.createFocusableMessageElement();
  this.createMessageElement();
  this.prepareFocusableMessageElement();
  this.setAttributesForKeyboardNavigation();
  this.initialized = true;
 },
 createFocusableMessageElement: function() {
  var focusableMessageElement = document.createElement("DIV");
  document.body.appendChild(focusableMessageElement);
  this.focusableMessageElement = focusableMessageElement;   
 },
 prepareFocusableMessageElement: function() {
  this.focusableMessageElement.className = "dxAIFFE";
 },
 setAttributesForKeyboardNavigation: function() {
  ASPx.Attr.Aria.SetApplicationRole(this.focusableMessageElement);
  ASPx.Attr.Aria.SetSilence(this.focusableMessageElement);
 },
 createMessageElement: function() {
  var messageElement = document.createElement("DIV");
  messageElement.id = this.pronouncerId;
  ASPx.Attr.SetAttribute(messageElement, "role", "note");
  this.focusableMessageElement.appendChild(messageElement);
  this.messageElement = messageElement;
 },
 getMessage: function(messagePartsArg) {
  var messageParts = messagePartsArg.filter(function(x) { return ASPx.IsExists(x); });
  return messageParts.join(", ");
 }
});
var AccessibilityPronouncerBase = ASPx.CreateClass(null, {
 constructor: function() {
  this.state = { };
 },
 Pronounce: function(args) {
  var messageElement = this.getMessageElement();
  ASPx.Attr.Aria.SetOrRemoveLabel(messageElement);
  ASPx.SetInnerHtml(messageElement, "");
  this.PronounceCore(args);
 },
 PronounceCore: function(args) { },
 SaveElementState: function(element) { 
  if(this.state[element.id])
   return;
  this.state[element.id] = {
   element: element,
   descendant: ASPx.Attr.GetAttribute(element, ASPx.Attr.Aria.descendant)
  };
 },
 RemoveState: function() {
  this.state = { };
 },
 RestoreControlState: function(mainElement) { 
  for(var elementInfo in this.state) {
   if(this.state.hasOwnProperty(elementInfo)) {
    var element = this.state[elementInfo].element;
    if(!mainElement || ASPx.GetIsParent(mainElement, element))
     this.RestoreElementState(element);
   }
  }
 },
 RestoreElementsState: function(elements) { 
  for(var i = 0; i < elements.length; i++)
   this.RestoreElementState(elements[i]);
 },
 RestoreElementState: function(element) {
  var elementState = this.state[element.id];
  if(!elementState)
   return;
  ASPx.Attr.Aria.SetOrRemoveDescendant(element, elementState.descendant);
  delete this.state[element.id];
 },
 getMessage: function(args) {
  return ASPx.AccessibilityPronouncer.getMessage(args.messageParts);
 },
 getMessageElement: function() {
  return ASPx.AccessibilityPronouncer.messageElement;
 },
 getFocusableMessageElement: function() {
   return ASPx.AccessibilityPronouncer.focusableMessageElement;
 }
});
var AccessibilityLivePronouncer = ASPx.CreateClass(AccessibilityPronouncerBase, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
 },
 PronounceCore: function(args) {
  var message = this.getMessage(args);
  var messageElement = this.getMessageElement();
  ASPx.Attr.SetAttribute(this.getFocusableMessageElement(), "aria-live", "assertive");
  ASPx.Attr.Aria.SetAtomic(this.getFocusableMessageElement(), "true");
  ASPx.SetInnerHtml(messageElement, ASPx.Str.EncodeHtml(message));
 }
});
var AccessibilityDescendantPronouncer = ASPx.CreateClass(AccessibilityPronouncerBase, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
 },
 PronounceCore: function(args) {
  var message = this.getMessage(args);
  var activeElement = ASPx.GetActiveElement();
  var messageElement = this.getMessageElement();
  this.SaveElementState(activeElement);
  ASPx.Attr.RemoveAttribute(this.getFocusableMessageElement(), "aria-live");
  ASPx.Attr.RemoveAttribute(this.getFocusableMessageElement(), "aria-atomic");
  ASPx.Attr.Aria.SetOrRemoveLabel(messageElement, message);
  ASPx.Attr.Aria.SetOrRemoveDescendant(activeElement, messageElement.id);
 }
});
ASPx.AccessibilityPronouncerType = {
 live: "live",
 descendant: "descendant"
};
ASPx.AccessibilityPronouncer = new AccessibilityPronouncer();
var RestoreFocusHelper = ASPx.CreateClass(null, {
 constructor: function() {
  this.excludedIDs = [ "DXCBtn" ]; 
  this.pronouncerType = ASPx.AccessibilityPronouncerType.live;
  this.callbackQueue = [];
  this.Initialize();
 },
 Initialize: function() {
  var that = this;
  ASPx.attachToLoad(function() {
   ASPxClientControl.GetControlCollection().BeginCallback.AddHandler(that.OnBeginCallback, that);
   ASPxClientControl.GetControlCollection().EndCallback.AddHandler(that.OnEndCallback, that);
  });
 },
 OnBeginCallback: function(s, e) {
  var control = e.control;
  if(!control.allowRestoreFocusOnCallbacks())
   return;
  control.accessibilityFocusTreeLine = this.getFocusTreeLine(control);
  var controlHasCallbackTreeLine = this.callbackQueueContainsTreeLine(control);
  this.pushTreeLineInfoIntoCallbackQueue(control);
  if(control.accessibilityFocusTreeLine && !controlHasCallbackTreeLine)
   control.SendMessageToAssistiveTechnology(this.getDefaultCallbackMessage());
 },
 OnEndCallback: function(s, e) {
  var control = e.control;
  if(!control.allowRestoreFocusOnCallbacks())
   return;
  var treeLineInfo = this.shiftTreeLineInfoFromCallbackQueue(control);
  if(treeLineInfo.queueLength == 0) {
   if(!control.accessibilityFocusTreeLine && treeLineInfo.treeLine)
    control.accessibilityFocusTreeLine = treeLineInfo.treeLine;
   var focusElement = this.findFocusElement(control);
   var focusIsManagerByPopupwindow = this.isFocusManagedByActivePopupWindow(focusElement);
   var focusIsManagedByControl = control.shouldPreventFocusRestoringOnCallback && control.shouldPreventFocusRestoringOnCallback();
   if(!focusIsManagerByPopupwindow && !focusIsManagedByControl)
    ASPx.AccessibilityUtils.SetFocusAccessible(focusElement);
   delete control.accessibilityFocusTreeLine;
  }
 },
 pushTreeLineInfoIntoCallbackQueue: function(control) {
  var controlTreeLine = control.accessibilityFocusTreeLine ? control.accessibilityFocusTreeLine.slice(0) : null;
  if(!this.callbackQueue[control.name])
   this.callbackQueue[control.name] = [];
  this.callbackQueue[control.name].push(controlTreeLine);
 },
 shiftTreeLineInfoFromCallbackQueue: function(control) {
  var treeLineInfo = { queueLength: 0, treeLine: null };
  var treeLines = this.callbackQueue[control.name];
  if(treeLines && treeLines.length > 0) {
   treeLineInfo.treeLine = treeLines.shift();
   var linesCount = treeLines.length;
   treeLineInfo.queueLength = linesCount;
   if(linesCount > 0 && !treeLines[0] && treeLineInfo.treeLine)
    treeLines[0] = treeLineInfo.treeLine.slice(0);
  }
  return treeLineInfo;
 },
 callbackQueueContainsTreeLine: function(control) {
  var treeLines = this.callbackQueue[control.name];
  if(!treeLines || treeLines.length == 0) 
   return false;
  if(treeLines[treeLines.length - 1])
   return true;
  return false;
 },
 getDefaultCallbackMessage: function() {
  return ASPx.AccessibilitySR.DefaultCallbackMessage;
 },
 isFocusManagedByActivePopupWindow: function(focusElement) {
  var popupControl = this.getActivePopupControl();
  if(!popupControl || popupControl.accessibleFocusElement)
   return false;
  this.initializePopupAccessibleFocusElement(popupControl, focusElement);
  return popupControl.setFocusOnCallback;
 },
 getActivePopupControl: function() {
  var activePopupWindow = ASPx.GetPopupControlCollection && ASPx.GetPopupControlCollection().GetCurrentActiveWindowElement();
  if(!activePopupWindow)
   return null;
  var popupInfo = ASPx.GetPopupControlCollection().GetPopupWindowFromID(activePopupWindow.id);
  return popupInfo.popupControl;
 },
 initializePopupAccessibleFocusElement: function(popupControl, focusElement) {
  if(popupControl.setFocusOnCallback)
   popupControl.accessibleFocusElement = focusElement;
  else {
   var parentControl = popupControl.GetParentControl();
   if(parentControl && parentControl.GetMainElement())
    popupControl.accessibleFocusElement = ASPx.FindFirstChildActionElement(parentControl.GetMainElement());
  }
 },
 getFocusTreeLine: function(control) {
  var element = ASPx.GetActiveElement();
  if(!ASPx.IsExistsElement(element))
   return null;
  var mainElement = control.GetMainElement();
  if(!ASPx.GetIsParent(mainElement, element)) {
   var treeInfo = this.findFocusedControlElement(mainElement, element);
   element = treeInfo.focusElement;
   mainElement = treeInfo.rootElement;
  }
  return this.getTreeLineCore(mainElement, element);
 },
 getTreeLineCore: function(mainElement, element) {
  if(!element) return null;
  treeLine = [ ];
  while(element) {
   treeLine.push({ 
    id: element.id,
    tagName: element.tagName,
    index: ASPx.Data.ArrayIndexOf(element.parentNode.childNodes, element)
   });
   if(element === mainElement || element === document.body)
    break;
   element = element.parentNode;
  }
  return treeLine;
 },
 findFocusedControlElement: function(mainElement, activeElement) {
  var element = null;
  var parentElement = mainElement;
  var focusedEditor = ASPx.IsExists(ASPx.GetFocusedEditor) ? ASPx.GetFocusedEditor() : null;
  if(focusedEditor && ASPx.GetIsParent(mainElement, focusedEditor.GetMainElement()))
   element = focusedEditor.GetFocusableInputElement();
  else {
   if(mainElement && activeElement) {
    var mainControl = ASPx.GetClientControlByElementID(mainElement.id);
    var parentControls = ASPx.GetParentClientControls(activeElement.id);
    for(var i = parentControls.length - 1; i > -1; i--) {   
     if(mainControl.name == parentControls[i].name) {
      element = activeElement;
      var rootIndex = i > 0 ? i - 1 : i;
      parentElement = parentControls[rootIndex].GetMainElement();
      if(!parentElement && parentControls[rootIndex].GetCurrentWindowElement)
       parentElement = parentControls[rootIndex].GetCurrentWindowElement();
      break;
     }
    }
   }
  }
  return { focusElement: element, rootElement: parentElement }; 
 },
 findFocusElement: function(control) {
  if(!control.accessibilityFocusTreeLine)
   return;
  var treeLine = control.accessibilityFocusTreeLine.slice(0);
  var focusElementParent = this.findFocusElementParentById(treeLine);
  if(!focusElementParent) 
   return;
  return this.findFocusElementFromDOMTree(treeLine, focusElementParent);
 },
 findFocusElementParentById: function(treeLine) {
  for(var i = 0; i < treeLine.length; i++) {
   var id = treeLine[i].id;
   if(!this.isValidId(id))
    continue;
   var element = document.getElementById(id);
   if(element) {
    treeLine.splice(i, treeLine.length - i);
    treeLine.reverse();
    return element;
   }
  }
  return null;
 },
 findFocusElementFromDOMTree: function(treeLine, focusElementParent) {
  var element = focusElementParent;
  for(var i = 0; i < treeLine.length; i++) {
   var info = treeLine[i];
   if(info.index >= element.childNodes.length) {
    element = element.childNodes.length > 0 ? element.childNodes[element.childNodes.length - 1] : null;
    return this.findNeighbourFocusElement(element, focusElementParent);
   }
   var child = element.childNodes[info.index];
   if(child.tagName !== info.tagName)
    return this.findNeighbourFocusElement(child, focusElementParent);
   element = child;
  }
  return element;
 },
 findNeighbourFocusElement: function(element, focusElementParent) {
  if(!element || !element.parentNode) return null;
  var neighbours = element.parentNode.childNodes;
  var indices = this.calcLeftRightIndices(ASPx.Data.ArrayIndexOf(neighbours, element), neighbours.length);
  for(var i = 0; i < indices.length; i++) {
   var index = indices[i];
   var actionElement = ASPx.FindFirstChildActionElement(neighbours[index]);
   if(actionElement)
    return actionElement;
  }
  if(element === focusElementParent)
   return null;
  return this.findNeighbourFocusElement(element.parentNode, focusElementParent);
 },
 calcLeftRightIndices: function(startIndex, count) {
  var indices = [ ];
  var incSides = [ 0, 0 ];
  var index = startIndex;
  for(var i = 0; i < count; i++) {
   indices.push(index);
   var even = i % 2 === 0;
   var nextIndex = this.calcNextIndex(startIndex, count, incSides, even);
   if(nextIndex < 0)
    nextIndex = this.calcNextIndex(startIndex, count, incSides, !even);
   index = nextIndex;
  }
  return indices;
 },
 calcNextIndex: function(startIndex, count, incSides, even) {
  var sideIndex = even ? 0 : 1;
  var inc = incSides[sideIndex];
  inc += even ? -1 : 1;
  var nextIndex = startIndex + inc;
  if(nextIndex >= 0 && nextIndex < count) {
   incSides[sideIndex] = inc;
   return nextIndex;
  }
  return -1;
 },
 isValidId: function(id) {
  return id && !this.isExcludedId(id);
 },
 isExcludedId: function(id) {
  var result = false;
  for(var i = 0; i < this.excludedIDs.length; i++) {
   if(id.indexOf(this.excludedIDs[i]) > -1) {
    result = true;
    break;
   }
  }
  return result;
 }
});
var EventStorage = ASPx.CreateClass(null, {
 constructor: function() {
  this.bag = { };
 },
 Save: function(e, data, overwrite) {
  var key = this.getEventKey(e);
  if(this.bag.hasOwnProperty(key) && !overwrite)
   return;
  this.bag[key] = data;
  window.setTimeout(function() { delete this.bag[key]; }.aspxBind(this), 100);
 },
 Load: function(e) {
  var key = this.getEventKey(e);
  return this.bag[key];
 },
 getEventKey: function(e) {
  if(ASPx.IsExists(e.timeStamp))
   return e.timeStamp.toString();
  var eventSource = ASPx.Evt.GetEventSource(e);
  var type = e.type.toString();
  return eventSource ? type + "_" + eventSource.uniqueID.toString() : type;
 }
});
ASPx.RestoreFocusHelper = new RestoreFocusHelper();
EventStorage.Instance = null;
EventStorage.getInstance = function() {
 if(!EventStorage.Instance)
  EventStorage.Instance = new EventStorage();
 return EventStorage.Instance;
};
var GetGlobalObject = function(objectName) {
 var fields = objectName.split('.');
 var obj = window[fields[0]];
 for(var i = 1; obj && i < fields.length; i++) {
  obj = obj[fields[i]];
 }
 return obj;
};
var GetExternalScriptProcessor = function() {
 return ASPx.ExternalScriptProcessor ? ASPx.ExternalScriptProcessor.getInstance() : null;
};
var SAVED_WIDTH_ATTR = "data-dx-ripple-saved-width";
var RIPPLE_FIXED_ROW_ATTR = "data-dx-ripple-locked";
var READ_ONLY_COMBOBOX_MARKER_CSS_CLASS = "dxICBReadonlyMarker";
var ThemesWithRipple = ['Material'];
var RippleHelper = {
 rippleTargetClassName: "dxRippleTarget",
 rippleTargetExternalClassName: "dxRippleTargetExternal",
 rippleContainerClassName: "dxRippleContainer",
 rippleClassName: "dxRipple",
 touchRadius: -1,
 isMobileExternalRipple: null,
 zoom: 1,
 Init: function() {
  if(this.getIsRippleFunctionalityEnabled()) {
   setTimeout(function() {
    this.calcTouchRadius();
   }.aspxBind(this), 0);
  }
 },
 calcTouchRadius: function() {
  var testBlock = document.createElement("DIV");
  ASPx.SetStyles(testBlock, {
   height: "1in",
   width: "1in",
   left: "-100%",
   top: "-100%",
   position: "absolute"
  });
  document.body.appendChild(testBlock);
  this.touchRadius = (1.8 / 2.54) * Math.max(testBlock.offsetWidth, testBlock.offsetHeight);
  document.body.removeChild(testBlock);
 },
 isRippleFunctionalityEnabled: null,
 checkRippleFunctionality: function() {
  if(ASPx.Browser.Safari && ASPx.Browser.Version <= 5.1)
   return false;
  for(var i = 0; i < ThemesWithRipple.length; i++) {
   var firstRippleThemeElement = document.querySelector("[class*='_" + ThemesWithRipple[i] + "']");
   if(firstRippleThemeElement)
    return true;
  }  
  return false;
 },
 ReInit: function() {
  this.isRippleFunctionalityEnabled = null;
  this.Init();
 },
 onDocumentMouseDown: function(evt) {
  if(RippleHelper.getIsRippleFunctionalityEnabled())
   RippleHelper.processMouseDown(evt);
 },
 getIsRippleFunctionalityEnabled: function() {
  if(!ASPx.IsExists(this.isRippleFunctionalityEnabled))
   this.isRippleFunctionalityEnabled = this.checkRippleFunctionality();
  return this.isRippleFunctionalityEnabled;
 },
   createTargetInfo: function(target) {
  return { 
   x: ASPx.GetAbsoluteX(target),
   y: ASPx.GetAbsoluteY(target),
   width: target.offsetWidth,
   height: target.offsetHeight,
   classNames: ASPx.GetClassNameList(target),
   getTarget: function() { return target; },
   getRect: function() { return {x: this.x, y: this.y, width: this.width, height: this.height }; }
  };
 },
 createEventInfo: function(evt) {
  return { x: this.getEventX(evt), y: this.getEventY(evt) };
 },
 processMouseDown: function(evt) {
  var evtSource = ASPx.Evt.GetEventSource(evt);
  var rippleTarget = this.getRippleTargetElement(evtSource);
  if(this.needToProcessRipple(rippleTarget, evtSource))
   this.processRipple(this.createTargetInfo(rippleTarget), this.createEventInfo(evt));
 },
 getRippleTargetElement: function(evtSource) {
  if(this.hasRippleMarker(evtSource))
   return evtSource;
  if(evtSource.tagName && evtSource.tagName.toLowerCase() == "input" && ASPx.ElementContainsCssClass(evtSource, "dxTI")) {
   var elements = ASPx.GetChildElementNodesByPredicate(evtSource.parentNode.parentNode, function(element) {
    return this.hasRippleMarker(element);
   }.aspxBind(this));
   return elements && elements[0];
  }
  return ASPx.GetParent(evtSource, function(element) {
   return this.hasRippleMarker(element);
  }.aspxBind(this));
 },
 hasRippleMarker: function(element) {
  if(!ASPx.IsExistsElement(element))
   return false;
  var computedStyles = window.getComputedStyle(element, ":before");
  if(ASPx.IsExists(computedStyles)) {
   var content = computedStyles.getPropertyValue("content");
   if(content.indexOf(this.rippleTargetExternalClassName) > -1) {
    ASPx.AddClassNameToElement(element, this.rippleTargetExternalClassName);
    return true;
   }
   return content.indexOf(this.rippleTargetClassName) > -1;
  }
  return false;
 },
 needToProcessRipple: function(rippleTarget, evtSource) {
  if(!rippleTarget || !ASPx.AnimationUtils)
   return false;
  var isClearButton = ASPx.ElementContainsCssClass(rippleTarget, "dxeButton") && rippleTarget.id && rippleTarget.id.indexOf("B-100") !== -1;
  var isEmptyCalendarDay = ASPx.ElementContainsCssClass(rippleTarget, "dxeCalendarDay") && ASPx.Str.Trim(rippleTarget.textContent) == "";
  var isReadonly = ASPx.ElementContainsCssClass(rippleTarget, READ_ONLY_COMBOBOX_MARKER_CSS_CLASS);
  var tempFixDisable = ASPx.ElementContainsCssClass(rippleTarget, "dxSwitcher") && ASPx.Browser.MacOSMobilePlatform;
  var rippleIsForbidden = isReadonly || isClearButton || isEmptyCalendarDay || ASPx.GetParentByPartialClassName(rippleTarget, "Disabled") ||
   ASPx.ElementContainsCssClass(rippleTarget, "dxgvBatchEditCell") || ASPx.ElementContainsCssClass(rippleTarget, "dxcvEditForm") ||
   ASPx.GetParentByPartialClassName(evtSource, "dxcvFocusedCell") || tempFixDisable;
  return !rippleIsForbidden;
 },
 hasBothOverflow: function(style) {
  return style.overflow == "scroll" || style.overflow == "auto" || style.overflow == "hidden";
 },
 hasOverflowX: function(style) {
  return style.overflowX == "scroll" || style.overflowX == "auto" || style.overflowX == "hidden";
 },
 hasOverflowY: function(style) {
  return style.overflowY == "scroll" || style.overflowY == "auto" || style.overflowY == "hidden";
 },
 getExternalRippleContainerSize: function(targetRect) {
  if(ASPx.Browser.MobileUI) {
   var origTouchRadius = this.getOriginTouchRadius();
   if(origTouchRadius < targetRect.width || origTouchRadius < targetRect.height)
    origTouchRadius = Math.max(targetRect.width, targetRect.height);
   return {x: targetRect.x + (targetRect.width - origTouchRadius) / 2, y: targetRect.y + (targetRect.height - origTouchRadius) / 2, width: origTouchRadius, height: origTouchRadius };
  }
  var result = { x: 0, y: 0, width: 0, height: 0 };
  var diff = targetRect.width - targetRect.height;
  if(diff > 0) {
   result.x = targetRect.x;
   result.y = targetRect.y - diff / 2;
   result.width = targetRect.width;
   result.height = targetRect.width;
  } else {
   result.x = targetRect.x + diff / 2;
   result.y = targetRect.y;
   result.width = targetRect.height;
   result.height = targetRect.height;
  }
  return result;
 },
 getInternalContainerSize: function(targetInfo) {
  var parentWithOverflow = RippleHelper.getParentWithOverflow(targetInfo.getTarget());
  if(!ASPx.IsExists(parentWithOverflow))
   return targetInfo;
  var parentWithOverflowStyle = ASPx.GetCurrentStyle(parentWithOverflow);
  var bothOverflow = this.hasBothOverflow(parentWithOverflowStyle);
  var overflowX = this.hasOverflowX(parentWithOverflowStyle);
  var overflowY = this.hasOverflowY(parentWithOverflowStyle);
  var parentRect = {
   x: ASPx.GetAbsoluteX(parentWithOverflow),
   y: ASPx.GetAbsoluteY(parentWithOverflow),
   width: parentWithOverflow.offsetWidth,
   height: parentWithOverflow.offsetHeight
  };
  return this.getInternalContainerSizeCore(targetInfo, parentRect, bothOverflow, overflowX, overflowY);
 },
 getInternalContainerSizeCore: function(targetRect, parentRect, bothOverflow, overflowX, overflowY) {
  var result = {};
  ASPx.Data.MergeHashTables(result, targetRect);
  if(bothOverflow || overflowX) {
   result.x = targetRect.x < parentRect.x ? parentRect.x : targetRect.x;
   if(targetRect.x + targetRect.width > parentRect.x + parentRect.width)
    result.width = parentRect.x + parentRect.width - targetRect.x;
   if(parentRect.x > targetRect.x)
    result.width -= (parentRect.x - targetRect.x);
  }
  if(bothOverflow || overflowY) {
   result.y = targetRect.y < parentRect.y ? parentRect.y : targetRect.y;
   if(targetRect.y + targetRect.height > parentRect.y + parentRect.height)
    result.height = parentRect.y + parentRect.height - targetRect.y;
   if(parentRect.y > targetRect.y)
    result.height -= (parentRect.y - targetRect.y);
  }
  return result;
 },
 calculateRippleContainerSize: function(targetInfo, isExternalRipple) {
  return isExternalRipple ? this.getExternalRippleContainerSize(targetInfo) : this.getInternalContainerSize(targetInfo);
 },
 getParentWithOverflow: function(rippleTarget) {
  var result = ASPx.GetParent(rippleTarget, function(element) {
   var elementStyle = ASPx.GetCurrentStyle(element);
   return this.hasBothOverflow(elementStyle) || this.hasOverflowX(elementStyle) || this.hasOverflowY(elementStyle);
  }.aspxBind(this));
  return result;
 },
 getDuration: function(targetInfo) {
  return this.IsExternalRipple(targetInfo) || ASPx.Browser.MobileUI ? 650 : 450;
 },
 createRippleTransition: function(container, rippleElement, radius, targetInfo) {
  var rippleSize = 2 * radius;
  var transitionEndIsAborted = true;
  var transitionProperties = {
   width: { from: 0, to: rippleSize, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "width", unit: "px" },
   height: { from: 0, to: rippleSize, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "height", unit: "px" },
   marginLeft: { from: 0, to: -rippleSize / 2, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "marginLeft", unit: "px" },
   marginTop: { from: 0, to: -rippleSize / 2, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "marginTop", unit: "px" },
   opacity: { from: 1, to: 0.05, transition: ASPx.AnimationConstants.Transitions.RIPPLE, propName: "opacity", unit: "%" }
  };
  var rippleTransition = ASPx.AnimationUtils.createMultipleAnimationTransition(rippleElement, {
   transition: ASPx.AnimationConstants.Transitions.RIPPLE,
   duration: this.getDuration(targetInfo),
   onComplete: function() {
    this.RemoveRippleContainer(container.parentElement);
    transitionEndIsAborted = false;
   }.bind(this)
  });
  rippleTransition.Start(transitionProperties);
  window.setTimeout(function() {
   if(transitionEndIsAborted)
    this.RemoveRippleContainer(container.parentElement);
  }.bind(this), 500);
 },
 calculateRadius: function(isExternalRipple, posX, posY, containerRect) {
  var radius = -1;
  if(isExternalRipple) {
   if(ASPx.Browser.MobileUI)
    radius = this.getOriginTouchRadius() / 2;
   else
    radius = Math.max(containerRect.height, containerRect.width);
  } else {
   var width1 = posX - containerRect.x;
   var width2 = containerRect.width - width1;
   var height1 = posY - containerRect.y;
   var height2 = containerRect.height - height1;
   var rippleWidth = Math.max(width1, width2);
   var rippleHeight = Math.max(height1, height2);
   radius = Math.sqrt(Math.pow(rippleHeight, 2) + Math.pow(rippleWidth, 2));
  }
  return radius;
 },
 createRippleElement: function(container, rippleCenter) {
  var rippleElement = document.createElement("DIV");
  rippleElement.className = this.rippleClassName;
  container.appendChild(rippleElement);
  ASPxClientUtils.SetAbsoluteX(rippleElement, rippleCenter.x);
  ASPxClientUtils.SetAbsoluteY(rippleElement, rippleCenter.y);
  return rippleElement;
 },
 processRipple: function(targetInfo, eventInfo) {
  this.initRippleProcess();
  var isExternalRipple = this.IsExternalRipple(targetInfo);
  var rippleCenter = this.getRippleCenter(targetInfo.getRect(), eventInfo, isExternalRipple);
  var container = this.createRippleContainer(targetInfo, isExternalRipple);
  var rippleElement = this.createRippleElement(container, rippleCenter);
  var radius = this.calculateRadius(isExternalRipple, rippleCenter.x, rippleCenter.y, this.getElementRect(container));
  this.createRippleTransition(container, rippleElement, radius, targetInfo);
 },
 initRippleProcess: function() {
  this.isMobileExternalRipple = null;
  this.zoom = screen.width / window.innerWidth;
 },
 getRippleCenter: function(targetInfo, eventInfo, isExternalRipple) {
  var posX = 0;
  var posY = 0;
  if(isExternalRipple) {
   posX = targetInfo.x + targetInfo.width / 2;
   posY = targetInfo.y + targetInfo.height / 2;
  } else {
   posX = eventInfo.x;
   posY = eventInfo.y;
  }
  return {x: posX, y: posY};
 },
 createRippleContainer: function(targetInfo, isExternalRipple) {
  var containerParent = targetInfo.getTarget();
  if(!containerParent)
   return;
  var containerTagName = containerParent.tagName == "TR" ? "TD" : "DIV";
  var container = document.createElement(containerTagName);
  container.className = this.rippleContainerClassName;
  if(containerParent.parentNode && containerParent.tagName == "IMG")
   containerParent = containerParent.parentNode;
  if(this.isARowInFixedLayoutTable(containerParent))
   this.lockFixedLayoutTableSizes(containerParent);
  containerParent.appendChild(container);
  if(isExternalRipple)
   container.style.borderRadius = "50%";
  var containerRect = this.calculateRippleContainerSize(targetInfo, isExternalRipple);
  this.assignContainerSettings(container, containerRect);
  return container;
 },
 isARowInFixedLayoutTable: function(containerParent) {
  if(containerParent.tagName !== "TR")
   return false;
  var parentTable = this.getParentTable(containerParent);
  return parentTable && ASPx.GetCurrentStyle(parentTable)["table-layout"] === "fixed";
 },
 processFirstRowOfFixedTable: function(containerRow, rowAction, cellAction) {
  var firstRow = this.getFirstRow(containerRow);
  rowAction(firstRow);
  var cells = ASPx.Data.CollectionToArray(firstRow.cells);
  cells.forEach(cellAction);
 },
 getParentTable: function(element) {
  var parentTable = element;
  while(parentTable && parentTable.tagName !== "TABLE")
   parentTable = parentTable.parentElement;
  return parentTable;
 },
 lockFixedLayoutTableSizes: function(containerRow) {
  var firstRow = this.getFirstRow(containerRow);
  if(this.incLockCount(firstRow) === 1) {
   var cells = ASPx.Data.CollectionToArray(firstRow.cells);
   var widths = cells.map(function(cell) { return cell.style.width; });
   var computedWidths = cells.map(function(cell) {
    if(ASPx.Browser.IE && ASPx.ElementHasCssClass(cell, "dxeCM"))
     return cell.offsetWidth + "px";
    return window.getComputedStyle(cell).width;
   });
   var fixWidth = function(cell, i) {
    if(ASPx.Attr.IsExistsAttribute(cell, SAVED_WIDTH_ATTR))
     return;
    if(widths[i])
     ASPx.Attr.SetAttribute(cell, SAVED_WIDTH_ATTR, widths[i]);
    cell.style.width = computedWidths[i];
   };
   cells.forEach(fixWidth);
  }
 }, 
 unlockFixedLayoutTableSizes: function(containerRow) {
  var firstRow = this.getFirstRow(containerRow);   
  if(this.decLockCount(firstRow) === 0) {
   var cells = ASPx.Data.CollectionToArray(firstRow.cells);
   var restoreState = function(cell) {
    if(ASPx.Attr.IsExistsAttribute(cell, SAVED_WIDTH_ATTR)) {
     cell.style.width = ASPx.Attr.GetAttribute(cell, SAVED_WIDTH_ATTR);
     ASPx.Attr.RemoveAttribute(cell, SAVED_WIDTH_ATTR);
    } else {
     cell.style.width = null;
    }
   };
   cells.forEach(restoreState);
  }
 },
 getFirstRow: function(containerRow) { return ASPx.GetChildByTagName(containerRow.parentElement, "TR", 0); },
 incLockCount: function(elem) { return this.changeLockCount(elem, 1); },
 decLockCount: function(elem) { return this.changeLockCount(elem, -1); },
 changeLockCount: function(elem, diff) {
  var lockCounter = this.getLockCount(elem);
  lockCounter += diff;
  lockCounter = Math.max(0, lockCounter);
  if(lockCounter === 0)
   ASPx.Attr.RemoveAttribute(elem, RIPPLE_FIXED_ROW_ATTR);
  else
   ASPx.Attr.SetAttribute(elem, RIPPLE_FIXED_ROW_ATTR, lockCounter);
  return lockCounter;
 },
 getLockCount: function(lockElement) {
  var attrValue = ASPx.Attr.GetAttribute(lockElement, RIPPLE_FIXED_ROW_ATTR);
  return parseInt(attrValue) || 0;
 },
 assignContainerSettings: function(container, containerRect) {
  var properties = {
   height: containerRect.height,
   width: containerRect.width,
   left: ASPx.PrepareClientPosForElement(containerRect.x, container, true),
   top: ASPx.PrepareClientPosForElement(containerRect.y, container, false)
  };
  if(ASPx.Browser.MobileUI)
   ASPx.Data.MergeHashTables(properties, {marginTop: 0, marginLeft: 0 });
  ASPx.SetStyles(container, properties, ASPx.Browser.MobileUI);
 },
 IsExternalRipple: function(targetInfo) {
  var hasExternalRippleClassName = ASPx.ElementContainsCssClass(targetInfo.getTarget(), this.rippleTargetExternalClassName);
  if(!ASPx.Browser.MobileUI)
   return hasExternalRippleClassName;
  return hasExternalRippleClassName || this.IsMobileExternalRipple(targetInfo);
 },
 IsMobileExternalRipple: function(targetInfo) {
  if(this.isMobileExternalRipple == null) {
   var originTouchRadius = this.getOriginTouchRadius();
   this.isMobileExternalRipple = ASPx.Browser.MobileUI && targetInfo.width < originTouchRadius && targetInfo.height < originTouchRadius;
  }
  return this.isMobileExternalRipple;
 },
 RemoveRippleContainer: function(element) {
  if(!element)
   return;
  var childs = ASPx.GetChildNodesByClassName(element, this.rippleContainerClassName);
  var rippleContainer = childs.length > 0 ? childs[0] : null;
  if(rippleContainer != null) {
   var containerParent = rippleContainer.parentNode;
   containerParent.removeChild(rippleContainer);
   if(this.isARowInFixedLayoutTable(containerParent))
    this.unlockFixedLayoutTableSizes(containerParent);
  }
 },
 getEventX: function(evt) {
  return ASPxClientUtils.GetEventX(evt);
 },
 getEventY: function(evt) {
  return ASPxClientUtils.GetEventY(evt);
 },
 getOriginTouchRadius: function() {
  return this.touchRadius / this.zoom;
 },
 getElementRect: function(element) {
  return { x: ASPx.GetAbsoluteX(element), y: ASPx.GetAbsoluteY(element), width: element.offsetWidth, height: element.offsetHeight };
 }
};
var AccessibilitySR = {
 AddStringResources: function(stringResourcesObj) {
  if(stringResourcesObj) {
   for(var key in stringResourcesObj)
    if(stringResourcesObj.hasOwnProperty(key))
     this[key] = stringResourcesObj[key];
  }
 }
};
ASPx.CollectionBase = CollectionBase;
ASPx.FunctionIsInCallstack = _aspxFunctionIsInCallstack;
ASPx.RaisePostHandlerOnPost = aspxRaisePostHandlerOnPost;
ASPx.GetPostHandler = aspxGetPostHandler;
ASPx.ProcessScriptsAndLinks = _aspxProcessScriptsAndLinks;
ASPx.InitializeLinks = _aspxInitializeLinks;
ASPx.InitializeScripts = _aspxInitializeScripts;
ASPx.RunStartupScripts = _aspxRunStartupScripts;
ASPx.IsStartupScriptsRunning = _aspxIsStartupScriptsRunning;
ASPx.AddScriptsRestartHandler = _aspxAddScriptsRestartHandler;
ASPx.GetFocusedElement = _aspxGetFocusedElement;
ASPx.GetDomObserver = _aspxGetDomObserver;
ASPx.CacheHelper = CacheHelper;
ASPx.ControlTree = ControlTree;
ASPx.ControlAdjuster = ControlAdjuster;
ASPx.GetControlAdjuster = GetControlAdjuster;
ASPx.ControlCallbackHandlersQueue = ControlCallbackHandlersQueue;
ASPx.ResourceManager = ResourceManager;
ASPx.UpdateWatcherHelper = UpdateWatcherHelper;
ASPx.EventStorage = EventStorage;
ASPx.GetGlobalObject = GetGlobalObject;
ASPx.GetExternalScriptProcessor = GetExternalScriptProcessor;
ASPx.CheckBoxCheckState = CheckBoxCheckState;
ASPx.CheckBoxInputKey = CheckBoxInputKey;
ASPx.CheckableElementStateController = CheckableElementStateController;
ASPx.CheckableElementHelper = CheckableElementHelper;
ASPx.CheckBoxInternal = CheckBoxInternal;
ASPx.CheckBoxInternalCollection = CheckBoxInternalCollection;
ASPx.ControlCallbackQueueHelper = ControlCallbackQueueHelper;
ASPx.FocusedStyleDecoration = FocusedStyleDecoration;
ASPx.EditorStyleDecoration = EditorStyleDecoration;
ASPx.TextEditorStyleDecoration = TextEditorStyleDecoration;
ASPx.AccessibilitySR = AccessibilitySR;
ASPx.KbdHelper = KbdHelper;
ASPx.AccessKeysHelper = AccessKeysHelper;
ASPx.AccessKey = AccessKey;
ASPx.IFrameHelper = IFrameHelper;
ASPx.Ident = Ident;
ASPx.TouchUIHelper = TouchUIHelper;
ASPx.ControlUpdateWatcher = ControlUpdateWatcher;
ASPx.ControlTabIndexManager = ControlTabIndexManager;
ASPx.AccessibilityHelperBase = AccessibilityHelperBase;
ASPx.RippleHelper = RippleHelper;
ASPx.ThemesWithRipple = ThemesWithRipple;
window.ASPxClientEvent = ASPxClientEvent;
window.ASPxClientEventArgs = ASPxClientEventArgs;
window.ASPxClientCancelEventArgs = ASPxClientCancelEventArgs;
window.ASPxClientProcessingModeEventArgs = ASPxClientProcessingModeEventArgs;
window.ASPxClientProcessingModeCancelEventArgs = ASPxClientProcessingModeCancelEventArgs;
ASPx.Evt.AttachEventToDocument(TouchUIHelper.touchMouseDownEventName, RippleHelper.onDocumentMouseDown);
ASPx.classesScriptParsed = true;
})(ASPx, { GCCheckInterval: 5000 });

(function () {
ASPx.StateItemsExist = false;
ASPx.FocusedItemKind = "FocusedStateItem";
ASPx.HoverItemKind = "HoverStateItem";
ASPx.PressedItemKind = "PressedStateItem";
ASPx.SelectedItemKind = "SelectedStateItem";
ASPx.DisabledItemKind = "DisabledStateItem";
ASPx.ReadOnlyItemKind = "ReadOnlyStateItem";
ASPx.CachedStatePrefix = "cached";
ASPxStateItem = ASPx.CreateClass(null, {
 constructor: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink){
  this.name = name;
  this.classNames = classNames;
  this.customClassNames = [];
  this.resultClassNames = [];
  this.cssTexts = cssTexts;
  this.postfixes = postfixes;
  this.imageObjs = imageObjs;
  this.imagePostfixes = imagePostfixes;
  this.kind = kind;
  this.classNamePostfix = kind.substr(0, 1).toLowerCase();
  this.enabled = true;
  this.needRefreshBetweenElements = false;
  this.elements = null;
  this.images = null;
  this.links = [];
  this.linkColor = null;
  this.linkTextDecoration = null;
  this.disableApplyingStyleToLink = !!disableApplyingStyleToLink; 
 },
 GetCssText: function(index){
  if(ASPx.IsExists(this.cssTexts[index]))
   return this.cssTexts[index];
  return this.cssTexts[0];
 },
 CreateStyleRule: function(index){
  if(this.GetCssText(index) == "") return "";
  var styleSheet = ASPx.GetCurrentStyleSheet();
  if(styleSheet)
   return ASPx.CreateImportantStyleRule(styleSheet, this.GetCssText(index), this.classNamePostfix);  
  return ""; 
 },
 GetClassName: function(index){
  if(ASPx.IsExists(this.classNames[index]))
   return this.classNames[index];
  return this.classNames[0];
 },
 GetResultClassName: function(index){
  if(!ASPx.IsExists(this.resultClassNames[index])) {
   if(!ASPx.IsExists(this.customClassNames[index]))
    this.customClassNames[index] = this.CreateStyleRule(index);
   if(this.GetClassName(index) != "" && this.customClassNames[index] != "")
    this.resultClassNames[index] = this.GetClassName(index) + " " + this.customClassNames[index];
   else if(this.GetClassName(index) != "")
    this.resultClassNames[index] = this.GetClassName(index);
   else if(this.customClassNames[index] != "")
    this.resultClassNames[index] = this.customClassNames[index];
   else
    this.resultClassNames[index] = "";
  }
  return this.resultClassNames[index];
 },
 GetElements: function(element){
  if(!this.elements || !ASPx.IsValidElements(this.elements)){
   if(this.postfixes && this.postfixes.length > 0){
    this.elements = [ ];
    var parentNode = element.parentNode;
    if(parentNode){
     for(var i = 0; i < this.postfixes.length; i++){
      var id = this.name + this.postfixes[i];
      this.elements[i] = ASPx.GetChildById(parentNode, id);
      if(!this.elements[i])
       this.elements[i] = ASPx.GetElementById(id);
     }
    }
   }
   else
    this.elements = [element];
  }
  return this.elements;
 },
 GetImages: function(element){
  if(!this.images || !ASPx.IsValidElements(this.images)){
   this.images = [ ];
   if(this.imagePostfixes && this.imagePostfixes.length > 0){
    var elements = this.GetElements(element);
    for(var i = 0; i < this.imagePostfixes.length; i++){
     var id = this.name + this.imagePostfixes[i];
     for(var j = 0; j < elements.length; j++){
      if(!elements[j]) continue;
      if(elements[j].id == id)
       this.images[i] = elements[j];
      else
       this.images[i] = ASPx.GetChildById(elements[j], id);
      if(this.images[i])
       break;
     }
    }
   }
  }
  return this.images;
 },
 Apply: function(element){
  if(!this.enabled) return;
  try{
   this.ApplyStyle(element);
   if(this.imageObjs && this.imageObjs.length > 0)
    this.ApplyImage(element);
   if(ASPx.Browser.IE && ASPx.Browser.MajorVersion >= 11 && ASPx.Browser.PlaformMajorVersion < 10)
    this.ForceRedrawAppearance(element);
  }
  catch(e){
  }
 },
 ApplyStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   if(this.GetResultClassName(i) != "") {
    var className = elements[i].className.replace(this.GetResultClassName(i), "");
    elements[i].className = ASPx.Str.Trim(className) + " " + this.GetResultClassName(i);
   }
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.ApplyStyleToLinks(elements, i);
  }
 },
 ApplyStyleToLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.ApplyStyleToLinkElement(this.links[index][i], index);
 },
 ApplyStyleToLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color", this.GetLinkColor(index));
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.ChangeAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration", this.GetLinkTextDecoration(index));
 },
 ApplyImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   var useSpriteImage = typeof(this.imageObjs[i]) != "string";
   var newUrl = "", newCssClass = "", newBackground = "";
   if(useSpriteImage){
    newUrl = ASPx.EmptyImageUrl;           
    if(this.imageObjs[i].spriteCssClass) 
     newCssClass = this.imageObjs[i].spriteCssClass;
    if(this.imageObjs[i].spriteBackground)
     newBackground = this.imageObjs[i].spriteBackground;
   }
   else{
    newUrl = this.imageObjs[i];
    if(ASPx.Attr.IsExistsAttribute(images[i].style, "background"))   
     newBackground = " ";
   }
   if(newUrl != "")
    ASPx.Attr.ChangeAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src", newUrl);
   if(newCssClass != "")
    this.ApplyImageClassName(images[i], newCssClass);
   if(newBackground != ""){
    if(ASPx.Browser.WebKitFamily) {
     var savedBackground = ASPx.Attr.GetAttribute(images[i].style, "background");
     if(!useSpriteImage)
      savedBackground += " " + images[i].style["backgroundPosition"];
     ASPx.Attr.SetAttribute(images[i], "saved" + this.kind + "Background", savedBackground);
     ASPx.Attr.SetAttribute(images[i].style, "background", newBackground);
    }
    else
     ASPx.Attr.ChangeAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background", newBackground);
   }     
  }
 },
 ApplyImageClassName: function(element, newClassName){
  if(ASPx.Attr.GetAttribute(element, "saved" + this.kind + "ClassName"))
   this.CancelImageClassName(element);
  var className = element.className;
  ASPx.Attr.SetAttribute(element, "saved" + this.kind + "ClassName", className);
  element.className = className + " " + newClassName;
 },
 Cancel: function(element){
  if(!this.enabled) return;
  try{  
   if(this.imageObjs && this.imageObjs.length > 0)
    this.CancelImage(element);
   this.CancelStyle(element);
  }
  catch(e){
  }
 },
 CancelStyle: function(element){
  var elements = this.GetElements(element);
  for(var i = 0; i < elements.length; i++){
   if(!elements[i]) continue;
   if(this.GetResultClassName(i) != "") {
    var className = ASPx.Str.Trim(elements[i].className.replace(this.GetResultClassName(i), ""));
    elements[i].className = className;
   }
   if(!ASPx.Browser.Opera || ASPx.Browser.Version >= 9)
    this.CancelStyleFromLinks(elements, i);
  }
 },
 CancelStyleFromLinks: function(elements, index){
  if(this.disableApplyingStyleToLink)
   return;
  if(!ASPx.IsValidElements(this.links[index]))
   this.links[index] = ASPx.GetNodesByTagName(elements[index], "A");
  for(var i = 0; i < this.links[index].length; i++)
   this.CancelStyleFromLinkElement(this.links[index][i], index);
 },
 CancelStyleFromLinkElement: function(link, index){
  if(this.GetLinkColor(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "color", link, "saved" + this.kind + "Color");
  if(this.GetLinkTextDecoration(index) != "")
   ASPx.Attr.RestoreAttributeExtended(link.style, "textDecoration", link, "saved" + this.kind + "TextDecoration");
 },
 CancelImage: function(element){
  var images = this.GetImages(element);
  for(var i = 0; i < images.length; i++){
   if(!images[i] || !this.imageObjs[i]) continue;
   ASPx.Attr.RestoreAttributeExtended(images[i], "src", images[i], "saved" + this.kind + "Src");
   this.CancelImageClassName(images[i]);
   ASPx.Attr.RestoreAttributeExtended(images[i].style, "background", images[i], "saved" + this.kind + "Background");
  }
 },
 CancelImageClassName: function(element){
  var savedClassName = ASPx.Attr.GetAttribute(element, "saved" + this.kind + "ClassName");
  if(ASPx.IsExists(savedClassName)) {
   element.className = savedClassName;
   ASPx.Attr.RemoveAttribute(element, "saved" + this.kind + "ClassName");
  }
 },
 Clone: function(){
  return new ASPxStateItem(this.name, this.classNames, this.cssTexts, this.postfixes, 
   this.imageObjs, this.imagePostfixes, this.kind, this.disableApplyingStyleToLink);
 },
 IsChildElement: function(element){
  if(element != null){
   var elements = this.GetElements(element);
   for(var i = 0; i < elements.length; i++){
    if(!elements[i]) continue;
    if(ASPx.GetIsParent(elements[i], element)) 
     return true;
   }
  }
  return false;
 },
 ForceRedrawAppearance: function(element) {
  if(!aspxGetStateController().IsForceRedrawAppearanceLocked()) {
   var value = element.style.opacity;
   element.style.opacity = "0.7777";
   var dummy = element.offsetWidth;
   element.style.opacity = value;
  }
 },
 GetLinkColor: function(index){
  if(!ASPx.IsExists(this.linkColor)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkColor = rule ? rule.style.color : null;
   if(!ASPx.IsExists(this.linkColor)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkColor = rule ? rule.style.color : null;
   }
   if(this.linkColor == null) 
    this.linkColor = "";
  }
  return this.linkColor;
 },
 GetLinkTextDecoration: function(index){
  if(!ASPx.IsExists(this.linkTextDecoration)){
   var rule = ASPx.GetStyleSheetRules(this.customClassNames[index]);
   this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   if(!ASPx.IsExists(this.linkTextDecoration)){
    var rule = ASPx.GetStyleSheetRules(this.GetClassName(index));
    this.linkTextDecoration = rule ? rule.style.textDecoration : null;
   }
   if(this.linkTextDecoration == null) 
    this.linkTextDecoration = "";
  }
  return this.linkTextDecoration;
 }
});
ASPxClientStateEventArgs = ASPx.CreateClass(null, {
 constructor: function(item, element){
  this.item = item;
  this.element = element;
  this.toElement = null;
  this.fromElement = null;
  this.htmlEvent = null;
 }
});
ASPxStateController = ASPx.CreateClass(null, {
 constructor: function(){
  this.focusedItems = { };
  this.hoverItems = { };
  this.pressedItems = { };
  this.selectedItems = { };
  this.disabledItems = {};
  this.readOnlyItems = {};
  this.disabledScheme = {};
  this.currentFocusedElement = null;
  this.currentFocusedItemName = null;
  this.currentHoverElement = null;
  this.currentHoverItemName = null;
  this.currentPressedElement = null;
  this.currentPressedItemName = null;
  this.savedCurrentPressedElement = null;
  this.savedCurrentMouseMoveSrcElement = null;
  this.forceRedrawAppearanceLockCount = 0;
  this.stateItemType = ASPxStateItem;
  this.AfterSetFocusedState = new ASPxClientEvent();
  this.AfterClearFocusedState = new ASPxClientEvent();
  this.AfterSetHoverState = new ASPxClientEvent();
  this.AfterClearHoverState = new ASPxClientEvent();
  this.AfterSetPressedState = new ASPxClientEvent();
  this.AfterClearPressedState = new ASPxClientEvent();
  this.AfterDisabled = new ASPxClientEvent();
  this.AfterEnabled = new ASPxClientEvent();
  this.BeforeSetFocusedState = new ASPxClientEvent();
  this.BeforeClearFocusedState = new ASPxClientEvent();
  this.BeforeSetHoverState = new ASPxClientEvent();
  this.BeforeClearHoverState = new ASPxClientEvent();
  this.BeforeSetPressedState = new ASPxClientEvent();
  this.BeforeClearPressedState = new ASPxClientEvent();
  this.BeforeDisabled = new ASPxClientEvent();
  this.BeforeEnabled = new ASPxClientEvent();
  this.FocusedItemKeyDown = new ASPxClientEvent();
 }, 
 AddHoverItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.hoverItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.HoverItemKind, disableApplyingStyleToLink);
  this.AddItem(this.focusedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.FocusedItemKind, disableApplyingStyleToLink);
 },
 AddPressedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.pressedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.PressedItemKind, disableApplyingStyleToLink);
 },
 AddSelectedItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink){
  this.AddItem(this.selectedItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.SelectedItemKind, disableApplyingStyleToLink);
 },
 AddDisabledItem: function (name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, rootId) {
  this.AddItem(this.disabledItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes,
   ASPx.DisabledItemKind, disableApplyingStyleToLink, this.addIdToDisabledItemScheme, rootId);
 },
 AddReadOnlyItem: function(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink) {
  this.AddItem(this.readOnlyItems, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, ASPx.ReadOnlyItemKind, disableApplyingStyleToLink);
 },
 addIdToDisabledItemScheme: function(rootId, childId) {
  if (!rootId)
   return;
  if (!this.disabledScheme[rootId])
   this.disabledScheme[rootId] = [rootId];
  if (childId && (rootId != childId) && ASPx.Data.ArrayIndexOf(this.disabledScheme[rootId], childId) == -1)
   this.disabledScheme[rootId].push(childId);
 },
 removeIdFromDisabledItemScheme: function(rootId, childId) {
  if (!rootId || !this.disabledScheme[rootId])
   return;
  ASPx.Data.ArrayRemove(this.disabledScheme[rootId], childId);
  if (this.disabledScheme[rootId].length == 0)
   delete this.disabledScheme[rootId];
 },
 AddItem: function (items, name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink, onAdd, rootId) {
  var type = this.getStateItemType();
  var stateItem = new type(name, classNames, cssTexts, postfixes, imageObjs, imagePostfixes, kind, disableApplyingStyleToLink);
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    items[name + postfixes[i]] = stateItem;
    if (onAdd)
     onAdd.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   if (onAdd)
    onAdd.call(this, rootId, name);
   items[name] = stateItem;
  }
  ASPx.StateItemsExist = true;
 },
 getStateItemType: function () { return this.stateItemType; },
 withCustomStateItemType: function (newType, callback) {
  this.stateItemType = newType;
  callback(this);
  this.stateItemType = ASPxStateItem;
 },
 RemoveHoverItem: function(name, postfixes){
  this.RemoveItem(this.hoverItems, name, postfixes);
  this.RemoveItem(this.focusedItems, name, postfixes);
 },
 RemovePressedItem: function(name, postfixes){
  this.RemoveItem(this.pressedItems, name, postfixes);
 },
 RemoveSelectedItem: function(name, postfixes){
  this.RemoveItem(this.selectedItems, name, postfixes);
 },
 RemoveDisabledItem: function (name, postfixes, rootId) {
  this.RemoveItem(this.disabledItems, name, postfixes, this.removeIdFromDisabledItemScheme, rootId);
 },
 RemoveReadOnlyItem: function(name, postfixes) {
  this.RemoveItem(this.readOnlyItems, name, postfixes);
 },
 RemoveItem: function (items, name, postfixes, onRemove, rootId) {
  if (postfixes && postfixes.length > 0) {
   for (var i = 0; i < postfixes.length; i++) {
    delete items[name + postfixes[i]];
    if (onRemove)
     onRemove.call(this, rootId, name + postfixes[i]);
   }
  }
  else {
   delete items[name];
   if (onRemove)
    onRemove.call(this, rootId, name);
  }
 },
 RemoveDisposedItems: function(){
  this.RemoveDisposedItemsByType(this.hoverItems);
  this.RemoveDisposedItemsByType(this.pressedItems);
  this.RemoveDisposedItemsByType(this.focusedItems);
  this.RemoveDisposedItemsByType(this.selectedItems);
  this.RemoveDisposedItemsByType(this.disabledItems);
  this.RemoveDisposedItemsByType(this.disabledScheme);
  this.RemoveDisposedItemsByType(this.readOnlyItems);
 },
 RemoveDisposedItemsByType: function(items){
  for(var key in items) {
   if(items.hasOwnProperty(key)) {
    var item = items[key];
    var element = document.getElementById(key);
    if(!element || !ASPx.IsValidElement(element))
     delete items[key];
    try {
     if(item && item.elements) {
      for(var i = 0; i < item.elements.length; i++) {
       if(!ASPx.IsValidElements(item.links[i]))
        item.links[i] = null;
      }
     }
    }
    catch(e) {
    }
   }
  }
 },
 GetFocusedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.focusedItems, ASPx.FocusedItemKind);
 },
 GetHoverElement: function(srcElement){
  return this.GetItemElement(srcElement, this.hoverItems, ASPx.HoverItemKind);
 },
 GetPressedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.pressedItems, ASPx.PressedItemKind);
 },
 GetSelectedElement: function(srcElement){
  return this.GetItemElement(srcElement, this.selectedItems, ASPx.SelectedItemKind);
 },
 GetDisabledElement: function(srcElement){
  return this.GetItemElement(srcElement, this.disabledItems, ASPx.DisabledItemKind);
 },
 GetReadOnlyElement: function(srcElement) {
  return this.GetItemElement(srcElement, this.readOnlyItems, ASPx.ReadOnlyItemKind);
 },
 GetItemElement: function(srcElement, items, kind){
  if(srcElement && srcElement[ASPx.CachedStatePrefix + kind]){
   var cachedElement = srcElement[ASPx.CachedStatePrefix + kind];
   if(cachedElement != ASPx.EmptyObject)
    return cachedElement;
   return null;
  }
  var element = srcElement;
  while(element != null) {
   var item = items[element.id];
   if(item){
    this.CacheItemElement(srcElement, kind, element);
    element[kind] = item;
    return element;
   }
   element = element.parentNode;
  }
  this.CacheItemElement(srcElement, kind, ASPx.EmptyObject);
  return null;
 },
 CacheItemElement: function(srcElement, kind, value){
  if(srcElement && !srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = value;
 },
 DoSetFocusedState: function(element, fromElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetFocusedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetFocusedState.FireEvent(this, args);
  }
 },
 DoClearFocusedState: function(element, toElement){
  var item = element[ASPx.FocusedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearFocusedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearFocusedState.FireEvent(this, args);
  }
 },
 DoSetHoverState: function(element, fromElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.fromElement = fromElement;
   this.BeforeSetHoverState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetHoverState.FireEvent(this, args);
  }
 },
 DoClearHoverState: function(element, toElement){
  var item = element[ASPx.HoverItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   args.toElement = toElement;
   this.BeforeClearHoverState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearHoverState.FireEvent(this, args);
  }
 },
 DoSetPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeSetPressedState.FireEvent(this, args);
   item.Apply(element);
   this.AfterSetPressedState.FireEvent(this, args);
  }
 },
 DoClearPressedState: function(element){
  var item = element[ASPx.PressedItemKind];
  if(item){
   var args = new ASPxClientStateEventArgs(item, element);
   this.BeforeClearPressedState.FireEvent(this, args);
   item.Cancel(element);
   this.AfterClearPressedState.FireEvent(this, args);
  }
 },
 SetCurrentFocusedElement: function(element){
  if(this.currentFocusedElement && !ASPx.IsValidElement(this.currentFocusedElement)){
   this.currentFocusedElement = null;
   this.currentFocusedItemName = "";
  }
  if(this.currentFocusedElement != element){
   var oldCurrentFocusedElement = this.currentFocusedElement;
   var item = (element != null) ? element[ASPx.FocusedItemKind] : null;
   var itemName = (item != null) ? item.name : "";
   if(this.currentFocusedItemName != itemName){
    if(this.currentHoverItemName != "")
     this.SetCurrentHoverElement(null);
    if(this.currentFocusedElement != null)
     this.DoClearFocusedState(this.currentFocusedElement, element);
    this.currentFocusedElement = element;
    item = (element != null) ? element[ASPx.FocusedItemKind] : null;
    this.currentFocusedItemName = (item != null) ? item.name : "";
    if(this.currentFocusedElement != null)
     this.DoSetFocusedState(this.currentFocusedElement, oldCurrentFocusedElement);
   }
  }
 },
 SetCurrentHoverElement: function(element){
  if(this.currentHoverElement && !ASPx.IsValidElement(this.currentHoverElement)){
   this.currentHoverElement = null;
   this.currentHoverItemName = "";
  }
  var item = (element != null) ? element[ASPx.HoverItemKind] : null;
  if(item && !item.enabled) { 
   element = this.GetItemElement(element.parentNode, this.hoverItems, ASPx.HoverItemKind);
   item = (element != null) ? element[ASPx.HoverItemKind] : null;
  }
  if(this.currentHoverElement != element){
   var oldCurrentHoverElement = this.currentHoverElement,
    itemName = (item != null) ? item.name : "";
   if(this.currentHoverItemName != itemName || (item != null && item.needRefreshBetweenElements)){
    if(this.currentHoverElement != null)
     this.DoClearHoverState(this.currentHoverElement, element);
    item = (element != null) ? element[ASPx.HoverItemKind] : null;
    if(item == null || item.enabled){
     this.currentHoverElement = element;
     this.currentHoverItemName = (item != null) ? item.name : "";
     if(this.currentHoverElement != null)
      this.DoSetHoverState(this.currentHoverElement, oldCurrentHoverElement);
    }
   }
  }
 },
 SetCurrentPressedElement: function(element){
  if(this.currentPressedElement && !ASPx.IsValidElement(this.currentPressedElement)){
   this.currentPressedElement = null;
   this.currentPressedItemName = "";
  }
  if(this.currentPressedElement != element){
   if(this.currentPressedElement != null)
    this.DoClearPressedState(this.currentPressedElement);
   var item = (element != null) ? element[ASPx.PressedItemKind] : null;
   if(item == null || item.enabled){
    this.currentPressedElement = element;
    this.currentPressedItemName = (item != null) ? item.name : "";
    if(this.currentPressedElement != null)
     this.DoSetPressedState(this.currentPressedElement);
   }
  }
 },
 SetCurrentFocusedElementBySrcElement: function(srcElement){
  var element = this.GetFocusedElement(srcElement);
  this.SetCurrentFocusedElement(element);
 },
 SetCurrentHoverElementBySrcElement: function(srcElement){
  var element = this.GetHoverElement(srcElement);
  this.SetCurrentHoverElement(element);
 },
 SetCurrentPressedElementBySrcElement: function(srcElement){
  var element = this.GetPressedElement(srcElement);
  this.SetCurrentPressedElement(element);
 },
 SetPressedElement: function (element) {
  this.SetCurrentHoverElement(null);
  this.SetCurrentPressedElementBySrcElement(element);
  this.savedCurrentPressedElement = this.currentPressedElement;
 },
 SelectElement: function (element) {
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Apply(element);
 }, 
 SelectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.SelectElement(element);
 }, 
 DeselectElement: function(element){
  var item = element[ASPx.SelectedItemKind];
  if(item)
   item.Cancel(element);
 }, 
 DeselectElementBySrcElement: function(srcElement){
  var element = this.GetSelectedElement(srcElement);
  if(element != null) this.DeselectElement(element);
 },
 SetElementEnabled: function(element, enable){
  if(enable)
   this.EnableElement(element);
  else
   this.DisableElement(element);
 },
 SetElementReadOnly: function(element, readOnly) {
  var element = this.GetReadOnlyElement(element);
  if (element != null) {
   var item = element[ASPx.ReadOnlyItemKind];
   if(item) {
    if(readOnly) {
     if(item.name == this.currentPressedItemName)
      this.SetCurrentPressedElement(null);
     if(item.name == this.currentHoverItemName)
      this.SetCurrentHoverElement(null);
    }
    if(readOnly)
     item.Apply(element);
    else
     item.Cancel(element);
   }
  }
 },
 SetElementWithChildNodesEnabled: function (parentName, enabled) {
  var procFunct = (enabled ? this.EnableElement : this.DisableElement);
  var childItems = this.disabledScheme[parentName];
  if (childItems && childItems.length > 0)
   for (var i = 0; i < childItems.length; i++) {
    procFunct.call(this, document.getElementById(childItems[i]));
   }
 },
 DisableElement: function (element) {
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeDisabled.FireEvent(this, args);
    if(item.name == this.currentPressedItemName)
     this.SetCurrentPressedElement(null);
    if(item.name == this.currentHoverItemName)
     this.SetCurrentHoverElement(null);
    item.Apply(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, false);
    this.AfterDisabled.FireEvent(this, args);
   }
  }
 }, 
 EnableElement: function(element){
  var element = this.GetDisabledElement(element);
  if(element != null) {
   var item = element[ASPx.DisabledItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    this.BeforeEnabled.FireEvent(this, args);
    item.Cancel(element);
    this.SetMouseStateItemsEnabled(item.name, item.postfixes, true);
    this.AfterEnabled.FireEvent(this, args);
   }
  }
 }, 
 SetMouseStateItemsEnabled: function(name, postfixes, enabled){   
  if(postfixes && postfixes.length > 0){
   for(var i = 0; i < postfixes.length; i ++){
    this.SetItemsEnabled(this.hoverItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.pressedItems, name + postfixes[i], enabled);
    this.SetItemsEnabled(this.focusedItems, name + postfixes[i], enabled);
   }
  }
  else{
   this.SetItemsEnabled(this.hoverItems, name, enabled);
   this.SetItemsEnabled(this.pressedItems, name, enabled);
   this.SetItemsEnabled(this.focusedItems, name, enabled);
  }  
 },
 SetItemsEnabled: function(items, name, enabled){   
  if(items[name])
   items[name].enabled = enabled;
 },
 OnFocusMove: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
 },
 OnMouseMove: function(evt, checkElementChanged){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  if(checkElementChanged && srcElement == this.savedCurrentMouseMoveSrcElement) return;
  this.savedCurrentMouseMoveSrcElement = srcElement;
  if(ASPx.Browser.IE && !ASPx.Evt.IsLeftButtonPressed(evt) && this.savedCurrentPressedElement != null)
   this.ClearSavedCurrentPressedElement();
  if(this.savedCurrentPressedElement == null)
   this.SetCurrentHoverElementBySrcElement(srcElement);
  else{
   var element = this.GetPressedElement(srcElement);
   if(element != this.currentPressedElement){
    if(element == this.savedCurrentPressedElement)
     this.SetCurrentPressedElement(this.savedCurrentPressedElement);
    else
     this.SetCurrentPressedElement(null);
   }
  }
 },
 OnMouseDown: function(evt){
  if(!ASPx.Evt.IsLeftButtonPressed(evt)) return;
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseDownOnElement(srcElement);
 },
 OnMouseDownOnElement: function (element) {
  if(this.GetPressedElement(element) == null) return;
  this.SetPressedElement(element);
 },
 OnMouseUp: function(evt){
  var srcElement = ASPx.Evt.GetEventSource(evt);
  this.OnMouseUpOnElement(srcElement);
 },
 OnMouseUpOnElement: function(element){
  if(this.savedCurrentPressedElement == null) return;
  this.ClearSavedCurrentPressedElement();
  this.SetCurrentHoverElementBySrcElement(element);
 },
 OnMouseOver: function(evt){
  var element = ASPx.Evt.GetEventSource(evt);
  if(element && element.tagName == "IFRAME")
   this.OnMouseMove(evt, true);
 },
 OnKeyDown: function(evt){
  var element = this.GetFocusedElement(ASPx.Evt.GetEventSource(evt));
  if(element != null && element == this.currentFocusedElement) {
   var item = element[ASPx.FocusedItemKind];
   if(item){
    var args = new ASPxClientStateEventArgs(item, element);
    args.htmlEvent = evt;
    this.FocusedItemKeyDown.FireEvent(this, args);
   }
  }
 },
 OnKeyUpOnElement: function(evt) {
  if(this.savedCurrentPressedElement != null && ASPx.Evt.IsActionKeyPressed(evt))
   this.ClearSavedCurrentPressedElement();
 },
 OnSelectStart: function(evt){
  if(this.savedCurrentPressedElement) {
   ASPx.Selection.Clear();
   return false;
  }
 },
 ClearSavedCurrentPressedElement: function() {
  this.savedCurrentPressedElement = null;
  this.SetCurrentPressedElement(null);
 },
 ClearCache: function(srcElement, kind) {
  if(srcElement[ASPx.CachedStatePrefix + kind])
   srcElement[ASPx.CachedStatePrefix + kind] = null;
 },
 ClearElementCache: function(srcElement) {
  this.ClearCache(srcElement, ASPx.FocusedItemKind);
  this.ClearCache(srcElement, ASPx.HoverItemKind);
  this.ClearCache(srcElement, ASPx.PressedItemKind);
  this.ClearCache(srcElement, ASPx.SelectedItemKind);
  this.ClearCache(srcElement, ASPx.DisabledItemKind);
 },
 LockForceRedrawAppearance: function() {
  this.forceRedrawAppearanceLockCount++;
 },
 UnlockForceRedrawAppearance: function() {
  this.forceRedrawAppearanceLockCount--;
 },
 IsForceRedrawAppearanceLocked: function() {
  return this.forceRedrawAppearanceLockCount > 0;
 }
});
var stateController = null;
function aspxGetStateController(){
 if(stateController == null)
  stateController = new ASPxStateController();
 return stateController;
}
function aspxAddStateItems(method, namePrefix, classes, disableApplyingStyleToLink){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][2].length; j ++) {
   var name = namePrefix;
   if(classes[i][2][j])
    name += "_" + classes[i][2][j];
   var postfixes = classes[i][3] || null;
   var imageObjs = (classes[i][4] && classes[i][4][j]) || null;
   var imagePostfixes = classes[i][5] || null;
   method.call(aspxGetStateController(), name, classes[i][0], classes[i][1], postfixes, imageObjs, imagePostfixes, disableApplyingStyleToLink, namePrefix);
  }
 }
}
ASPx.AddHoverItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddHoverItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddPressedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddPressedItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddSelectedItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddSelectedItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddDisabledItems = function(namePrefix, classes, disableApplyingStyleToLink){
 aspxAddStateItems(aspxGetStateController().AddDisabledItem, namePrefix, classes, disableApplyingStyleToLink);
};
ASPx.AddReadOnlyItems = function(namePrefix, classes, disableApplyingStyleToLink) {
 aspxAddStateItems(aspxGetStateController().AddReadOnlyItem, namePrefix, classes, disableApplyingStyleToLink);
};
function aspxRemoveStateItems(method, namePrefix, classes){
 for(var i = 0; i < classes.length; i ++){
  for(var j = 0; j < classes[i][0].length; j ++) {
   var name = namePrefix;
   if(classes[i][0][j])
    name += "_" + classes[i][0][j];
   method.call(aspxGetStateController(), name, classes[i][1], namePrefix);
  }
 }
}
ASPx.RemoveHoverItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveHoverItem, namePrefix, classes);
};
ASPx.RemovePressedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemovePressedItem, namePrefix, classes);
};
ASPx.RemoveSelectedItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveSelectedItem, namePrefix, classes);
};
ASPx.RemoveDisabledItems = function(namePrefix, classes){
 aspxRemoveStateItems(aspxGetStateController().RemoveDisabledItem, namePrefix, classes);
};
ASPx.RemoveReadOnlyItems = function(namePrefix, classes) {
 aspxRemoveStateItems(aspxGetStateController().RemoveReadOnlyItem, namePrefix, classes);
};
ASPx.AddAfterClearFocusedState = function(handler){
 aspxGetStateController().AfterClearFocusedState.AddHandler(handler);
};
ASPx.AddAfterSetFocusedState = function(handler){
 aspxGetStateController().AfterSetFocusedState.AddHandler(handler);
};
ASPx.AddAfterClearHoverState = function(handler){
 aspxGetStateController().AfterClearHoverState.AddHandler(handler);
};
ASPx.AddAfterSetHoverState = function(handler){
 aspxGetStateController().AfterSetHoverState.AddHandler(handler);
};
ASPx.AddAfterClearPressedState = function(handler){
 aspxGetStateController().AfterClearPressedState.AddHandler(handler);
};
ASPx.AddAfterSetPressedState = function(handler){
 aspxGetStateController().AfterSetPressedState.AddHandler(handler);
};
ASPx.AddAfterDisabled = function(handler){
 aspxGetStateController().AfterDisabled.AddHandler(handler);
};
ASPx.AddAfterEnabled = function(handler){
 aspxGetStateController().AfterEnabled.AddHandler(handler);
};
ASPx.AddBeforeClearFocusedState = function(handler){
 aspxGetStateController().BeforeClearFocusedState.AddHandler(handler);
};
ASPx.AddBeforeSetFocusedState = function(handler){
 aspxGetStateController().BeforeSetFocusedState.AddHandler(handler);
};
ASPx.AddBeforeClearHoverState = function(handler){
 aspxGetStateController().BeforeClearHoverState.AddHandler(handler);
};
ASPx.AddBeforeSetHoverState = function(handler){
 aspxGetStateController().BeforeSetHoverState.AddHandler(handler);
};
ASPx.AddBeforeClearPressedState = function(handler){
 aspxGetStateController().BeforeClearPressedState.AddHandler(handler);
};
ASPx.AddBeforeSetPressedState = function(handler){
 aspxGetStateController().BeforeSetPressedState.AddHandler(handler);
};
ASPx.AddBeforeDisabled = function(handler){
 aspxGetStateController().BeforeDisabled.AddHandler(handler);
};
ASPx.AddBeforeEnabled = function(handler){
 aspxGetStateController().BeforeEnabled.AddHandler(handler);
};
ASPx.AddFocusedItemKeyDown = function(handler){
 aspxGetStateController().FocusedItemKeyDown.AddHandler(handler);
};
ASPx.SetHoverState = function(element){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(element);
};
ASPx.ClearHoverState = function(evt){
 aspxGetStateController().SetCurrentHoverElementBySrcElement(null);
};
ASPx.UpdateHoverState = function(evt){
 aspxGetStateController().OnMouseMove(evt, false);
};
ASPx.SetFocusedState = function(element){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(element);
};
ASPx.ClearFocusedState = function(evt){
 aspxGetStateController().SetCurrentFocusedElementBySrcElement(null);
};
ASPx.UpdateFocusedState = function(evt){
 aspxGetStateController().OnFocusMove(evt);
};
ASPx.AccessibilityMarkerClass = "dxalink";
ASPx.AssignAccessibilityEventsToChildrenLinks = function(container, clearFocusedStateOnMouseOut){
 var links = ASPx.GetNodesByPartialClassName(container, ASPx.AccessibilityMarkerClass);
 for(var i = 0; i < links.length; i++)
  ASPx.AssignAccessibilityEventsToLink(links[i], clearFocusedStateOnMouseOut);
};
ASPx.AssignAccessibilityEventsToLink = function(link, clearFocusedStateOnMouseOut) {
 if(!ASPx.ElementContainsCssClass(link, ASPx.AccessibilityMarkerClass))
  return;
 ASPx.AssignAccessibilityEventsToLinkCore(link, clearFocusedStateOnMouseOut);
};
ASPx.AssignAccessibilityEventsToLinkCore = function (link, clearFocusedStateOnMouseOut) {
 ASPx.Evt.AttachEventToElement(link, "focus", function (e) { ASPx.UpdateFocusedState(e); });
 var clearFocusedStateHandler = function (e) { ASPx.ClearFocusedState(e); };
 ASPx.Evt.AttachEventToElement(link, "blur", clearFocusedStateHandler);
 if(clearFocusedStateOnMouseOut)
  ASPx.Evt.AttachEventToElement(link, "mouseout", clearFocusedStateHandler);
};
ASPx.Evt.AttachEventToDocument("mousemove", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseMove(evt, true);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseDown(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseUp(evt);
});
ASPx.Evt.AttachEventToDocument("mouseover", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnMouseOver(evt);
});
ASPx.Evt.AttachEventToDocument("keydown", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  aspxGetStateController().OnKeyDown(evt);
});
ASPx.Evt.AttachEventToDocument("selectstart", function(evt) {
 if(ASPx.classesScriptParsed && ASPx.StateItemsExist)
  return aspxGetStateController().OnSelectStart(evt);
});
ASPx.GetStateController = aspxGetStateController;
ASPx.StateItem = ASPxStateItem;
})();
(function () {
 var ASPx = window.ASPx || {};
 ASPx.ASPxImageLoad = {};
 ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass = "dxe-loadingImage";
 ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClassRegexp = new RegExp("dx\\w+-loadingImage");
 ASPx.ASPxImageLoad.OnLoad = function (image, customLoadingImage, isOldIE, customBackgroundImageUrl) {
  image.dxCustomBackgroundImageUrl = "";
  image.dxShowLoadingImage = true;
  image.dxCustomLoadingImage = customLoadingImage;
  if (customBackgroundImageUrl != "")
   image.dxCustomBackgroundImageUrl = "url('" + customBackgroundImageUrl + "')";
  ASPx.ASPxImageLoad.prepareImageBackground(image, isOldIE);
  ASPx.ASPxImageLoad.removeHandlers(image);
  image.className = image.className.replace(ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClassRegexp, "");
 };
 ASPx.ASPxImageLoad.removeASPxImageBackground = function (image, isOldIE) {
  if (isOldIE) 
   image.style.removeAttribute("background-image");
  else 
   image.style.backgroundImage = "";
 };
 ASPx.ASPxImageLoad.prepareImageBackground = function (image, isOldIE) {
  ASPx.ASPxImageLoad.removeASPxImageBackground(image, isOldIE);
  if (image.dxCustomBackgroundImageUrl != "")
   image.style.backgroundImage = image.dxCustomBackgroundImageUrl;
 };
 ASPx.ASPxImageLoad.removeHandlers = function (image) {
  image.removeAttribute("onload");
  image.removeAttribute("onabort");
  image.removeAttribute("onerror");
 };
 window.ASPx = ASPx;
})();
(function module(ASPx) {
ASPx.modules.Controls = module;
var ASPxClientBeginCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(command){
  this.constructor.prototype.constructor.call(this);
  this.command = command;
 }
});
var ASPxClientGlobalBeginCallbackEventArgs = ASPx.CreateClass(ASPxClientBeginCallbackEventArgs, {
 constructor: function(control, command){
  this.constructor.prototype.constructor.call(this, command);
  this.control = control;
 }
});
var ASPxClientEndCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(command){
  this.constructor.prototype.constructor.call(this);
  this.command = command;
 }
});
var ASPxClientGlobalEndCallbackEventArgs = ASPx.CreateClass(ASPxClientEndCallbackEventArgs, {
 constructor: function(control){
  this.constructor.prototype.constructor.call(this);
  this.control = control;
 }
});
var ASPxClientCustomDataCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(result) {
  this.constructor.prototype.constructor.call(this);
  this.result = result;
 }
});
var ASPxClientCallbackErrorEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function (message, callbackId) {
  this.constructor.prototype.constructor.call(this);
  this.message = message;
  this.handled = false;
  this.callbackId = callbackId;
 }
});
var ASPxClientGlobalCallbackErrorEventArgs = ASPx.CreateClass(ASPxClientCallbackErrorEventArgs, {
 constructor: function (control, message, callbackId) {
  this.constructor.prototype.constructor.call(this, message, callbackId);
  this.control = control;
 }
});
var ASPxClientValidationCompletedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function (container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl) {
  this.constructor.prototype.constructor.call(this);
  this.container = container;
  this.validationGroup = validationGroup;
  this.invisibleControlsValidated = invisibleControlsValidated;
  this.isValid = isValid;
  this.firstInvalidControl = firstInvalidControl;
  this.firstVisibleInvalidControl = firstVisibleInvalidControl;
 }
});
var ASPxClientControlsInitializedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(isCallback) {
  this.isCallback = isCallback;
 }
});
var ASPxClientControlBeforePronounceEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(messageParts, control){
  this.constructor.prototype.constructor.call(this);
  this.messageParts = messageParts;
  this.control = control;
 }
});
var ASPxClientControlUnloadEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(control){
  this.constructor.prototype.constructor.call(this);
  this.control = control;
 }
});
var ASPxClientEndFocusEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
var ASPxClientItemFocusedEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
var BeforeInitCallbackEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(callbackOwnerID){
  this.constructor.prototype.constructor.call(this);
  this.callbackOwnerID = callbackOwnerID;
 }
});
ASPx.createControl = function(type, name, windowName, properties, events, setupMethod, data){
 var globalName = windowName && windowName.length > 0 ? windowName : name;
 var dxo = new type(name);
 var haveWrapper = ASPx.Platform === "NETCORE" && dxo.createWrapper && !DevExpress.AspNetCore.Internal.BackwardCompatibility.useLegacyClientAPI;
 if(haveWrapper) {
  window[globalName] = dxo.createWrapper();
  dxo.aspNetCoreWrapperInstance = window[globalName];
 }
 else
  dxo.InitGlobalVariable(globalName);
 if(properties)
  dxo.SetProperties(properties);
 if(events)
  dxo.SetEvents(events);
 if(setupMethod)
  setupMethod.call(dxo);
 if(data)
  dxo.SetData(data);
 dxo.AfterCreate();
};
var ASPxClientControlBase = ASPx.CreateClass(null, {
 constructor: function(name){
  this.name = name;
  this.uniqueID = name;   
  this.globalName = name;
  this.stateObject = null;
  this.needEncodeState = true;
  this.encodeHtml = true;
  this.enabled = true;
  this.clientEnabled = true;
  this.savedClientEnabled = true;
  this.clientVisible = true;
  this.accessibilityCompliant = false;
  this.parseJSPropertiesOnCallbackError = false;
  this.autoPostBack = false;
  this.allowMultipleCallbacks = true;
  this.callBack = null;
  this.enableCallbackAnimation = false;
  this.enableSlideCallbackAnimation = false;
  this.slideAnimationDirection = null;
  this.beginCallbackAnimationProcessing = false;
  this.endCallbackAnimationProcessing = false;
  this.savedCallbackResult = null;
  this.savedCallbacks = null;
  this.isCallbackAnimationPrevented = false;
  this.lpDelay = 300;
  this.lpTimer = -1;
  this.requestCount = 0;
  this.enableSwipeGestures = false;
  this.disableSwipeGestures = false;
  this.supportGestures = false;
  this.repeatedGestureValue = 0;
  this.repeatedGestureCount = 0;
  this.isInitialized = false;
  this.initialFocused = false;
  this.leadingAfterInitCall = ASPxClientControl.LeadingAfterInitCallConsts.None; 
  this.serverEvents = [];
  this.loadingPanelElement = null;
  this.loadingDivElement = null;  
  this.hasPhantomLoadingElements = false;
  this.mainElement = null;
  this.touchUIMouseScroller = null;
  this.hiddenFields = {};
  this.scPrefix = "dx";
  this.callbackHandlersQueue = new ASPx.ControlCallbackHandlersQueue(this);
  this.callbackCommand = {};
  this.currentCallbackID = -1;
  this.Init = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.EndCallbackAnimationStart = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.CustomDataCallback = new ASPxClientEvent();
  this.BeforePronounce = new ASPxClientEvent();
  this.Unload = new ASPxClientEvent();
  aspxGetControlCollection().Add(this);
 },
 Initialize: function() {
  if(this.callBack != null)
   this.InitializeCallBackData();
  if (this.useCallbackQueue())
   this.callbackQueueHelper = new ASPx.ControlCallbackQueueHelper(this);
  ASPx.AccessibilityUtils.createAccessibleBackgrounds(this);
  if(this.accessibilityCompliant)
   ASPx.AccessibilityPronouncer.EnsureInitialize();
 },
 FinalizeInitialization: function() { },
 InlineInitialize: function() {
  this.savedClientEnabled = this.clientEnabled;
 },
 InitializeGestures: function() {
  if(this.isSwipeGesturesEnabled() && this.supportGestures) {
   ASPx.GesturesHelper.AddSwipeGestureHandler(this.name, 
    function() { return this.GetCallbackAnimationElement(); }.aspxBind(this), 
    function(evt) { return this.CanHandleGestureCore(evt); }.aspxBind(this), 
    function(value) { return this.AllowStartGesture(value); }.aspxBind(this),
    function(value) { return this.StartGesture(); }.aspxBind(this),
    function(value) { return this.AllowExecuteGesture(value); }.aspxBind(this),
    function(value) { this.ExecuteGesture(value); }.aspxBind(this),
    function(value) { this.CancelGesture(value); }.aspxBind(this),
    this.GetDefaultanimationEngineType(),
    this.rtl
   );
   if(ASPx.Browser.MSTouchUI)
    this.touchUIMouseScroller = ASPx.MouseScroller.Create(
     function() { return this.GetCallbackAnimationElement(); }.aspxBind(this),
     function() { return null; },
     function() { return this.GetCallbackAnimationElement(); }.aspxBind(this),
     function(element) { return this.NeedPreventTouchUIMouseScrolling(element); }.aspxBind(this),
     true
    );
  }
 },
 isSwipeGesturesEnabled: function() {
  return !this.disableSwipeGestures && (this.enableSwipeGestures || ASPx.Browser.TouchUI);
 },
 isSlideCallbackAnimationEnabled: function() {
  return this.enableSlideCallbackAnimation || this.isSwipeGesturesEnabled(); 
 },
 InitGlobalVariable: function(varName){
  if(!window) return;
  this.globalName = varName;
  window[varName] = this;
 },
 SetElementDisplay: function(element, value, checkCurrentStyle, makeInline) {
  ASPx.SetElementDisplay(element, value, checkCurrentStyle, makeInline);
 },
 SetProperties: function(properties, obj){
  if(!obj) obj = this;
  var isAspNetCoreWrapperInstanceExist = !!obj.aspNetCoreWrapperInstance;
  for(var name in properties){
   if(!properties.hasOwnProperty(name)) continue;
   obj[name] = properties[name];
   if(isAspNetCoreWrapperInstanceExist && name.indexOf("cp") === 0)
    obj.aspNetCoreWrapperInstance[name] = properties[name]; 
  }
 },
 SetEvents: function(events, obj){
  if(!obj) obj = this;
  for(var name in events){
   if(events.hasOwnProperty(name) && obj[name] && obj[name].AddHandler)
    obj[name].AddHandler(events[name]);
  }
 },
 SetData: function(data){
 },
 useCallbackQueue: function(){
  return false;
 },
 NeedPreventTouchUIMouseScrolling: function(element) {
  return false;
 },
 InitailizeFocus: function() {
  if(this.initialFocused && this.IsVisible())
   this.Focus();
 },
 AfterCreate: function() {
  this.AddDefaultStateControllerItems();
  this.InlineInitialize();
  this.InitializeGestures();
 },
 AfterInitialize: function() {
  this.initializeAriaDescriptor();
  this.InitailizeFocus();
  this.isInitialized = true;
  this.RaiseInit();
  if(this.savedCallbacks) {
   for(var i = 0; i < this.savedCallbacks.length; i++) 
    this.CreateCallbackInternal(this.savedCallbacks[i].arg, this.savedCallbacks[i].command, 
     false, this.savedCallbacks[i].callbackInfo);
   this.savedCallbacks = null;
  }
 },
 InitializeCallBackData: function() {
 },
 AtlasPreInitialize: function() {
 },
 AtlasInitialize: function() {
 },
 IsDOMDisposed: function() { 
  return !ASPx.IsExistsElement(this.GetMainElement());
 },
 initializeAriaDescriptor: function() {
  if(this.ariaDescription) {
   var descriptionObject = ASPx.Json.Eval(this.ariaDescription);
   if(descriptionObject) {
    this.ariaDescriptor = new AriaDescriptor(this, descriptionObject);
    this.applyAccessibilityAttributes(this.ariaDescriptor); 
   }
  }
 },
 applyAccessibilityAttributes: function() { },
 setAriaDescription: function(selector, argsList) {
  if(this.ariaDescriptor)
   this.ariaDescriptor.setDescription(selector, argsList || [[]]);
 },
 allowRestoreFocusOnCallbacks: function(){
  return this.accessibilityCompliant;
 },
 HtmlEncode: function(text) {
  return this.encodeHtml ? ASPx.Str.EncodeHtml(text) : text;
 },
 IsServerEventAssigned: function(eventName){
  return ASPx.Data.ArrayIndexOf(this.serverEvents, eventName) >= 0;
 },
 OnPost: function(args){
  this.SerializeStateHiddenField();
 },
 SerializeStateHiddenField: function() {
  this.UpdateStateObject();
  if(this.stateObject != null)
   this.UpdateStateHiddenField();
 },
 OnPostFinalization: function(args){
 },
 UpdateStateObject: function(){
 },
 UpdateStateObjectWithObject: function(obj){
  if(!obj) return;
  if(!this.stateObject)
   this.stateObject = { };
  for(var key in obj)
   if(obj.hasOwnProperty(key))
    this.stateObject[key] = obj[key];
 },
 UpdateStateHiddenField: function() {
  var stateHiddenField = this.GetStateHiddenField();
  if(stateHiddenField) {
   var stateObjectStr = ASPx.Json.ToJson(this.stateObject, !this.needEncodeState);
   stateHiddenField.value = this.needEncodeState ? ASPx.Str.EncodeHtml(stateObjectStr) : stateObjectStr;
  }
 },
 GetStateHiddenField: function() {
  return this.GetHiddenField(this.GetStateHiddenFieldName(), this.GetStateHiddenFieldID(), 
   this.GetStateHiddenFieldParent(), this.GetStateHiddenFieldOrigin());
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID;
 },
 GetStateHiddenFieldID: function() {
  return this.name + "_State";
 },
 GetStateHiddenFieldOrigin: function() {
  return this.GetMainElement();
 },
 GetStateHiddenFieldParent: function() {
  var element = this.GetStateHiddenFieldOrigin();
  return element ? element.parentNode : null;
 },
 GetHiddenField: function(name, id, parent, beforeElement) {
  var hiddenField = this.hiddenFields[id];
  if(!hiddenField || !ASPx.IsValidElement(hiddenField)) {
   if(parent) {
    var existingHiddenField = ASPx.GetElementById(this.GetStateHiddenFieldID());
    this.hiddenFields[id] = hiddenField = existingHiddenField || ASPx.CreateHiddenField(name, id);
    if(existingHiddenField)
     return existingHiddenField;
    if(beforeElement)
     parent.insertBefore(hiddenField, beforeElement);
    else
     parent.appendChild(hiddenField);
   }
  }
  return hiddenField;
 },
 GetChildElement: function(idPostfix){
  var mainElement = this.GetMainElement();
  if(idPostfix.charAt && idPostfix.charAt(0) !== "_")
   idPostfix = "_" + idPostfix;
  return mainElement ? ASPx.CacheHelper.GetCachedChildById(this, mainElement, this.name + idPostfix) : null;
 },
 getChildControl: function(idPostfix) {
  var result = null;
  var childControlId = this.getChildControlUniqueID(idPostfix);
  ASPx.GetControlCollection().ProcessControlsInContainer(this.GetMainElement(), function(control) {
   if(control.uniqueID == childControlId)
    result = control;
  });
  return result;  
 },
 getChildControlUniqueID: function(idPostfix) {
  idPostfix = idPostfix.split("_").join("$");
  if(idPostfix.charAt && idPostfix.charAt(0) !== "$")
   idPostfix = "$" + idPostfix;
  return this.uniqueID + idPostfix;  
 },
 getInnerControl: function(idPostfix) {
  var name = this.name + idPostfix;
  var result = window[name];
  return result && Ident.IsASPxClientControl(result)
   ? result
   : null;
 },
 GetParentForm: function(){
  return ASPx.GetParentByTagName(this.GetMainElement(), "FORM");
 },
 GetMainElement: function(){
  if(!ASPx.IsExistsElement(this.mainElement))
   this.mainElement = ASPx.GetElementById(this.GetMainElementId());
  return this.mainElement;
 },
 GetMainElementId: function() {
  return this.name;
 },
 IsLoadingContainerVisible: function(){
  return this.IsVisible();
 },
 GetLoadingPanelElement: function(){
  return ASPx.GetElementById(this.name + "_LP");
 },
 GetClonedLoadingPanel: function(){
  return document.getElementById(this.GetLoadingPanelElement().id + "V"); 
 },
 CloneLoadingPanel: function(element, parent) {
  var clone = element.cloneNode(true);
  clone.id = element.id + "V";
  parent.appendChild(clone);
  return clone;
 },
 CreateLoadingPanelWithoutBordersInsideContainer: function(container) {
  var loadingPanel = this.CreateLoadingPanelInsideContainer(container, false, true, true);
  var contentStyle = ASPx.GetCurrentStyle(container);
  if(!loadingPanel || !contentStyle)
   return;
  var elements = [ ];
  var table = (loadingPanel.tagName == "TABLE") ? loadingPanel : ASPx.GetNodeByTagName(loadingPanel, "TABLE", 0);
  if(table != null)
   elements.push(table);
  else
   elements.push(loadingPanel);
  var cells = ASPx.GetNodesByTagName(loadingPanel, "TD");
  if(!cells) cells = [ ];
  for(var i = 0; i < cells.length; i++)
   elements.push(cells[i]);
  for(var i = 0; i < elements.length; i++) {
   var el = elements[i];
   el.style.backgroundColor = contentStyle.backgroundColor;
   ASPx.RemoveBordersAndShadows(el);
  }
 },
 CreateLoadingPanelInsideContainer: function(parentElement, hideContent, collapseHeight, collapseWidth) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if(element != null){
   var width = collapseWidth ? 0 : ASPx.GetClearClientWidth(parentElement);
   var height = collapseHeight ? 0 : ASPx.GetClearClientHeight(parentElement);
   if(hideContent){
    for(var i = parentElement.childNodes.length - 1; i > -1; i--){
     if(parentElement.childNodes[i].style)
      parentElement.childNodes[i].style.display = "none";
     else if(parentElement.childNodes[i].nodeType == 3) 
      parentElement.removeChild(parentElement.childNodes[i]);
    }
   }
   else
    parentElement.innerHTML = "";
   var table = document.createElement("TABLE");
   parentElement.appendChild(table);
   table.border = 0;
   table.cellPadding = 0;
   table.cellSpacing = 0;
   ASPx.SetStyles(table, {
    width: (width > 0) ? width : "100%",
    height: (height > 0) ? height : "100%"
   });
   var tbody = document.createElement("TBODY");
   table.appendChild(tbody);
   var tr = document.createElement("TR");
   tbody.appendChild(tr);
   var td = document.createElement("TD");
   tr.appendChild(td);
   td.align = "center";
   td.vAlign = "middle";
   element = this.CloneLoadingPanel(element, td);
   ASPx.SetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  } else
   parentElement.innerHTML = "&nbsp;";
  return null;
 },
 CreateLoadingPanelWithAbsolutePosition: function(parentElement, offsetElement) {
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   ASPx.SetStyles(element, {
    position: "absolute"
   });
   ASPx.SetElementDisplay(element, true);
   ASPx.Evt.AttachEventToElement(element, ASPx.Evt.GetMouseWheelEventName(), ASPx.Evt.PreventEvent);
   this.SetLoadingPanelLocation(offsetElement, element);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 CreateLoadingPanelInline: function(parentElement, centerInParent){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingPanel();
  if(parentElement == null)
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  var element = this.GetLoadingPanelElement();
  if(element != null) {
   element = this.CloneLoadingPanel(element, parentElement);
   if(centerInParent){
    ASPx.SetElementDisplay(element, true);
    parentElement.style.textAlign = "center";
   }
   else
    ASPx.SetElementDisplay(element, true);
   this.loadingPanelElement = element;
   return element;
  }
  return null;
 },
 ShowLoadingPanel: function() {
 },
 ShowLoadingElements: function() {
  if(this.InCallback() || this.lpTimer > -1) return;
  this.ShowLoadingDiv();
  if(this.IsCallbackAnimationEnabled())
   this.StartBeginCallbackAnimation();
  else
   this.ShowLoadingElementsInternal();
 },
 ShowLoadingElementsInternal: function() {
  if(this.lpDelay > 0 && !this.IsCallbackAnimationEnabled()) 
   this.lpTimer = window.setTimeout(function() { 
    this.ShowLoadingPanelOnTimer(); 
   }.aspxBind(this), this.lpDelay);
  else {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 GetLoadingPanelOffsetElement: function (baseElement) {
  if(this.IsCallbackAnimationEnabled()) {
   var element = this.GetLoadingPanelCallbackAnimationOffsetElement();
   if(element) {
    var container = typeof(ASPx.AnimationHelper) != "undefined" ? ASPx.AnimationHelper.findSlideAnimationContainer(element) : null;
    if(container)
     return container.parentNode.parentNode;
    else
     return element;
   }
  }
  return baseElement;
 },
 GetLoadingPanelCallbackAnimationOffsetElement: function () {
  return this.GetCallbackAnimationElement();
 },
 IsCallbackAnimationEnabled: function () {
  return (this.enableCallbackAnimation || this.isSlideCallbackAnimationEnabled()) && !this.isCallbackAnimationPrevented;
 },
 GetDefaultanimationEngineType: function() {
  return ASPx.AnimationEngineType.DEFAULT;
 },
 StartBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = true;
  this.isCallbackFinished = false;
  var element = this.GetCallbackAnimationElement();
  if (element && this.isSlideCallbackAnimationEnabled() && this.slideAnimationDirection)
   ASPx.AnimationHelper.slideOut(element, this.slideAnimationDirection, this.FinishBeginCallbackAnimation.aspxBind(this), this.GetDefaultanimationEngineType(), this.rtl);
  else if(element && this.enableCallbackAnimation) 
   ASPx.AnimationHelper.fadeOut(element, this.FinishBeginCallbackAnimation.aspxBind(this));
  else
   this.FinishBeginCallbackAnimation();
 },
 CancelBeginCallbackAnimation: function() {
  if(this.beginCallbackAnimationProcessing) {
   this.beginCallbackAnimationProcessing = false;
   var element = this.GetCallbackAnimationElement();
   ASPx.AnimationHelper.cancelAnimation(element);
  }
 },
 FinishBeginCallbackAnimation: function () {
  this.beginCallbackAnimationProcessing = false;
  if(!this.isCallbackFinished)
   this.ShowLoadingElementsInternal();
  else {
   this.DoCallback(this.savedCallbackResult);
   this.savedCallbackResult = null;
  }
 },
 CheckBeginCallbackAnimationInProgress: function(callbackResult) {
  if(this.beginCallbackAnimationProcessing) {
   this.savedCallbackResult = callbackResult;
   this.isCallbackFinished = true;
   return true;
  }
  return false;
 },
 StartEndCallbackAnimation: function () {
  this.HideLoadingPanel();
  this.SetInitialLoadingDivOpacity();
  this.RaiseEndCallbackAnimationStart();
  this.endCallbackAnimationProcessing = true;
  var element = this.GetCallbackAnimationElement();
  if(element && this.isSlideCallbackAnimationEnabled() && this.slideAnimationDirection) 
   ASPx.AnimationHelper.slideIn(element, this.slideAnimationDirection, this.FinishEndCallbackAnimation.aspxBind(this), this.GetDefaultanimationEngineType(), this.rtl);
  else if(element && this.enableCallbackAnimation) 
   ASPx.AnimationHelper.fadeIn(element, this.FinishEndCallbackAnimation.aspxBind(this));
  else
   this.FinishEndCallbackAnimation();
  this.slideAnimationDirection = null;
 },
 FinishEndCallbackAnimation: function () {
  this.DoEndCallback();
  this.endCallbackAnimationProcessing = false;
  this.CheckRepeatGesture();
 },
 CheckEndCallbackAnimationNeeded: function() {
  if(!this.endCallbackAnimationProcessing && this.requestCount == 1) {
   this.StartEndCallbackAnimation();
   return true;
  }
  return false;
 },
 PreventCallbackAnimation: function() {
  this.isCallbackAnimationPrevented = true;
 },
 GetCallbackAnimationElement: function() {
  return null;
 },
 AssignSlideAnimationDirectionByPagerArgument: function(arg, currentPageIndex) {
  this.slideAnimationDirection = null;
  if(this.isSlideCallbackAnimationEnabled() && typeof(ASPx.AnimationHelper) != "undefined") {
   if(arg == PagerCommands.Next || arg == PagerCommands.Last)
    this.slideAnimationDirection = ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION;
   else if(arg == PagerCommands.First || arg == PagerCommands.Prev)
    this.slideAnimationDirection = ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION;
   else if(!isNaN(currentPageIndex) && arg.indexOf(PagerCommands.PageNumber) == 0) {
    var newPageIndex = parseInt(arg.substring(2));
    if (!isNaN(newPageIndex)) {
     var leftDir = this.rtl ? ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION : ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION;
     var rightDir = this.rtl ? ASPx.AnimationHelper.SLIDE_RIGHT_DIRECTION : ASPx.AnimationHelper.SLIDE_LEFT_DIRECTION;
     this.slideAnimationDirection = newPageIndex < currentPageIndex ? leftDir : rightDir;
    }
   }
  }
 },
 TryShowPhantomLoadingElements: function () {
  if(this.hasPhantomLoadingElements && this.InCallback()) {
   this.hasPhantomLoadingElements = false;
   this.ShowLoadingDivAndPanel();
  }
 },
 ShowLoadingDivAndPanel: function () {
  this.ShowLoadingDiv();
  this.RestoreLoadingDivOpacity();
  this.ShowLoadingPanel();
 },
 HideLoadingElements: function() {
  this.CancelBeginCallbackAnimation();
  this.HideLoadingPanel();
  this.HideLoadingDiv();
 },
 ShowLoadingPanelOnTimer: function() {
  this.ClearLoadingPanelTimer();
  if(!this.IsDOMDisposed()) {
   this.RestoreLoadingDivOpacity();
   this.ShowLoadingPanel();
  }
 },
 ClearLoadingPanelTimer: function() {
  this.lpTimer = ASPx.Timer.ClearTimer(this.lpTimer);  
 },
 HideLoadingPanel: function() {
  this.ClearLoadingPanelTimer();
  this.hasPhantomLoadingElements = false;
  if(ASPx.IsExistsElement(this.loadingPanelElement)) {
   ASPx.RemoveElement(this.loadingPanelElement);
   this.loadingPanelElement = null;
  }
 },
 SetLoadingPanelLocation: function(offsetElement, loadingPanel, x, y, offsetX, offsetY) {
  if(!ASPx.IsExists(x) || !ASPx.IsExists(y)){
   var x1 = ASPx.GetAbsoluteX(offsetElement);
   var y1 = ASPx.GetAbsoluteY(offsetElement);
   var x2 = x1;
   var y2 = y1;
   if(offsetElement == document.body) {
    x1 = 0;
    y1 = 0;
    x2 = ASPx.GetDocumentMaxClientWidth();
    y2 = ASPx.GetDocumentMaxClientHeight();
   }
   else{
    x2 += offsetElement.offsetWidth;
    y2 += offsetElement.offsetHeight;
   }
   if(x1 < ASPx.GetDocumentScrollLeft())
    x1 = ASPx.GetDocumentScrollLeft();
   if(y1 < ASPx.GetDocumentScrollTop())
    y1 = ASPx.GetDocumentScrollTop();
   if(x2 > ASPx.GetDocumentScrollLeft() + ASPx.GetDocumentClientWidth())
    x2 = ASPx.GetDocumentScrollLeft() + ASPx.GetDocumentClientWidth();
   if(y2 > ASPx.GetDocumentScrollTop() + ASPx.GetDocumentClientHeight())
    y2 = ASPx.GetDocumentScrollTop() + ASPx.GetDocumentClientHeight();
   x = x1 + ((x2 - x1 - loadingPanel.offsetWidth) / 2);
   y = y1 + ((y2 - y1 - loadingPanel.offsetHeight) / 2);
  }
  if(ASPx.IsExists(offsetX) && ASPx.IsExists(offsetY)){
   x += offsetX;
   y += offsetY;
  }
  x = ASPx.PrepareClientPosForElement(x, loadingPanel, true);
  y = ASPx.PrepareClientPosForElement(y, loadingPanel, false);
  if(ASPx.Browser.IE && ASPx.Browser.Version > 8) {
   x = Math.round(x);
   y = Math.round(y);
  }
  ASPx.SetStyles(loadingPanel, { left: x, top: y });
 },
 GetLoadingDiv: function(){
  return ASPx.GetElementById(this.name + "_LD");
 },
 CreateLoadingDiv: function(parentElement, offsetElement){
  if(this.ShouldHideExistingLoadingElements())
   this.HideLoadingDiv();
  if(parentElement == null) 
   return null;
  if(!this.IsLoadingContainerVisible()) {
   this.hasPhantomLoadingElements = true;
   return null;
  }
  if(!offsetElement)
   offsetElement = parentElement;
  var div = this.GetLoadingDiv();
  if(div != null){
   div = div.cloneNode(true);
   parentElement.appendChild(div);
   ASPx.SetElementDisplay(div, true);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseDownEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseMoveEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.TouchUIHelper.touchMouseUpEventName, ASPx.Evt.PreventEvent);
   ASPx.Evt.AttachEventToElement(div, ASPx.Evt.GetMouseWheelEventName(), ASPx.Evt.PreventEvent);
   this.SetLoadingDivBounds(offsetElement, div);
   this.loadingDivElement = div;
   this.SetInitialLoadingDivOpacity();
   return div;
  }
  return null;
 },
 SetInitialLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  ASPx.Attr.SaveStyleAttribute(this.loadingDivElement, "opacity");
  ASPx.Attr.SaveStyleAttribute(this.loadingDivElement, "filter");
  ASPx.SetElementOpacity(this.loadingDivElement, 0.01);
 },
 RestoreLoadingDivOpacity: function() {
  if(!this.loadingDivElement) return;
  ASPx.Attr.RestoreStyleAttribute(this.loadingDivElement, "opacity");
  ASPx.Attr.RestoreStyleAttribute(this.loadingDivElement, "filter");
 },
 SetLoadingDivBounds: function(offsetElement, loadingDiv) {
  var absX = (offsetElement == document.body) ? 0 : ASPx.GetAbsoluteX(offsetElement);
  var absY = (offsetElement == document.body) ? 0 : ASPx.GetAbsoluteY(offsetElement);
  ASPx.SetStyles(loadingDiv, {
   left: ASPx.PrepareClientPosForElement(absX, loadingDiv, true),
   top: ASPx.PrepareClientPosForElement(absY, loadingDiv, false)
  });
  var width = (offsetElement == document.body) ? ASPx.GetDocumentWidth() : offsetElement.offsetWidth;
  var height = (offsetElement == document.body) ? ASPx.GetDocumentHeight() : offsetElement.offsetHeight;
  if(height < 0) 
   height = 0;
  ASPx.SetStyles(loadingDiv, { width: width, height: height });
  var correctedWidth = 2 * width - loadingDiv.offsetWidth;
  if(correctedWidth <= 0) correctedWidth = width;
  var correctedHeight = 2 * height - loadingDiv.offsetHeight;
  if(correctedHeight <= 0) correctedHeight = height;
  ASPx.SetStyles(loadingDiv, { width: correctedWidth, height: correctedHeight });
 },
 ShowLoadingDiv: function() {
 },
 HideLoadingDiv: function() {
  this.hasPhantomLoadingElements = false;
  if(ASPx.IsExistsElement(this.loadingDivElement)){
   ASPx.RemoveElement(this.loadingDivElement);
   this.loadingDivElement = null;
  }
 },
 CanHandleGesture: function(evt) {
  return false;
 },
 CanHandleGestureCore: function(evt) {
  var source = ASPx.Evt.GetEventSource(evt);
  if(ASPx.GetIsParent(this.loadingPanelElement, source) || ASPx.GetIsParent(this.loadingDivElement, source))
   return true; 
  var callbackAnimationElement = this.GetCallbackAnimationElement();
  if(!callbackAnimationElement)
   return false;
  var animationContainer = ASPx.AnimationHelper.getSlideAnimationContainer(callbackAnimationElement, false, false);
  if(animationContainer && ASPx.GetIsParent(animationContainer, source) && !ASPx.GetIsParent(animationContainer.childNodes[0], source))
   return true; 
  return this.CanHandleGesture(evt); 
 },
 AllowStartGesture: function() {
  return !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing;
 },
 StartGesture: function() {
 },
 AllowExecuteGesture: function(value) {
  return false;
 },
 ExecuteGesture: function(value) {
 },
 CancelGesture: function(value) {
  if(this.repeatedGestureCount === 0) {
   this.repeatedGestureValue = value;
   this.repeatedGestureCount = 1;
  }
  else {
   if(this.repeatedGestureValue * value > 0)
    this.repeatedGestureCount++;
   else
    this.repeatedGestureCount--;
   if(this.repeatedGestureCount === 0)
    this.repeatedGestureCount = 0;
  }
 },
 CheckRepeatGesture: function() {
  if(this.repeatedGestureCount !== 0) {
   if(this.AllowExecuteGesture(this.repeatedGestureValue))
    this.ExecuteGesture(this.repeatedGestureValue, this.repeatedGestureCount);
   this.repeatedGestureValue = 0;
   this.repeatedGestureCount = 0;
  }
 },
 AllowExecutePagerGesture: function (pageIndex, pageCount, value) {
  if(pageIndex < 0) return false;
  if(pageCount <= 1) return false;
  if(value > 0 && pageIndex === 0) return false;
  if(value < 0 && pageIndex === pageCount - 1) return false;
  return true;
 },
 ExecutePagerGesture: function(pageIndex, pageCount, value, count, method) {
  if(!count) count = 1;
  var pageIndex = pageIndex + (value < 0 ? count : -count);
  if(pageIndex < 0) pageIndex = 0;
  if(pageIndex > pageCount - 1) pageIndex = pageCount - 1;
  method(PagerCommands.PageNumber + pageIndex);
 },
 RaiseInit: function(){
  if(!this.Init.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.Init.FireEvent(this, args);
  }
 },
 RaiseBeginCallbackInternal: function(command){
  if(!this.BeginCallback.IsEmpty()){
   var args = new ASPxClientBeginCallbackEventArgs(command);
   this.BeginCallback.FireEvent(this, args);
  }
 },
 RaiseEndCallbackInternal: function(command) {
  if(!this.EndCallback.IsEmpty()){
   var args = new ASPxClientEndCallbackEventArgs(command);
   this.EndCallback.FireEvent(this, args);
  }
 },
 RaiseCallbackErrorInternal: function(message, callbackId) {
  if(!this.CallbackError.IsEmpty()) {
   var args = new ASPxClientCallbackErrorEventArgs(message, callbackId);
   this.CallbackError.FireEvent(this, args);
   if(args.handled)
    return { isHandled: true, errorMessage: args.message };
  }
 },
 RaiseBeginCallback: function(command){
  this.RaiseBeginCallbackInternal(command);    
  aspxGetControlCollection().RaiseBeginCallback(this, command);
 },
 RaiseEndCallback: function(command){
  this.RaiseEndCallbackInternal(command);
  aspxGetControlCollection().RaiseEndCallback(this, command);
 },
 RaiseCallbackError: function (message, callbackId) {
  var result = this.RaiseCallbackErrorInternal(message, callbackId);
  if(!result) 
   result = aspxGetControlCollection().RaiseCallbackError(this, message, callbackId);
  return result;
 },
 RaiseEndCallbackAnimationStart: function(){
  if(!this.EndCallbackAnimationStart.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EndCallbackAnimationStart.FireEvent(this, args);
  }
 },
 RaiseBeforePronounce: function(message) {
  var args = new ASPxClientControlBeforePronounceEventArgs(message, this);
  if(!this.BeforePronounce.IsEmpty())
   this.BeforePronounce.FireEvent(this, args);
  return args;
 },
 RaiseUnload: function() {
  var args = new ASPxClientControlUnloadEventArgs(this);
  if(!this.Unload.IsEmpty())
   this.Unload.FireEvent(this, args);
 },
 SendMessageToAssistiveTechnology: function(message) {
  if(!this.accessibilityCompliant)
   return;
  this.PronounceMessageInternal(message, ASPx.AccessibilityPronouncerType.live);
 },
 PronounceMessageInternal: function(messageArg, type) {
  var message = messageArg;
  if(!ASPx.Ident.IsArray(messageArg))
   message = [messageArg];
  var args = this.RaiseBeforePronounce(message);
  ASPx.AccessibilityPronouncer.Pronounce(args, type);
 },
 IsVisible: function() {
  var element = this.GetMainElement();
  return ASPx.IsElementVisible(element);
 },
 IsDisplayedElement: function(element) {
  while(element && element.tagName != "BODY") {
   if(!ASPx.GetElementDisplay(element)) 
    return false;
   element = element.parentNode;
  }
  return true;
 },
 IsDisplayed: function() {
  return this.IsDisplayedElement(this.GetMainElement());
 },
 IsHiddenElement: function(element) {
  return element && element.offsetWidth == 0 && element.offsetHeight == 0;
 },
 IsHidden: function() {
  return this.IsHiddenElement(this.GetMainElement());
 },
 GetParentControl: function() {
  var mainElement = this.GetMainElement() || (this.GetCurrentWindowElement && this.GetCurrentWindowElement());
  var popupPostfix = ASPx.PCWIdSuffix + "-1";
  var result = null;
  ASPx.GetParent(mainElement, function(element) {
   if(element === mainElement || !element.id)
    return false;
   var controlName = element.id.replace(popupPostfix, "");
   result = ASPx.GetControlCollection().Get(controlName);
   return !!result;
  });
  return result;
 },
 findParentByType: function (type) {
  var ctrl = this;
  while (ctrl) {
   var parent = ctrl.GetParentControl();
   if (parent && parent instanceof type)
    return parent;
   ctrl = parent;
  }
  return null;
 },
 Focus: function() {
 },
 GetClientVisible: function(){
  return this.GetVisible();
 },
 SetClientVisible: function(visible){
  this.SetVisible(visible);
 },
 GetVisible: function(){
  return this.clientVisible;
 },
 SetVisible: function(visible){
  if(this.clientVisible != visible){
   this.clientVisible = visible;
   ASPx.SetElementDisplay(this.GetMainElement(), visible);
   if(visible) {
    this.AdjustControl();
    var mainElement = this.GetMainElement();
    if(mainElement)
     aspxGetControlCollection().AdjustControls(mainElement);
   }
  }
 },
 GetEnabled: function() {
  return this.clientEnabled;
 },
 SetEnabled: function(enabled) {
  this.clientEnabled = enabled;
  if(ASPxClientControl.setEnabledLocked)
   return;
  else
   ASPxClientControl.setEnabledLocked = true;
  this.savedClientEnabled = enabled;
  aspxGetControlCollection().ProcessControlsInContainer(this.GetMainElement(), function(control) {
   if(ASPx.IsFunction(control.SetEnabled))
    control.SetEnabled(enabled && control.savedClientEnabled);
  });
  delete ASPxClientControl.setEnabledLocked;
 },
 InCallback: function() {
  return this.requestCount > 0;
 },
 DoBeginCallback: function(command) {
  this.RaiseBeginCallback(command || "");
  aspxGetControlCollection().Before_WebForm_InitCallback(this.name);
  if(typeof(WebForm_InitCallback) != "undefined" && WebForm_InitCallback) {
   __theFormPostData = "";
   __theFormPostCollection = [ ];
   this.ClearPostBackEventInput("__EVENTTARGET");
   this.ClearPostBackEventInput("__EVENTARGUMENT");
   WebForm_InitCallback();
   this.savedFormPostData = __theFormPostData;   
   this.savedFormPostCollection = __theFormPostCollection;
  }
 },
 ClearPostBackEventInput: function(id){
  var element = ASPx.GetElementById(id);
  if(element != null) element.value = "";
 },
 PerformDataCallback: function(arg, handler) {
  this.CreateCustomDataCallback(arg, "", handler);
 },
 sendCallbackViaQueue: function (prefix, arg, showLoadingPanel, context, handler, onBeforeSend) {
  if (!this.useCallbackQueue())
   return false;
  var context = context || this;
  var token = this.callbackQueueHelper.sendCallback(ASPx.FormatCallbackArg(prefix, arg), context, handler || context.OnCallback, prefix, onBeforeSend);
  if (showLoadingPanel)
   this.callbackQueueHelper.showLoadingElements();
  return token;
 },
 CreateCallback: function (arg, command, handler) {
  var callbackInfo = this.CreateCallbackInfo(ASPx.CallbackType.Common, handler || null);
  var callbackID = this.CreateCallbackByInfo(arg, command, callbackInfo);
  return callbackID;
 },
 CreateCustomDataCallback: function(arg, command, handler) {
  var callbackInfo = this.CreateCallbackInfo(ASPx.CallbackType.Data, handler);
  this.CreateCallbackByInfo(arg, command, callbackInfo);
 },
 CreateCallbackByInfo: function(arg, command, callbackInfo) {
  if(!this.CanCreateCallback()) return;
  var callbackID;
  if(typeof(WebForm_DoCallback) != "undefined" && WebForm_DoCallback && ASPx.documentLoaded || ASPx.Platform === "NETCORE")
   callbackID = this.CreateCallbackInternal(arg, command, true, callbackInfo);
  else {
   if(!this.savedCallbacks)
    this.savedCallbacks = [];
   var callbackInfo = { arg: arg, command: command, callbackInfo: callbackInfo };
   if(this.allowMultipleCallbacks)
    this.savedCallbacks.push(callbackInfo);
   else
    this.savedCallbacks[0] = callbackInfo;
  }
  return callbackID;
 },
 CreateCallbackInternal: function(arg, command, viaTimer, callbackInfo) {
  var watcher = ASPx.ControlUpdateWatcher.getInstance();
  if(watcher && !watcher.CanSendCallback(this, arg)) {
   this.CancelCallbackInternal();
   return;
  }
  this.requestCount++;
  this.DoBeginCallback(command);
  if(typeof(arg) == "undefined")
   arg = "";
  if(typeof(command) == "undefined")
   command = "";
  var callbackID = this.SaveCallbackInfo(callbackInfo, command),
   customArgs = this.GetCustomCallbackArgs();
  if(viaTimer)
   window.setTimeout(function() { this.CreateCallbackCoreWithCustomArgs(arg, command, callbackID, customArgs); }.aspxBind(this), 0);
  else
   this.CreateCallbackCoreWithCustomArgs(arg, command, callbackID, customArgs);
  return callbackID;
 },
 CreateCallbackCoreWithCustomArgs: function(arg, command, callbackID, customArgs) {
  this.CreateCallbackCore(arg, command, callbackID);
 },
 GetCustomCallbackArgs: function() {
  return {};
 },
 CancelCallbackInternal: function() {
  this.CancelCallbackCore();
  this.HideLoadingElements();
 },
 CancelCallbackCore: function() {
 },
 CreateCallbackCore: function(arg, command, callbackID) {
  var callBackMethod = this.GetCallbackMethod(command);
  __theFormPostData = this.savedFormPostData;
  __theFormPostCollection = this.savedFormPostCollection;
  callBackMethod.call(this, this.GetSerializedCallbackInfoByID(callbackID) + arg);
 },
 GetCallbackMethod: function(command){
  return this.callBack;
 },
 CanCreateCallback: function() {
  return !this.InCallback() || (this.allowMultipleCallbacks && !this.beginCallbackAnimationProcessing && !this.endCallbackAnimationProcessing);
 },
 DoLoadCallbackScripts: function() {
  ASPx.ProcessScriptsAndLinks(this.name, true);
 },
 DoEndCallback: function() {
  if(this.IsCallbackAnimationEnabled() && this.CheckEndCallbackAnimationNeeded()) 
   return;
  this.requestCount--;
  if (this.requestCount < 1) 
   this.callbackHandlersQueue.executeCallbacksHandlers();
  if(this.HideLoadingPanelOnCallback() && this.requestCount < 1) 
   this.HideLoadingElements();
  if(this.isSwipeGesturesEnabled() && this.supportGestures) {
   ASPx.GesturesHelper.UpdateSwipeAnimationContainer(this.name);
   if(this.touchUIMouseScroller)
    this.touchUIMouseScroller.update();
  }
  this.isCallbackAnimationPrevented = false;
  this.OnCallbackFinalized();
  this.AssignEllipsisTooltips();
  var command = this.GetCallbackCommand();
  this.RaiseEndCallback(command);
  this.currentCallbackID = -1;
 },
 DoFinalizeCallback: function() {
 },
 OnCallbackFinalized: function() {
 },
 AssignEllipsisTooltips: function() { },
 GetCallbackCommand: function() {
  var result = "";
  if(this.currentCallbackID != -1) {
   var command = this.callbackCommand[this.currentCallbackID];
   if(command)
    result = command;
  }
  return result;
 },
 HideLoadingPanelOnCallback: function() {
  return true;
 },
 ShouldHideExistingLoadingElements: function() {
  return true;
 },
 EvalCallbackResult: function(resultString){
  return eval(resultString);
 },
 ParseJSProperties: function(resultObj) {
  if(resultObj.cp) {
   for(var name in resultObj.cp)
    if(resultObj.cp.hasOwnProperty(name)) {
     this[name] = resultObj.cp[name];
     if(this.aspNetCoreWrapperInstance)
      this.aspNetCoreWrapperInstance[name] = resultObj.cp[name]; 
    }
  }
 },
 DoCallback: function(result) {
  if(this.IsCallbackAnimationEnabled() && this.CheckBeginCallbackAnimationInProgress(result))
   return;
  result = ASPx.Str.Trim(result);
  if(result.indexOf(ASPx.CallbackResultPrefix) != 0) 
   this.ProcessCallbackGeneralError(result, false);
  else {
   var resultObj = null;
   try {
    resultObj = this.EvalCallbackResult(result);
   } 
   catch(e) {
   }
   if(resultObj) {
    this.currentCallbackID = resultObj.id;
    ASPx.CacheHelper.DropCache(this);
    if(resultObj.redirect) {
     this.ParseJSProperties(resultObj); 
     ASPx.Url.Redirect(resultObj.redirect);
    }
    else if(ASPx.IsExists(resultObj.generalError)) {
     this.ProcessCallbackGeneralError(resultObj.generalError, true);
    }
    else {
     var errorObj = resultObj.error;
     if(errorObj) { 
      if(this.parseJSPropertiesOnCallbackError)
       this.ParseJSProperties(resultObj);
      this.ProcessCallbackError(errorObj,resultObj.id);
     } else {
      this.ParseJSProperties(resultObj);
      var callbackInfo = this.DequeueCallbackInfo(resultObj.id);
      if(callbackInfo && callbackInfo.type == ASPx.CallbackType.Data)
       this.ProcessCustomDataCallback(resultObj.result, callbackInfo);
      else {
       if (this.useCallbackQueue() && this.callbackQueueHelper.getCallbackInfoById(resultObj.id))
        this.callbackQueueHelper.processCallback(resultObj.result, resultObj.id);
       else {
        this.ProcessCallback(resultObj.result, resultObj.id);
        if(callbackInfo && callbackInfo.handler) {
         var handlerInfo = { handler: callbackInfo.handler, result: resultObj.result.data };
         this.callbackHandlersQueue.addCallbackHandler(handlerInfo);
        }
       }
      }
     }
    }
   }
  }
  this.DoLoadCallbackScripts();
 },
 DoCallbackError: function(result) {
  this.HideLoadingElements();
  this.ProcessCallbackGeneralError(result, false); 
 },
 DoControlClick: function(evt) {
  this.OnControlClick(ASPx.Evt.GetEventSource(evt), evt);
 },
 ProcessCallback: function (result, callbackId) {
  this.OnCallback(result, callbackId);
 },
 ProcessCustomDataCallback: function(result, callbackInfo) {
  if(callbackInfo.handler != null)
   callbackInfo.handler(this, result);
  this.RaiseCustomDataCallback(result);
 },
 RaiseCustomDataCallback: function(result) {
  if(!this.CustomDataCallback.IsEmpty()) {
   var arg = new ASPxClientCustomDataCallbackEventArgs(result);
   this.CustomDataCallback.FireEvent(this, arg);
  }
 },
 OnCallback: function(result) {
 },
 CreateCallbackInfo: function(type, handler) {
  return { type: type, handler: handler };
 },
 GetSerializedCallbackInfoByID: function(callbackID) {
  return this.GetCallbackInfoByID(callbackID).type + callbackID + ASPx.CallbackSeparator;
 },
 SaveCallbackInfo: function(info, command) {
  var callbacks = this.GetActiveCallbacksInfo();
  var index = callbacks.indexOf(null);
  if(index === -1)
   index = callbacks.length;
  callbacks[index] = info;
  this.callbackCommand[index] = command;
  return index;
 },
 GetActiveCallbacksInfo: function() {
  var persistentProperties = this.GetPersistentProperties();
  if(!persistentProperties.activeCallbacks)
   persistentProperties.activeCallbacks = [ ];
  return persistentProperties.activeCallbacks;
 },
 GetPersistentProperties: function() {
  var storage = _aspxGetPersistentControlPropertiesStorage();
  var persistentProperties = storage[this.name];
  if(!persistentProperties) {
   persistentProperties = { };
   storage[this.name] = persistentProperties;
  }
  return persistentProperties;
 },
 GetCallbackInfoByID: function(callbackID) {
  return this.GetActiveCallbacksInfo()[callbackID];
 },
 DequeueCallbackInfo: function(index) {
  var activeCallbacksInfo = this.GetActiveCallbacksInfo();
  if(index < 0 || index >= activeCallbacksInfo.length)
   return null;
  var result = activeCallbacksInfo[index];
  activeCallbacksInfo[index] = null;
  return result;
 },
 ProcessCallbackError: function (errorObj, callbackId) {
  var data = ASPx.IsExists(errorObj.data) ? errorObj.data : null;
  var result = this.RaiseCallbackError(errorObj.message, callbackId);
  if(result.isHandled)
   this.OnCallbackErrorAfterUserHandle(result.errorMessage, data); 
  else
   this.OnCallbackError(result.errorMessage, data); 
 },
 OnCallbackError: function(errorMessage, data) {
  if(errorMessage)
   ASPx.ShowErrorAlert(errorMessage);
 },
 OnCallbackErrorAfterUserHandle: function(errorMessage, data) {
 },
 ProcessCallbackGeneralError: function(errorMessage, serverExceptionOnLastCallback) {
  this.serverExceptionOnLastCallback = serverExceptionOnLastCallback;
  var result = this.RaiseCallbackError(errorMessage);
  if(result.isHandled)
   this.OnCallbackGeneralErrorAfterUserHandle(result.errorMessage);
  else
   this.OnCallbackGeneralError(result.errorMessage);
 },
 OnCallbackGeneralError: function(errorMessage) {
  this.OnCallbackError(errorMessage, null);
 },
 OnCallbackGeneralErrorAfterUserHandle: function (errorMessage) {
 },
 SendPostBack: function(params, preventConvertToUpdatePanelCallback) {
  if(preventConvertToUpdatePanelCallback)
   this.sendMSAjaxCompatPostBack(params);
  else
   this.sendPostBackInternal(params);
 },
 sendPostBackInternal: function(params) {
  if(typeof(__doPostBack) != "undefined")
   __doPostBack(this.uniqueID, params);
  else{
   var form = this.GetParentForm();
   if(form) form.submit();
  }
 },
 sendMSAjaxCompatPostBack: function(params) {
  var rm = ASPx.GetMSAjaxRequestManager();
  var triggers = rm ? rm._postBackControlClientIDs : null;
  var needRegister = triggers && ASPx.Ident.IsArray(triggers) && ASPx.Data.ArrayIndexOf(triggers, this.name) == -1;
  if(needRegister)
   triggers.unshift(this.name);
  this.sendPostBackInternal(params);
  if(needRegister)
   triggers.shift();
 },
 IsValidInstance: function () {
  return aspxGetControlCollection().GetByName(this.name) === this;
 },
 OnDispose: function() { 
  var varName = this.globalName;
  if(varName && varName !== "" && window && window[varName] && window[varName] == this){
   try{
    delete window[varName];
   }
   catch(e){  }
  }
  if(this.callbackQueueHelper)
   this.callbackQueueHelper.detachEvents();
 },
 OnGlobalControlsInitialized: function(args) { 
 },
 OnGlobalBrowserWindowResized: function(args) { 
 },
 OnGlobalBeginCallback: function(args) { 
 },
 OnGlobalEndCallback: function(args) { 
 },
 OnGlobalCallbackError: function(args) { 
 },
 OnGlobalValidationCompleted: function(args) { 
 },
 AddDefaultStateControllerItems: function() {
  var states = this.scStates;
  if(!states) return;
  var postfix = this.scPostfix ? ("_" + this.scPostfix) : "";
  var mainElementId = this.GetMainElementId();
  if(states & 2)
   this.AddDefaultReadOnlyStateControllerItem(this.scPrefix + "ReadOnly" + postfix, mainElementId);
  if(states & 4)
   this.AddDefaultDisabledStateControllerItem(this.scPrefix + "Disabled" + postfix, mainElementId);
 },
 AddDefaultReadOnlyStateControllerItem: function(cssClass, mainElementId) { throw "Not implemented"; },
 AddDefaultDisabledStateControllerItem: function(cssClass, mainElementId) { throw "Not implemented"; },
 DOMContentLoaded: function() { },
 IsStateControllerEnabled: function() { return false; },
 InitializeDOM: function() {
  var mainElement = this.GetMainElement();
  if(mainElement)
   ASPx.SetElementInitializedFlag(mainElement);
 },
 IsDOMInitialized: function() {
  var mainElement = this.GetMainElement();
  return mainElement && ASPx.GetElementInitializedFlag(mainElement);
 },
 AdjustControl: function(nestedCall) { },
 OnBrowserWindowResizeInternal: function(e) { },
 RegisterInControlTree: function(tree) { }
});
ASPxClientControlBase.Cast = function(obj) {
 if(typeof obj == "string")
  return window[obj];
 return obj;
};
var persistentControlPropertiesStorage = null;
function _aspxGetPersistentControlPropertiesStorage() {
 if(persistentControlPropertiesStorage == null)
  persistentControlPropertiesStorage = { };
 return persistentControlPropertiesStorage;
}
var ELLIPSIS_MARKER_CLASS = "dx-ellipsis";
var ELLIPSIS_TOOLTIP_MARKER_ATTR = "dxEllipsisTitle";
var ASPxClientControl = ASPx.CreateClass(ASPxClientControlBase, {
 constructor: function(name){
  this.constructor.prototype.constructor.call(this, name);
  this.rtl = false;
  this.enableEllipsis = false;
  this.isNative = false;
  this.isControlCollapsed = false;
  this.isInsideHierarchyAdjustment = false;
  this.controlOwner = null;
  this.adjustedSizes = { };
  this.dialogContentHashTable = { };
  this.renderIFrameForPopupElements = false;
  this.widthValueSetInPercentage = false;
  this.heightValueSetInPercentage = false;
  this.verticalAlignedElements = { };
  this.wrappedTextContainers = { };
  this.scrollPositionState = { };
  this.sizingConfig = {
   allowSetWidth: true,
   allowSetHeight: true,
   correction : false,
   adjustControl : false,
   supportPercentHeight: false,
   supportAutoHeight: false
  };
  this.percentSizeConfig = {
   width: -1,
   height: -1,
   markerWidth: -1,
   markerHeight: -1
  };  
 },
 querySelector: function(selector) { return this.querySelectorAll(selector)[0] || null; },
 querySelectorAll: function(selector) {
  return ASPx.CacheHelper.GetCachedElement(this, "querySelectorAll_" + selector,
   function() { return Array.prototype.slice.call(this.GetMainElement().querySelectorAll(selector)); });
 },
 createAccessKey: function (popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing) {
  return new ASPx.AccessKey(popupItem, getPopupElement, keyTipElement, key, onlyClick, manualStopProcessing);
 },
 InlineInitialize: function() {
  this.InitializeDOM();
  ASPxClientControlBase.prototype.InlineInitialize.call(this);
 },
 AfterCreate: function() { 
  ASPxClientControlBase.prototype.AfterCreate.call(this);
  if(!this.CanInitializeAdjustmentOnDOMContentLoaded() || ASPx.IsStartupScriptsRunning())
   this.InitializeAdjustment();
 },
 DOMContentLoaded: function() {
  if(this.CanInitializeAdjustmentOnDOMContentLoaded()) 
   this.InitializeAdjustment();
 },
 CanInitializeAdjustmentOnDOMContentLoaded: function() {
  return !ASPx.Browser.IE || ASPx.Browser.Version >= 10; 
 },
 InitializeAdjustment: function() {
  this.UpdateAdjustmentFlags();
  this.AdjustControl();
 },
 AfterInitialize: function() {
  this.AdjustControl();
  ASPxClientControlBase.prototype.AfterInitialize.call(this);
 },
 IsStateControllerEnabled: function(){
  return typeof(ASPx.GetStateController) != "undefined" && ASPx.GetStateController();
 },
 GetWidth: function() {
  return this.GetMainElement().offsetWidth;
 },
 GetHeight: function() {
  return this.GetMainElement().offsetHeight;
 },
 SetWidth: function(width) {
  if(this.sizingConfig.allowSetWidth)
   this.SetSizeCore("width", width, "GetWidth", false);
 },
 SetHeight: function(height) {
  if(this.sizingConfig.allowSetHeight)
   this.SetSizeCore("height", height, "GetHeight", false);
 },
 SetSizeCore: function(sizePropertyName, size, getFunctionName, corrected) {
  if(size < 0)
   return;
  this.GetMainElement().style[sizePropertyName] = size + "px";
  this.UpdateAdjustmentFlags(sizePropertyName);
  if(this.sizingConfig.adjustControl)
   this.AdjustControl(true);
  if(this.sizingConfig.correction && !corrected) {
   var realSize = this[getFunctionName]();
   if(realSize != size) {
    var correctedSize = size - (realSize - size);
    this.SetSizeCore(sizePropertyName, correctedSize, getFunctionName, true);
   }
  }
 },
 AdjustControl: function(nestedCall) {
  if(this.IsAdjustmentRequired() && (!ASPxClientControl.adjustControlLocked || nestedCall)) {
   ASPxClientControl.adjustControlLocked = true;
   try {
    if(!this.IsAdjustmentAllowed())
     return;
    this.AdjustControlCore();
    this.UpdateAdjustedSizes();
   } 
   finally {
    delete ASPxClientControl.adjustControlLocked;
   }
  }
  this.AssignEllipsisTooltips();
  this.TryShowPhantomLoadingElements();
 },
 ResetControlAdjustment: function () {
  this.adjustedSizes = { };
 },
 UpdateAdjustmentFlags: function(sizeProperty) {
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var mainElementStyle = ASPx.GetCurrentStyle(mainElement);
   this.UpdatePercentSizeConfig([mainElementStyle.width, mainElement.style.width], [mainElementStyle.height, mainElement.style.height], sizeProperty);
  }
 },
 UpdatePercentSizeConfig: function(widths, heights, modifyStyleProperty) {
  switch(modifyStyleProperty) {
   case "width":
    this.UpdatePercentWidthConfig(widths);
    break;
   case "height":
    this.UpdatePercentHeightConfig(heights);
    break;
   default:
    this.UpdatePercentWidthConfig(widths);
    this.UpdatePercentHeightConfig(heights);
    break;
  }
  this.ResetControlPercentMarkerSize();
 },
 UpdatePercentWidthConfig: function(widths) {
  this.widthValueSetInPercentage = false;
  for(var i = 0; i < widths.length; i++) {
   if(this.IsPercentageWidth(widths[i])) {
    this.percentSizeConfig.width = widths[i];
    this.widthValueSetInPercentage = true;
    break;
   }
  }
 },
 IsPercentageWidth: function(width) { return ASPx.IsPercentageSize(width); },
 UpdatePercentHeightConfig: function(heights) {
  this.heightValueSetInPercentage = false;
    for(var i = 0; i < heights.length; i++) {
   if(ASPx.IsPercentageSize(heights[i])) {
    this.percentSizeConfig.height = heights[i];
    this.heightValueSetInPercentage = true;
    break;
   }
  }
 },
 GetAdjustedSizes: function() {
  var mainElement = this.GetMainElement();
  if(mainElement) 
   return { width: mainElement.offsetWidth, height: mainElement.offsetHeight };
  return { width: 0, height: 0 };
 },
 IsAdjusted: function() {
  return (this.adjustedSizes.width && this.adjustedSizes.width > 0) && (this.adjustedSizes.height && this.adjustedSizes.height > 0);
 },
 IsAdjustmentRequired: function() {
  if(!this.IsAdjusted())
   return true;
  if(this.widthValueSetInPercentage)
   return true;
  if(this.heightValueSetInPercentage)
   return true;
  var sizes = this.GetAdjustedSizes();
  for(var name in sizes){
   if(this.adjustedSizes[name] !== sizes[name])
    return true;
  }
  return false;
 },
 IsAdjustmentAllowed: function() {
  var mainElement = this.GetMainElement();
  return mainElement && this.IsDisplayed() && !this.IsHidden() && this.IsDOMInitialized();
 },
 UpdateAdjustedSizes: function() {
  var sizes = this.GetAdjustedSizes();
  for(var name in sizes)
   if(sizes.hasOwnProperty(name))
    this.adjustedSizes[name] = sizes[name];
 },
 AdjustControlCore: function() {
 },
 AdjustAutoHeight: function() {
 },
 IsControlCollapsed: function() {
  return this.isControlCollapsed;
 },
 NeedCollapseControl: function() {
  return this.NeedCollapseControlCore() && this.IsAdjustmentRequired() && this.IsAdjustmentAllowed();
 },
 NeedCollapseControlCore: function() {
  return false;
 },
 CollapseEditor: function() {
 },
 CollapseControl: function() {
  this.SaveScrollPositions();
  var mainElement = this.GetMainElement(),
   marker = this.GetControlPercentSizeMarker();
  marker.style.height = this.heightValueSetInPercentage && this.sizingConfig.supportPercentHeight
   ? this.percentSizeConfig.height 
   : (mainElement.offsetHeight + "px");
  mainElement.style.display = "none";
  this.isControlCollapsed = true;
 },
 ExpandControl: function() {
  var mainElement = this.GetMainElement();
  mainElement.style.display = "";
  this.GetControlPercentSizeMarker().style.height = "0px";
  this.isControlCollapsed = false;
  this.RestoreScrollPositions();
 },
 CanCauseReadjustment: function() {
  return this.NeedCollapseControlCore();
 },
 IsExpandableByAdjustment: function() {
  return false;
 },
 HasFixedPosition: function() {
  return false;
 },
 SaveScrollPositions: function() {
  var mainElement = this.GetMainElement();
  this.scrollPositionState.outer = ASPx.GetOuterScrollPosition(mainElement.parentNode);
  this.scrollPositionState.inner = ASPx.GetInnerScrollPositions(mainElement);
 },
 RestoreScrollPositions: function() {
  ASPx.RestoreOuterScrollPosition(this.scrollPositionState.outer);
  ASPx.RestoreInnerScrollPositions(this.scrollPositionState.inner);
 },
 GetControlPercentSizeMarker: function() {
  if(this.percentSizeMarker === undefined) {
   this.percentSizeMarker = ASPx.CreateHtmlElementFromString("<div style='height:0px;font-size:0px;line-height:0;width:100%;'></div>");
   ASPx.InsertElementAfter(this.percentSizeMarker, this.GetMainElement());
  }
  return this.percentSizeMarker;
 },
 KeepControlPercentSizeMarker: function(needCollapse, needCalculateHeight) {
  var marker = this.GetControlPercentSizeMarker(),
   markerHeight;
  if(needCollapse)
   this.CollapseControl();
  if(this.widthValueSetInPercentage && marker.style.width !== this.percentSizeConfig.width)
   marker.style.width = this.percentSizeConfig.width;
  if(needCalculateHeight) {
   if(this.IsControlCollapsed())
    markerHeight = marker.style.height;
   marker.style.height = this.percentSizeConfig.height;
  }
  this.percentSizeConfig.markerWidth = marker.offsetWidth;
  if(needCalculateHeight) {
   this.percentSizeConfig.markerHeight = marker.offsetHeight;
   if(this.IsControlCollapsed())
    marker.style.height = markerHeight;
   else
    marker.style.height = "0px";
  }
  if(needCollapse)
   this.ExpandControl();
 },
 ResetControlPercentMarkerSize: function() {
  this.percentSizeConfig.markerWidth = -1;
  this.percentSizeConfig.markerHeight = -1;
 },
 GetControlPercentMarkerSize: function(hideControl, force) {
  var needCalculateHeight = this.heightValueSetInPercentage && this.sizingConfig.supportPercentHeight;
  if(force || this.percentSizeConfig.markerWidth < 1 || (needCalculateHeight && this.percentSizeConfig.markerHeight < 1))
   this.KeepControlPercentSizeMarker(hideControl && !this.IsControlCollapsed(), needCalculateHeight);
  return {
   width: this.percentSizeConfig.markerWidth,
   height: this.percentSizeConfig.markerHeight
  };
 },
 AssignEllipsisTooltips: function() {
  if(this.RequireAssignTooltips())
   this.AssignEllipsisTooltipsCore();
 },
 AssignEllipsisTooltipsCore: function(rootElement, reassingExistingTooltips) {
  var requirePaddingManipulation = ASPx.Browser.IE || ASPx.Browser.Edge || ASPx.Browser.Firefox;
  rootElement = rootElement || this.GetMainElement();
  var nodes = this.GetEllipsisNodes(rootElement);
  var nodeInfos = [];
  var nodesCount = nodes.length;
  for(var i = 0; i < nodesCount; i++) {
   var node = nodes[i];
   var info = { node: node };
   if(requirePaddingManipulation) {
    var style = ASPx.GetCurrentStyle(node);
    info.paddingLeft = node.style.paddingLeft;
    info.totalPadding = ASPx.GetLeftRightPaddings(node, style);
   }
   nodeInfos.push(info);
  }
  if(requirePaddingManipulation) {
   for(var i = 0; i < nodesCount; i++) {
    var info = nodeInfos[i];
    ASPx.SetStyles(info.node, { paddingLeft: info.totalPadding }, true);
   }
  }
  for(var i = 0; i < nodesCount; i++) {
   var info = nodeInfos[i];
   var node = info.node;
   info.isTextShortened = node.scrollWidth > node.clientWidth;
   info.hasTitle = ASPx.Attr.GetAttribute(node, "title") !== null;
   if(!info.hasTitle || reassingExistingTooltips)
    info.title = this.GetEllipsisTooltipText(node);
  }
  for(var i = 0; i < nodesCount; i++) {
   var info = nodeInfos[i];
   var node = info.node;
   if(info.isTextShortened && info.title) {
    ASPx.Attr.SetAttribute(node, "title", info.title);
    ASPx.Attr.SetAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR, true);
   }
   if(!info.isTextShortened && info.hasTitle)
    ASPx.Attr.RemoveAttribute(node, "title");
  }
  if(requirePaddingManipulation) {
   for(var i = 0; i < nodesCount; i++) {
    var info = nodeInfos[i];
    var node = info.node;
    node.style.paddingLeft = info.paddingLeft;
   }
  }
 },
 GetEllipsisNodes: function(element) {
  var ellipsibleNodes = ASPx.Data.CollectionToArray(ASPx.GetNodesByClassName(element, ELLIPSIS_MARKER_CLASS));
  if(ASPx.ElementHasCssClass(element, ELLIPSIS_MARKER_CLASS))
   ellipsibleNodes.push(element);
  return ellipsibleNodes.filter(function(node) {
   return !ASPx.Attr.IsExistsAttribute(node, "title") || ASPx.Attr.IsExistsAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR);
  });
 },
 GetEllipsisTooltipText: function(element) {
  return ASPx.GetInnerText(element);
 },
 RequireAssignTooltips: function() {
  return this.enableEllipsis && !ASPx.Browser.MobileUI;
 },
 RemoveEllipsisFromNode: function(node) {
  ASPx.RemoveClassNameFromElement(node, ELLIPSIS_MARKER_CLASS);
  this.RemoveEllipsisTooltip(node);
 },
 RemoveEllipsisTooltip: function(node) {
  if(ASPx.Attr.IsExistsAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR)) {
   ASPx.Attr.RemoveAttribute(node, "title");
   ASPx.Attr.RemoveAttribute(node, ELLIPSIS_TOOLTIP_MARKER_ATTR);
  }
 },
 OnBrowserWindowResize: function(e) {
 },
 OnBrowserWindowResizeInternal: function(e){
  if(this.BrowserWindowResizeSubscriber()) 
   this.OnBrowserWindowResize(e);
 },
 BrowserWindowResizeSubscriber: function() {
  return this.widthValueSetInPercentage || !this.IsAdjusted();
 },
 ShrinkWrappedText: function(getElements, key, reCorrect) {
  if(!ASPx.Browser.Safari) return;
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.wrappedTextContainers);
  for(var i = 0; i < elements.length; i++)
   this.ShrinkWrappedTextInContainer(elements[i], reCorrect);
 },
 ShrinkWrappedTextInContainer: function(container, reCorrect) {
  if(!ASPx.Browser.Safari || !container || (container.dxWrappedTextShrinked && !reCorrect) || container.offsetWidth === 0) return;
  ASPx.ShrinkWrappedTextInContainer(container);
  container.dxWrappedTextShrinked = true;
 },
 CorrectWrappedText: function(getElements, key, reCorrect) {
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.wrappedTextContainers);
  for(var i = 0; i < elements.length; i++)
   this.CorrectWrappedTextInContainer(elements[i], reCorrect);
 },
 CorrectWrappedTextInContainer: function(container, reCorrect) {
  if(!container || (container.dxWrappedTextCorrected && !reCorrect) || container.offsetWidth === 0) return;
  ASPx.AdjustWrappedTextInContainer(container);
  container.dxWrappedTextCorrected = true;
 },
 CorrectVerticalAlignment: function(alignMethod, getElements, key, reAlign) {
  var elements = ASPx.CacheHelper.GetCachedElements(this, key, getElements, this.verticalAlignedElements);
  for(var i = 0; i < elements.length; i++)
   this.CorrectElementVerticalAlignment(alignMethod, elements[i], reAlign);
 },
 CorrectElementVerticalAlignment: function(alignMethod, element, reAlign) {
  if(!element || (element.dxVerticalAligned && !reAlign) || element.offsetHeight === 0) return;
  alignMethod(element);
  element.dxVerticalAligned = true;
 },
 ClearVerticalAlignedElementsCache: function() {
  ASPx.CacheHelper.DropCache(this.verticalAlignedElements);
 },
 ClearWrappedTextContainersCache: function() {
  ASPx.CacheHelper.DropCache(this.wrappedTextContainers);
 },
 AdjustPagerControls: function() {
  if(typeof(ASPx.GetPagersCollection) != "undefined")
   ASPx.GetPagersCollection().AdjustControls(this.GetMainElement());
 },
 RegisterInControlTree: function(tree) {
  var mainElement = this.GetMainElement();
  if(mainElement && mainElement.id)
   tree.createNode(mainElement.id, this);
 },
 GetItemElementName: function(element) {
  var name = "";
  if(element.id)
   name = element.id.substring(this.name.length + 1);
  return name;
 },
 GetLinkElement: function(element) {
  if(element == null) return null;
  return (element.tagName == "A") ? element : ASPx.GetNodeByTagName(element, "A", 0);
 },
 GetInternalHyperlinkElement: function(parentElement, index) {
  var element = ASPx.GetNodeByTagName(parentElement, "A", index);
  if(element == null) 
   element = ASPx.GetNodeByTagName(parentElement, "SPAN", index);
  return element;
 },
 OnControlClick: function(clickedElement, htmlEvent) {
 }
});
ASPxClientControl.Cast = function(obj) {
 if(typeof obj == "string")
  return window[obj];
 return obj;
};
ASPxClientControl.AdjustControls = function(container, collapseControls){
 aspxGetControlCollection().AdjustControls(container, collapseControls);
};
ASPxClientControl.GetControlCollection = function(){
 return aspxGetControlCollection();
};
ASPxClientControl.LeadingAfterInitCallConsts = {
 None: 0,
 Direct: 1,
 Reverse: 2
};
var ASPxClientComponent = ASPx.CreateClass(ASPxClientControl, {
 constructor: function (name) {
  this.constructor.prototype.constructor.call(this, name);
 },
 IsDOMDisposed: function() { 
  return false;
 }
});
var ASPxClientControlCollection = ASPx.CreateClass(ASPx.CollectionBase, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
  this.prevWndWidth = "";
  this.prevWndHeight = "";
  this.requestCountInternal = 0; 
  this.BeforeInitCallback = new ASPxClientEvent();
  this.ControlsInitialized = new ASPxClientEvent();
  this.BrowserWindowResized = new ASPxClientEvent();
  this.BeginCallback = new ASPxClientEvent();
  this.EndCallback = new ASPxClientEvent();
  this.CallbackError = new ASPxClientEvent();
  this.ValidationCompleted = new ASPxClientEvent();
  aspxGetControlCollectionCollection().Add(this);
 },
 Add: function(element) {
  var existsElement = this.Get(element.name);
  if(existsElement && existsElement !== element) 
   this.Remove(existsElement);
  ASPx.CollectionBase.prototype.Add.call(this, element.name, element);
 },
 Remove: function(element) {
  if(element && element instanceof ASPxClientControl)
   element.OnDispose();
  ASPx.CollectionBase.prototype.Remove.call(this, element.name);
 },
 GetGlobal: function(name) {
  var result = window[name];
  return result && Ident.IsASPxClientControl(result)
   ? result
   : null;
 },
 GetByName: function(name){
  return this.Get(name) || this.GetGlobal(name);
 },
 GetCollectionType: function(){
  return ASPxClientControlCollection.BaseCollectionType;
 },
 GetControlsByPredicate: function(predicate) {
  var result = [];
  this.ForEachControl(function(control) {
   if(!predicate || predicate(control))
    result.push(control);
  });
  return result;
 },
 GetControlsByType: function(type) {
  return this.GetControlsByPredicate(function(control) { 
   return type && (control instanceof type);
  });
 },
 ForEachControl: function(action, context) {
  context = context || this;
  this.elementsMap.forEachEntry(function(name, control) {
   if(Ident.IsASPxClientControl(control) && (!this.filterPredicate || this.filterPredicate(control)))
    return action.call(context, control);
  }, context);
 },
 ProcessActionByPredicate: function(action, predicate) {
  try {
   this.filterPredicate = predicate;
   action(this);
  }
  finally {
   this.filterPredicate = null;
  }
 },
 adjustControlsInternal: function(container, context, collapseControls, adjustFunc) {
  context = context || this;
  var func = function(control) {
   adjustFunc.call(context, control);
  };
  ASPx.GetControlAdjuster().adjustControlsInHierarchy(this, func, container, collapseControls);
 },
 AdjustControls: function(container, collapseControls) {
  container = container || null;
  window.setTimeout(function() {
   this.AdjustControlsCore(container, collapseControls);
  }.aspxBind(this), 0);
 },
 AdjustControlsCore: function(container, collapseControls) {
  var adjustFunction = function(control) { control.AdjustControl(); };
  this.adjustControlsInternal(container, this, collapseControls, adjustFunction);
 },
 CollapseControls: function(container) {
  this.ProcessControlsInContainer(container, function(control) {
   if(control.isASPxClientEdit)
    control.CollapseEditor();
   else if(!!window.ASPxClientRibbon && control instanceof ASPxClientRibbon)
    control.CollapseControl();
  });
 },
 AtlasInitialize: function(isCallback) {
  this.ForEachControl(function(control) {
   control.AtlasPreInitialize();
  });
  ASPx.ProcessScriptsAndLinks("", isCallback);
  this.ForEachControl(function(control) {
   control.AtlasInitialize();
  });
 },
 DOMContentLoaded: function() {
  this.ForEachControl(function(control){
    control.DOMContentLoaded();
  });
 },
 OnDocumentUnload: function() {
  this.ForEachControl(function(control) {
   control.RaiseUnload();
  });
 },
 Initialize: function() {
  ASPx.GetPostHandler().Post.AddHandler(
   function(s, e) { this.OnPost(e); }.aspxBind(this)
  );
  ASPx.GetPostHandler().PostFinalization.AddHandler(
   function(s, e) { this.OnPostFinalization(e); }.aspxBind(this)
  );
  this.InitializeElements(false );
  if(typeof(Sys) != "undefined" && typeof(Sys.Application) != "undefined") {
   var checkIsInitialized = function() {
    if(Sys.Application.get_isInitialized())
     Sys.Application.add_load(aspxCAInit);
    else
     setTimeout(checkIsInitialized, 0);
   };
   checkIsInitialized();
  }
  this.InitWindowSizeCache();
 },
 FinalizeInitialization: function() {
  this.ForEachControl(function(control) {
   control.FinalizeInitialization();
  });
 },
 InitializeElements: function(isCallback) {
  this.ForEachControl(function(control){
   if(!control.isInitialized)
    control.Initialize();
  });
  this.AfterInitializeElementsLeadingCall();
  this.AfterInitializeElements();
  this.RaiseControlsInitialized(isCallback);
 },
 AfterInitializeElementsLeadingCall: function() {
  var controls = {};
  controls[ASPxClientControl.LeadingAfterInitCallConsts.Direct] = [];
  controls[ASPxClientControl.LeadingAfterInitCallConsts.Reverse] = [];
  this.ForEachControl(function(control) {
   if(control.leadingAfterInitCall != ASPxClientControl.LeadingAfterInitCallConsts.None && !control.isInitialized)
    controls[control.leadingAfterInitCall].push(control);
  });
  var directInitControls = controls[ASPxClientControl.LeadingAfterInitCallConsts.Direct],
   reverseInitControls = controls[ASPxClientControl.LeadingAfterInitCallConsts.Reverse];
  for(var i = 0, control; control = directInitControls[i]; i++)
   control.AfterInitialize();
  for(var i = reverseInitControls.length - 1, control; control = reverseInitControls[i]; i--)
   control.AfterInitialize();
 },
 AfterInitializeElements: function() {
  this.ForEachControl(function(control) {
   if(control.leadingAfterInitCall == ASPxClientControl.LeadingAfterInitCallConsts.None && !control.isInitialized)
    control.AfterInitialize();
  });
  ASPx.RippleHelper.Init();
 },
 DoFinalizeCallback: function() {
  this.ForEachControl(function(control){
   control.DoFinalizeCallback();
  });
 },
 ProcessControlsInContainer: function(container, processFunc, filterFunc) {
  this.ForEachControl(function(control){
   if((!filterFunc || filterFunc(control)) && (!container || this.IsControlInContainer(container, control)))
    processFunc(control);
  });
 },
 IsControlInContainer: function(container, control) {
  if(control.GetMainElement) {
   var mainElement = control.GetMainElement();
   if(mainElement && (mainElement != container)) {
    if(ASPx.GetIsParent(container, mainElement))
     return true;
   }
  }
  return false;
 },
 RaiseControlsInitialized: function(isCallback) {
  if(typeof(isCallback) == "undefined")
   isCallback = true;
  var args = new ASPxClientControlsInitializedEventArgs(isCallback);
  if(!this.ControlsInitialized.IsEmpty())  
   this.ControlsInitialized.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalControlsInitialized(args);
  });
 },
 RaiseBrowserWindowResized: function() {
  var args = new ASPxClientEventArgs();
  if(!this.BrowserWindowResized.IsEmpty())
   this.BrowserWindowResized.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalBrowserWindowResized(args);
  });
 },
 RaiseBeginCallback: function (control, command) {
  var args = new ASPxClientGlobalBeginCallbackEventArgs(control, command);
  if(!this.BeginCallback.IsEmpty())
   this.BeginCallback.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalBeginCallback(args);
  });
  this.IncrementRequestCount();
 },
 RaiseEndCallback: function (control) {
  var args = new ASPxClientGlobalEndCallbackEventArgs(control);
  if (!this.EndCallback.IsEmpty()) 
   this.EndCallback.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalEndCallback(args);
  });
  this.DecrementRequestCount();
 },
 InCallback: function() {
  return this.requestCountInternal > 0;
 },
 RaiseCallbackError: function (control, message, callbackId) {
  var args = new ASPxClientGlobalCallbackErrorEventArgs(control, message, callbackId);
  if (!this.CallbackError.IsEmpty()) 
   this.CallbackError.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalCallbackError(args);
  });
  if(args.handled)
   return { isHandled: true, errorMessage: args.message };  
  return { isHandled: false, errorMessage: message };
 },
 RaiseValidationCompleted: function (container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl) {
  var args = new ASPxClientValidationCompletedEventArgs(container, validationGroup, invisibleControlsValidated, isValid, firstInvalidControl, firstVisibleInvalidControl);
  if (!this.ValidationCompleted.IsEmpty()) 
   this.ValidationCompleted.FireEvent(this, args);
  this.ForEachControl(function(control){
   control.OnGlobalValidationCompleted(args);
  });
  return args.isValid;
 },
 Before_WebForm_InitCallback: function(callbackOwnerID){
  var args = new BeforeInitCallbackEventArgs(callbackOwnerID);
  this.BeforeInitCallback.FireEvent(this, args);
 },
 InitWindowSizeCache: function(){
  this.prevWndWidth = ASPx.GetDocumentClientWidth();
  this.prevWndHeight = ASPx.GetDocumentClientHeight();
 },
 OnBrowserWindowResize: function(evt){
  var shouldIgnoreNestedEvents = ASPx.Browser.IE && ASPx.Browser.MajorVersion == 8;
  if(shouldIgnoreNestedEvents) {
   if(this.prevWndWidth === "" || this.prevWndHeight === "" || this.browserWindowResizeLocked)
    return;
   this.browserWindowResizeLocked = true;
  }
  this.OnBrowserWindowResizeCore(evt);
  if(shouldIgnoreNestedEvents)
   this.browserWindowResizeLocked = false;
 },
 OnBrowserWindowResizeCore: function(htmlEvent){
  var args = this.CreateOnBrowserWindowResizeEventArgs(htmlEvent);
  if(this.CalculateIsBrowserWindowSizeChanged()) {
   this.adjustControlsInternal(null, this, true, function(control) {
    if(control.IsDOMInitialized())
     control.OnBrowserWindowResizeInternal(args);
   });
   this.RaiseBrowserWindowResized();
  }
 },
 CreateOnBrowserWindowResizeEventArgs: function(htmlEvent){
  return {
   htmlEvent: htmlEvent,
   wndWidth: ASPx.GetDocumentClientWidth(),
   wndHeight: ASPx.GetDocumentClientHeight(),
   prevWndWidth: this.prevWndWidth,
   prevWndHeight: this.prevWndHeight
  };
 },
 CalculateIsBrowserWindowSizeChanged: function(){
  var wndWidth = ASPx.GetDocumentClientWidth();
  var wndHeight = ASPx.GetDocumentClientHeight();
  var isBrowserWindowSizeChanged = (this.prevWndWidth != wndWidth) || (this.prevWndHeight != wndHeight);
  if(isBrowserWindowSizeChanged){
   this.prevWndWidth = wndWidth;
   this.prevWndHeight = wndHeight;
   return true;
  }
  return false;
 },
 OnPost: function(args){
  this.ForEachControl(function(control) {
   control.OnPost(args);
  }, null);
 },
 OnPostFinalization: function(args){
  this.ForEachControl(function(control) {
   control.OnPostFinalization(args);
  }, null);
 },
 IncrementRequestCount: function() {
  this.requestCountInternal++;
 },
 DecrementRequestCount: function() {
  this.requestCountInternal--;
 },
 ResetRequestCount: function() {
  this.requestCountInternal = 0;
 }
});
ASPxClientControlCollection.BaseCollectionType = "Control";
var controlCollection = null;
function aspxGetControlCollection(){
 if(controlCollection == null) {
  controlCollection = new ASPxClientControlCollection();
  if(ASPx.loadControlCollectionPreloadHandlers)
   ASPx.loadControlCollectionPreloadHandlers(controlCollection);
 }
 return controlCollection;
}
var ControlCollectionCollection = ASPx.CreateClass(ASPx.CollectionBase, {
 constructor: function(){
  this.constructor.prototype.constructor.call(this);
 },
 Add: function(element) {
  var key = element.GetCollectionType();
  if(!key) throw "The collection type isn't specified.";
  if(this.Get(key)) throw "The collection with type='" + key + "' already exists.";
  ASPx.CollectionBase.prototype.Add.call(this, key, element);
 },
 RemoveDisposedControls: function(){
  var baseCollection = this.Get(ASPxClientControlCollection.BaseCollectionType);
  var disposedControls = [];
  baseCollection.elementsMap.forEachEntry(function(name, control) {
   if(!ASPx.Ident.IsASPxClientControl(control)) return;
   if(control.IsDOMDisposed())
    disposedControls.push(control);
  });
  this.RemoveControls(disposedControls);
 },
 RemoveControls: function(controls){
  for(var i = 0; i < controls.length; i++) {
   this.elementsMap.forEachEntry(function(key, collection) {
    if(ASPx.Ident.IsASPxClientCollection(collection))
     collection.Remove(controls[i]);
   });
  }
 }
});
var controlCollectionCollection = null;
function aspxGetControlCollectionCollection(){
 if(controlCollectionCollection == null)
  controlCollectionCollection = new ControlCollectionCollection();
 return controlCollectionCollection;
}
var AriaDescriptionAttributes = {
 Role: "0",
 AriaLabel: "1",
 TabIndex: "2",
 AriaOwns: "3",
 AriaDescribedBy: "4",
 AriaDisabled: "5",
 AriaHasPopup: "6",
 AriaLevel: "7"
};
var AriaDescriptor = ASPx.CreateClass(null, {
 constructor: function(ownerControl, description) {
  this.ownerControl = ownerControl;
  this.rootElement = ownerControl.GetMainElement();
  this.description = description;
 },
 setDescription: function(name, argList) {
  var description = this.findChildDescription(name);
  if(description) {
   var elements = name ? this.rootElement.querySelectorAll(this.getDescriptionSelector(description)) : [this.rootElement];
   for(var i = 0; i < elements.length; i++)
    this.applyDescriptionToElement(elements[i], description, argList[i] || argList[0]);
  }
 },
 getDescriptionName: function(description) {
  return description.n;
 },
 getDescriptionSelector: function(description) {
  return description.s;
 },
 findChildDescription: function(name) {
  if(name === this.getDescriptionName(this.description))
   return this.description;
  var childCollection = this.description.c || [];
  for(var i = 0; i < childCollection.length; i++) {
   var childDescription = childCollection[i];
   if(this.getDescriptionName(childDescription) === name)
    return childDescription;
  }
  return null;
 },
 applyDescriptionToElement: function(element, description, args) {
  if(!description || !element)
   return;
  this.trySetAriaOwnsAttribute(element, description);
  this.trySetAriaDescribedByAttribute(element, description);
  this.trySetAttribute(element, description, AriaDescriptionAttributes.Role, "role");
  this.trySetAttribute(element, description, AriaDescriptionAttributes.TabIndex, "tabindex");
  this.trySetAttribute(element, description, AriaDescriptionAttributes.AriaLevel, "aria-level");
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaLabel, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-label", ASPx.Str.ApplyReplacement(value, args));
  });
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaDisabled, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-disabled", !!value); 
  });
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaHasPopup, function(value) {
   ASPx.Attr.SetAttribute(element, "aria-haspopup", !!value);
  });
 },
 trySetAriaDescribedByAttribute: function(element, description) {
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaDescribedBy, function(selectorInfo) {
   var descriptor = this.getNodesBySelector(element, selectorInfo.descriptorSelector)[0];
   var target = this.getNodesBySelector(element, selectorInfo.targetSelector)[0];
   if(!target || !descriptor)
    return;
   ASPx.Attr.SetAttribute(target, "aria-describedby", this.getNodeId(descriptor));
  });
 },
 trySetAriaOwnsAttribute: function(element, description) {
  this.executeOnDescription(description, AriaDescriptionAttributes.AriaOwns, function(selector) {
   var ownedNodes = this.getNodesBySelector(element, selector);
   var ariaOwnsAttributeValue = "";
   for(var i = 0; i < ownedNodes.length; i++)
    ariaOwnsAttributeValue += (this.getNodeId(ownedNodes[i]) + (i != ownedNodes.length - 1 ? " " : ""));
   ASPx.Attr.SetAttribute(element, "aria-owns", ariaOwnsAttributeValue);
  });
 },
 trySetAttribute: function(element, description, ariaAttribute, attributeName) {
  this.executeOnDescription(description, ariaAttribute, function(value) { 
   ASPx.Attr.SetAttribute(element, attributeName, description[ariaAttribute]); 
  });
 },
 executeOnDescription: function(description, ariaDescAttr, callback) {
  var descInfo = description[ariaDescAttr];
  if(ASPx.IsExists(descInfo))
   callback.aspxBind(this)(descInfo);
 },
 getNodesBySelector: function(element, selector) {
  var id = element.id || "";
  var childNodes = element.querySelectorAll("#" + this.getNodeId(element) + " > " + selector);
  ASPx.Attr.SetOrRemoveAttribute(element, "id", id);
  return childNodes;
 },
 getNodeId: function(node) {
  if(!node.id)
   node.id = this.createRandomId();
  return node.id; 
 },
 createRandomId: function() {
  return "r" + ASPx.CreateGuid();
 }
});
PagerCommands = {
 Next : "PBN",
 Prev : "PBP",
 Last : "PBL",
 First : "PBF",
 PageNumber : "PN",
 PageSize : "PSP"
};
ASPx.callbackProcessed = false;
ASPx.Callback = function(result, context){ 
 var collection = aspxGetControlCollection();
 collection.DoFinalizeCallback();
 var control = collection.Get(context);
 if(control != null)
  control.DoCallback(result);
 ASPx.RippleHelper.ReInit();
 ASPx.callbackProcessed = true;
};
ASPx.CallbackError = function(result, context){
 var control = aspxGetControlCollection().Get(context);
 if(control != null)
  control.DoCallbackError(result, false);
 ASPx.callbackProcessed = true;
};
ASPx.CClick = function(name, evt) {
 var control = aspxGetControlCollection().Get(name);
 if(control != null) control.DoControlClick(evt);
};
function aspxCAInit() {
 var isAppInit = typeof(Sys$_Application$initialize) != "undefined" &&
  ASPx.FunctionIsInCallstack(arguments.callee, Sys$_Application$initialize, 10 );
 aspxGetControlCollection().AtlasInitialize(!isAppInit);
}
ASPx.Evt.AttachEventToElement(window, "resize", aspxGlobalWindowResize);
function aspxGlobalWindowResize(evt){
 aspxGetControlCollection().OnBrowserWindowResize(evt); 
}
ASPx.Evt.AttachEventToElement(window, "unload", aspxClassesUnload);
function aspxClassesUnload(evt) {
 aspxGetControlCollection().OnDocumentUnload();
}
ASPx.attachToLoad(aspxClassesDOMContentLoaded);
function aspxClassesDOMContentLoaded(evt){
 aspxGetControlCollection().DOMContentLoaded();
}
ASPx.GetControlCollection = aspxGetControlCollection;
ASPx.GetControlCollectionCollection = aspxGetControlCollectionCollection;
ASPx.GetPersistentControlPropertiesStorage = _aspxGetPersistentControlPropertiesStorage;
ASPx.PagerCommands = PagerCommands;
ASPx.ELLIPSIS_MARKER_CLASS = ELLIPSIS_MARKER_CLASS;
window.ASPxClientBeginCallbackEventArgs = ASPxClientBeginCallbackEventArgs;
window.ASPxClientGlobalBeginCallbackEventArgs = ASPxClientGlobalBeginCallbackEventArgs;
window.ASPxClientEndCallbackEventArgs = ASPxClientEndCallbackEventArgs;
window.ASPxClientGlobalEndCallbackEventArgs = ASPxClientGlobalEndCallbackEventArgs;
window.ASPxClientCallbackErrorEventArgs = ASPxClientCallbackErrorEventArgs;
window.ASPxClientGlobalCallbackErrorEventArgs = ASPxClientGlobalCallbackErrorEventArgs;
window.ASPxClientCustomDataCallbackEventArgs = ASPxClientCustomDataCallbackEventArgs;
window.ASPxClientValidationCompletedEventArgs = ASPxClientValidationCompletedEventArgs;
window.ASPxClientControlsInitializedEventArgs = ASPxClientControlsInitializedEventArgs;
window.ASPxClientControlBeforePronounceEventArgs = ASPxClientControlBeforePronounceEventArgs;
window.ASPxClientControlUnloadEventArgs = ASPxClientControlUnloadEventArgs;
window.ASPxClientEndFocusEventArgs = ASPxClientEndFocusEventArgs;
window.ASPxClientItemFocusedEventArgs = ASPxClientItemFocusedEventArgs;
window.ASPxClientControlCollection = ASPxClientControlCollection;
window.ASPxClientControlBase = ASPxClientControlBase;
window.ASPxClientControl = ASPxClientControl;
window.ASPxClientComponent = ASPxClientComponent;
})(ASPx);

(function () {
 var PositionAnimationTransition = ASPx.CreateClass(ASPx.AnimationTransitionBase, {
  constructor: function (element, options) {
   this.constructor.prototype.constructor.call(this, element, options);
   this.direction = options.direction;
   this.animationTransition = this.createAnimationTransition();
   AnimationHelper.appendWKAnimationClassNameIfRequired(this.element);
  },
  Start: function (to) {
   var from = this.GetValue();
   if(ASPx.AnimationUtils.CanUseCssTransform()) {
    from = this.convertPosToCssTransformPos(from);
    to = this.convertPosToCssTransformPos(to);
   }
   this.animationTransition.Start(from, to);
  },
  SetValue: function (value) {
   ASPx.AnimationUtils.SetTransformValue(this.element, value, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  GetValue: function () {
   return ASPx.AnimationUtils.GetTransformValue(this.element, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  },
  createAnimationTransition: function () {
   var transition = ASPx.AnimationUtils.CanUseCssTransform() ? this.createTransformAnimationTransition() : this.createPositionAnimationTransition();
   transition.transition = ASPx.AnimationConstants.Transitions.POW_EASE_OUT;
   return transition;
  },
  createTransformAnimationTransition: function () {
   return ASPx.AnimationUtils.createCssAnimationTransition(this.element, {
    property: ASPx.AnimationUtils.CanUseCssTransform(),
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  createPositionAnimationTransition: function () {
   return AnimationHelper.createAnimationTransition(this.element, {
    property: this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION ? "top" : "left",
    unit: "px",
    duration: this.duration,
    onComplete: this.onComplete
   });
  },
  convertPosToCssTransformPos: function (position) {
   return ASPx.AnimationUtils.GetTransformCssText(position, this.direction == AnimationHelper.SLIDE_VERTICAL_DIRECTION);
  }
 });
 var AnimationHelper = {
  SLIDE_HORIZONTAL_DIRECTION: 0,
  SLIDE_VERTICAL_DIRECTION: 1,
  SLIDE_TOP_DIRECTION: 0,
  SLIDE_RIGHT_DIRECTION: 1,
  SLIDE_BOTTOM_DIRECTION: 2,
  SLIDE_LEFT_DIRECTION: 3,
  SLIDE_CONTAINER_CLASS: "dxAC",
  MAXIMUM_DEPTH: 3,
  createAnimationTransition: function (element, options) {
   if(options.onStep) 
    options.animationEngine = "js";
   switch (options.animationEngine) {
    case "js":
     return ASPx.AnimationUtils.createJsAnimationTransition(element, options);
    case "css":
     return ASPx.AnimationUtils.createCssAnimationTransition(element, options);
    default:
     return ASPx.AnimationUtils.CanUseCssTransition() ? ASPx.AnimationUtils.createCssAnimationTransition(element, options) :
      ASPx.AnimationUtils.createJsAnimationTransition(element, options);
   }
  },
  createMultipleAnimationTransition: function (element, options) {
   return ASPx.AnimationUtils.createMultipleAnimationTransition(element, options);
  },
  createSimpleAnimationTransition: function (options) {
   return ASPx.AnimationUtils.createSimpleAnimationTransition(options);
  },
  cancelAnimation: function (element) {
   ASPx.AnimationTransitionBase.Cancel(element);
  },
  fadeIn: function (element, onComplete, duration) {
   AnimationHelper.fadeTo(element, {
    from: 0, to: 1,
    onComplete: onComplete,
    duration: duration || ASPx.AnimationConstants.Durations.DEFAULT
   });
  },
  fadeOut: function (element, onComplete, duration) {
   AnimationHelper.fadeTo(element, {
    from: ASPx.GetElementOpacity(element), to: 0,
    onComplete: onComplete,
    duration: duration || ASPx.AnimationConstants.Durations.DEFAULT
   });
  },
  fadeTo: function (element, options) {
   options.property = "opacity";
   if(!options.duration)
    options.duration = ASPx.AnimationConstants.Durations.SHORT;
   var transition = AnimationHelper.createAnimationTransition(element, options);
   if(!ASPx.IsExists(options.from))
    options.from = transition.GetValue();
   transition.Start(options.from, options.to);
  },
  slideIn: function (element, direction, onComplete, animationEngineType, rtl) {
   AnimationHelper.setOpacity(element, 1);
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideInStartPos(animationContainer, direction, rtl);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.resetSlideAnimationContainerSize(animationContainer);
     if(onComplete)
      onComplete(el);
    }, animationEngineType, rtl);
   transition.Start(pos, 0);
  },
  slideOut: function (element, direction, onComplete, animationEngineType, rtl) {
   var animationContainer = AnimationHelper.getSlideAnimationContainer(element, true, true);
   var pos = AnimationHelper.getSlideOutFinishPos(animationContainer, direction, rtl);
   var transition = AnimationHelper.createSlideTransition(animationContainer, direction,
    function (el) {
     AnimationHelper.setOpacity(el.firstChild, 0);
     if(onComplete)
      onComplete(el);
    }, animationEngineType, rtl);
   transition.Start(pos);
  },
  slideTo: function (element, options) {
   if(!ASPx.IsExists(options.direction))
    options.direction = AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
   var transition = new PositionAnimationTransition(element, options);
   transition.Start(options.to);
  },
  setOpacity: function (element, value) {
   ASPx.AnimationUtils.setOpacity(element, value);
  },
  appendWKAnimationClassNameIfRequired: function (element) {
   if(ASPx.AnimationUtils.CanUseCssTransform() && ASPx.Browser.WebKitFamily && !ASPx.ElementHasCssClass(element, "dx-wbv"))
    element.className += " dx-wbv";
  },
  findSlideAnimationContainer: function (element) {
   var container = element;
   for(var i = 0; i < AnimationHelper.MAXIMUM_DEPTH; i++) {
    if(container.tagName == "BODY")
     return null;
    if(ASPx.ElementHasCssClass(container, AnimationHelper.SLIDE_CONTAINER_CLASS))
     return container;
    container = container.parentNode;
   }
   return null;
  },
  createSlideAnimationContainer: function (element) {
   var rootContainer = document.createElement("DIV");
   ASPx.SetStyles(rootContainer, {
    className: AnimationHelper.SLIDE_CONTAINER_CLASS,
    overflow: "hidden"
   });
   var elementContainer = document.createElement("DIV");
   rootContainer.appendChild(elementContainer);
   var parentNode = element.parentNode;
   parentNode.insertBefore(rootContainer, element);
   elementContainer.appendChild(element);
   return rootContainer;
  },
  getSlideAnimationContainer: function (element, create, fixSize) {
   if(!element) return;
   var width = element.offsetWidth;
   var height = element.offsetHeight;
   var container;
   if(element.className == AnimationHelper.SLIDE_CONTAINER_CLASS)
    container = element;
   if(!container)
    container = AnimationHelper.findSlideAnimationContainer(element);
   if(!container && create)
    container = AnimationHelper.createSlideAnimationContainer(element);
   if(container && fixSize) {
    ASPx.SetStyles(container, {
     width: width, height: height
    });
    ASPx.SetStyles(container.firstChild, {
     width: width, height: height
    });
   }
   return container;
  },
  resetSlideAnimationContainerSize: function (container) {
   ASPx.SetStyles(container, {
    width: "", height: ""
   });
   ASPx.SetStyles(container.firstChild, {
    width: "", height: ""
   });
  },
  getModifyProperty: function (direction, rtl) {
   if(direction == AnimationHelper.SLIDE_TOP_DIRECTION || direction == AnimationHelper.SLIDE_BOTTOM_DIRECTION)
    return "marginTop";
   return rtl ? "margin-right" : "margin-left";
  },
  createSlideTransition: function (animationContainer, direction, complete, animationEngineType, rtl) {
   if(rtl == undefined)
    rtl = false;
   var animationEngine = "";
   switch(animationEngineType) {
    case AnimationEngineType.JS:
     animationEngine = "js";
     break;
    case AnimationEngineType.CSS:
     animationEngine = "css";
     break;
   }
   return AnimationHelper.createAnimationTransition(animationContainer.firstChild, {
    unit: "px",
    property: AnimationHelper.getModifyProperty(direction, rtl),
    onComplete: complete,
    animationEngine: animationEngine
   });
  },
  getSlideInStartPos: function (animationContainer, direction, rtl) {
   var dir = rtl ? -1 : 1;
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return -animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return -animationContainer.offsetHeight;
   }
  },
  getSlideOutFinishPos: function (animationContainer, direction, rtl) {
   var dir = rtl ? -1 : 1;
   switch (direction) {
    case AnimationHelper.SLIDE_TOP_DIRECTION:
     return -animationContainer.offsetHeight;
    case AnimationHelper.SLIDE_LEFT_DIRECTION:
     return -animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_RIGHT_DIRECTION:
     return animationContainer.offsetWidth * dir;
    case AnimationHelper.SLIDE_BOTTOM_DIRECTION:
     return animationContainer.offsetHeight;
   }
  }
 };
 var GestureHandler = ASPx.CreateClass(null, {
  constructor: function (getAnimationElement, canHandle, allowStart) {
   this.getAnimationElement = getAnimationElement;
   this.canHandle = canHandle;
   this.allowStart = allowStart;
   this.startMousePosX = 0;
   this.startMousePosY = 0;
   this.startTime = null;
   this.isEventsPrevented = false;
   this.savedElements = [];
  },
  OnSelectStart: function(evt) {
   ASPx.Evt.PreventEvent(evt); 
  },
  OnDragStart: function(evt) {
   ASPx.Evt.PreventEvent(evt);  
  },
  OnMouseDown: function (evt) {
   this.startMousePosX = ASPx.Evt.GetEventX(evt);
   this.startMousePosY = ASPx.Evt.GetEventY(evt);
   this.startTime = new Date();
  },
  OnMouseMove: function(evt) {
   if(!ASPx.Browser.MobileUI)
    ASPx.Selection.Clear();
   if(Math.abs(this.GetCurrentDistanceX(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE && Math.abs(this.GetCurrentDistanceY(evt)) < GestureHandler.SLIDER_MIN_START_DISTANCE)
    GesturesHelper.isExecutedGesture = false;
  },
  OnMouseUp: function (evt) {
  },
  CanHandleEvent: function (evt) {
   return !this.canHandle || this.canHandle(evt);
  },
  IsStartAllowed: function(value) {
   return !this.allowStart || this.allowStart(value);
  },
  RollbackGesture: function () {
  },
  GetRubberPosition: function (position) {
   return position / GestureHandler.FACTOR_RUBBER;
  },
  GetCurrentDistanceX: function (evt) {
   return ASPx.Evt.GetEventX(evt) - this.startMousePosX;
  },
  GetCurrentDistanceY: function (evt) {
   return ASPx.Evt.GetEventY(evt) - this.startMousePosY;
  },
  GetDistanceLimit: function () {
   return (new Date() - this.startTime) < GestureHandler.MAX_TIME_SPAN ? GestureHandler.MIN_DISTANCE_LIMIT : GestureHandler.MAX_DISTANCE_LIMIT;
  },
  GetContainerElement: function () {
  },
  AttachPreventEvents: function (evt) {
   if(!this.isEventsPrevented) {
    var element = ASPx.Evt.GetEventSource(evt);
    var container = this.GetContainerElement();
    while(element && element != container) {
     ASPx.Evt.AttachEventToElement(element, "mouseup", ASPx.Evt.PreventEvent);
     ASPx.Evt.AttachEventToElement(element, "click", ASPx.Evt.PreventEvent);
     this.savedElements.push(element);
     element = element.parentNode;
    }
    this.isEventsPrevented = true;
   }
  },
  DetachPreventEvents: function () {
   if(this.isEventsPrevented) {
    window.setTimeout(function () {
     while(this.savedElements.length > 0) {
      var element = this.savedElements.pop();
      ASPx.Evt.DetachEventFromElement(element, "mouseup", ASPx.Evt.PreventEvent);
      ASPx.Evt.DetachEventFromElement(element, "click", ASPx.Evt.PreventEvent);
     }
    }.aspxBind(this), 0);
    this.isEventsPrevented = false;
   }
  }
 });
 GestureHandler.MAX_DISTANCE_LIMIT = 70;
 GestureHandler.MIN_DISTANCE_LIMIT = 10;
 GestureHandler.MIN_START_DISTANCE = 0;
 GestureHandler.SLIDER_MIN_START_DISTANCE = 5;
 GestureHandler.MAX_TIME_SPAN = 300;
 GestureHandler.FACTOR_RUBBER = 4;
 GestureHandler.RETURN_ANIMATION_DURATION = 150;
 var SwipeSlideGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, move) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle);
   this.slideElement = this.getAnimationElement();
   this.container = this.slideElement.parentNode;
   this.direction = direction;
   this.backward = backward;
   this.forward = forward;
   this.rollback = rollback;
   this.slideElementSize = 0;
   this.containerElementSize = 0;
   this.startSliderElementPosition = 0;
   this.centeredSlideElementPosition = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.slideElementSize = this.GetElementSize();
   this.startSliderElementPosition = this.GetElementPosition();
   this.containerElementSize = this.GetContainerElementSize();
   if(this.slideElementSize <= this.containerElementSize)
    this.centeredSlideElementPosition = (this.containerElementSize - this.slideElementSize) / 2;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   if(!ASPx.Browser.TouchUI && !ASPx.GetIsParent(this.container, ASPx.Evt.GetEventSource(evt))) {
    GesturesHelper.OnDocumentMouseUp(evt);
    return;
   }
   var distance = this.GetCurrentDistance(evt);
   if(Math.abs(distance) < GestureHandler.SLIDER_MIN_START_DISTANCE || ASPx.TouchUIHelper.isGesture)
    return;
   this.SetElementPosition(this.GetCalculatedPosition(distance));
   this.AttachPreventEvents(evt);
   ASPx.Evt.PreventEvent(evt);
  },
  GetCalculatedPosition: function (distance) {
   ASPx.AnimationTransitionBase.Cancel(this.slideElement);
   var position = this.startSliderElementPosition + distance,
    maxPosition = -(this.slideElementSize - this.containerElementSize),
    minPosition = 0;
   if(this.centeredSlideElementPosition > 0)
    position = this.GetRubberPosition(distance) + this.centeredSlideElementPosition;
   else if(position > minPosition)
    position = this.GetRubberPosition(distance);
   else if(position < maxPosition)
    position = this.GetRubberPosition(distance) + maxPosition;
   return position;
  },
  OnMouseUp: function (evt) {
   this.DetachPreventEvents();
   if(this.GetCurrentDistance(evt) != 0)
    this.OnMouseUpCore(evt);
  },
  OnMouseUpCore: function (evt) {
   var distance = this.GetCurrentDistance(evt);
   if(this.centeredSlideElementPosition > 0 || this.CheckSlidePanelIsOutOfBounds())
    this.PerformRollback();
   else
    this.PerformAction(distance);
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  PerformBackward: function () {
   this.backward();
  },
  PerformForward: function () {
   this.forward();
  },
  PerformRollback: function () {
   this.rollback();
  },
  CheckSlidePanelIsOutOfBounds: function () {
   var minOffset = -(this.slideElementSize - this.containerElementSize), maxOffset = 0;
   var slideElementPos = this.GetElementPosition();
   if(slideElementPos > maxOffset || slideElementPos < minOffset)
    return true;
   return false;
  },
  GetContainerElement: function () {
   return this.container;
  },
  GetElementSize: function () {
   return this.IsHorizontalDirection() ? this.slideElement.offsetWidth : this.slideElement.offsetHeight;
  },
  GetContainerElementSize: function () {
   return this.IsHorizontalDirection() ? ASPx.GetClearClientWidth(this.container) : ASPx.GetClearClientHeight(this.container);
  },
  GetCurrentDistance: function (evt) {
   return this.IsHorizontalDirection() ? this.GetCurrentDistanceX(evt) : this.GetCurrentDistanceY(evt);
  },
  GetElementPosition: function () {
   return ASPx.AnimationUtils.GetTransformValue(this.slideElement, !this.IsHorizontalDirection());
  },
  SetElementPosition: function (position) {
   ASPx.AnimationUtils.SetTransformValue(this.slideElement, position, !this.IsHorizontalDirection());
  },
  IsHorizontalDirection: function () {
   return this.direction == AnimationHelper.SLIDE_HORIZONTAL_DIRECTION;
  }
 });
 var SwipeSimpleSlideGestureHandler = ASPx.CreateClass(SwipeSlideGestureHandler, {
  constructor: function (getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, direction, canHandle, backward, forward, rollback);
   this.container = this.slideElement;
   this.updatePosition = updatePosition;
   this.prevDistance = 0;
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   this.prevDistance = 0;
  },
  OnMouseUpCore: function (evt) {
   this.PerformAction(this.GetCurrentDistance(evt));
  },
  PerformAction: function (distance) {
   if(Math.abs(distance) < this.GetDistanceLimit())
    this.PerformRollback();
   else if(distance < 0)
    this.PerformForward();
   else
    this.PerformBackward();
  },
  GetCalculatedPosition: function (distance) {
   var position = distance - this.prevDistance;
   this.prevDistance = distance;
   return position;
  },
  SetElementPosition: function (position) {
   this.updatePosition(position);
  }
 });
 var SwipeGestureHandler = ASPx.CreateClass(GestureHandler, {
  constructor: function (getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl) {
   this.constructor.prototype.constructor.call(this, getAnimationElement, canHandle, allowStart);
   this.start = start;
   this.allowComplete = allowComplete;
   this.complete = complete;
   this.cancel = cancel;
   this.animationTween = null;
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
   this.animationEngineType = animationEngineType;
   this.rtl = rtl;
   this.UpdateAnimationContainer();
  },
  UpdateAnimationContainer: function () {
   this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, false);
  },
  CanHandleEvent: function (evt) {
   if(GestureHandler.prototype.CanHandleEvent.call(this, evt))
    return true;
   return this.animationTween && this.animationContainer && ASPx.GetIsParent(this.animationContainer, ASPx.Evt.GetEventSource(evt));
  },
  OnMouseDown: function (evt) {
   GestureHandler.prototype.OnMouseDown.call(this, evt);
   if(this.animationTween)
    this.animationTween.Cancel();
   this.currentDistanceX = 0;
   this.currentDistanceY = 0;
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  OnMouseMove: function (evt) {
   GestureHandler.prototype.OnMouseMove.call(this, evt);
   var isZoomGestureConflict = evt.touches && evt.touches.length > 1;
   if (isZoomGestureConflict)
    return false;
   this.currentDistanceX = this.GetCurrentDistanceX(evt);
   this.currentDistanceY = this.GetCurrentDistanceY(evt);
   if(this.rtl)
    this.currentDistanceX = -this.currentDistanceX;
   if(!this.animationTween && !this.tryStartScrolling && (Math.abs(this.currentDistanceX) >
    GestureHandler.MIN_START_DISTANCE || Math.abs(this.currentDistanceY) > GestureHandler.MIN_START_DISTANCE)) {
    if(Math.abs(this.currentDistanceY) < Math.abs(this.currentDistanceX)) {
     this.tryStartGesture = true;
     if(this.IsStartAllowed(this.currentDistanceX)) {
      this.animationContainer = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement(), true, true);
      this.animationTween = AnimationHelper.createSlideTransition(this.animationContainer, AnimationHelper.SLIDE_LEFT_DIRECTION,
       function () {
        AnimationHelper.resetSlideAnimationContainerSize(this.animationContainer);
        this.animationContainer = null;
        this.animationTween = null;
       }.aspxBind(this), this.animationEngineType, this.rtl);
      this.PerformStart(this.currentDistanceX);
      this.AttachPreventEvents(evt);
     }
    }
    else
     this.tryStartScrolling = true;
   }
   if(this.animationTween) {
    if(this.allowComplete && !this.allowComplete(this.currentDistanceX))
     this.currentDistanceX = this.GetRubberPosition(this.currentDistanceX);
    this.animationTween.SetValue(this.currentDistanceX);
   }
   if(!this.tryStartScrolling && !ASPx.TouchUIHelper.isGesture && evt.touches && evt.touches.length < 2)
    ASPx.Evt.PreventEvent(evt);
  },
  OnMouseUp: function (evt) {
   if(!this.animationTween) {
    if(this.tryStartGesture)
     this.PerformCancel(this.currentDistanceX);
   }
   else {
    if(Math.abs(this.currentDistanceX) < this.GetDistanceLimit())
     this.RollbackGesture();
    else {
     if(this.IsCompleteAllowed(this.currentDistanceX)) {
      this.PerformComplete(this.currentDistanceX);
      this.animationContainer = null;
      this.animationTween = null;
     }
     else
      this.RollbackGesture();
    }
   }
   this.DetachPreventEvents();
   this.tryStartGesture = false;
   this.tryStartScrolling = false;
  },
  PerformStart: function (value) {
   if(this.start)
    this.start(value);
  },
  IsCompleteAllowed: function (value) {
   return !this.allowComplete || this.allowComplete(value);
  },
  PerformComplete: function (value) {
   if(this.complete)
    this.complete(value);
  },
  PerformCancel: function (value) {
   if(this.cancel)
    this.cancel(value);
  },
  RollbackGesture: function () {
   this.animationTween.Start(this.currentDistanceX, 0);
  },
  ResetGestureElementPosition: function () {
   if (this.currentDistanceX === 0) return;
   var container = AnimationHelper.getSlideAnimationContainer(this.getAnimationElement());
   var onComplete = function () { AnimationHelper.resetSlideAnimationContainerSize(container); };
   var animation = AnimationHelper.createSlideTransition(container, AnimationHelper.SLIDE_LEFT_DIRECTION, onComplete, this.animationEngineType, this.rtl);
   animation.Start(this.currentDistanceX, 0);
  },
  GetContainerElement: function () {
   return this.animationContainer;
  }
 });
 var GesturesHelper = {
  handlers: {},
  activeHandler: null,
  isAttachedEvents: false,
  isExecutedGesture: false,
  AddSwipeGestureHandler: function (id, getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl) {
   this.handlers[id] = new SwipeGestureHandler(getAnimationElement, canHandle, allowStart, start, allowComplete, complete, cancel, animationEngineType, rtl);
  },
  UpdateSwipeAnimationContainer: function (id) {
   if(this.handlers[id])
    this.handlers[id].UpdateAnimationContainer();
  },
  AddSwipeSlideGestureHandler: function (id, getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition) {
   if(updatePosition)
    this.handlers[id] = new SwipeSimpleSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback, updatePosition);
   else
    this.handlers[id] = new SwipeSlideGestureHandler(getAnimationElement, direction, canHandle, backward, forward, rollback);
  },
  getParentDXEditorWithSwipeGestures: function(element) {
     return ASPx.GetParent(element, function(parent) {
      var parentObj = ASPx.GetControlCollection().Get(parent.id);
      return parentObj && parentObj.supportGestures && parentObj.isSwipeGesturesEnabled();
   });
  },
  canHandleMouseDown: function(evt) {
   if(!ASPx.Evt.IsLeftButtonPressed(evt))
    return false;
   var element = ASPx.Evt.GetEventSource(evt);
   var dxFocusedEditor = ASPx.Ident.scripts.ASPxClientEdit && ASPx.GetFocusedEditor();
   if(dxFocusedEditor && dxFocusedEditor.IsEditorElement(element)) {
    var elementParentDXEditorWithSwipeGestures = GesturesHelper.getParentDXEditorWithSwipeGestures(element);
    if(!elementParentDXEditorWithSwipeGestures || !dxFocusedEditor.IsEditorElement(elementParentDXEditorWithSwipeGestures))
     return false;
   }
   var isTextEditor = element.tagName == "TEXTAREA" || element.tagName == "INPUT" && ASPx.Attr.GetAttribute(element, "type") == "text";
   if(isTextEditor && document.activeElement == element)
    return false;
   return true;  
  },
  OnDocumentDragStart: function(evt) {
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnDragStart(evt);
  },
  OnDocumentSelectStart: function(evt) {
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnSelectStart(evt);
  },
  OnDocumentMouseDown: function (evt) {
   if(!GesturesHelper.canHandleMouseDown(evt))
    return;
   GesturesHelper.activeHandler = GesturesHelper.FindHandler(evt);
   if(GesturesHelper.activeHandler)
    GesturesHelper.activeHandler.OnMouseDown(evt);
  },
  OnDocumentMouseMove: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.isExecutedGesture = true;
    GesturesHelper.activeHandler.OnMouseMove(evt);
   }
  },
  OnDocumentMouseUp: function (evt) {
   if(GesturesHelper.activeHandler) {
    GesturesHelper.activeHandler.OnMouseUp(evt);
    GesturesHelper.activeHandler = null;
    window.setTimeout(function () { GesturesHelper.isExecutedGesture = false; }, 0);
   }
  },
  AttachEvents: function () {
   if(!GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.AttachEventToElement);
    GesturesHelper.isAttachedEvents = true;
   }
  },
  DetachEvents: function () {
   if(GesturesHelper.isAttachedEvents) {
    GesturesHelper.Attach(ASPx.Evt.DetachEventFromElement);
    GesturesHelper.isAttachedEvents = false;
   }
  },
  Attach: function (changeEventsMethod) {
   var doc = window.document;
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseDownEventName, GesturesHelper.OnDocumentMouseDown);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseMoveEventName, GesturesHelper.OnDocumentMouseMove);
   changeEventsMethod(doc, ASPx.TouchUIHelper.touchMouseUpEventName, GesturesHelper.OnDocumentMouseUp);
   if(!ASPx.Browser.MobileUI) {
    changeEventsMethod(doc, "selectstart", GesturesHelper.OnDocumentSelectStart);
    changeEventsMethod(doc, "dragstart", GesturesHelper.OnDocumentDragStart);
   }
  },
  FindHandler: function (evt) {
   var handlers = [];
   for(var id in GesturesHelper.handlers) {
    if(GesturesHelper.handlers.hasOwnProperty(id)) {
     var handler = GesturesHelper.handlers[id];
     if(handler.CanHandleEvent && handler.CanHandleEvent(evt))
      handlers.push(handler);
    }
   }
   if(!handlers.length)
    return null;
   handlers.sort(function (a, b) {
    return ASPx.GetIsParent(a.getAnimationElement(), b.getAnimationElement()) ? 1 : -1;
   });
   return handlers[0];
  },
  IsExecutedGesture: function () {
   return GesturesHelper.isExecutedGesture;
  }
 };
 GesturesHelper.AttachEvents();
 var AnimationEngineType = {
  "JS": 0,
  "CSS": 1,
  "DEFAULT" : 2
 };
 ASPx.AnimationEngineType = AnimationEngineType;
 ASPx.AnimationHelper = AnimationHelper;
 ASPx.GesturesHelper = GesturesHelper;
})();

(function() {
 ASPxClientPanelBase = ASPx.CreateClass(ASPxClientControl, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.touchUIScroller = null;
  },
  Initialize: function(){
   ASPxClientControl.prototype.Initialize.call(this);
   this.touchUIScroller = ASPx.TouchUIHelper.makeScrollableIfRequired(this.GetMainElement());
  },
  getContentElement: function() {
   if(this.getAnimationContentContainerElement())
    return this.getAnimationContentContainerElement();
   if(this.getScrollContentContainerElement())
    return this.getScrollContentContainerElement();
   if(!ASPx.IsExistsElement(this.contentElement)){
    var element = this.GetMainElement();
    this.contentElement = element && element.tagName == "TABLE" ? element.rows[0].cells[0] : element;
   }
   return this.contentElement;
  },
  getAnimationContentContainerElement: function() {
   return null;
  },
  getScrollContentContainerElement: function() {
   return null;
  },
  GetContentHTML: function(){
   return this.GetContentHtml();
  },
  SetContentHTML: function(html){
   this.SetContentHtml(html);
  },
  GetContentHtml: function(){
   return this.getContentElement().innerHTML;
  },
  SetContentHtml: function(html){
   ASPx.SetInnerHtml(this.getContentElement(), html);
   if(this.touchUIScroller)
    this.touchUIScroller.ChangeElement(this.getContentElement());
  }
 });
 ASPxClientPanelBase.Cast = ASPxClientControl.Cast;
 var FixedPanels = {};
 var FixedPositionProperties;
 var InitFixedPositionProperties = function(){
  FixedPositionProperties = {};
  FixedPositionProperties["Top"] = { 
   documentPadding: "padding-top", documentMargin: "margin-top", documentMargin2: "margin-bottom", 
   contentEdge: "top", oppositeContentEdge: "bottom", size: "offsetHeight", animationSize: "height", oppositePanel: "Bottom" 
  };
  FixedPositionProperties["Bottom"] = { 
   documentPadding: "padding-bottom", documentMargin: "margin-top", documentMargin2: "margin-bottom", 
   contentEdge: "bottom", oppositeContentEdge: "top", size: "offsetHeight", animationSize: "height", oppositePanel: "Top"
  };
  FixedPositionProperties["Left"] = { 
   documentPadding: "padding-left", documentMargin: "margin-left", documentMargin2: "margin-right", 
   contentEdge: "left", oppositeContentEdge: "right", size: "offsetWidth", animationSize: "width", oppositePanel: "Right"
  };
  FixedPositionProperties["Right"] = { 
   documentPadding: "padding-right", documentMargin: "margin-left", documentMargin2: "margin-right", 
   contentEdge: "right", oppositeContentEdge: "left", size: "offsetWidth", animationSize: "width", oppositePanel: "Left"
  };
 };
 var ExpandDirectionProperties;
 var InitExpandDirectionProperties = function(){
  ExpandDirectionProperties = {};
  ExpandDirectionProperties["PopupToLeft"] = { 
   hAlign: ASPx.PopupUtils.OutsideLeftAlignIndicator, vAlign: ASPx.PopupUtils.TopSidesAlignIndicator, 
   size: "offsetWidth", animationSize: "width" 
  };
  ExpandDirectionProperties["PopupToRight"] = { 
   hAlign: ASPx.PopupUtils.OutsideRightAlignIndicator, vAlign: ASPx.PopupUtils.TopSidesAlignIndicator, 
   size: "offsetWidth", animationSize: "width" 
  };
  ExpandDirectionProperties["PopupToTop"] = { 
   hAlign: ASPx.PopupUtils.LeftSidesAlignIndicator, vAlign: ASPx.PopupUtils.AboveAlignIndicator, 
   size: "offsetHeight", animationSize: "height" 
  };
  ExpandDirectionProperties["PopupToBottom"] = { 
   hAlign: ASPx.PopupUtils.LeftSidesAlignIndicator, vAlign: ASPx.PopupUtils.BelowAlignIndicator, 
   size: "offsetHeight", animationSize: "height" 
  };
 };
 var CollapsiblePanelsAutoGenGroupCount = 0;
 var CollapsiblePanelsGroups = {};
 var ExpandedPanels = {};
 var DocumentProperties = {};
 var EXPANDED_SELECTOR = "dxpnl-expanded";
 var COLLAPSIBLE_SELECTOR = "dxpnl-collapsible";
 var CENTER_BTN_POSITION_SELECTOR = "dxpnl-cp";
 var EXPAND_BAR_ID = "_EB";
 var MODAL_ELEMENT_ID = "_M";
 var EXPAND_BUTTON_ID = "_EBB";
 var COLLAPSED_STATE_CLASS_NAME = "dxpnl-collapsedState";
 var HIDDEN_STATE_CLASS_NAME = "dxpnl-hiddenState";
 ASPxClientPanel = ASPx.CreateClass(ASPxClientPanelBase, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.animationType = "none";
   this.fixedPosition = this.getFixedPosition();
   this.expandEffect = "Slide";
   this.expandOnPageLoad = false;
   this.groupName = "";
   this.fixedPositionOverlap = false;
   this.fixedPositionProperties = null;
   this.expandDirectionProperties = null;
   this.documentMarginsChanged = false;
   this.slideAnimationPosProperty = null;
   this.slideAnimationExpandBarSize = null;
   this.collapseWindowWidth = 0;
   this.collapseWindowHeight = 0;
   this.hideWindowWidth = 0;
   this.hideWindowHeight = 0;
   this.modalElement = null;
   this.modalElementOpacity = 0.7;
   this.modalShowAnimationDuration = ASPx.AnimationConstants.Durations.SHORT;
   this.modalHideAnimationDuration = ASPx.AnimationConstants.Durations.SHORT - 50;
   this.contentElement = null;
   this.expandBarElement = null;
   this.expandButtonElement = null;
   this.animationContentContainerElement = null;
   this.scrollContentContainerElement = null;
   this.Collapsed = new ASPxClientEvent();
   this.Expanded = new ASPxClientEvent();
  },
  InlineInitialize: function(){
   ASPxClientPanelBase.prototype.InlineInitialize.call(this);
   if(this.fixedPosition) {
    if(!FixedPositionProperties)
     InitFixedPositionProperties();
    this.fixedPositionProperties = FixedPositionProperties[this.fixedPosition];
   }
   if(this.expandEffect.indexOf("Popup") > -1){
    if(!ExpandDirectionProperties)
     InitExpandDirectionProperties();
    this.expandDirectionProperties = ExpandDirectionProperties[this.expandEffect];
   }
   if(this.isPositionFixed()){
    this.prepareModalElement();
    FixedPanels[this.fixedPosition] = this;
    var scrollContainer = this.getScrollContentContainerElement();
    if(scrollContainer && 
     (scrollContainer.style.overflow !== "" && scrollContainer.style.overflow !== "visible" ||
     scrollContainer.style.overflowX !== "" && scrollContainer.style.overflowX !== "visible" ||
     scrollContainer.style.overflowY !== "" && scrollContainer.style.overflowY !== "visible")){
     ASPx.Evt.AttachEventToElement(scrollContainer, "scroll",
      function (evt) {
       if(ASPx.Evt.GetEventSource(evt) != scrollContainer)
        return;
       if(typeof(ASPx.GetDropDownCollection) != "undefined")
        ASPx.GetDropDownCollection().ProcessControlsInContainer(scrollContainer, function(control) {
         control.HideDropDown();
        });
       if(typeof(ASPx.GetMenuCollection) != "undefined")
        ASPx.GetMenuCollection().HideAll();
      }.aspxBind(this));
    }
   }
   if(this.hideWindowWidth > 0 || this.hideWindowHeight > 0)
    this.createVisibilityCss();
   if(this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0)
    this.createCollapsibilityCss();
   if(this.useAdaptivityClassNames())
    this.ensureAdaptivityClassNames();
   if(this.groupName == ""){
    this.groupName = "DXAutoGenExpandGroup" + CollapsiblePanelsAutoGenGroupCount;
    CollapsiblePanelsAutoGenGroupCount++;
   }
   if(!CollapsiblePanelsGroups[this.groupName])
    CollapsiblePanelsGroups[this.groupName] = [];
   CollapsiblePanelsGroups[this.groupName].push(this);
   var btnElement = this.getExpandButtonElement();
   if(btnElement){
    ASPx.Evt.AttachEventToElement(btnElement, ASPx.TouchUIHelper.touchMouseUpEventName,
     function (evt) {
      if(ASPx.Evt.IsLeftButtonPressed(evt))
       this.Toggle();
     }.aspxBind(this));
   }
   this.updateFixedPanelContext();
   if(!this.clientEnabled)
    this.SetEnabled(this.clientEnabled);
  },
  prepareModalElement: function() {
   if(!this.isModal()) return;
   var modalElement = this.getModalElement();
   this.modalElementOpacity = ASPx.GetCurrentStyle(modalElement).opacity;
   ASPx.Evt.AttachEventToElement(modalElement, ASPx.TouchUIHelper.touchMouseUpEventName,
    function(evt) {
     if(ASPx.Evt.IsLeftButtonPressed(evt))
      this.Collapse();
    }.aspxBind(this));
   modalElement.style.zIndex = ASPx.GetCurrentStyle(this.GetMainElement()).zIndex - 2;
  },
  AfterInitialize: function(){
   ASPxClientPanelBase.prototype.AfterInitialize.call(this);
   var barElement = this.getExpandBarElement();
   if(barElement && this.isExpandBarChangeVisibilityOnExpanding())
    ASPx.AddClassNameToElement(barElement, "h");
   if(this.expandOnPageLoad)
    this.Expand(true);
  },
  OnDispose: function () {
   if(FixedPanels[this.fixedPosition] === this)
    delete FixedPanels[this.fixedPosition];
   if(ASPx.Ident.IsArray(CollapsiblePanelsGroups[this.groupName])){
    ASPx.Data.ArrayRemove(CollapsiblePanelsGroups[this.groupName], this);
    if(CollapsiblePanelsGroups[this.groupName].length === 0)
     delete CollapsiblePanelsGroups[this.groupName];
   }
   if(ExpandedPanels[this.groupName] === this)
    delete ExpandedPanels[this.groupName];
   ASPxClientPanelBase.prototype.OnDispose.call(this);
  },
  AdjustControlCore: function() {
   this.updateExpandButtonPosition();
   this.updateFixedPanelContext();
  },
  GetAdjustedSizes: function() {
   var sizes = ASPxClientControl.prototype.GetAdjustedSizes.call(this);
   var expandBar = this.getExpandBarElement();
   if(expandBar) {
    sizes["expandBarWidth"] = expandBar.offsetWidth;
    sizes["expandBarHeight"] = expandBar.offsetHeight;
   }
   return sizes;
  },
  IsDisplayed: function() {
   if(ASPxClientPanelBase.prototype.IsDisplayed.call(this))
    return true;
   return this.IsDisplayedElement(this.getExpandBarElement());
  },
  IsHidden: function() {
   if(!ASPxClientPanelBase.prototype.IsHidden.call(this))
    return false;
   return this.IsHiddenElement(this.getExpandBarElement());
  },
  OnBrowserWindowResize: function(e) {
   if(this.useAdaptivityClassNames())
    this.ensureAdaptivityClassNames();
   this.onBrowserWindowResizeCore();
   window.setTimeout(function() {
    this.onBrowserWindowResizeCore();
   }.aspxBind(this), 0);
  },
  BrowserWindowResizeSubscriber: function() {
   return this.isPositionFixed() || this.getExpandBarElement() || this.useAdaptivityClassNames();
  },
  HasFixedPosition: function() {
   return this.isPositionFixed();
  },
  RegisterInControlTree: function(tree) {
   var mainNode = tree.createNode(null, this);
   this.registerElementInTree(this.GetMainElement(), tree, mainNode);
   this.registerElementInTree(this.getExpandBarElement(), tree, mainNode);
  },
  getSizeCore: function(element, sizeProperty){
   return element[sizeProperty];
  },
  getFixedSize: function(sizeProperty){
   return this.getSizeCore(this.getFixedElement(), sizeProperty);
  },
  getExpandedSize: function(sizeProperty){
   if(this.getExpandBarElement() && this.isElementDisplayed(this.getExpandBarElement()))
    return this.getSizeCore(this.GetMainElement(), sizeProperty);
   return 0;
  },
  GetWidth: function() {
   if(!this.getExpandBarElement()) 
    return ASPxClientControl.prototype.GetWidth.call(this);
   var width = 0;
   if(this.isElementDisplayed(this.getExpandBarElement()))
    width += this.getExpandBarElement().offsetWidth;
   if(this.isElementDisplayed(this.GetMainElement()) && (!this.IsExpandedInternal() || !this.isPopupExpanding()))
    width += this.GetMainElement().offsetWidth;
   return width;
  },
  GetHeight: function() {
   if(!this.getExpandBarElement()) 
    return ASPxClientControl.prototype.GetHeight.call(this);
   var height = 0;
   if(this.isElementDisplayed(this.getExpandBarElement()))
    height += this.getExpandBarElement().offsetHeight;
   if(this.isElementDisplayed(this.GetMainElement()) && (!this.IsExpandedInternal() || !this.isPopupExpanding()))
    height += this.GetMainElement().offsetHeight;
   return height;
  },
  SetVisible: function (value) {
   if(this.clientVisible != value) {
    ASPxClientPanelBase.prototype.SetVisible.call(this, value);
    var expandBarElement = this.getExpandBarElement();
    if(expandBarElement) ASPx.SetElementDisplay(expandBarElement, value);
    this.updateFixedPanelContext();
   }
  },
  onBrowserWindowResizeCore: function() {
   this.updateExpandButtonPosition();
   this.updateFixedPanelContext();
   this.checkCollapseContent();
  },
  registerElementInTree: function(element, tree, mainNode) {
   if(element && element.id) {
    var node = tree.createNode(element.id, null);
    tree.addRelatedNode(node, mainNode);
   }
  },
  updateFixedPanelContext: function(){
   if(!this.isPositionFixed()) return;
   this.updateDocumentPaddings();
   this.updateMainElementFixedPosition();
   this.updateFixedPanelsPosition();
  },
  updateExpandButtonPosition: function(){
   var expandButton = this.getExpandButtonElement();
   if(!expandButton) return;
   var isCenterPosition = expandButton.className.indexOf(CENTER_BTN_POSITION_SELECTOR) > -1;
   if(isCenterPosition && expandButton.offsetWidth > 0){
    expandButton.style.width = expandButton.offsetWidth + "px";
    ASPx.SetElementFloat(expandButton, "none");
   }
   var correctButtonPosition = false;
   if(this.fixedPosition == "Top" || this.fixedPosition == "Bottom")
    correctButtonPosition = true;
   else if(this.fixedPosition == "Left" || this.fixedPosition == "Right")
    correctButtonPosition = isCenterPosition;
   else if(this.hasVerticalOrientation())
    correctButtonPosition = isCenterPosition;
   else
    correctButtonPosition = true;
   if(correctButtonPosition) 
    this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.getExpandButtonElement, "Btn", true);
  },
  updateDocumentPaddings: function(){
   if(!this.fixedPositionProperties) return;
   var size = this.getFixedSize(this.fixedPositionProperties.size);
   var expandedSize = 0;
   if(this.expandEffect == "Slide"){
    expandedSize = this.getExpandedSize(this.fixedPositionProperties.size);
    if(this.fixedPosition == "Right" || this.fixedPosition == "Bottom")
     expandedSize = -expandedSize;
   }
   if(!this.fixedPanelCoversViewPort(this.fixedPositionProperties.contentEdge, size))
    this.changeStyleSideAttribute(document.documentElement, "padding", this.fixedPositionProperties.documentPadding, size + "px");
   var documentMarginValue = this.getDocumentPropertyValue(this.fixedPositionProperties.documentMargin);
   var documentMargin2Value = this.getDocumentPropertyValue(this.fixedPositionProperties.documentMargin2);
   if(expandedSize != 0){
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin, (documentMarginValue + expandedSize) + "px");
    ASPx.Attr.ChangeStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin2, (documentMargin2Value - expandedSize) + "px");
    this.documentMarginsChanged = true;
   }
   else if(this.documentMarginsChanged){
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin);
    ASPx.Attr.RestoreStyleAttribute(document.documentElement, this.fixedPositionProperties.documentMargin2);
    this.documentMarginsChanged = false;
   }
  },
  fixedPanelCoversViewPort: function(contentEdge, size) {
   return ((contentEdge === "top" || contentEdge === "bottom") && size >= window.innerHeight) ||
    ((contentEdge === "left" || contentEdge === "right") && size >= window.innerWidth);
  },
  changeStyleSideAttribute: function(element, baseAttr, attr, value){
   if(!ASPx.Browser.IE || ASPx.Browser.Version > 8)
    ASPx.Attr.ChangeStyleAttribute(element, attr, value);
   else{
    var style = ASPx.GetCurrentStyle(element);
    var top = (attr == baseAttr + "-top") ? value : style[baseAttr + "Top"];
    var right = (attr == baseAttr + "-right") ? value : style[baseAttr + "Right"];
    var bottom = (attr == baseAttr + "-bottom") ? value : style[baseAttr + "Bottom"];
    var left = (attr == baseAttr + "-left") ? value : style[baseAttr + "Left"];
    ASPx.Attr.ChangeStyleAttribute(element, baseAttr, top + " " + right + " " + bottom + " " + left);
   }
  },
  updateMainElementFixedPosition: function(){
   if(!this.fixedPositionProperties) return;
   var barElement = this.getExpandBarElement();
   if(barElement){
    var size = this.getSizeCore(barElement, this.fixedPositionProperties.size);
    ASPx.Attr.ChangeStyleAttribute(this.GetMainElement(), this.fixedPositionProperties.contentEdge, size + "px");
   }
  },
  updateFixedPanelsPosition: function() {
   this.updateFixedPanelsEdges(this.updateFixedPanelEdge);
   this.updateFixedPanelsEdges(this.updateFixedPanelOppositeEdge);
  },
  updateFixedPanelsEdges: function(method) {
   if(FixedPanels["Top"]){
    if(FixedPanels["Left"] && !FixedPanels["Top"].fixedPositionOverlap && FixedPanels["Left"].fixedPositionOverlap)
     method.call(FixedPanels["Left"], FixedPanels["Top"], FixedPanels["Right"]);
    if(FixedPanels["Right"] && !FixedPanels["Top"].fixedPositionOverlap && FixedPanels["Right"].fixedPositionOverlap)
     method.call(FixedPanels["Right"], FixedPanels["Top"], FixedPanels["Left"]);
   }
   if(FixedPanels["Bottom"]){
    if(FixedPanels["Left"] && !FixedPanels["Bottom"].fixedPositionOverlap && FixedPanels["Left"].fixedPositionOverlap)
     method.call(FixedPanels["Left"], FixedPanels["Bottom"], FixedPanels["Right"]);
    if(FixedPanels["Right"] && !FixedPanels["Bottom"].fixedPositionOverlap && FixedPanels["Right"].fixedPositionOverlap)
     method.call(FixedPanels["Right"], FixedPanels["Bottom"], FixedPanels["Left"]);
   }
   if(FixedPanels["Left"]){
    if(FixedPanels["Top"] && (!FixedPanels["Left"].fixedPositionOverlap || FixedPanels["Top"].fixedPositionOverlap))
     method.call(FixedPanels["Top"], FixedPanels["Left"], FixedPanels["Bottom"]);
    if(FixedPanels["Bottom"] && (!FixedPanels["Left"].fixedPositionOverlap || FixedPanels["Bottom"].fixedPositionOverlap))
     method.call(FixedPanels["Bottom"], FixedPanels["Left"], FixedPanels["Top"]);
   }
   if(FixedPanels["Right"]){
    if(FixedPanels["Top"] && (!FixedPanels["Right"].fixedPositionOverlap || FixedPanels["Top"].fixedPositionOverlap))
     method.call(FixedPanels["Top"], FixedPanels["Right"], FixedPanels["Bottom"]);
    if(FixedPanels["Bottom"] && (!FixedPanels["Right"].fixedPositionOverlap || FixedPanels["Bottom"].fixedPositionOverlap))
     method.call(FixedPanels["Bottom"], FixedPanels["Right"], FixedPanels["Top"]);
   }
  },
  updateFixedPanelEdge: function(panel){
   var size = this.getFixedSize(this.fixedPositionProperties.size);
   if(this.expandEffect == "Slide")
    size += this.getExpandedSize(this.fixedPositionProperties.size);
   this.updateFixedPanelEdgeCore(panel, this.fixedPositionProperties.contentEdge, size);
  },
  updateFixedPanelOppositeEdge: function(panel, opppositePanel){
   if(!this.IsExpandedInternal() && opppositePanel) return;
   if(this.expandEffect == "Slide") {
    var size = this.getExpandedSize(this.fixedPositionProperties.size);
    this.updateFixedPanelEdgeCore(panel, this.fixedPositionProperties.oppositeContentEdge, -size);
   }
  },
  updateFixedPanelEdgeCore: function(panel, edge, size){
   var mainElement = panel.GetMainElement();
   mainElement.style[edge] = size + "px";
   var expandBarElement = panel.getExpandBarElement();
   if(expandBarElement)
    expandBarElement.style[edge] = size + "px";
  },
  isPositionFixed: function(){
   return !!this.fixedPositionProperties;
  },
  getFixedPosition: function(){
   var cssClass = this.GetMainElement().className;
   if(cssClass.indexOf("dxpnl-edge t") > -1)
    return "Top";
   if(cssClass.indexOf("dxpnl-edge b") > -1)
    return "Bottom";
   if(cssClass.indexOf("dxpnl-edge l") > -1)
    return "Left";
   if(cssClass.indexOf("dxpnl-edge r") > -1)
    return "Right";
   return null;
  },
  isPopupExpanding: function(){
   return !!this.expandDirectionProperties;
  },
  isExpandBarChangeVisibilityOnExpanding: function(){
   return !this.isPopupExpanding() && !this.isPositionFixed() && CollapsiblePanelsGroups[this.groupName].length > 1;
  },
  createVisibilityCss: function() {
   var rules = [];
   rules.push({ selector: "#" + this.name, cssText: "display: none!important;" });
   rules.push({ selector: "#" + this.getExpandBarId(), cssText: "display: none!important;" });
   this.insertAdaptivityRules(rules, this.hideWindowWidth, this.hideWindowHeight, HIDDEN_STATE_CLASS_NAME);
  },
  createCollapsibilityCss: function() {
   var rules = [];
   rules.push({ selector: "#" + this.name, cssText: "display: none;" });
   rules.push({ selector: "#" + this.getExpandBarId() + ".dxpnl-bar", cssText: (this.isPositionFixed() ? "display: block;" : "display: table;") });
   rules.push({ selector: "#" + this.name + "." + EXPANDED_SELECTOR, cssText: "display: block!important;" });
   this.insertAdaptivityRules(rules, this.collapseWindowWidth, this.collapseWindowHeight, COLLAPSED_STATE_CLASS_NAME);
  },
  insertAdaptivityRules: function(rules, maxWindowWidth, maxWindowHeight, adaptivityClassName) {
   var styleSheet = ASPx.GetCurrentStyleSheet();
   if(!styleSheet) return;
   var mediaRule = "@media all and (max-width: " + maxWindowWidth + "px), (max-height: " + maxWindowHeight + "px) { ";
   for(var i = 0; i < rules.length; i++)
    mediaRule += rules[i].selector + "{" + rules[i].cssText + "}";
   mediaRule += "}";
   if(styleSheet.insertRule)
    styleSheet.insertRule(mediaRule, styleSheet.cssRules.length);
  },
  ensureAdaptivityClassNames: function() {
   this.ensureAdaptivityClassName(HIDDEN_STATE_CLASS_NAME, this.hideWindowWidth, this.hideWindowHeight);
   this.ensureAdaptivityClassName(COLLAPSED_STATE_CLASS_NAME, this.collapseWindowWidth, this.collapseWindowHeight);
  },
  ensureAdaptivityClassName: function(adaptivityClassName, maxWindowWidth, maxWindowHeight) {
   var currentDocumentWidth = ASPx.GetCurrentDocumentWidth();
   var currentDocumentHeight = ASPx.GetCurrentDocumentHeight();
   if(currentDocumentWidth <= maxWindowWidth || currentDocumentHeight <= maxWindowHeight)
    this.addAdaptivityClassName(adaptivityClassName);
   else
    this.removeAdaptivityClassName(adaptivityClassName);
  },
  addAdaptivityClassName: function(className) {
   ASPx.AddClassNameToElement(this.GetMainElement(), className);
   if(ASPx.IsExists(this.getExpandBarElement()))
    ASPx.AddClassNameToElement(this.getExpandBarElement(), className);
  },
  removeAdaptivityClassName: function(className) {
   ASPx.RemoveClassNameFromElement(this.GetMainElement(), className);
   if(ASPx.IsExists(this.getExpandBarElement()))
    ASPx.RemoveClassNameFromElement(this.getExpandBarElement(), className);
  },
  useAdaptivityClassNames: function() {
   return this.isIE8()
    && (this.hideWindowWidth > 0 || this.hideWindowHeight > 0 || this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0);
  },
  isIE8: function() {
   return ASPx.Browser.IE && ASPx.Browser.Version === 8;
  },
  Toggle: function() {
   if(this.IsExpandedInternal()) 
    this.Collapse();
   else 
    this.Expand();
  },
  IsExpandable: function() {
   if(this.GetMainElement().className.indexOf(" " + COLLAPSIBLE_SELECTOR) > -1)
    return true;
   if(this.collapseWindowWidth > 0 || this.collapseWindowHeight > 0){
    var expandBarElement = this.getExpandBarElement();
    return expandBarElement && ASPx.GetCurrentStyle(expandBarElement).display !== "none";
   }
   return false;
  },
  IsExpanded: function() {
   if(this.IsExpandable())
    return this.IsExpandedInternal();
   return true;
  },
  IsExpandedInternal: function() {
   return this.GetMainElement().className.indexOf(" " + EXPANDED_SELECTOR) > -1;
  },
  Expand: function(preventAnimation) {
   if(ExpandedPanels[this.groupName] != this) {
    if(ExpandedPanels[this.groupName])
     ExpandedPanels[this.groupName].Collapse(preventAnimation);
    this.collapseOppositePanel(preventAnimation);
    this.collapseUnfixedPopupPanels();
    ExpandedPanels[this.groupName] = this;
    ASPx.GetStateController().SelectElementBySrcElement(this.GetMainElement());
    ASPx.GetStateController().SelectElementBySrcElement(this.getExpandButtonElement());
    if(this.isModal()) {
     var modalElement = this.getModalElement();
     ASPx.AnimationHelper.fadeTo(modalElement, { from: 0, to: this.modalElementOpacity, duration: this.modalShowAnimationDuration });
    }
    ASPx.GetControlCollection().AdjustControls(this.GetMainElement());
    if(this.isPopupExpanding() && !this.isPositionFixed())
     this.updateMainElementPosition(true);
    if(this.isExpandBarChangeVisibilityOnExpanding())
     this.slideAnimationExpandBarSize = this.getSlideAnimationSize(this.getExpandBarElement(), true);
    ASPx.GetStateController().SelectElementBySrcElement(this.getExpandBarElement());
    if(!preventAnimation && this.animationType == "slide")
     this.startSlideAnimation(this.GetMainElement(), false);
    else if(!preventAnimation && this.animationType == "fade")
     this.startFadeAnimation(this.GetMainElement(), false);
    else
     this.expandCore();
   }
  },
  Collapse: function(preventAnimation) {
   if(ExpandedPanels[this.groupName] == this) {
    ExpandedPanels[this.groupName] = null;
    this.collapseUnfixedPopupPanels();
    if(this.isExpandBarChangeVisibilityOnExpanding()){
     ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandBarElement());
     this.slideAnimationExpandBarSize = this.getSlideAnimationSize(this.getExpandBarElement(), true);
     ASPx.GetStateController().SelectElementBySrcElement(this.getExpandBarElement());
    }
    if(this.isModal()) {
     var modalElement = this.getModalElement(),
      fromOpacity = ASPx.GetCurrentStyle(modalElement).opacity;
     ASPx.AnimationHelper.fadeTo(modalElement, { from: fromOpacity, to: 0, duration: this.modalHideAnimationDuration });
    }
    if(!preventAnimation && this.animationType == "slide")
     this.startSlideAnimation(this.GetMainElement(), true);
    else if(!preventAnimation && this.animationType == "fade")
     this.startFadeAnimation(this.GetMainElement(), true);
    else
     this.collapseCore();
   }
  },
  isModal: function() {
   return !!this.getModalElement();
  },
  expandCore: function() {
   if(this.isPositionFixed()) {
    this.updateFixedPanelContext();
   }
   this.raiseExpanded();
  },
  collapseCore: function() {
   ASPx.GetStateController().DeselectElementBySrcElement(this.GetMainElement());
   ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandButtonElement());
   if(this.isPopupExpanding() && !this.isPositionFixed())
    this.updateMainElementPosition(false);
   ASPx.GetStateController().DeselectElementBySrcElement(this.getExpandBarElement());
   if(this.isPositionFixed()) {
    this.updateFixedPanelContext();
   }
   this.slideAnimationPosProperty = null;
   this.raiseCollapsed();
  },
  collapseOppositePanel: function(preventAnimation) {
   if(!this.fixedPositionProperties) return;
   if(FixedPanels[this.fixedPositionProperties.oppositePanel])
    FixedPanels[this.fixedPositionProperties.oppositePanel].Collapse(preventAnimation);
  },
  collapseUnfixedPopupPanels: function() {
   if(!this.isPositionFixed() || this.isPopupExpanding()) return;
   for(var groupName in ExpandedPanels){
    if(ExpandedPanels[groupName] && !ExpandedPanels[groupName].fixedPosition && ExpandedPanels[groupName].isPopupExpanding())
     ExpandedPanels[groupName].Collapse(true);
   }
  },
  saveOpacity: function(element) {
   if(!this.isIE8())
    ASPx.Attr.SaveStyleAttribute(element, "opacity");
   else if(ASPx.GetCurrentStyle(element).filter)
    ASPx.Attr.SaveStyleAttribute(element, "filter");
  },
  restoreOpacity: function(element) {
   if(!this.isIE8())
    ASPx.Attr.RestoreStyleAttribute(element, "opacity");
   else
    ASPx.Attr.RestoreStyleAttribute(element, "filter");
  },
  startFadeAnimation: function (element, isCollapsing) {
   this.saveOpacity(element);
   var onComplete =  function() { this.finishFadeAnimation(element, isCollapsing); }.aspxBind(this);
   if(isCollapsing)
    ASPx.AnimationHelper.fadeOut(element, onComplete, ASPx.AnimationConstants.Durations.SHORT);
   else
    ASPx.AnimationHelper.fadeIn(element, onComplete, ASPx.AnimationConstants.Durations.SHORT);
  },
  finishFadeAnimation: function (element, isCollapsing) {
   this.restoreOpacity(element);
   if(isCollapsing)
    this.collapseCore(); 
   else
    this.expandCore(); 
  },
  startSlideAnimation: function(element, isCollapsing) {
   var sizeProperty = this.getSlideAnimationSizeProperty();
   ASPx.Attr.ChangeStyleAttribute(element, "overflow", "auto");
   var offsetWidth = element.offsetWidth;
   var offsetHeight = element.offsetHeight;
   ASPx.Attr.RestoreStyleAttribute(element, "overflow");
   ASPx.Attr.SaveStyleAttribute(element, sizeProperty);
   if(element.style.overflow !== "")
    ASPx.Attr.ChangeStyleAttribute(element, "overflow", "hidden");
   else {
    ASPx.Attr.ChangeStyleAttribute(element, "overflow-x", "hidden");
    ASPx.Attr.ChangeStyleAttribute(element, "overflow-y", "hidden");
   }
   var contentContainer = this.getAnimationContentContainerElement();
   if(contentContainer) {
    if(contentContainer.style.overflow !== "")
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow", "hidden");
    else{
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow-x", "hidden");
     ASPx.Attr.ChangeStyleAttribute(contentContainer, "overflow-y", "hidden");
    }
    ASPx.Attr.ChangeStyleAttribute(contentContainer, "width", offsetWidth - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element) + "px");
    ASPx.Attr.ChangeStyleAttribute(contentContainer, "height", offsetHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element) + "px");
   }
   var transitionProperties = {
    duration: ASPx.AnimationConstants.Durations.SHORT, 
    onComplete: function() { this.finishSlideAnimation(element, isCollapsing); }.aspxBind(this)
   };
   if(this.isPositionFixed())
    transitionProperties.onStep = function() { this.performSlideAnimationStep(); }.aspxBind(this);
   var transition = ASPx.AnimationHelper.createMultipleAnimationTransition(element, transitionProperties);
   var size = this.getSlideAnimationSize(element, !this.isPositionFixed());
   var startSize = isCollapsing ? size : 0;
   var endSize = isCollapsing ? 0 : size;
   if(this.isExpandBarChangeVisibilityOnExpanding() && this.slideAnimationExpandBarSize){
    if(startSize == 0)
     startSize = this.slideAnimationExpandBarSize;
    if(endSize == 0)
     endSize = this.slideAnimationExpandBarSize;
   }
   var properties = {};
   properties[sizeProperty] = { from: startSize, to: endSize, unit: "px" };
   if(!isCollapsing) 
    ASPx.Attr.ChangeStyleAttribute(element, sizeProperty, startSize + "px");
   if(this.slideAnimationPosProperty){
    var position = parseInt(element.style[this.slideAnimationPosProperty]);
    var startPosition = isCollapsing ? position : position + size;
    var endPosition = isCollapsing ? position + size : position;
    properties[this.slideAnimationPosProperty] = { from: startPosition, to: endPosition, unit: "px" };
    if(!isCollapsing) 
     ASPx.Attr.ChangeStyleAttribute(element, this.slideAnimationPosProperty, startPosition + "px");
   }
   transition.Start(properties);
  },
  finishSlideAnimation: function(element, isCollapsing) {
   var sizeProperty = this.getSlideAnimationSizeProperty();
   ASPx.Attr.RestoreStyleAttribute(element, sizeProperty);
   ASPx.Attr.RestoreStyleAttribute(element, "overflow");
   ASPx.Attr.RestoreStyleAttribute(element, "overflow-x");
   ASPx.Attr.RestoreStyleAttribute(element, "overflow-y");
   var contentContainer = this.getAnimationContentContainerElement();
   if(contentContainer) {
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow-x");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "overflow-y");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "width");
    ASPx.Attr.RestoreStyleAttribute(contentContainer, "height");
   }
   if(isCollapsing)
    this.collapseCore(); 
   else
    this.expandCore(); 
  },
  performSlideAnimationStep: function() {
   this.updateFixedPanelContext();
  },
  getSlideAnimationSizeProperty: function() {
   if(this.fixedPositionProperties)
    return this.fixedPositionProperties.animationSize;
   else if(this.expandDirectionProperties)
    return this.expandDirectionProperties.animationSize;
   else 
    return this.hasVerticalOrientation() ? "width" : "height";
  },
  getSlideAnimationSize: function(element, fullSize) {
   var sizeProperty;
   if(this.fixedPositionProperties)
    sizeProperty = this.fixedPositionProperties.size;
   else if(this.expandDirectionProperties)
    sizeProperty = this.expandDirectionProperties.size;
   else
    sizeProperty = this.hasVerticalOrientation() ? "offsetWidth" : "offsetHeight";
   var size = this.getSizeCore(element, sizeProperty);
   if(fullSize) {
    if(sizeProperty == "offsetWidth")
     size -= ASPx.GetHorizontalBordersWidth(element);
    else
     size -= ASPx.GetVerticalBordersWidth(element);
   }
   else {
    if(sizeProperty == "offsetWidth")
     size -= ASPx.GetLeftRightBordersAndPaddingsSummaryValue(element);
    else
     size -= ASPx.GetTopBottomBordersAndPaddingsSummaryValue(element);
   }
   return size;
  },
  getSlideAnimationPosProperty: function(x, y) {
   if(this.expandEffect == "PopupToTop")
    return !y.isInverted ? "top" : null;
   if(this.expandEffect == "PopupToBottom")
    return y.isInverted ? "top" : null;
   if(this.expandEffect == "PopupToLeft")
    return !x.isInverted ? "left" : null;
   if(this.expandEffect == "PopupToRight")
    return y.isInverted ? "left" : null;
   return null;
  }, 
  hasVerticalOrientation: function() {
   var float = ASPx.GetElementFloat(this.GetMainElement());
   return (float === "left" || float === "right");
  },
  updateMainElementPosition: function(expanded) {
   if(!this.expandDirectionProperties) return;
   if(expanded)
    this.updateMainElementExpandedPosition(this.GetMainElement());
   else
    this.updateMainElementCollapsedPosition(this.GetMainElement());
  },
  updateMainElementExpandedPosition: function(element) {
   if(element.style.width === "100%")
    ASPx.Attr.ChangeStyleAttribute(element, "width", (element.parentNode.offsetWidth - ASPx.GetLeftRightMargins(element)) + "px");
   if(element.style.height === "100%")
    ASPx.Attr.ChangeStyleAttribute(element, "height", (element.parentNode.offsetHeight - ASPx.GetTopBottomMargins(element)) + "px");
   ASPx.Attr.ChangeStyleAttribute(element, "position", "absolute");
   var barElement = this.getExpandBarElement();
   var x = ASPx.PopupUtils.GetPopupAbsoluteX(element,
    barElement, this.expandDirectionProperties.hAlign, 0, 0, 0, false, false);
   var y = ASPx.PopupUtils.GetPopupAbsoluteY(element,
    barElement, this.expandDirectionProperties.vAlign, 0, 0, 0, true, false);
   ASPx.SetAbsoluteX(element, x.position);
   ASPx.SetAbsoluteY(element, y.position);
   this.slideAnimationPosProperty = this.getSlideAnimationPosProperty(x, y);
  },
  updateMainElementCollapsedPosition: function(element) {
   ASPx.Attr.RestoreStyleAttribute(element, "position");
   ASPx.Attr.RestoreStyleAttribute(element, "left");
   ASPx.Attr.RestoreStyleAttribute(element, "top");
   ASPx.Attr.RestoreStyleAttribute(element, "width");
   ASPx.Attr.RestoreStyleAttribute(element, "height");
  },
  checkCollapseContent: function(){
   if(!this.getExpandBarElement()) return;
   if(this.IsExpandedInternal()){
    if(CollapsiblePanelsGroups[this.groupName].length === 1 && !this.isElementDisplayed(this.getExpandBarElement()) && this.isElementDisplayed(this.GetMainElement()))
     this.Collapse(true);
    if(!this.isPositionFixed() && this.isPopupExpanding())
     this.Collapse(true);
   }
  },
  raiseCollapsed: function() {
   if(!this.Collapsed.IsEmpty()) {
    var args = new ASPxClientEventArgs();
    this.Collapsed.FireEvent(this, args);
   }
  },
  raiseExpanded: function() {
   if(!this.Expanded.IsEmpty()) {
    var args = new ASPxClientEventArgs();
    this.Expanded.FireEvent(this, args);
   }
  },
  getAnimationContentContainerElement: function() {
   if(!ASPx.IsExistsElement(this.animationContentContainerElement)) 
    this.animationContentContainerElement = ASPx.GetChildByClassName(this.GetMainElement(), "dxpnl-acc");
   return this.animationContentContainerElement;
  },
  getScrollContentContainerElement: function() {
   if (!ASPx.IsExistsElement(this.scrollContentContainerElement)) {
    var mainElement = this.GetMainElement();
    this.scrollContentContainerElement = ASPx.GetNodesByPartialClassName(this.GetMainElement(), "dxpnl-scc")[0];
    if (mainElement.tagName == "DIV" && this.scrollContentContainerElement && this.scrollContentContainerElement.parentNode != mainElement)
     this.scrollContentContainerElement = null;
   }
   return this.scrollContentContainerElement;
  },
  getExpandBarElement: function() {
   if(!ASPx.IsExistsElement(this.expandBarElement))
    this.expandBarElement = ASPx.GetElementById(this.getExpandBarId());
   return this.expandBarElement;
  },
  getExpandBarId: function() {
   return this.name + EXPAND_BAR_ID;
  },
  getModalElement: function() {
   if(!ASPx.IsExistsElement(this.modalElement))
    this.modalElement = ASPx.GetElementById(this.getModalELementId());
   return this.modalElement;
  },
  getModalELementId: function() {
   return this.name + MODAL_ELEMENT_ID;
  },
  getExpandButtonElement: function() {
   if(!ASPx.IsExistsElement(this.expandButtonElement))
    this.expandButtonElement = ASPx.GetElementById(this.name + EXPAND_BUTTON_ID);
   return this.expandButtonElement;
  },
  getFixedElement: function(){
   if(this.getExpandBarElement() && this.isElementDisplayed(this.getExpandBarElement()))
    return this.getExpandBarElement();
   else
    return this.GetMainElement();
  },
  getDocumentPropertyValue: function(attr){
   if(DocumentProperties[attr] === undefined){
    var currentStyle = ASPx.GetCurrentStyle(document.documentElement);
    var attrValue = parseInt(ASPx.Attr.GetAttribute(currentStyle, attr));
    DocumentProperties[attr] = !isNaN(attrValue) ? attrValue : 0;
   }
   return DocumentProperties[attr];
  },
  isElementDisplayed: function(element){
   return ASPx.GetCurrentStyle(element).display != "none";
  }
 });
 ASPxClientPanel.Cast = ASPxClientControl.Cast;
 window.ASPxClientPanelBase = ASPxClientPanelBase;
 window.ASPxClientPanel = ASPxClientPanel;
})();
(function () {
var PopupUtils = {
 NotSetAlignIndicator: "NotSet",
 InnerAlignIndicator: "Sides",
 OutsideLeftAlignIndicator: "OutsideLeft",
 LeftSidesAlignIndicator: "LeftSides",
 RightSidesAlignIndicator: "RightSides",
 OutsideRightAlignIndicator: "OutsideRight",
 CenterAlignIndicator: "Center",
 AboveAlignIndicator: "Above",
 TopSidesAlignIndicator: "TopSides",
 MiddleAlignIndicator: "Middle",
 BottomSidesAlignIndicator: "BottomSides",
 BelowAlignIndicator: "Below",
 WindowCenterAlignIndicator: "WindowCenter",
 LeftAlignIndicator: "Left",
 RightAlignIndicator: "Right",
 TopAlignIndicator: "Top",
 BottomAlignIndicator: "Bottom",
 WindowLeftAlignIndicator: "WindowLeft",
 WindowRightAlignIndicator: "WindowRight",
 WindowTopAlignIndicator: "WindowTop",
 WindowBottomAlignIndicator: "WindowBottom",
 IsAlignNotSet: function (align) {
  return align == PopupUtils.NotSetAlignIndicator;
 },
 IsInnerAlign: function (align) {
  return align.indexOf(PopupUtils.InnerAlignIndicator) != -1;
 },
 IsRightSidesAlign: function(align) {
  return align == PopupUtils.RightSidesAlignIndicator;
 },
 IsOutsideRightAlign: function(align) {
  return align == PopupUtils.OutsideRightAlignIndicator;
 },
 IsCenterAlign: function(align) {
  return align == PopupUtils.CenterAlignIndicator;
 },
 FindPopupElementById: function (id) {
  if(id == "")
   return null; 
  var popupElement = ASPx.GetElementById(id);
  if(!ASPx.IsExistsElement(popupElement)) {
   var idParts = id.split("_");
   var uniqueId = idParts.join("$");
   popupElement = ASPx.GetElementById(uniqueId);
  }
  return popupElement;
 },
 FindEventSourceParentByTestFunc: function (evt, testFunc) {
  return ASPx.GetParent(ASPx.Evt.GetEventSource(evt), testFunc);
 },
 PreventContextMenu: function (evt) {
  ASPx.Evt.PreventEventAndBubble(evt);
  if(ASPx.Browser.WebKitFamily)
   evt.returnValue = false;
 },
 GetDocumentClientWidthForPopup: function() {
  return ASPx.Browser.WebKitTouchUI ? document.body.offsetWidth : ASPx.GetDocumentClientWidth();
 },
 GetDocumentClientHeightForPopup: function() {
  return ASPx.Browser.WebKitTouchUI ? document.body.offsetHeight : ASPx.GetDocumentClientHeight();
 },
 AdjustPositionToClientScreen: function (element, pos, rtl, isX) {
  var min = isX ? ASPx.GetDocumentScrollLeft() : ASPx.GetDocumentScrollTop(),
   max = min + (isX ? ASPx.GetDocumentClientWidth() : ASPx.GetDocumentClientHeight());
  max -= (isX ? element.offsetWidth : element.offsetHeight);
  if(rtl && isX) {
   if(pos < min) pos = min;
   if(pos > max) pos = max;
  } else {
   if(pos > max) pos = max;
   if(pos < min) pos = min;
  }
  return pos;
 },
 GetPopupAbsoluteX: function(element, popupElement, hAlign, hOffset, x, left, rtl, isPopupFullCorrectionOn) {
  return PopupUtils.getPopupAbsolutePos(element, popupElement, hAlign, hOffset, x, left, rtl, isPopupFullCorrectionOn, false, false, true);
 },
 GetPopupAbsoluteY: function (element, popupElement, vAlign, vOffset, y, top, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders) {
  return PopupUtils.getPopupAbsolutePos(element, popupElement, vAlign, vOffset, y, top, false, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, false);
 },
 getPopupAbsolutePos: function(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal) {
  var calculator = getPositionCalculator();
  calculator.applyParams(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal);
  var position = calculator.getPopupAbsolutePos();
  calculator.disposeState();
  return position;
 },
 RemoveFocus: function (parent) {
  var div = document.createElement('div');
  div.tabIndex = "-1";
  PopupUtils.ConcealDivElement(div);
  parent.appendChild(div);
  if(ASPx.IsFocusable(div))
   div.focus();
  ASPx.RemoveElement(div);
 },
 ConcealDivElement: function (div) {
  div.style.position = "absolute";
  div.style.left = 0;
  div.style.top = 0;
  if(ASPx.Browser.WebKitFamily) {
   div.style.opacity = 0;
   div.style.width = 1;
   div.style.height = 1;
  } else {
   div.style.border = 0;
   div.style.width = 0;
   div.style.height = 0;
  }
 },
 InitAnimationProperties: function(element, onAnimStopCallString) {
  element.popuping = true;
  element.onAnimStopCallString = onAnimStopCallString;
 },
 InitAnimationDiv: function (element, x, y, onAnimStopCallString, skipSizeInit) {
  PopupUtils.InitAnimationProperties(element, onAnimStopCallString);
  PopupUtils.InitAnimationDivCore(element);
  if(!skipSizeInit) {
   ASPx.SetStyles(element, { width: "", height: "" });
   ASPx.SetStyles(element, { width: element.offsetWidth, height: element.offsetHeight });
  }
  ASPx.SetStyles(element, { left: x, top: y });
 },
 InitAnimationDivCore: function (element) {
  ASPx.SetStyles(element, {
   overflow: "hidden",
   position: "absolute"
  });
 },
 StartSlideAnimation: function (animationDivElement, element, iframeElement, duration, preventChangingWidth, preventChangingHeight) {
  if(iframeElement) {
   var endLeft = ASPx.PxToInt(iframeElement.style.left);
   var endTop = ASPx.PxToInt(iframeElement.style.top);
   var startLeft = ASPx.PxToInt(element.style.left) < 0 ? endLeft : animationDivElement.offsetLeft + animationDivElement.offsetWidth;
   var startTop = ASPx.PxToInt(element.style.top) < 0 ? endTop : animationDivElement.offsetTop + animationDivElement.offsetHeight;
   var properties = {
    left: { from: startLeft, to: endLeft, unit: "px" },
    top: { from: startTop, to: endTop, unit: "px" }
   };
   if(!preventChangingWidth)
    properties.width = { to: element.offsetWidth, unit: "px" };
   if(!preventChangingHeight)
    properties.height = { to: element.offsetHeight, unit: "px" };
   ASPx.AnimationHelper.createMultipleAnimationTransition(iframeElement, {
    duration: duration
   }).Start(properties);
  }
  ASPx.AnimationHelper.createMultipleAnimationTransition(element, {
   duration: duration,
   onComplete: function () { PopupUtils.AnimationFinished(animationDivElement, element); }
  }).Start({
   left: { to: 0, unit: "px" },
   top: { to: 0, unit: "px" }
  });
 },
 AnimationFinished: function (animationDivElement, element) {
  if(PopupUtils.StopAnimation(animationDivElement, element) && ASPx.IsExists(animationDivElement.onAnimStopCallString) &&
   animationDivElement.onAnimStopCallString !== "") {
   window.setTimeout(animationDivElement.onAnimStopCallString, 0);
  }
 },
 StopAnimation: function (animationDivElement, element) {
  if(animationDivElement.popuping) {
   ASPx.AnimationHelper.cancelAnimation(element);
   animationDivElement.popuping = false;
   animationDivElement.style.overflow = "visible";
   return true;
  }
  return false;
 },
 GetAnimationHorizontalDirection: function (popupPosition, horizontalAlign, verticalAlign, rtl) {
  if(PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsAlignNotSet(verticalAlign))
   return 0;
  var toTheLeft = (horizontalAlign == PopupUtils.OutsideLeftAlignIndicator || horizontalAlign == PopupUtils.RightSidesAlignIndicator || (horizontalAlign == PopupUtils.NotSetAlignIndicator && rtl)) ^ popupPosition.isInverted;
  return toTheLeft ? 1 : -1;
 },
 GetAnimationVerticalDirection: function (popupPosition, horizontalAlign, verticalAlign) {
  if(PopupUtils.IsInnerAlign(verticalAlign)
   && !PopupUtils.IsInnerAlign(horizontalAlign)
   && !PopupUtils.IsAlignNotSet(horizontalAlign))
   return 0;
  var toTheTop = (verticalAlign == PopupUtils.AboveAlignIndicator || verticalAlign == PopupUtils.BottomSidesAlignIndicator) ^ popupPosition.isInverted;
  return toTheTop ? 1 : -1;
 },
 IsVerticalScrollExists: function () {
  var scrollIsNotHidden = ASPx.GetCurrentStyle(document.body).overflowY !== "hidden" && ASPx.GetCurrentStyle(document.documentElement).overflowY !== "hidden";
  return (scrollIsNotHidden && ASPx.GetDocumentHeight() > ASPx.GetDocumentClientHeight());
 },
 CoordinatesInDocumentRect: function (x, y) {
  var docScrollLeft = ASPx.GetDocumentScrollLeft();
  var docScrollTop = ASPx.GetDocumentScrollTop();
  return (x > docScrollLeft && y > docScrollTop &&
   x < ASPx.GetDocumentClientWidth() + docScrollLeft &&
   y < ASPx.GetDocumentClientHeight() + docScrollTop);
 },
 GetElementZIndexArray: function (element) {
  var currentElement = element;
  var zIndexesArray = [0];
  while(currentElement && currentElement.tagName != "BODY") {
   if(currentElement.style) {
    if(typeof (currentElement.style.zIndex) != "undefined" && currentElement.style.zIndex != "")
     zIndexesArray.unshift(currentElement.style.zIndex);
   }
   currentElement = currentElement.parentNode;
  }
  return zIndexesArray;
 },
 IsHigher: function (higherZIndexArrat, zIndexArray) {
  if(zIndexArray == null) return true;
  var count = (higherZIndexArrat.length >= zIndexArray.length) ? higherZIndexArrat.length : zIndexArray.length;
  for(var i = 0; i < count; i++)
   if(typeof (higherZIndexArrat[i]) != "undefined" && typeof (zIndexArray[i]) != "undefined") {
    var higherZIndexArrayCurrentElement = parseInt(higherZIndexArrat[i].toString());
    var zIndexArrayCurrentElement = parseInt(zIndexArray[i].toString());
    if(higherZIndexArrayCurrentElement != zIndexArrayCurrentElement)
     return higherZIndexArrayCurrentElement > zIndexArrayCurrentElement;
   } else return typeof (zIndexArray[i]) == "undefined";
  return true;
 },
 TestIsPopupElement: function (element) {
  return !!element.DXPopupElementControl;
 },
 adjustViewportScrollWrapper: function(wrapper, wrapperScroll, windowElement) {
  var document = wrapper.ownerDocument;
  var window = document.defaultView || document.parentWindow;
  var isWindowElementDisplayed = ASPx.IsElementDisplayed(windowElement);
  if(!isWindowElementDisplayed) {
   wrapper.style.cssText = "";
   wrapperScroll.style.cssText = "";
   return; 
  }
  var windowRect = windowElement.getBoundingClientRect();
  var yAxis = this.calculateViewPortScrollDataByAxis(wrapper.style.top, windowRect.top, windowElement.offsetHeight, window.innerHeight, wrapper.scrollTop);
  var xAxis = this.calculateViewPortScrollDataByAxis(wrapper.style.left, windowRect.left, windowElement.offsetWidth, window.innerWidth, wrapper.scrollLeft);
  this.prepareViewPortScrollData(xAxis, yAxis);
  ASPx.SetStyles(windowElement, {
   top: yAxis.windowOffset,
   left: xAxis.windowOffset
  });
  ASPx.SetStyles(wrapper, {
   width: xAxis.wrapperSize,
   height: yAxis.wrapperSize,
   position: "absolute",
   overflow: ASPx.Browser.MobileUI ? "scroll" : "auto",
   zIndex: windowElement.style.zIndex
  });
  ASPx.SetAbsoluteX(wrapper, ASPx.GetDocumentScrollLeft());
  ASPx.SetAbsoluteY(wrapper, ASPx.GetDocumentScrollTop());
  ASPx.SetStyles(wrapperScroll, {
   width: xAxis.wrapperScrollSize,
   height: yAxis.wrapperScrollSize,
   position: "absolute",
   overflow: "hidden"
  });
  wrapper.scrollLeft = xAxis.scrollSize;
  wrapper.scrollTop = yAxis.scrollSize;
 },
 calculateViewPortScrollDataByAxis: function(wrapperOffsetStyle, windowOffset, windowSize, viewPortSize, scrollSize) {
  var isWindowOffsetNegative = windowOffset < 0;
  windowOffset = isWindowOffsetNegative ? 0 : windowOffset;
  var wrapperScrollSize = Math.max(viewPortSize + Math.abs(Math.min(0, windowOffset)), windowSize + Math.abs(windowOffset));
  return { 
   windowOffset: isWindowOffsetNegative ? 0 : windowOffset,
   wrapperSize: viewPortSize,
   wrapperScrollSize: wrapperScrollSize,
   scrollSize: isWindowOffsetNegative ? scrollSize + Math.abs(windowOffset) : 0,
   hasScroll: wrapperScrollSize > viewPortSize
  };
 },
 prepareViewPortScrollData: function(xAxis, yAxis) {
  var scrollBarSize = ASPx.GetVerticalScrollBarWidth();
  if(yAxis.hasScroll && !xAxis.hasScroll) {
   xAxis.wrapperScrollSize = Math.min(xAxis.wrapperSize - scrollBarSize, xAxis.wrapperScrollSize);
  } else if(xAxis.hasScroll && !yAxis.hasScroll) {
   yAxis.wrapperScrollSize = Math.min(yAxis.wrapperSize - scrollBarSize, yAxis.wrapperScrollSize);
  } else if(yAxis.hasScroll && xAxis.hasScroll) {
   yAxis.wrapperScrollSize -= scrollBarSize;
   xAxis.wrapperScrollSize -= scrollBarSize;
  }
 }
};
PopupUtils.OverControl = {
 GetPopupElementByEvt: function (evt) {
  return PopupUtils.FindEventSourceParentByTestFunc(evt, PopupUtils.TestIsPopupElement);
 },
 OnMouseEvent: function (evt, mouseOver) {
  var popupElement = PopupUtils.OverControl.GetPopupElementByEvt(evt);
  if(mouseOver)
   popupElement.DXPopupElementControl.OnPopupElementMouseOver(evt, popupElement);
  else
   popupElement.DXPopupElementControl.OnPopupElementMouseOut(evt, popupElement);
 },
 OnMouseOut: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, false);
 },
 OnMouseOver: function (evt) {
  PopupUtils.OverControl.OnMouseEvent(evt, true);
 }
};
PopupUtils.BodyScrollHelper = (function () {
 var windowScrollLock = {},
  windowScroll = {},
  hideScrollbarsClassName = "dxpc-hideScrollbars",
  savedHtmlOverflow = "";
 function lockWindowScroll(windowId) {
  windowScrollLock[windowId] = true;
 }
 function unlockWindowScroll(windowId) {
  delete windowScrollLock[windowId];
 }
 function isLocked(windowId) {
  return !!windowScrollLock[windowId];
 }
 function isAnyWindowScrollLocked() {
  for(var key in windowScrollLock) 
   if (windowScrollLock.hasOwnProperty(key) && windowScrollLock[key] === true)
    return true;
  return false;
 }
 function replaceVerticalScrollByPadding() {
  var currentBodyStyle = ASPx.GetCurrentStyle(document.body),
   paddingWidth = ASPx.GetVerticalScrollBarWidth() + ASPx.PxToInt(currentBodyStyle.paddingRight);
  ASPx.Attr.ChangeStyleAttribute(document.body, "padding-right", paddingWidth + "px");
 }
 function needToChangeOverflowUsingStyle() {
  return ASPx.Browser.IE && ASPx.Browser.Version >= 11;
 }
 function changeOverflow() {
  if(needToChangeOverflowUsingStyle()) { 
   savedHtmlOverflow = document.documentElement.style.overflow;
   document.documentElement.style.overflow = "hidden";
  }
  else
   ASPx.Attr.ChangeStyleAttribute(document.documentElement, "overflow", "hidden");
  if(ASPx.GetCurrentStyle(document.body).overflowY === "scroll")
   ASPx.Attr.ChangeStyleAttribute(document.body, "overflow", "hidden");
  resetOverflowCache();
 }
 function restoreOverflow() {
  if(needToChangeOverflowUsingStyle()) { 
   document.documentElement.style.overflow = savedHtmlOverflow;
   savedHtmlOverflow = "";
  }
  else
   ASPx.Attr.RestoreStyleAttribute(document.documentElement, "overflow");
  ASPx.Attr.RestoreStyleAttribute(document.body, "overflow");
  resetOverflowCache();
 }
 function resetOverflowCache() {
  ASPx.verticalScrollIsNotHidden = null;
  ASPx.horizontalScrollIsNotHidden = null;
 }
 function saveScrollPosition(windowId) {
  windowScroll[windowId] = {
   x: window.pageXOffset,
   y: window.pageYOffset
  };
 }
 function restoreScrollPosition(windowId) {
  var currentWindowScroll = windowScroll[windowId];
  if(!!currentWindowScroll)
   window.scrollTo(currentWindowScroll.x, currentWindowScroll.y);
 }
 function restoreBodyScroll(windowId) {
  unlockWindowScroll(windowId);
  if(isAnyWindowScrollLocked())
   return;
  if(ASPx.Browser.IE) {
   ASPx.Attr.RestoreAttribute(document.body, "scroll");
   restoreOverflow();
   restoreScrollPosition(windowId);
  } else if(ASPx.Browser.WebKitTouchUI) {
   ASPx.Attr.RestoreStyleAttribute(document.body, "position");
   ASPx.Attr.RestoreStyleAttribute(document.body, "height");
   ASPx.Attr.RestoreStyleAttribute(document.body, "margin");
   ASPx.RemoveClassNameFromElement(document.documentElement, hideScrollbarsClassName);
   ASPx.Attr.RestoreStyleAttribute(document.body, "overflow");
   restoreScrollPosition(windowId);
  } else {
   restoreOverflow();
   restoreScrollPosition(windowId);
  }
  if(ASPx.Browser.Chrome)
   var dummy = document.documentElement.scrollTop; 
  ASPx.Attr.RestoreStyleAttribute(document.body, "padding-right");
  ASPx.Attr.RestoreStyleAttribute(document.body, "height");
  ASPx.Attr.RestoreStyleAttribute(document.body, "width");
 }
 return {
  RestoreIfLocked: function(windowId) {
   if(isLocked(windowId))
    restoreBodyScroll(windowId);
  },
  HideBodyScroll: function(windowId) {
   if(isAnyWindowScrollLocked()) { 
    lockWindowScroll(windowId);
    return;
   }
   lockWindowScroll(windowId);
   if(PopupUtils.IsVerticalScrollExists())
    replaceVerticalScrollByPadding();
   if(ASPx.Browser.IE) {
    saveScrollPosition(windowId);
    ASPx.Attr.ChangeAttribute(document.body, "scroll", "no");
    changeOverflow();
   } else if(ASPx.Browser.WebKitTouchUI) {
    saveScrollPosition(windowId);
    ASPx.Attr.ChangeStyleAttribute(document.body, "overflow", "hidden");
    ASPx.Attr.ChangeStyleAttribute(document.body, "position", "relative");
    ASPx.Attr.ChangeStyleAttribute(document.body, "height", "100%");
    ASPx.Attr.ChangeStyleAttribute(document.body, "margin", "0");
    ASPx.AddClassNameToElement(document.documentElement, hideScrollbarsClassName);
   } else {
    saveScrollPosition(windowId);
    changeOverflow();
    var documentHeight = ASPx.GetDocumentHeight();
    var documentWidth = ASPx.GetDocumentWidth();
    if(window.pageYOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentHeight)
     ASPx.Attr.ChangeStyleAttribute(document.body, "height", documentHeight + "px");
    if(window.pageXOffset > 0 && ASPx.PxToInt(window.getComputedStyle(document.body, null)) != documentWidth)
     ASPx.Attr.ChangeStyleAttribute(document.body, "width", documentWidth + "px");
   }
  },
  RestoreBodyScroll: restoreBodyScroll
 };
})();
var PositionAlignConsts = {
 NOT_SET: 0,
 OUTSIDE_START: 1,
 NEAR_BOUND_START: 2,
 INNER_START: 3,
 CENTER: 4,
 INNER_END: 5,
 NEAR_BOUND_END: 6,
 OUTSIDE_END: 7,
 WINDOW_CENTER: 8,
 WINDOW_START: 9,
 WINDOW_END: 10
};
var AlignIndicatorTable = {};
var PositionCalculator = ASPx.CreateClass(null, {
 constructor: function() {
  this.element = null;
  this.popupElement = null;
  this.align = 0;
  this.offset = 0;
  this.startPos = 0;
  this.startPosInit = 0;
  this.rtl = false;
  this.isPopupFullCorrectionOn = false;
  this.isHorizontal = true;
  this.size = 0;
  this.bodySize = 0;
  this.actualBodySize = 0;
  this.elementStartPos = 0;
  this.scrollStartPos = 0;
  this.isInverted = false;
  this.popupElementSize = 0;
  this.boundStartPos = 0;
  this.boundEndPos = 0;
  this.innerBoundStartPos = 0;
  this.innerBoundEndPos = 0;
  this.isMoreFreeSpaceLeft = false;
  this.nearBoundOverlapRate = 0.25;
  this.functionsTable = {};
  this.initializeFunctionsTable();
 },
 applyParams: function(element, popupElement, align, offset, startPos, startPosInit, rtl, isPopupFullCorrectionOn, ignoreAlignWithoutScrollReserve, ignorePopupElementBorders, isHorizontal) {
  this.isHorizontal = isHorizontal;
  this.element = element;
  this.popupElement = popupElement;
  this.align = this.getAlignValueFromIndicator(align);
  this.offset = offset;
  this.startPos = startPos;
  this.startPosInit = startPosInit;
  this.rtl = rtl;
  this.isPopupFullCorrectionOn = isPopupFullCorrectionOn;
  this.ignoreAlignWithoutScrollReserve = ignoreAlignWithoutScrollReserve;
  this.ignorePopupElementBorders = ignorePopupElementBorders;
  this.calculateParams();
 },
 disposeState: function() {
  this.element = null;
  this.popupElement = null;
 },
 getPopupAbsolutePos: function() {
  if(this.isWindowAlign()) {
   var showAtPos = this.startPos != ASPx.InvalidPosition && !this.popupElement;
   if(showAtPos)
    this.align = PositionAlignConsts.NOT_SET;
   else
    return this.getWindowAlignPos();
  }
  if(this.popupElement)
   this.calculatePopupElement();
  else
   this.align = PositionAlignConsts.NOT_SET;
  return this.getPopupAbsolutePosCore();
 },
 initializeFunctionsTable: function() {
  var table = this.functionsTable;
  table[PositionAlignConsts.NOT_SET] = this.calculateNotSet;
  table[PositionAlignConsts.OUTSIDE_START] = this.calculateOutsideStart;
  table[PositionAlignConsts.INNER_START] = this.calculateInnerStart;
  table[PositionAlignConsts.CENTER] = this.calculateCenter;
  table[PositionAlignConsts.INNER_END] = this.calculateInnerEnd;
  table[PositionAlignConsts.OUTSIDE_END] = this.calculateOutsideEnd;
  table[PositionAlignConsts.NEAR_BOUND_START] = this.calculateNearBoundStart;
  table[PositionAlignConsts.NEAR_BOUND_END] = this.calculateNearBoundEnd;
  table[PositionAlignConsts.WINDOW_CENTER] = this.calculateWindowCenter;
  table[PositionAlignConsts.WINDOW_START] = this.calculateWindowStart;
  table[PositionAlignConsts.WINDOW_END] = this.calculateWindowEnd;
 },
 calculateParams: function() {
  this.size = this.getElementSize();
  if(this.isHorizontal) {
   this.bodySize = ASPx.GetDocumentClientWidth();
   this.elementStartPos = ASPx.GetAbsoluteX(this.popupElement) + this.getBorderCorrection();
   this.scrollStartPos = ASPx.GetDocumentScrollLeft();
  }
  else {
   this.bodySize = ASPx.GetDocumentClientHeight();
   this.elementStartPos = ASPx.GetAbsoluteY(this.popupElement) + this.getBorderCorrection();
   this.scrollStartPos = ASPx.GetDocumentScrollTop();
  }
 },
 getBorderCorrection: function() {
  if(!this.ignorePopupElementBorders)
   return 0;
  var style = getComputedStyle(this.popupElement);
  return ASPx.PxToInt(this.isHorizontal ? style.borderLeftWidth : style.borderTopWidth);
 },
 isWindowAlign: function() {
  return this.align == PositionAlignConsts.WINDOW_CENTER || this.align == PositionAlignConsts.WINDOW_START ||
   this.align == PositionAlignConsts.WINDOW_END;
 },
 getWindowAlignPos: function() {
  this.actualBodySize = ASPx.Browser.WebKitTouchUI ? this.getWindowInnerSize() : this.bodySize;
  return this.getPopupAbsolutePosCore();
 },
 getPopupAbsolutePosCore: function() {
  var calculationFunc = this.functionsTable[this.align];
  calculationFunc.call(this);
  return new ASPx.PopupPosition(this.startPos, this.isInverted);
 },
 calculateWindowCenter: function() {
  this.startPos = Math.max(Math.ceil(this.actualBodySize / 2 - this.size / 2), 0) + this.scrollStartPos + this.offset;
 },
 calculateWindowStart: function() {
  this.startPos = this.scrollStartPos + this.offset;
 },
 calculateWindowEnd: function() {
  this.startPos = this.scrollStartPos + this.actualBodySize - this.size + this.offset;
 },
 calculatePopupElement: function() {
  this.popupElementSize = this.getPopupElementSize();
  this.boundStartPos = this.elementStartPos - this.size;
  this.boundEndPos = this.elementStartPos + this.popupElementSize;
  this.innerBoundStartPos = this.elementStartPos;
  this.innerBoundEndPos = this.elementStartPos + this.popupElementSize - this.size;
  var hasLeftScrollReserve = this.boundStartPos >= 0;
  this.isMoreFreeSpaceLeft = (this.bodySize - (this.boundEndPos + this.size) < this.boundStartPos - 2 * this.scrollStartPos) && (!this.ignoreAlignWithoutScrollReserve || hasLeftScrollReserve);
 },
 calculateOutsideStart: function() {
  this.isInverted = this.isPopupFullCorrectionOn && (!(this.boundStartPos - this.scrollStartPos > 0 || this.isMoreFreeSpaceLeft));
  if(this.isInverted)
   this.startPos = this.boundEndPos - this.offset;
  else
   this.startPos = this.boundStartPos + this.offset;
 },
 calculateInnerStart: function() {
  this.startPos = this.innerBoundStartPos + this.offset;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateCenter: function() {
  this.startPos = this.elementStartPos + Math.round((this.popupElementSize - this.size) / 2) + this.offset;
 },
 calculateInnerEnd: function() {
  this.startPos = this.innerBoundEndPos + this.offset;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateOutsideEnd: function() {
  this.isInverted = this.isPopupFullCorrectionOn && (!(this.boundEndPos + this.size < this.bodySize + this.scrollStartPos || !this.isMoreFreeSpaceLeft));
  if(this.isInverted)
   this.startPos = this.boundStartPos - this.offset;
  else
   this.startPos = this.boundEndPos + this.offset;
 },
 calculateNotSet: function() {
  if(this.rtl)
   this.calculateNotSetRightToLeft();
  else
   this.calculateNotSetLeftToRight();
 },
 calculateNotSetLeftToRight: function() {
  if(!ASPx.IsValidPosition(this.startPos)) {
   if(this.popupElement)
    this.startPos = this.elementStartPos;
   else if(this.offset)
    this.startPos = 0;
   else
    this.startPos = this.startPosInit;
  }
  this.isInverted = this.isPopupFullCorrectionOn && (this.startPos - this.scrollStartPos + this.size > this.bodySize && this.startPos - this.scrollStartPos > this.bodySize / 2);
  if(this.isInverted)
   this.startPos = this.startPos - this.size - this.offset;
  else
   this.startPos = this.startPos + this.offset;
 },
 calculateNotSetRightToLeft: function() {
  if(!ASPx.IsValidPosition(this.startPos)) {
   if(this.popupElement)
    this.startPos = this.innerBoundEndPos;
   else if(this.offset)
    this.startPos = 0;
   else
    this.startPos = this.startPosInit;
  }
  else
   this.startPos -= this.size;
  this.isInverted = this.isPopupFullCorrectionOn && (this.startPos < this.scrollStartPos && this.startPos - this.scrollStartPos < this.bodySize / 2);
  if(this.isInverted)
   this.startPos = this.startPos + this.size + this.offset;
  else
   this.startPos = this.startPos - this.offset;
 },
 calculateNearBoundStart: function() {
  this.startPos = this.boundStartPos + this.offset + this.size * this.nearBoundOverlapRate;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 calculateNearBoundEnd: function() {
  this.startPos = this.boundEndPos + this.offset - this.size * this.nearBoundOverlapRate;
  if(this.isPopupFullCorrectionOn)
   this.startPos = PopupUtils.AdjustPositionToClientScreen(this.element, this.startPos, this.rtl, this.isHorizontal);
 },
 getAlignValueFromIndicator: function(alignIndicator) {
  var alignValue = AlignIndicatorTable[alignIndicator];
  if(alignValue === undefined)
   throw "Incorrect align indicator.";
  return alignValue;
 },
 getElementSize: function() {
  return this.getCustomElementSize(this.element, false);
 },
 getPopupElementSize: function() {
  return this.getCustomElementSize(this.popupElement, this.ignorePopupElementBorders);
 },
 getCustomElementSize: function(customElement, ignoreBorders) {
  if(ignoreBorders) {
   return this.isHorizontal ? ASPx.GetClearClientWidth(customElement) : ASPx.GetClearClientHeight(customElement);
  }
  return this.isHorizontal ? ASPx.GetElementOffsetWidth(customElement) : ASPx.GetElementOffsetHeight(customElement);
 },
 getWindowInnerSize: function() {
  return this.isHorizontal ? window.innerWidth : window.innerHeight;
 }
});
var positionCalculator = null;
function getPositionCalculator() {
 if(positionCalculator == null)
  positionCalculator = new PositionCalculator();
 return positionCalculator;
}
function initializeAlignIndicatorTable() {
 AlignIndicatorTable[PopupUtils.NotSetAlignIndicator] = PositionAlignConsts.NOT_SET;
 AlignIndicatorTable[PopupUtils.OutsideLeftAlignIndicator] = PositionAlignConsts.OUTSIDE_START;
 AlignIndicatorTable[PopupUtils.AboveAlignIndicator] = PositionAlignConsts.OUTSIDE_START;
 AlignIndicatorTable[PopupUtils.LeftAlignIndicator] = PositionAlignConsts.NEAR_BOUND_START;
 AlignIndicatorTable[PopupUtils.TopAlignIndicator] = PositionAlignConsts.NEAR_BOUND_START;
 AlignIndicatorTable[PopupUtils.LeftSidesAlignIndicator] = PositionAlignConsts.INNER_START;
 AlignIndicatorTable[PopupUtils.TopSidesAlignIndicator] = PositionAlignConsts.INNER_START;
 AlignIndicatorTable[PopupUtils.CenterAlignIndicator] = PositionAlignConsts.CENTER;
 AlignIndicatorTable[PopupUtils.MiddleAlignIndicator] = PositionAlignConsts.CENTER;
 AlignIndicatorTable[PopupUtils.RightSidesAlignIndicator] = PositionAlignConsts.INNER_END;
 AlignIndicatorTable[PopupUtils.BottomSidesAlignIndicator] = PositionAlignConsts.INNER_END;
 AlignIndicatorTable[PopupUtils.RightAlignIndicator] = PositionAlignConsts.NEAR_BOUND_END;
 AlignIndicatorTable[PopupUtils.BottomAlignIndicator] = PositionAlignConsts.NEAR_BOUND_END;
 AlignIndicatorTable[PopupUtils.OutsideRightAlignIndicator] = PositionAlignConsts.OUTSIDE_END;
 AlignIndicatorTable[PopupUtils.BelowAlignIndicator] = PositionAlignConsts.OUTSIDE_END;
 AlignIndicatorTable[PopupUtils.WindowCenterAlignIndicator] = PositionAlignConsts.WINDOW_CENTER;
 AlignIndicatorTable[PopupUtils.WindowLeftAlignIndicator] = PositionAlignConsts.WINDOW_START;
 AlignIndicatorTable[PopupUtils.WindowTopAlignIndicator] = PositionAlignConsts.WINDOW_START;
 AlignIndicatorTable[PopupUtils.WindowRightAlignIndicator] = PositionAlignConsts.WINDOW_END;
 AlignIndicatorTable[PopupUtils.WindowBottomAlignIndicator] = PositionAlignConsts.WINDOW_END;
}
initializeAlignIndicatorTable();
ASPx.PopupPosition = function(position, isInverted) {
 this.position = position;
 this.isInverted = isInverted;
};
ASPx.PopupSize = function(width, height) {
 this.width = width;
 this.height = height;
};
ASPx.PopupUtils = PopupUtils;
ASPx.PositionCalculator = PositionCalculator;
})();
(function(){
 var ScrollingManager = ASPx.CreateClass(null, {
  constructor: function(owner, options) {
   this.owner = owner;
   this.scrollableArea = options.scrollableArea;
   this.orientation = options.orientation;
   this.animationDelay = 1;
   this.animationStep = 2;
   this.animationOffset = 5;
   this.animationAcceleration = 0;
   this.scrollSessionInterval = 10;
   this.stopScrolling = true;
   this.busy = false;
   this.currentAcceleration = 0;
   this.startPos = 0;
   this.onBeforeScrolling = options.onBeforeScrolling;
   this.onAfterScrolling = options.onAfterScrolling;
   this.emulationMode = options.forseEmulation === true || !ASPx.Browser.TouchUI;
   this.useMarginForPosition = options.useMarginForPosition;
   this.handleMouseWheel = !!options.handleMouseWheel;
   this.Initialize();
  },
  Initialize: function(){
   this.setParentNodeOverflow();
   if(this.emulationMode) {
    this.wrapper = new ScrollingManager.scrollWrapper(this.scrollableArea, this.useMarginForPosition);
   } else {
    this.wrapper = new ScrollingManager.scrollWrapperTouchUI(this.scrollableArea, function(direction){
     if(this.onAfterScrolling)
      this.onAfterScrolling(this, direction);
    }.aspxBind(this)); 
   }
   if(this.handleMouseWheel)
    ASPx.Evt.AttachEventToElement(this.scrollableArea, ASPx.Evt.GetMouseWheelEventName(), this.onMouseWheel.aspxBind(this));
  },
  onMouseWheel: function(e) {
   ASPx.Evt.PreventEvent(e);
   var delta = ASPx.Evt.GetWheelDelta(e);
   if(ASPx.Browser.Firefox)
    delta = delta / 0.03;
   this.DoScrollSessionToOffset(-delta);
  },
  setParentNodeOverflow: function() {
   if(ASPx.Browser.MSTouchUI){
    this.scrollableArea.parentNode.style.overflow = "auto";
    this.scrollableArea.parentNode.style["-ms-overflow-style"] = "-ms-autohiding-scrollbar";
   } 
  },
  GetScrolledAreaPosition: function() {
   return this.wrapper.GetScrollLeft() * this.orientation[0]
    + this.wrapper.GetScrollTop() * this.orientation[1];
  },
  SetScrolledAreaPosition: function(pos) {
   this.wrapper.SetScrollLeft(pos * this.orientation[0]);
   this.wrapper.SetScrollTop(pos * this.orientation[1]);
  },
  PrepareForScrollAnimation: function() {
   if(!this.scrollableArea)
    return;  
   this.currentAcceleration = 0;
   this.startPos = this.GetScrolledAreaPosition();
   this.busy = false;
  },
  GetAnimationStep: function(dir) {
   var step = dir * (this.animationStep + this.currentAcceleration);
   var newPos = this.GetScrolledAreaPosition() + step;
   var requiredPos = this.startPos + dir * this.animationOffset;
   if((dir == 1 && newPos >= requiredPos) || (dir == -1 && newPos <= requiredPos)) {
    step = requiredPos - this.GetScrolledAreaPosition();
   } 
   return step;
  },
  DoScrollSessionToOffset: function(offset) {
   var newScrollPos = this.GetScrolledAreaPosition() - offset;
   this.stopScrolling = false;
   if(this.onBeforeScrolling)
    this.onBeforeScrolling(this, offset);
   if(this.stopScrolling) return;
   this.SetScrolledAreaPosition(newScrollPos);
   if(this.onAfterScrolling)
    this.onAfterScrolling(this, offset); 
  },
  DoScrollSessionAnimation: function(direction) {
   if(!this.scrollableArea)
    return;
   this.SetScrolledAreaPosition(this.GetScrolledAreaPosition() + this.GetAnimationStep(direction));
   var self = this;
   if(!this.ShouldStopScrollSessionAnimation()) {
    this.busy = true;
    this.currentAcceleration += this.animationAcceleration;
    window.setTimeout(function() { self.DoScrollSessionAnimation(direction); }, this.animationDelay);
   } else {
    this.busy = false;
    if(this.onAfterScrolling)
     this.onAfterScrolling(this, -direction);   
    this.currentAcceleration = 0;
    window.setTimeout(function() { self.DoScroll(direction); }, this.scrollSessionInterval);
   }
  },
  ShouldStopScrollSessionAnimation: function() {
   return (Math.abs(this.GetScrolledAreaPosition() - this.startPos) >= Math.abs(this.animationOffset));
  },
  DoScroll: function(direction) {
   if(!this.scrollableArea)
    return; 
   if(!this.busy && !this.stopScrolling) {
    if(this.onBeforeScrolling)
     this.onBeforeScrolling(this, -direction);
    if(this.stopScrolling) return;
    this.PrepareForScrollAnimation();
    this.DoScrollSessionAnimation(direction);
   } 
  },
  StartScrolling: function(direction, delay, step) {
   this.stopScrolling = false;
   this.animationDelay = delay;
   this.animationStep = step;
   this.DoScroll(-direction);
  },
  StopScrolling: function() {
   this.stopScrolling = true;
  },
  IsStopped: function() {
   return this.stopScrolling;
  },
  IsInProgress: function() {
   return this.busy;
  }
 });
 var MouseScrollingManager = ASPx.CreateClass(ScrollingManager, {
  constructor: function(owner, options) {
   this.mouseEventsElement = options.mouseEventsElement;
   this.preventOuterScroll = options.preventOuterScroll;
   this.enableMouseScrollInternal = true;
   this.constructor.prototype.constructor.call(this, owner, options);
  },
  Initialize: function() {
   ASPx.ScrollingManager.prototype.Initialize.call(this);
   this.initializeMouseScroll();
  },
  initializeMouseScroll: function() {
   this.mouseDown = false;
   this.vx = 0;
   this.prevX = 0;
   this.scrollTime = null;
   this.mouseScrollAcceleration = 0.7;
   this.mouseScrollTimeStep = 30;
   ASPx.Evt.AttachEventToElement(this.mouseEventsElement, ASPx.TouchUIHelper.touchMouseDownEventName, this.startMouseScroll.aspxBind(this));
  },
  scrollToOffset: function(mouseOffset) {
   var newOffset = this.GetScrolledAreaPosition() - mouseOffset;
   if(this.getValidNewScrollOffset)
    newOffset = this.getValidNewScrollOffset(newOffset);
   this.SetScrolledAreaPosition(newOffset);
  },
  preventTextSelectionAndOuterDivScrollOnScroll: function(e) {
   if(this.preventOuterScroll)
    ASPx.Evt.PreventEvent(e);
   ASPx.Selection.Clear();
  },
  mouseScroll: function(e) {
   if(!this.mouseDown) return;
   this.preventTextSelectionAndOuterDivScrollOnScroll(e);
   var x = ASPx.Evt.GetEventX(e),
    dx = this.prevX - x,
    dt = new Date() - this.scrollTime;
   if(dt < 1) dt = 1;
   this.vx = dx / dt;
   this.scrollToOffset(dx);
   this.prevX = x;
   this.scrollTime = new Date();
  },
  startMouseScroll: function(e) {
   if(!this.enableMouseScrollInternal) return;
   this.detachMouseEvents();
   this.mouseMoveHandler = this.mouseScroll.aspxBind(this);
   this.mouseUpHandler = this.stopMouseScroll.aspxBind(this);
   ASPx.Evt.AttachEventToElement(document, ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
   this.mouseDown = true;
   window.clearTimeout(this.inertialStopTimerId);
   this.prevX = ASPx.Evt.GetEventX(e);
   this.scrollTime = new Date();
  },
  detachMouseEvents: function() {
   ASPx.Evt.DetachEventFromElement(document, ASPx.TouchUIHelper.touchMouseMoveEventName, this.mouseMoveHandler);
   ASPx.Evt.DetachEventFromDocument(ASPx.TouchUIHelper.touchMouseUpEventName, this.mouseUpHandler);
  },
  stopMouseScroll: function() {
   this.detachMouseEvents();
   this.mouseDown = false;
   this.inertialStopTimerId = window.setTimeout(function() {
    this.vx *= this.mouseScrollAcceleration;
    if(Math.abs(this.vx) < 0.1) {
     this.vx = 0;
     if(this.onAfterScrolling)
      this.onAfterScrolling(this);
     return;
    }
    var dx = Math.ceil(this.vx * this.mouseScrollTimeStep);
    this.scrollToOffset(dx);
    this.stopMouseScroll();
   }.aspxBind(this), this.mouseScrollTimeStep);
  }
 });
 ScrollingManager.scrollWrapper = function(scrollableArea, useMarginForPosition) {
  this.scrollableArea = scrollableArea;
  this.useMarginForPosition = useMarginForPosition;
  this.Initialize();
 };
 ScrollingManager.scrollWrapper.prototype = {
  Initialize: function() {
   if(this.useMarginForPosition) {
    this.leftScrollProperty = "margin-left";
    this.topScrollProperty = "margin-top";
   } else {
    this.scrollableArea.style.position = "relative";
    this.scrollableArea.parentNode.style.position = "relative";
    this.leftScrollProperty = "left";
    this.topScrollProperty = "top";
   }
  },
  GetScrollLeft: function() { return ASPx.PxToFloat(this.scrollableArea.style[this.leftScrollProperty]); },
  GetScrollTop: function() { return ASPx.PxToFloat(this.scrollableArea.style[this.topScrollProperty]); },
  SetScrollLeft: function(value) {
   this.scrollableArea.style[this.leftScrollProperty] = value + "px";
  },
  SetScrollTop: function(value) {
   this.scrollableArea.style[this.topScrollProperty] = value + "px";
  }
 };
 ScrollingManager.scrollWrapperTouchUI = function(scrollableArea, onScroll){
  this.scrollableArea = scrollableArea;
  this.scrollTimerId = -1;
  this.onScroll = onScroll;
  this.Initialize(onScroll);
 };
 ScrollingManager.scrollWrapperTouchUI.prototype = {
  Initialize: function(){
   var div = this.scrollableArea.parentNode;
   var timeout = ASPx.Browser.MSTouchUI ? 500 : 1000;
   var nativeScrollSupported = ASPx.TouchUIHelper.nativeScrollingSupported();
   this.onScrollCore = function(){
     ASPx.Timer.ClearTimer(this.scrollTimerId);
     if(this.onScrollLocked) return;
     this.scrollTimerId = window.setTimeout(this.onScrollByTimer, timeout);
    }.aspxBind(this);
   this.onScrollByTimer = function(){
     if(this.onScrollLocked) return;
     var direction = this.lastScrollTop < div.scrollTop ? 1 : -1;
     this.lastScrollTop = div.scrollTop;
     this.onScrollLocked = true;
     this.onScroll(direction);
     this.onScrollLocked = false;
    }.aspxBind(this);
   this.lastScrollTop = div.scrollTop;
   var onscroll = nativeScrollSupported ? this.onScrollCore : this.onScrollByTimer;
   ASPx.Evt.AttachEventToElement(div, "scroll", onscroll);
   if(ASPx.Browser.WebKitTouchUI)
    this.scrollExtender = ASPx.TouchUIHelper.MakeScrollable(div, {showHorizontalScrollbar: false});
  },
  GetScrollLeft: function(){ return -this.scrollableArea.parentNode.scrollLeft; },
  GetScrollTop:  function(){ return -this.scrollableArea.parentNode.scrollTop; },
  SetScrollLeft: function(value){ 
   this.onScrollLocked = true;
   this.scrollableArea.parentNode.scrollLeft = -value; 
   this.onScrollLocked = false;
  },
  SetScrollTop:  function(value){ 
   this.onScrollLocked = true;
   this.scrollableArea.parentNode.scrollTop  = -value; 
   this.onScrollLocked = false;
  }
 };
 ASPx.ScrollingManager = ScrollingManager;
 ASPx.MouseScrollingManager = MouseScrollingManager;
})();
(function() {
var Constants = {
 MIIdSuffix: "_DXI",
 MMIdSuffix: "_DXM",
 SBIdSuffix: "_DXSB",
 SBUIdEnd: "_U",
 SBDIdEnd: "_D",
 ATSIdSuffix: "_ATS",
 SampleCssClassNameForImageElement: "SAMPLE_CSS_CLASS",
 ImagePostfix: "Img",
 PopupImagePostfix: "PImg"
};
var SLIDE_DURATION_VALUE = 300;
var SIDE_MENU_ZINDEX_VALUE = 10000;
var MENU_PREFIX_CLASS_NAME = 'dxm';
var SLIDE_PANEL_EXPANDED_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-expanded';
var BREAD_CRUMBS_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-bread-crumbs';
var OVERLAY_PANEL_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-overlay';
var BURGER_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-side-menu-button';
var BACK_ICON_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-back-icon';
var NO_MAIN_POP_OUT_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-no-main-popout';
var TEMPORARY_VISIBILITY_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-temp-visibility';
var SIDE_MENU_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-side-menu-mode';
var PRE_HOVERED_ELEMENT_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-pre-hovered';
var PRE_SELECTED_ELEMENT_CLASS_NAME = MENU_PREFIX_CLASS_NAME + '-pre-selected';
var MenuItemInfo = ASPx.CreateClass(null, {
 constructor: function(menu, indexPath) {
  var itemElement = menu.GetItemElement(indexPath);
  this.clientHeight = itemElement.clientHeight;
  this.clientWidth = itemElement.clientWidth;
  this.clientTop = ASPx.GetClientTop(itemElement);
  this.clientLeft = ASPx.GetClientLeft(itemElement);
  this.offsetHeight = itemElement.offsetHeight;
  this.offsetWidth = itemElement.offsetWidth;
  this.offsetTop = 0;
  this.offsetLeft = 0;
 }
});
var MenuCssClasses = {};
MenuCssClasses.Prefix = "dxm-";
MenuCssClasses.Menu = "dxmLite";
MenuCssClasses.BorderCorrector = "dxmBrdCor";
MenuCssClasses.Disabled = MenuCssClasses.Prefix + "disabled";
MenuCssClasses.MainMenu = MenuCssClasses.Prefix + "main";
MenuCssClasses.PopupMenu = MenuCssClasses.Prefix + "popup";
MenuCssClasses.ItemTemplate = MenuCssClasses.Prefix + "tmpl";
MenuCssClasses.HorizontalMenu = MenuCssClasses.Prefix + "horizontal";
MenuCssClasses.VerticalMenu = MenuCssClasses.Prefix + "vertical";
MenuCssClasses.NoWrapMenu = MenuCssClasses.Prefix + "noWrap";
MenuCssClasses.AutoWidthMenu = MenuCssClasses.Prefix + "autoWidth";
MenuCssClasses.CalculateMenu = MenuCssClasses.Prefix + "calc";
MenuCssClasses.DX = "dx";
MenuCssClasses.Separator = MenuCssClasses.Prefix + "separator";
MenuCssClasses.Spacing = MenuCssClasses.Prefix + "spacing";
MenuCssClasses.AlignSpacing = MenuCssClasses.Prefix + "alignSpacing";
MenuCssClasses.Gutter = MenuCssClasses.Prefix + "gutter";
MenuCssClasses.WithoutImages = MenuCssClasses.Prefix + "noImages";
MenuCssClasses.Item = MenuCssClasses.Prefix + "item";
MenuCssClasses.ItemHovered = MenuCssClasses.Prefix + "hovered";
MenuCssClasses.ItemSelected = MenuCssClasses.Prefix + "selected";
MenuCssClasses.ItemChecked = MenuCssClasses.Prefix + "checked";
MenuCssClasses.ItemWithoutImage = MenuCssClasses.Prefix + "noImage";
MenuCssClasses.ItemWithSubMenu = MenuCssClasses.Prefix + "subMenu";
MenuCssClasses.ItemDropDownMode = MenuCssClasses.Prefix + "dropDownMode";
MenuCssClasses.ItemWithoutSubMenu = MenuCssClasses.Prefix + "noSubMenu"; 
MenuCssClasses.AdaptiveMenuItem = MenuCssClasses.Prefix + "ami";
MenuCssClasses.AdaptiveMenuItemSpacing = MenuCssClasses.Prefix + "amis";
MenuCssClasses.AdaptiveMenu = MenuCssClasses.Prefix + "am";
MenuCssClasses.AdaptiveMenuHiddenElement = MenuCssClasses.Prefix + "amhe";
MenuCssClasses.ContentContainer = MenuCssClasses.Prefix + "content";
MenuCssClasses.Image = MenuCssClasses.Prefix + "image";
MenuCssClasses.PopOutContainer = MenuCssClasses.Prefix + "popOut";
MenuCssClasses.PopOutImage = MenuCssClasses.Prefix + "pImage";
MenuCssClasses.ImageLeft = MenuCssClasses.Prefix + "image-l";
MenuCssClasses.ImageRight = MenuCssClasses.Prefix + "image-r";
MenuCssClasses.ImageTop = MenuCssClasses.Prefix + "image-t";
MenuCssClasses.ImageBottom = MenuCssClasses.Prefix + "image-b";
MenuCssClasses.ScrollArea = MenuCssClasses.Prefix + "scrollArea";
MenuCssClasses.ScrollUpButton = MenuCssClasses.Prefix + "scrollUpBtn";
MenuCssClasses.ScrollDownButton = MenuCssClasses.Prefix + "scrollDownBtn";
MenuCssClasses.ItemClearElement = MenuCssClasses.DX + "-clear";
MenuCssClasses.ItemTextElement = MenuCssClasses.DX + "-vam";
MenuCssClasses.SmallImage = MenuCssClasses.DX + "-small-image";
var MenuRenderHelper = ASPx.CreateClass(null, {
 constructor: function(menu) {
  this.menu = menu;
  this.itemLinkMode = "ContentBounds";
  this.elementsToHide = [];
 },
 InlineInitializeElements: function() {
  if(!this.menu.isPopupMenu)
   this.InlineInitializeMainMenuElements(this.menu.GetMainElement());
  else
   this.InlineInitializePopupMenuElements(this.menu.GetMainElement());
  var popupMenuElements = this.GetPopupMenuElements(this.menu.GetMainElement());
  for(var i = 0; i < popupMenuElements.length; i++) {
   if(popupMenuElements[i] == this.menu.GetMainElement()) continue;
   this.InlineInitializePopupMenuElements(popupMenuElements[i]);
  }
 },
 InlineInitializeScrollElements: function(indexPath, menuElement) {
  var scrollArea = ASPx.GetNodeByClassName(menuElement, MenuCssClasses.ScrollArea);
  if(scrollArea) scrollArea.id = this.menu.GetScrollAreaId(indexPath);
  this.InitializeScrollButton(menuElement, MenuCssClasses.ScrollUpButton, this.menu.GetScrollUpButtonId(indexPath));
  this.InitializeScrollButton(menuElement, MenuCssClasses.ScrollDownButton, this.menu.GetScrollDownButtonId(indexPath));
 },
 InitializeScrollButton: function(menuElement, buttonClassName, id) {
  var scrollButton = ASPx.GetNodeByClassName(menuElement, buttonClassName);
  if(!scrollButton) return;
  scrollButton.id = id;
  if(this.menu.NeedCreateItemsOnClientSide()) {
   ASPx.GetStateController().AddHoverItem(id, ["dxm-scrollBtnHovered"], [""]);
   ASPx.GetStateController().AddPressedItem(id, ["dxm-scrollBtnPressed"], [""]);
  }
 },
 InlineInitializeMainMenuElements: function(menuElement) {
  this.menu.CheckElementsCache(menuElement);
  var contentElement = this.GetContentElement(menuElement);
  if(contentElement.className.indexOf("dxm-ti") > 1)
   this.itemLinkMode = "TextAndImage";
  else if(contentElement.className.indexOf("dxm-t") > -1)
   this.itemLinkMode = "TextOnly";
  var itemElements = this.GetItemElements(menuElement);
  for(var i = 0; i < itemElements.length; i++)
   this.InlineInitializeItemElement(itemElements[i], "", i);
  this.InlineInitializeScrollElements("", menuElement);
 },
 InlineInitializePopupMenuElements: function(parentElement) {
  parentElement.style.position = "absolute";
  var indexPath = this.GetSubMenuIndexPathByMenuParentElement(parentElement);
  var borderCorrectorElement = ASPx.GetNodeByClassName(parentElement, MenuCssClasses.BorderCorrector);
  if(borderCorrectorElement != null) {
   borderCorrectorElement.id = this.menu.GetMenuBorderCorrectorElementId(indexPath);
   borderCorrectorElement.style.position = "absolute";
   parentElement.removeChild(borderCorrectorElement);
   parentElement.parentNode.appendChild(borderCorrectorElement);
  }
  this.InlineInitializePopupMenuMenuElement(parentElement, indexPath);
 },
 GetSubMenuIndexPathByMenuParentElement: function(element){
  return this.menu.GetMenuIndexPathById(element.id);
 },
 InlineInitializePopupMenuMenuElement: function(parentElement, indexPath) {
  var menuElement = ASPx.GetNodeByClassName(parentElement, MenuCssClasses.PopupMenu);
  menuElement.id = this.menu.GetMenuMainElementId(indexPath);
  this.InlineInitializePopupMenuContentElements(parentElement, menuElement, indexPath);
 },
 InlineInitializePopupMenuContentElements: function(parentElement, menuElement, indexPath) {
  this.menu.CheckElementsCache(menuElement);
  var contentElement = this.GetContentElement(menuElement);
  if(contentElement != null) {
   var itemElements = this.GetItemElements(menuElement);
   var parentIndexPath = parentElement == this.menu.GetMainElement() ? "" : indexPath;
   for(var i = 0; i < itemElements.length; i++) {
    var itemElementId = itemElements[i].id;
    if(itemElementId && aspxGetMenuCollection().GetMenu(itemElementId) != this.menu)
     continue;
    this.InlineInitializeItemElement(itemElements[i], parentIndexPath, i);
   }
  }
  this.InlineInitializeScrollElements(indexPath, menuElement);
 },
 HasSubMenuTemplate: function(menuElement) {
  var contentElement = this.GetContentElement(menuElement);
  return contentElement && (contentElement.tagName != "UL" || !ASPx.GetNodesByPartialClassName(contentElement, MenuCssClasses.ContentContainer).length);
 },
 InlineInitializeItemElement: function(itemElement, parentIndexPath, visibleIndex) {
  function getItemIndex(visibleIndex) {
   var itemData = parentItemData[Math.max(visibleIndex, 0)];
   return itemData.constructor == Array
    ? itemData[0]
    : itemData;
  }
  var parentItemData = this.menu.renderData[parentIndexPath],
   prepareItemOnClick = parentItemData[visibleIndex].constructor == Array,
   indexPathPrefix = parentIndexPath + (parentIndexPath != "" ? ASPx.ItemIndexSeparator : ""),
   indexPath = indexPathPrefix + getItemIndex(visibleIndex);
  itemElement.id = this.menu.GetItemElementId(indexPath);
  if(this.canAssignAccessibilityEventsToChildrenLinks())
   ASPx.AssignAccessibilityEventsToChildrenLinks(itemElement, true);
  if(this.canContainSeparators()) {
   var separatorElement = itemElement.previousSibling;
   if(separatorElement && separatorElement.className) {
    if(ASPx.ElementContainsCssClass(separatorElement, MenuCssClasses.Spacing))
     separatorElement.id = this.menu.GetItemIndentElementId(indexPath);
    else if(ASPx.ElementContainsCssClass(separatorElement, MenuCssClasses.Separator))
     separatorElement.id = this.menu.GetItemSeparatorElementId(indexPath);
   }
  }
  var contentElement = this.GetItemContentElement(itemElement);
  if(contentElement != null) {
   contentElement.id = this.menu.GetItemContentElementId(indexPath);
   if (this.canContainImageElement()) {
    var imageElement = ASPx.GetNodeByClassName(contentElement, MenuCssClasses.Image);
    if(imageElement == null) {
     var hyperLinkElement = ASPx.GetNodeByClassName(contentElement, MenuCssClasses.DX);
     if(hyperLinkElement != null)
      imageElement = ASPx.GetNodeByClassName(hyperLinkElement, MenuCssClasses.Image);
    }
    if(imageElement != null)
     imageElement.id = this.menu.GetItemImageId(indexPath);
   }
  }
  else
   prepareItemOnClick = false;
  this.InlineInitializeItemPopOutElement(itemElement, indexPath);
  if(prepareItemOnClick)
   this.InlineInitializeItemOnClick(itemElement, indexPath);
  if(ASPx.ElementContainsCssClass(itemElement, MenuCssClasses.ItemSelected)) 
   this.menu.serverSideSelectedItemPath = indexPath;
 },
 canAssignAccessibilityEventsToChildrenLinks: function () { return true; },
 canContainSeparators: function () { return true; },
 canContainImageElement: function () { return true; },
 InlineInitializeItemPopOutElement: function(itemElement, indexPath) {
  var popOutElement = this.GetItemPopOutElement(itemElement);
  if(popOutElement != null) {
   popOutElement.id = this.menu.GetItemPopOutElementId(indexPath);
   var popOutImageElement = ASPx.GetNodeByClassName(popOutElement, MenuCssClasses.PopOutImage);
   if(popOutImageElement != null)
    popOutImageElement.id = this.menu.GetItemPopOutImageId(indexPath);
  }
 },
 InlineInitializeItemOnClick: function(itemElement, indexPath) {
  var name = this.menu.name;
  var onclick = this.GetItemOnClick(name, itemElement, indexPath);
  if(this.menu.IsDropDownItem(indexPath)) {
   var contentElement = this.menu.GetItemContentElement(indexPath);
   var dropDownElement = this.menu.GetItemPopOutElement(indexPath);
   var dropDownOnclick = this.GetItemDropdownOnClick(name, itemElement, indexPath);
   this.AssignItemOnClickToElement(contentElement, this.itemLinkMode, onclick);
   this.AssignItemOnClickToElement(dropDownElement, this.itemLinkMode, dropDownOnclick);
  }
  else
   this.AssignItemOnClickToElement(itemElement, this.itemLinkMode, onclick);
 },
 AssignItemOnClickToElement: function(element, itemLinkMode, method) {
  switch(itemLinkMode){
   case "ContentBounds":
    this.AssignItemOnClickToElementCore(element, method);
    break;
   case "TextOnly":
    var textElement = ASPx.GetNodeByTagName(element, "A");
    if(!textElement)
     textElement = ASPx.GetNodeByTagName(element, "SPAN");
    if(textElement)
     this.AssignItemOnClickToElementCore(textElement, method);
    break;
   case "TextAndImage":
    var linkElement = ASPx.GetNodeByTagName(element, "A");
    if(linkElement)
     this.AssignItemOnClickToElementCore(linkElement, method);
    else{
     var textElement = ASPx.GetNodeByTagName(element, "SPAN");
     if(textElement)
      this.AssignItemOnClickToElementCore(textElement, method);
     var imageElement = ASPx.GetNodeByTagName(element, "IMG");
     if(imageElement)
      this.AssignItemOnClickToElementCore(imageElement, method);
    }
    break;
  }
 },
 AssignItemOnClickToElementCore: function(element, method) {
  ASPx.Evt.AttachEventToElement(element, "click", method);
 },
 GetItemOnClick: function(name, itemElement, indexPath) { 
  var menu = this.menu;
  var sendPostBackHandler = function() {
   menu.SendPostBack("CLICK:" + indexPath);
  };
  var itemClickHandler = function(e) {
   ASPx.MIClick(e, name, indexPath);
  };
  var itemLink = this.GetItemLinkElement(itemElement);
  var handler = menu.autoPostBack && !menu.IsClientSideEventsAssigned() && (!itemLink || itemLink.href === "")
   ? sendPostBackHandler
   : itemClickHandler;
  return function(e) {
   if(!itemElement.clientDisabled)
    handler(e);
  };
 },
 GetItemDropdownOnClick: function(name, itemElement, indexPath) {
  return function(e) {
   if(!itemElement.clientDisabled)
    ASPx.MIDDClick(e, name, indexPath);
  };
 },
 ChangeItemEnabledAttributes: function(itemElement, enabled, accessibilityCompliant) {
  if(!itemElement) return;
  itemElement.clientDisabled = !enabled;
  ASPx.Attr.ChangeStyleAttributesMethod(enabled)(itemElement, "cursor");
  var hyperLink = this.GetItemLinkElement(itemElement);
  if(hyperLink)
   this.ChangeItemLinkEnabledAttributes(hyperLink, itemElement, enabled, accessibilityCompliant);
 },
 ChangeItemLinkEnabledAttributes: function(hyperLink, itemElement, enabled, accessibilityCompliant) {
  if(accessibilityCompliant) {
   var action = enabled ? ASPx.Attr.RemoveAttribute : ASPx.Attr.SetAttribute;
   action(hyperLink, "aria-disabled", "true");
  }
  ASPx.Attr.ChangeAttributesMethod(enabled)(hyperLink, "href");
  if(accessibilityCompliant && !enabled && itemElement.enabled)
   hyperLink.href = ASPx.AccessibilityEmptyUrl;
 },
 GetPopupMenuElements: function(menuElement) {
  return ASPx.GetChildNodesByTagName(menuElement.parentNode, "DIV");
 },
 GetContentElement: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "contentElement", 
   function() {
    var contentElement = ASPx.GetNodeByTagName(menuElement, "DIV", 0);
    if(contentElement && contentElement.className == MenuCssClasses.DX && contentElement.parentNode == menuElement) 
     return contentElement;
    contentElement = ASPx.GetNodeByTagName(menuElement, "UL", 0);
    if(contentElement)
     return contentElement;
    return ASPx.GetNodeByTagName(menuElement, "TABLE", 0); 
   }, menuElement);
 },
 GetItemElements: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElements(this, "itemElements", 
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodesByClassName(contentElement, MenuCssClasses.Item) : null;
   }, menuElement);
 },
 GetSpacingElements: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElements(this, "spacingElements", 
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodesByClassName(contentElement, MenuCssClasses.Spacing) : null;
   }, menuElement);
 },
 GetAlignSpacingElements: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElements(this, "alignSpacingElements",
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodesByClassName(contentElement, MenuCssClasses.AlignSpacing) : null;
   }, menuElement);
 },
 GetSeparatorElements: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElements(this, "separatorElements", 
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodesByClassName(contentElement, MenuCssClasses.Separator) : null;
   }, menuElement);
 },
 GetItemContentElement: function(itemElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "contentElement", 
   function() {
    return ASPx.GetNodeByClassName(itemElement, MenuCssClasses.ContentContainer);
   }, itemElement);
 },
 GetItemPopOutElement: function(itemElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "popOutElement", 
   function() {
    return ASPx.GetNodeByClassName(itemElement, MenuCssClasses.PopOutContainer);
   }, itemElement);
 },
 GetAdaptiveMenuItemElement: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "adaptiveMenuItemElement", 
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodeByClassName(contentElement, this.menu.getAdaptiveMenuItemCssClass()) : null;
   }, menuElement);
 },
 GetAdaptiveMenuItemSpacingElement: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "adaptiveMenuItemSpacingElement", 
   function() {
    var contentElement = this.GetContentElement(menuElement);
    return contentElement ? ASPx.GetNodeByClassName(contentElement, this.menu.getAdaptiveMenuItemSpacingCssClass()) : null;
   }, menuElement);
 },
 GetAdaptiveMenuElement: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "adaptiveMenuElement", 
   function() {
    var adaptiveItemElement = this.GetAdaptiveMenuItemElement(menuElement);
    if(adaptiveItemElement){
     var adaptiveItemIndexPath = this.menu.GetIndexPathById(adaptiveItemElement.id);
     var adaptiveMenuParentElement = this.menu.GetMenuElement(adaptiveItemIndexPath);
     if(adaptiveMenuParentElement) 
      return this.menu.GetMenuMainElement(adaptiveMenuParentElement);
    }
    return null;
   }, menuElement);
 },
 GetAdaptiveMenuContentElement: function(menuElement) {
  return ASPx.CacheHelper.GetCachedElement(this, "adaptiveMenuContentElement", 
   function() {
    var adaptiveMenuElement = this.GetAdaptiveMenuElement(menuElement);
    return adaptiveMenuElement ? this.GetContentElement(adaptiveMenuElement) : null;
   }, menuElement);
 },
 GetItemLinkElement: function(itemElement) {
  return ASPx.GetNodeByTagName(itemElement, "A", 0);
 },
 CalculateMenuControl: function(menuElement, recalculate) {
  if(menuElement.offsetWidth === 0) return;
  this.PrecalculateMenuPopOuts(menuElement);
  var isVertical = this.menu.IsVertical("");
  var isAutoWidth = ASPx.ElementContainsCssClass(menuElement, MenuCssClasses.AutoWidthMenu);
  var isNoWrap = ASPx.ElementContainsCssClass(menuElement, MenuCssClasses.NoWrapMenu);
  var contentElement = this.GetContentElement(menuElement);
  if(this.menu.enableAdaptivity) 
   this.CalculateAdaptiveMainMenu(menuElement, contentElement, isVertical, isAutoWidth, isNoWrap, recalculate);
  else
   this.CalculateMainMenu(menuElement, contentElement, isVertical, isAutoWidth, isNoWrap, recalculate);
 },
 CalculateMainMenu: function(menuElement, contentElement, isVertical, isAutoWidth, isNoWrap, recalculate) {
  var itemElements = this.GetItemElements(menuElement);
  this.PrecalculateMenuItems(menuElement, itemElements, recalculate);
  this.CalculateMenuItemsAutoWidth(menuElement, itemElements, isVertical, isAutoWidth);
  this.CalculateMinSize(menuElement, contentElement, itemElements, isVertical, isAutoWidth, isNoWrap, recalculate);
  this.CalculateMenuItems(menuElement, contentElement, itemElements, isVertical, recalculate);
  this.CalculateSeparatorsAndSpacers(menuElement, itemElements, contentElement, isVertical);
 },
 PrecalculateMenuPopOuts: function(menuElement) {
  if(menuElement.popOutsPreCalculated) return;
  var elements = this.GetItemElements(menuElement);
  for(var i = 0; i < elements.length; i++) {
   var popOutElement = this.GetItemPopOutElement(elements[i]);
   if (popOutElement)
    popOutElement.style.display = "block";
  }
  menuElement.popOutsPreCalculated = true;
 },
 PrecalculateMenuItems: function(menuElement, itemElements, recalculate) {
  if(!recalculate) return;
  for(var i = 0; i < itemElements.length; i++) {
   var itemContentElement = this.GetItemContentElement(itemElements[i]);
   if(!itemContentElement || itemContentElement.offsetWidth === 0) continue;
   ASPx.SetElementFloat(itemContentElement, "");
   ASPx.Attr.RestoreStyleAttribute(itemContentElement, "padding-left");
   ASPx.Attr.RestoreStyleAttribute(itemContentElement, "padding-right");
     this.ReCalculateMenuItemContent(itemElements[i], itemContentElement);
  }
 },
 ReCalculateMenuItemContent: function(itemElement, itemContentElement) {
  for(var j = 0; j < itemElement.childNodes.length; j++) {
   var child = itemElement.childNodes[j];
   if(!child.offsetWidth) continue;
   if(child !== itemContentElement) {
    if(ASPx.Browser.IE && ASPx.Browser.Version == 8)
     ASPx.Attr.RestoreStyleAttribute(child, "margin");
    else{
     ASPx.Attr.RestoreStyleAttribute(child, "margin-top");
     ASPx.Attr.RestoreStyleAttribute(child, "margin-bottom");
    }
   }
  }
 },
 CalculateMenuItemsAutoWidth: function(menuElement, itemElements, isVertical, isAutoWidth) {
  if(!isAutoWidth) return;
  for(var i = 0; i < itemElements.length; i++) 
   ASPx.Attr.RestoreStyleAttribute(itemElements[i], "width");
  if(!isVertical) {
   var autoWidthItemCount = 0;
   var adaptiveItemCssClass = this.menu.getAdaptiveMenuItemCssClass();
   for(var i = 0; i < itemElements.length; i++) {
    if(ASPx.GetElementDisplay(itemElements[i]) && !ASPx.ElementHasCssClass(itemElements[i], adaptiveItemCssClass))
     autoWidthItemCount++;
   }
   for(var i = 0; i < itemElements.length; i++) {
    if(autoWidthItemCount > 0 && !ASPx.ElementHasCssClass(itemElements[i], adaptiveItemCssClass) && (itemElements[i].style.width === "" || itemElements[i].autoWidth)) {
     ASPx.Attr.ChangeStyleAttribute(itemElements[i], "width", (100 / autoWidthItemCount) + "%");
     itemElements[i].autoWidth = true;
    }
   }
  }
 },
 CalculateMenuItems: function(menuElement, contentElement, itemElements, isVertical, recalculate) {
  if(contentElement.itemsCalculated && recalculate)
   contentElement.itemsCalculated = false;
  if(menuElement.offsetWidth === 0) return;
  if(contentElement.style.margin === "0px auto")
   ASPx.SetStyles(contentElement, { float: "none" }); 
  var menuWidth = ASPx.GetCurrentStyle(menuElement).width;
  var menuRequireItemCorrection = isVertical && menuWidth;
  this.ApplyItemsVerticalAlignment(menuElement, itemElements);
  for(var i = 0; i < itemElements.length; i++) {
   if(!itemElements[i].style.width && !menuRequireItemCorrection) continue;
   if(ASPx.IsPercentageSize(itemElements[i].style.width) && contentElement.style.width === "")
    contentElement.style.width = "100%"; 
   var itemContentElement = this.GetItemContentElement(itemElements[i]);
   if(!itemContentElement || itemContentElement.offsetWidth === 0) continue;
   if(!contentElement.itemsCalculated) {
    ASPx.Attr.RestoreStyleAttribute(itemContentElement, "padding-left");
    ASPx.Attr.RestoreStyleAttribute(itemContentElement, "padding-right");
    ASPx.SetElementFloat(itemContentElement, "none");
    var itemContentCurrentStyle = ASPx.GetCurrentStyle(itemContentElement);
    if(!isVertical || (itemContentCurrentStyle.textAlign != "center" && menuWidth)) {
     var originalPaddingLeft = parseInt(itemContentCurrentStyle.paddingLeft);
     var originalPaddingRight = parseInt(itemContentCurrentStyle.paddingRight);
     var leftChildrenWidth = 0, rightChildrenWidth = 0;
     for(var j = 0; j < itemElements[i].childNodes.length; j++) {
      var child = itemElements[i].childNodes[j];
      if(!child.offsetWidth) continue;
      if(child !== itemContentElement) {
       if(ASPx.GetElementFloat(child) === "right")
        rightChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
       else if(ASPx.GetElementFloat(child) === "left")
        leftChildrenWidth += child.offsetWidth + ASPx.GetLeftRightMargins(child);
      }
     }
     if(leftChildrenWidth > 0 || rightChildrenWidth > 0){
      ASPx.Attr.ChangeStyleAttribute(itemContentElement, "padding-left", (leftChildrenWidth + originalPaddingLeft) + "px");
      ASPx.Attr.ChangeStyleAttribute(itemContentElement, "padding-right", (rightChildrenWidth + originalPaddingRight) + "px");
     }
    }
   }
   ASPx.AdjustWrappedTextInContainer(itemContentElement);
   this.CalculateMenuItemContent(itemElements[i], itemContentElement);
  }
  contentElement.itemsCalculated = true;
 },
 ApplyItemsVerticalAlignment: function(menuElement, itemElements) {
  var menuAlignmentInProgressClassName = "miva";
  ASPx.AddClassNameToElement(menuElement, menuAlignmentInProgressClassName);
  if(!ASPx.IsExists(itemElements))
   itemElements = this.GetItemElements(menuElement);
  for(var i = 0; i < itemElements.length; i++) {
   var itemContentElement = this.GetItemContentElement(itemElements[i]);
   if(itemContentElement && itemContentElement.offsetWidth !== 0 && itemContentElement.style.verticalAlign)
    this.CalculateItemContentLineHeight(itemElements[i], itemContentElement);
  }
  ASPx.RemoveClassNameFromElement(menuElement, menuAlignmentInProgressClassName);
 },
 CalculateItemContentLineHeight: function(itemElement, itemContentElement) {
  var lineHeight = 0;
  var maxHeight = itemElement.getBoundingClientRect().height - this.GetBordersAndPaddingSummaryHeight(itemElement);
  if(itemContentElement && itemContentElement.offsetHeight != maxHeight)
   lineHeight = maxHeight - this.GetBordersAndPaddingSummaryHeight(itemContentElement);
  if(lineHeight > 0) {
   var link = this.GetItemLinkElement(itemElement);
   if(link)
    ASPx.SetStyles(link, { lineHeight: lineHeight }, false);
   else
    ASPx.SetStyles(itemContentElement, { lineHeight: lineHeight }, false);
  }
 },
 GetBordersAndPaddingSummaryHeight: function(element) {
  var elementStyle = getComputedStyle(element);
  return ASPx.GetVerticalBordersWidth(element, elementStyle) + ASPx.PxToFloat(elementStyle.paddingTop) + ASPx.PxToFloat(elementStyle.paddingBottom);
 },
 CalculateMenuItemContent: function(itemElement, itemContentElement) {
  var itemContentFound = false;
  for(var j = 0; j < itemElement.childNodes.length; j++) {
   var child = itemElement.childNodes[j];
   if(!child.offsetWidth) continue;
   var contentHeight = itemContentElement.offsetHeight;
   if(child !== itemContentElement) {
    if(itemContentFound){
     if(ASPx.Browser.IE && ASPx.Browser.Version == 8)
      ASPx.Attr.ChangeStyleAttribute(child, "margin", "-" + contentHeight + "px 0 0");
     else
      ASPx.Attr.ChangeStyleAttribute(child, "margin-top", "-" + contentHeight + "px");
    }
    else{
     if(ASPx.Browser.IE && ASPx.Browser.Version == 8)
      ASPx.Attr.ChangeStyleAttribute(child, "margin", "0 0 -" + contentHeight + "px");
     else
      ASPx.Attr.ChangeStyleAttribute(child, "margin-bottom", "-" + contentHeight + "px");
    }
   }
   else
    itemContentFound = true;
  }
 },
 CalculateSubMenu: function(parentElement, recalculate) {
  var menuElement = this.menu.GetMenuMainElement(parentElement);
  var contentElement = this.GetContentElement(menuElement);
  if(!parentElement.isSubMenuCalculated || recalculate) {
   menuElement.style.width = "";
   menuElement.style.display = "table";
   menuElement.style.borderSpacing = "0px";
   parentElement.isSubMenuCalculated = true;
   if(contentElement.tagName === "UL") {
    if(contentElement.offsetWidth > 0) {
     if(ASPx.Browser.IE && ASPx.ElementHasCssClass(menuElement, this.menu.getAdaptiveMenuCssClass()))
      menuElement.style.width = "0px";
     menuElement.style.width = contentElement.offsetWidth + "px";
     menuElement.style.display = "";
     if(ASPx.IsPercentageSize(contentElement.style.width))
      contentElement.style.width = menuElement.style.width;
    }
    else
     parentElement.isSubMenuCalculated = false;
   }
  }
  this.CalculateSubMenuItems(menuElement, contentElement, recalculate);
 },
 CalculateSubMenuItems: function(menuElement, contentElement, recalculate) {
  var itemElements = this.GetItemElements(menuElement);
  this.PrecalculateMenuItems(menuElement, itemElements, recalculate);
  this.CalculateMenuItems(menuElement, contentElement, itemElements, true, recalculate);
 },
 ResetMinSize: function() {
  var menuElement = this.menu.GetMainElement();
  if(!menuElement.isMinSizeCalculated || this.menu.isVertical) return;
  var itemElements = this.GetItemElements(menuElement);
  var contentElement = this.GetContentElement(menuElement);
  if(!!contentElement.adaptiveInfo)
   itemElements = itemElements.concat(contentElement.adaptiveInfo.elements);
  for(var i = 0; i < itemElements.length; i++)
   this.ResetItemMinSize(itemElements[i]);
  menuElement.isMinSizeCalculated = false;
 },
 ResetItemMinSize: function(itemElement) {
  itemElement.style.minWidth = "";
  itemElement.isMinSizeCalculated = false;
 },
 CalculateMinSize: function(menuElement, contentElement, itemElements, isVertical, isAutoWidth, isNoWrap, recalculate) {
  if(menuElement.isMinSizeCalculated && !recalculate) return;
  if(isVertical) {
   menuElement.style.minWidth = "";
   if(!this.menu.IsSidePanelExpanded()) {
    ASPx.Attr.ChangeStyleAttribute(contentElement, "width", "1px");
    for(var i = 0; i < itemElements.length; i++) {
     var itemContentElement = this.GetItemContentElement(itemElements[i]);
     if(!itemContentElement || itemElements[i].offsetWidth === 0) continue;
     this.CalculateItemMinSize(itemElements[i], recalculate);
    }
    ASPx.Attr.RestoreStyleAttribute(contentElement, "width");
   }
  }
  else {
   ASPx.RemoveClassNameFromElement(menuElement, MenuCssClasses.NoWrapMenu);
   ASPx.RemoveClassNameFromElement(menuElement, MenuCssClasses.AutoWidthMenu);
   if(isAutoWidth || isNoWrap)
    menuElement.style.minWidth = "";
   ASPx.Attr.ChangeStyleAttribute(menuElement, "width", "1px");
   for(var i = 0; i < itemElements.length; i++) {
    var itemContentElement = this.GetItemContentElement(itemElements[i]);
    if((!itemContentElement || itemElements[i].offsetWidth === 0) && !ASPx.ElementHasCssClass(itemElements[i], MenuCssClasses.ItemTemplate)) continue;
    var textContainer = ASPx.GetNodeByTagName(itemContentElement, "SPAN", 0);
    if(textContainer && ASPx.GetCurrentStyle(textContainer).whiteSpace !== "nowrap")
     ASPx.AdjustWrappedTextInContainer(itemContentElement);
    this.CalculateItemMinSize(itemElements[i], recalculate);
   }
   if(isAutoWidth)
    ASPx.AddClassNameToElement(menuElement, MenuCssClasses.AutoWidthMenu);
   if(isNoWrap)
    ASPx.AddClassNameToElement(menuElement, MenuCssClasses.NoWrapMenu);
   if(isAutoWidth || isNoWrap)
    menuElement.style.minWidth = (contentElement.offsetWidth + ASPx.GetLeftRightBordersAndPaddingsSummaryValue(menuElement)) + "px";
   ASPx.Attr.RestoreStyleAttribute(menuElement, "width");
  }
  menuElement.isMinSizeCalculated = true;
 },
 CalculateItemMinSize: function(itemElement, recalculate) {
  if(itemElement.isMinSizeCalculated && !recalculate) return;
  var sizeCorrection = ASPx.Browser.HardwareAcceleration ? 1 : 0;
  itemElement.style.minWidth = "";
  var childrenWidth = 0;
  if(ASPx.ElementHasCssClass(itemElement, MenuCssClasses.ItemTemplate)) {
   ASPx.Attr.ChangeStyleAttribute(itemElement, "display", "table");
   childrenWidth += itemElement.clientWidth + sizeCorrection;
   ASPx.Attr.RestoreStyleAttribute(itemElement, "display");
   if(ASPx.Browser.Edge && ASPx.Browser.MajorVersion >= 16)
    var dummy = itemElement.clientWidth;
  } 
  else {
   for(var j = 0; j < itemElement.childNodes.length; j++) {
    var child = itemElement.childNodes[j];
    if(!child.offsetWidth) continue;
    var float = ASPx.GetElementFloat(child);
    if(float === "none") {
     childrenWidth = child.offsetWidth;
     break;
    }
    else
     childrenWidth += child.offsetWidth + sizeCorrection;
   }
  }
  itemElement.style.minWidth = childrenWidth + "px";
  itemElement.isMinSizeCalculated = true;
 },
 CalculateSeparatorsAndSpacers: function(menuElement, itemElements, contentElement, isVertical, isAutoWidth, isNoWrap) {
  var spacerElements = this.GetSpacingElements(menuElement);
  var spacerAndSeparatorElements = spacerElements.concat(this.GetSeparatorElements(menuElement));
  for(var i = 0; i < spacerAndSeparatorElements.length; i++)
   ASPx.Attr.RestoreStyleAttribute(spacerAndSeparatorElements[i], "height");
  if(!isVertical && itemElements) {
   var menuHeight = 0;
   if(!isAutoWidth && !isNoWrap) {
    for(var i=0; i < itemElements.length; i++) {
     var newHeight = itemElements[i].getBoundingClientRect().height;
     if(newHeight > menuHeight)
      menuHeight = newHeight;
    }
   }
   for(var i = 0; i < spacerAndSeparatorElements.length; i++){
    var separatorHeight = menuHeight - ASPx.GetTopBottomBordersAndPaddingsSummaryValue(spacerAndSeparatorElements[i]) - ASPx.GetTopBottomMargins(spacerAndSeparatorElements[i]);
    ASPx.Attr.ChangeStyleAttribute(spacerAndSeparatorElements[i], "height", separatorHeight + "px");
   }
   for(var i = 0; i < spacerElements.length; i++){
    if(!ASPx.ElementContainsCssClass(spacerElements[i], this.menu.getAdaptiveMenuItemSpacingCssClass()))
     spacerElements[i].style.minWidth = spacerElements[i].style.width; 
   }
   this.calculateAlignSpacings(menuElement, contentElement);
  }
 },
 calculateAlignSpacings: function(menuElement, contentElement) {
  var separatorElements = this.GetAlignSpacingElements(menuElement),
   separatorsCount = separatorElements.length;
  if(separatorsCount === 0) return;
  ASPx.Data.ForEach(separatorElements, function(separator) {
   separator.style.width = "0";
  });
  var unit = this.menu.enableAdaptivity ? "%" : "px";
  var width = this.menu.enableAdaptivity ? 100 / separatorsCount :
   (ASPx.GetClearClientWidth(menuElement) - contentElement.offsetWidth) / separatorsCount;
  ASPx.Data.ForEach(separatorElements, function(separator) {
   separator.style.width = width + unit;
  });
  if(!this.menu.enableAdaptivity)
   separatorElements[0].style.width = (width - 1) + unit;
 },
 CalculateAdaptiveMainMenu: function(menuElement, contentElement, isVertical, isAutoWidth, isNoWrap, recalculate) {
  var adaptiveItemElement = this.GetAdaptiveMenuItemElement(menuElement);
  if(!adaptiveItemElement) return;
  var adaptiveItemSpacing = this.GetAdaptiveMenuItemSpacingElement(menuElement);
  if(adaptiveItemSpacing) adaptiveItemSpacing.style.width = "";
  var adaptiveMenuElement = this.GetAdaptiveMenuElement(menuElement);
  if(!adaptiveMenuElement) return;
  var adaptiveMenuContentElement = this.GetAdaptiveMenuContentElement(menuElement);
  if(!contentElement.adaptiveInfo)
   this.InitAdaptiveInfo(contentElement);
  var wasAdaptivity = contentElement.adaptiveInfo.hasAdaptivity;
  if(wasAdaptivity) {
   var previousSibling = this.GetAdaptiveItemElementPreviousSibling(adaptiveItemSpacing || adaptiveItemElement);
   this.RestoreAdaptiveItems(previousSibling, contentElement, isVertical);
  }
  if(!isVertical) {
   ASPx.SetElementDisplay(adaptiveItemElement, true);
   if(adaptiveItemSpacing) ASPx.SetElementDisplay(adaptiveItemSpacing, true);
   ASPx.AddClassNameToElement(menuElement, MenuCssClasses.CalculateMenu);
   ASPx.RemoveClassNameFromElement(menuElement, MenuCssClasses.NoWrapMenu);
   menuElement.style.minWidth = "";
   var adaptiveItemWidth = adaptiveItemElement.offsetWidth;
   if(isAutoWidth) {
    ASPx.Attr.ChangeStyleAttribute(contentElement, "display", "none");
    ASPx.Attr.ChangeStyleAttribute(menuElement, "min-width", "");
   }
   var menuWidth = menuElement.offsetWidth - ASPx.GetLeftRightBordersAndPaddingsSummaryValue(menuElement) - adaptiveItemWidth;
   if(isAutoWidth) {
    ASPx.Attr.RestoreStyleAttribute(contentElement, "display");
    ASPx.Attr.RestoreStyleAttribute(menuElement, "min-width");
   }
   var additionalWidth = adaptiveItemWidth;
   if(adaptiveItemSpacing) {
    menuWidth -= adaptiveItemSpacing.offsetWidth;
    additionalWidth += adaptiveItemSpacing.offsetWidth;
   }
   var hasAdaptivity = this.HideAdaptiveItems(menuWidth, additionalWidth, contentElement, adaptiveMenuContentElement);
   contentElement.adaptiveInfo.hasAdaptivity = hasAdaptivity;
   this.SetAdaptiveItemElementVisibility(adaptiveItemElement, adaptiveItemSpacing, hasAdaptivity);
   contentElement.style.width = hasAdaptivity ? "100%" : "";
   if(hasAdaptivity){
    ASPx.CacheHelper.DropCache(adaptiveMenuElement);
    this.CalculateSubMenu(adaptiveMenuElement, true);
    this.CalculateSeparatorsAndSpacers(adaptiveMenuElement, null, adaptiveMenuContentElement, true);
   }
   if(isNoWrap) {
    ASPx.AddClassNameToElement(menuElement, MenuCssClasses.NoWrapMenu);
    if(adaptiveItemSpacing) adaptiveItemSpacing.style.width = hasAdaptivity ? "100%" : "";
   }
   ASPx.RemoveClassNameFromElement(menuElement, MenuCssClasses.CalculateMenu);
  }
  else {
   this.SetAdaptiveItemElementVisibility(adaptiveItemElement, adaptiveItemSpacing, false);
  }
  if(wasAdaptivity || contentElement.adaptiveInfo.hasAdaptivity)
   ASPx.CacheHelper.DropCache(menuElement);
  this.CalculateMainMenu(menuElement, contentElement, isVertical, isAutoWidth, isNoWrap, wasAdaptivity || contentElement.adaptiveInfo.hasAdaptivity || recalculate);
 },
 InitAdaptiveInfo: function(contentElement) {
  if(contentElement.adaptiveInfo) return;
  contentElement.adaptiveInfo = { };
  contentElement.adaptiveInfo.elements = this.CreateAdaptiveElementsArray(contentElement);
  contentElement.adaptiveInfo.hasAdaptivity = false;
 },
 GetAdaptiveItemElementByIndex: function(adaptiveInfo, index) {
  return adaptiveInfo.elements[index];
 },
 GetAdaptiveItemElementParent: function(adaptiveInfo, index) {
  return undefined;
 },
 GetAdaptiveItemElementPreviousSibling: function(defaultPreviousSibling) {
  return defaultPreviousSibling;
 },
 RestoreAdaptiveItems: function(previousSibling, contentElement, isVertical) {
  this.SetLastSeparatorsVisible(true, contentElement);
  for(var i = 0; i < contentElement.adaptiveInfo.elements.length; i++) {
   var element = this.GetAdaptiveItemElementByIndex(contentElement.adaptiveInfo, i);
   if(ASPx.Browser.IE)
    ASPx.RemoveElement(element);
   var isReplacedIndent = !element.parent;
   if(isReplacedIndent)
    ASPx.RemoveElement(ASPx.GetElementById(element.id));
   var itemParentElement = this.GetAdaptiveItemElementParent(contentElement.adaptiveInfo, i) || contentElement;
   itemParentElement.insertBefore(element, previousSibling);
   ASPx.Attr.RestoreStyleAttribute(element, "width");
   if(!isVertical)
    this.SetItemItemPopOutImageHorizontal(element);
   if(ASPx.ElementContainsCssClass(element, MenuCssClasses.Separator) || ASPx.ElementContainsCssClass(element, MenuCssClasses.Spacing))
    ASPx.RemoveClassNameFromElement(element, MenuCssClasses.AdaptiveMenuHiddenElement);
  }
  if(this.menu.GetRootItem()) {
   for(var i = this.elementsToHide.length - 1; i >= 0; i--) {
    if(!this.elementsToHide[i]) continue;
    var indexPath = this.elementsToHide[i].indexPath;
    if(this.menu.GetItemByIndexPath(indexPath).GetVisible())
     this.menu.UpdateItemCssClasses(indexPath, true);
    this.elementsToHide[i] = null;
   }
  }
  this.elementsToHide = [];
 },
 SetLastSeparatorsVisible: function(isVisible, contentElement) {
  var elements = ASPx.GetChildElementNodes(contentElement);
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   if(ASPx.ElementContainsCssClass(element, MenuCssClasses.Separator) || ASPx.ElementContainsCssClass(element, MenuCssClasses.Spacing))
    ASPx.RemoveClassNameFromElement(element, MenuCssClasses.AdaptiveMenuHiddenElement);
   else
    break;
  }
 },
 CreateAdaptiveElementsArray: function(contentElement) {
  var result = [];
  var elements = ASPx.GetChildElementNodes(contentElement);
  for(var i = 0; i < elements.length; i++) {
   if(this.CheckElementIsAdaptive(elements[i]))
    result.push(elements[i]);
  }
  return result;
 },
 SetItemItemPopOutImageHorizontal: function(element) {
  var popOutElements = ASPx.GetNodesByPartialClassName(element, "dxWeb_mVerticalPopOut");
  for(var i = 0; i < popOutElements.length; i++)
   popOutElements[i].className = popOutElements[i].className.replace("Vertical", "Horizontal");
 },
 CheckElementIsAdaptive: function(element) {
  return !ASPx.ElementHasCssClass(element, this.menu.getAdaptiveMenuItemCssClass()) && !ASPx.ElementHasCssClass(element, this.menu.getAdaptiveMenuItemSpacingCssClass());
 },
 CheckAdaptiveItemsWidth: function(contentElement, menuWidth, additionalWidth) {
  var itemsWidth = 0;
  var elements = ASPx.GetChildElementNodes(contentElement);
  for(var i = 0; i < elements.length; i++) {
   var element = elements[i];
   if(this.CheckElementIsAdaptive(element) && element.offsetWidth > 0)
    itemsWidth += this.GetAdaptiveElementWidth(element);
   if(itemsWidth > menuWidth + additionalWidth)
    return false;
  }
  return true;
 },
 GetAdaptiveElementWidth: function(element) {
  return element.style.minWidth !== "" ? parseInt(element.style.minWidth) + ASPx.GetHorizontalBordersWidth(element) : element.offsetWidth;
 },
 HideAdaptiveItems: function(menuWidth, additionalWidth, contentElement, adaptiveMenuContentElement) {
  if(this.CheckAdaptiveItemsWidth(contentElement, menuWidth, additionalWidth))
   return false;
  this.elementsToHide = [];
  var elementsToHide = this.elementsToHide;
  var adaptiveItemSpacingCssClass = this.menu.getAdaptiveMenuItemSpacingCssClass();
  var addToHide = function(index, indexPath, itemElement, separatorElement, indentElement, insteadSeparatorElement) {
   if(!itemElement) return;
   if(separatorElement && ASPx.ElementHasCssClass(separatorElement, adaptiveItemSpacingCssClass))
    separatorElement = null;
   if(indentElement && ASPx.ElementHasCssClass(indentElement, adaptiveItemSpacingCssClass))
    indentElement = null;
   elementsToHide[index] = { indexPath: indexPath, itemElement: itemElement, separatorElement: separatorElement, indentElement: indentElement, insteadSeparatorElement: insteadSeparatorElement };
   ASPx.Attr.ChangeStyleAttribute(itemElement, "display", "none");
   if(separatorElement) {
    var elementForHide = insteadSeparatorElement || separatorElement;
    ASPx.Attr.ChangeStyleAttribute(elementForHide, "display", "none");
   }
   if(indentElement)
    ASPx.Attr.ChangeStyleAttribute(indentElement, "display", "none");
  };
  for(var i = 0; i < this.menu.adaptiveItemsOrder.length; i++){
   var indexPath = this.menu.adaptiveItemsOrder[i],
    index = parseInt(indexPath, 10),
    itemToKeepSeparator = this.menu.GetRootItem() ? this.GetItemForKeepSeparator(index) : null,
    insteadSeparatorElement = itemToKeepSeparator ? this.menu.GetItemIndentElement(itemToKeepSeparator.indexPath) : null;
   addToHide(index, indexPath, this.menu.GetItemElement(indexPath), this.menu.GetItemSeparatorElement(indexPath), this.menu.GetItemIndentElement(indexPath), insteadSeparatorElement);
   var actualAdditionalWidth = this.NeedShowAdaptiveItemForHiddenElements(elementsToHide) ? 0 : additionalWidth;
   if(this.CheckAdaptiveItemsWidth(contentElement, menuWidth, actualAdditionalWidth))
    break;
  }
  var hasImages = false;
  for(var i = 0; i < elementsToHide.length; i++) {
   if(!elementsToHide[i]) continue;
   ASPx.Attr.RestoreStyleAttribute(elementsToHide[i].itemElement, "display");
   if(elementsToHide[i].separatorElement) {
    var elementForRestore = elementsToHide[i].insteadSeparatorElement || elementsToHide[i].separatorElement;
    ASPx.Attr.RestoreStyleAttribute(elementForRestore, "display");
   }
   if(elementsToHide[i].indentElement)
    ASPx.Attr.RestoreStyleAttribute(elementsToHide[i].indentElement, "display");
   this.menu.UpdateItemCssClasses(elementsToHide[i].indexPath, false);
   if(elementsToHide[i].separatorElement) {
    if(this.menu.GetRootItem())
     this.KeepSeparatorInRoot(i);
    adaptiveMenuContentElement.appendChild(elementsToHide[i].separatorElement);
   }
   else if(this.menu.GetRootItem())
    this.InsertSeparatorInAdaptiveMenu(i, elementsToHide[i].indexPath);
   if(elementsToHide[i].indentElement)
    adaptiveMenuContentElement.appendChild(elementsToHide[i].indentElement);
   adaptiveMenuContentElement.appendChild(elementsToHide[i].itemElement);
   this.PrepareHiddenAdaptiveItemElement(elementsToHide[i].itemElement);
   if(ASPx.GetNodeByClassName(elementsToHide[i].itemElement, "dxm-image"))
    hasImages = true;
  }
  for(var i = 0; i < elementsToHide.length; i++) {
   if(!elementsToHide[i]) continue;
   if(elementsToHide[i].separatorElement) 
    ASPx.AddClassNameToElement(elementsToHide[i].separatorElement, MenuCssClasses.AdaptiveMenuHiddenElement);
   if(elementsToHide[i].indentElement) 
    ASPx.AddClassNameToElement(elementsToHide[i].indentElement, MenuCssClasses.AdaptiveMenuHiddenElement);
   break;
  }
  this.SetLastSeparatorsVisible(false, contentElement);
  this.PrepareAdaptiveMenuContentElement(adaptiveMenuContentElement, hasImages);
  return elementsToHide.length > 0;
 },
 PrepareHiddenAdaptiveItemElement: function(itemElement) {
  ASPx.Attr.ChangeStyleAttribute(itemElement, "width", "auto");
  this.SetItemPopOutImageVertical(itemElement);
 },
 PrepareAdaptiveMenuContentElement: function(contentElement, hasImages) {
  if(hasImages)
   ASPx.RemoveClassNameFromElement(contentElement, MenuCssClasses.WithoutImages);
  else
   ASPx.AddClassNameToElement(contentElement, MenuCssClasses.WithoutImages);
 },
 SetAdaptiveItemElementVisibility: function(adaptiveItemElement, adaptiveItemSpacing, visible) {
  ASPx.SetElementDisplay(adaptiveItemElement, visible);
  if(adaptiveItemSpacing)
   ASPx.SetElementDisplay(adaptiveItemSpacing, visible);
 },
 NeedShowAdaptiveItemForHiddenElements: function(elementsToHide) {
  return true;
 },
 KeepSeparatorInRoot: function(index) {
  var nextItemInGroup = this.GetItemForKeepSeparator(index);
  if(nextItemInGroup) {
   var separatorElement = this.elementsToHide[index].separatorElement;
   this.ReplaceIndentElement(nextItemInGroup.indexPath, separatorElement);
  }
 },
 InsertSeparatorInAdaptiveMenu: function(index, indexPath) {
  var itemWithSeparator = this.GetItemWithSeparatorForAdaptiveMenu(index);
  if(itemWithSeparator) {
   var separatorElement = this.menu.GetItemSeparatorElement(itemWithSeparator.indexPath);
   if(!separatorElement) return;
   this.elementsToHide[index].indentElement = this.ReplaceIndentElement(indexPath, separatorElement);
  }
 },
 ReplaceIndentElement: function(indexPath, separatorElement) {
  var itemElement = this.menu.GetItemElement(indexPath),
   itemIndent = this.menu.GetItemIndentElement(indexPath),
   newIndentElement = separatorElement.cloneNode(true),
   parentNode = itemElement.parentNode;
  newIndentElement.id = this.menu.GetItemIndentElementId(indexPath);
  if(itemIndent)
   itemIndent.parentNode.removeChild(itemIndent);
  parentNode.insertBefore(newIndentElement, itemElement);
  return newIndentElement;
 },
 GetItemForKeepSeparator: function(index) {
  var rootItem = this.menu.GetRootItem(),
   nextItemInGroup = this.menu.GetNextVisibleItemInGroup(rootItem, index, true);
  if(nextItemInGroup && this.IsItemInAdaptiveMenu(nextItemInGroup.index)) {
   while(nextItemInGroup && this.IsItemInAdaptiveMenu(nextItemInGroup.index))
    nextItemInGroup = this.menu.GetNextVisibleItemInGroup(rootItem, nextItemInGroup.index, true);
  }
  return nextItemInGroup;
 },
 GetItemWithSeparatorForAdaptiveMenu: function(index) {
  var rootItem = this.menu.GetRootItem(),
   prevItemInGroup = this.menu.GetPrevVisibleItemInGroup(rootItem, index);
  if(prevItemInGroup && !this.IsItemInAdaptiveMenu(prevItemInGroup.index) && !this.menu.IsItemBeginsGroup(prevItemInGroup)) {
   while(prevItemInGroup && !this.IsItemInAdaptiveMenu(prevItemInGroup.index) && !this.menu.IsItemBeginsGroup(prevItemInGroup))
    prevItemInGroup = this.menu.GetPrevVisibleItemInGroup(rootItem, prevItemInGroup.index);
  }
  return prevItemInGroup && !this.IsItemInAdaptiveMenu(prevItemInGroup.index) ? prevItemInGroup : null;
 },
 IsItemInAdaptiveMenu: function(index) {
  return this.elementsToHide.length >= index ? !!this.elementsToHide[index] : false;
 },
 SetItemPopOutImageVertical: function(element) {
  var popOutElements = ASPx.GetNodesByPartialClassName(element, "dxWeb_mHorizontalPopOut");
  for(var i = 0; i < popOutElements.length; i++)
   popOutElements[i].className = popOutElements[i].className.replace("Horizontal", "Vertical");
 },
 ChangeItemsPopOutImages: function(menuElement, isVertical) {
  var itemElements = this.GetItemElements(menuElement);
  for(var i = 0; i < itemElements.length; i++){
   if(isVertical)
    this.SetItemPopOutImageVertical(itemElements[i]);
   else
    this.SetItemItemPopOutImageHorizontal(itemElements[i]);
  }
 },
 ChangeOrientaion: function(menuElement, isVertical) {
  var oldCssSelector = isVertical ? MenuCssClasses.HorizontalMenu : MenuCssClasses.VerticalMenu;
  var newCssSelector = isVertical ? MenuCssClasses.VerticalMenu : MenuCssClasses.HorizontalMenu;
  menuElement.className = menuElement.className.replace(oldCssSelector, newCssSelector);
  this.ChangeItemsPopOutImages(menuElement, isVertical);
  this.CalculateMenuControl(menuElement, true);
  this.ChangeItemsPopOutImages(menuElement, isVertical);
 }
});
var MenuScrollingManager = ASPx.CreateClass(ASPx.ScrollingManager, {
 constructor: function(menuScrollHelper) {
  this.constructor.prototype.constructor.call(this, menuScrollHelper, {
   scrollableArea: menuScrollHelper.scrollingAreaElement,
   orientation: [0, 1],
   onBeforeScrolling: function(manager, direction) {
    manager.owner.OnBeforeScrolling(direction);
   },
   onAfterScrolling: function(manager, direction) {
    manager.owner.OnAfterScrolling(direction);
   },
   forseEmulation: false,
   useMarginForPosition: true,
   handleMouseWheel: menuScrollHelper.handleMouseWheel
  });
 },
 setParentNodeOverflow: function() { 
  if(ASPx.Browser.MSTouchUI) {
   this.scrollableArea.parentNode.style.overflow = "auto";
   this.scrollableArea.parentNode.style["-ms-overflow-style"] = "none";
  }  
 }
});
var MenuScrollHelper = ASPx.CreateClass(null, {
 constructor: function(menu, indexPath) {
  this.menu = menu;
  this.indexPath = indexPath;
  this.scrollingAreaElement = null;
  this.manager = null;
  this.initialized = false;
  this.visibleItems = [];
  this.itemsHeight = 0;
  this.scrollHeight = 0;
  this.scrollUpButtonHeight = 0;
  this.scrollDownButtonHeight = 0;
  this.scrollAreaHeight = null;
  this.scrollUpButtonVisible = false;
  this.scrollDownButtonVisible = false;
  this.handleMouseWheel = true;
 },
 Initialize: function() {
  if(this.initialized && !this.menu.NeedCreateItemsOnClientSide()) return;
  this.scrollingAreaElement = this.menu.GetScrollContentItemsContainer(this.indexPath);
  this.manager = new MenuScrollingManager(this);
  this.ShowScrollButtons();
  var scrollUpButton = this.menu.GetScrollUpButtonElement(this.indexPath);
  if(scrollUpButton) {
   this.scrollUpButtonHeight = this.GetScrollButtonHeight(scrollUpButton);
   ASPx.Selection.SetElementSelectionEnabled(scrollUpButton, false);
  }
  var scrollDownButton = this.menu.GetScrollDownButtonElement(this.indexPath);
  if(scrollDownButton) {
   this.scrollDownButtonHeight = this.GetScrollButtonHeight(scrollDownButton);
   ASPx.Selection.SetElementSelectionEnabled(scrollDownButton, false);
  }
  if(ASPx.Browser.WebKitTouchUI) {
   var preventDefault = function(event) { event.preventDefault(); };
   ASPx.Evt.AttachEventToElement(scrollUpButton, "touchstart", preventDefault);
   ASPx.Evt.AttachEventToElement(scrollDownButton, "touchstart", preventDefault);
  }
  this.HideScrollButtons();
  this.initialized = true;
 },
 GetScrollButtonHeight: function(button) {
  var style = ASPx.GetCurrentStyle(button);
  return button.offsetHeight + ASPx.PxToInt(style.marginTop) + ASPx.PxToInt(style.marginBottom);
 },
 FillVisibleItemsList: function() {
  var index = 0;
  this.visibleItems = [];
  while(true) {
   var childIndexPath = (this.indexPath != "" ? this.indexPath + ASPx.ItemIndexSeparator : "") + index;
   var itemElement = this.menu.GetItemElement(childIndexPath);
   if(itemElement == null)
    break;
   if(ASPx.GetElementDisplay(itemElement))
    this.visibleItems.push(itemElement);
   index++;
  }
 },
 CanCalculate: function() {
  return this.scrollingAreaElement && ASPx.IsElementDisplayed(this.scrollingAreaElement);
 },
 Calculate: function(scrollHeight) {
  if(!this.CanCalculate()) return;
  this.FillVisibleItemsList();
  this.itemsHeight = 0;
  this.scrollHeight = scrollHeight;
  var itemsContainer = this.menu.GetScrollContentItemsContainer(this.indexPath);
  if(itemsContainer) this.itemsHeight = itemsContainer.offsetHeight;
  this.SetPosition(0);
  this.CalculateScrollingElements(-1);
 },
 GetPosition: function() {
  return -this.manager.GetScrolledAreaPosition();
 },
 SetPosition: function(pos) {
  this.manager.SetScrolledAreaPosition(-pos);
 },
 CalculateScrollingElements: function(direction) {
  if(this.itemsHeight <= this.scrollHeight) {
   this.scrollUpButtonVisible = false;
   this.scrollDownButtonVisible = false;
   this.scrollAreaHeight = null;
   this.SetPosition(0);
  }
  else {
   var scrollTop = this.GetPosition();
   this.scrollAreaHeight = this.scrollHeight;
   if(direction > 0) {
    var showScrollUpButton = !this.scrollUpButtonVisible;
    this.scrollUpButtonVisible = true;
    this.scrollAreaHeight -= this.scrollUpButtonHeight;
    this.scrollDownButtonVisible = this.itemsHeight - this.scrollAreaHeight - scrollTop > this.scrollDownButtonHeight;
    if(this.scrollDownButtonVisible) {
     this.scrollAreaHeight -= this.scrollDownButtonHeight;
     if(showScrollUpButton)
      this.SetPosition(this.GetPosition() + this.scrollUpButtonHeight);
    }
    else {
     this.SetPosition(this.itemsHeight - this.scrollAreaHeight);
    }
   }
   else {
    this.scrollDownButtonVisible = true;
    this.scrollAreaHeight -= this.scrollDownButtonHeight;
    this.scrollUpButtonVisible = scrollTop > this.scrollUpButtonHeight;
    if(this.scrollUpButtonVisible)
     this.scrollAreaHeight -= this.scrollUpButtonHeight;
    else
     this.SetPosition(0);
   }
   if(this.scrollAreaHeight < 1) this.scrollAreaHeight = 1;
  }
  this.UpdateScrollingElements();
 },
 UpdateScrollingElements: function() {
  this.UpdateScrollAreaHeight();
  this.UpdateScrollButtonsVisibility();
 },
 UpdateScrollAreaHeight: function() {
  var scrollAreaElement = this.menu.GetScrollAreaElement(this.indexPath);
  if(scrollAreaElement)
   scrollAreaElement.style.height = (this.scrollAreaHeight) ? (this.scrollAreaHeight + "px") : "";
 },
 UpdateScrollButtonsVisibility: function() {
  var scrollUpButton = this.menu.GetScrollUpButtonElement(this.indexPath);
  if(scrollUpButton) ASPx.SetElementDisplay(scrollUpButton, this.scrollUpButtonVisible);
  var scrollDownButton = this.menu.GetScrollDownButtonElement(this.indexPath);
  if(scrollDownButton) ASPx.SetElementDisplay(scrollDownButton, this.scrollDownButtonVisible);
 },
 ChangeScrollButtonsVisibility: function(visible) {
  this.scrollUpButtonVisible = visible;
  this.scrollDownButtonVisible = visible;
  this.UpdateScrollButtonsVisibility();
 },
 ShowScrollButtons: function() {
  this.ChangeScrollButtonsVisibility(true);
 },
 HideScrollButtons: function() {
  this.ChangeScrollButtonsVisibility(false);
 },
 ResetScrolling: function() {
  if(!this.initialized)
   return;
  this.HideScrollButtons();
  this.SetPosition(0);
  this.scrollAreaHeight = null;
  this.UpdateScrollAreaHeight();
 },
 GetScrollAreaHeight: function() {
  var scrollAreaElement = this.menu.GetScrollAreaElement(this.indexPath);
  if(scrollAreaElement)
   return scrollAreaElement.offsetHeight;
  return 0;
 },
 OnAfterScrolling: function(direction) {
  this.CalculateScrollingElements(direction);
 },
 OnBeforeScrolling: function(direction) {
  var scrollButton = (direction > 0) ? this.menu.GetScrollDownButtonElement(this.indexPath) :
   this.menu.GetScrollUpButtonElement(this.indexPath);
  if(!scrollButton || !ASPx.GetElementDisplay(scrollButton))
   this.manager.StopScrolling();
 },
 StartScrolling: function(direction, delay, step) {
  this.manager.StartScrolling(direction, delay, step);
 },
 StopScrolling: function() {
  this.manager.StopScrolling();
 }
});
MenuScrollHelper.GetMenuByScrollButtonId = function(id) {
 var menuName = aspxGetMenuCollection().GetMenuNameBySuffixes(id, [Constants.SBIdSuffix]);
 return aspxGetMenuCollection().Get(menuName);
};
var ASPxClientMenuBase = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.renderData = null;
  this.renderHelper = this.CreateRenderHelper();
  this.sampleItemsFlags = {
   TextOnly: 0,
   SubItems: 1,
   Image: 2,
   NavigateUrl: 4,
   DropDownMode: 8,
   CheckBox: 16,
   ImageClassName: 32,
   Svg: 64
  };
  this.rootMenuSample = null;
  this.dropElementsCache = false;
  this.allowSelectItem = false;
  this.allowCheckItems = false;
  this.allowMultipleCallbacks = false;
  this.appearAfter = 300;
  this.slideAnimationDuration = 60;
  this.disappearAfter = 500;
  this.enableAnimation = true;
  this.enableAdaptivity = false;
  this.adaptiveItemsOrder = [];
  this.enableSubMenuFullWidth = false;
  this.checkedItems = [];
  this.isVertical = true;
  this.itemCheckedGroups = [];
  this.itemCheckedGroups.groupNames = {};
  this.lockHoverEvents = false;
  this.popupToLeft = false;
  this.popupCount = 0;
  this.rootItem = null;
  this.showSubMenus = false;
  this.savedCallbackHoverItem = null;
  this.savedCallbackHoverElement = null;
  this.selectedItemIndexPath = "";
  this.checkedState = null;
  this.scrollInfo = [];
  this.scrollHelpers = {};
  this.scrollVertOffset = 1;
  this.keyboardHelper = null;
  this.isContextMenu = false;
  this.accessibleFocusElement = null;
  this.rootSubMenuFIXOffset = 0;
  this.rootSubMenuFIYOffset = 0;
  this.rootSubMenuLIXOffset = 0;
  this.rootSubMenuLIYOffset = 0;
  this.rootSubMenuXOffset = 0;
  this.rootSubMenuYOffset = 0;
  this.subMenuFIXOffset = 0;
  this.subMenuFIYOffset = 0;
  this.subMenuLIXOffset = 0;
  this.subMenuLIYOffset = 0;
  this.subMenuXOffset = 0;
  this.subMenuYOffset = 0;
  this.maxHorizontalOverlap = -3;
  this.sizingConfig.allowSetHeight = false;
  this.ItemClick = new ASPxClientEvent();
  this.ItemMouseOver = new ASPxClientEvent();
  this.ItemMouseOut = new ASPxClientEvent();
  this.PopUp = new ASPxClientEvent();
  this.CloseUp = new ASPxClientEvent();
  aspxGetMenuCollection().Add(this);
 },
 SetData: function(data) {
  if(data.items)
   this.CreateItems(data.items);
 },
 InlineInitialize: function() {
  ASPxClientControl.prototype.InlineInitialize.call(this);
  if(!this.NeedCreateItemsOnClientSide())
   this.renderHelper.InlineInitializeElements();
  else
   this.renderHelper.InlineInitializeScrollElements("", this.GetMainElement());
  this.InitializeInternal(true);
  if(this.IsCallbacksEnabled()) {
   this.showSubMenus = this.GetLoadingPanelElement() != null;
   this.CreateCallback("DXMENUCONTENT");
  }
  else
   this.showSubMenus = true;
  this.popupToLeft = this.rtl;
 },
 InitializeInternal: function(inline) {
  if(!this.NeedCreateItemsOnClientSide()) {
   this.InitializeCheckedItems();
   this.InitializeSelectedItem();
  }
  this.InitializeEnabledAndVisible(!inline || !this.IsCallbacksEnabled());
  if(!this.IsCallbacksEnabled())
   this.InitializeScrollableMenus();
  this.InitializeKeyboardHelper();
 },
 InitializeEnabledAndVisible: function(recursive) {
  if(this.rootItem == null) return;
  for(var i = 0; i < this.rootItem.items.length; i++)
   this.rootItem.items[i].InitializeEnabledAndVisible(recursive);
 },
 InitializeScrollableMenus: function() {
  var info = eval(this.scrollInfo);
  this.scrollHelpers = {};
  for(var i = 0; i < info.length; i++)
   this.InitializeScrollableMenu(info[i]);
 },
 InitializeScrollableMenu: function(indexPath) {
  if(!this.scrollHelpers[indexPath])
   this.scrollHelpers[indexPath] = new MenuScrollHelper(this, indexPath);
 },
 GetScrollHelper: function(indexPath) {
  var scrollsEnabledOnServer = this.scrollInfo.length > 0;
  if(this.NeedCreateItemsOnClientSide() && scrollsEnabledOnServer)
   this.InitializeScrollableMenu(indexPath);
  return this.scrollHelpers[indexPath];
 },
 InitializeKeyboardHelper: function() {
  this.keyboardHelper = new ASPxMenuKeyboardHelper(this);
 },
 InitializeMenuSamples: function() {
  this.rootMenuSample = this.GetSampleNode(this.samples.root);
  this.samples.spacing = this.GetSampleNode(this.samples.spacing);
  this.samples.separator = this.GetSampleNode(this.samples.separator);
  this.InitializeItemsSamples(this.samples.rootItems);
  if(this.samples.submenu) {
   this.samples.submenu = this.GetSampleNode(this.samples.submenu);
   this.InitializeItemsSamples(this.samples.submenuItems);
  }
 },
 InitializeItemsSamples: function(itemsSamples) {
  for(var sampleProperty in itemsSamples) {
   if(itemsSamples.hasOwnProperty(sampleProperty)) {
    itemsSamples[sampleProperty] = itemsSamples[sampleProperty].replace(/DXFAKE/, "");
    itemsSamples[sampleProperty] = this.GetSampleNode(itemsSamples[sampleProperty]);
   }
  }
 },
 CheckElementsCache: function(menuElement){
  if(this.dropElementsCache) {
   ASPx.CacheHelper.DropCache(menuElement);
   this.dropElementsCache = false;
  }
 },
 NeedCreateItemsOnClientSide: function() {
  return false;
 },
 IsClientSideEventsAssigned: function() {
  return !this.ItemClick.IsEmpty()
   || !this.ItemMouseOver.IsEmpty()
   || !this.ItemMouseOut.IsEmpty()
   || !this.PopUp.IsEmpty()
   || !this.CloseUp.IsEmpty()
   || !this.Init.IsEmpty();
 },
 IsCallbacksEnabled: function() {
  return ASPx.IsFunction(this.callBack);
 },
 ShouldHideExistingLoadingElements: function() {
  return false;
 },
 CreateRenderHelper: function(){
  return new MenuRenderHelper(this);
 },
 IsSidePanelExpanded: function() {
  return false;
 },
 GetMenuElementId: function(indexPath) {
  return this.name + Constants.MMIdSuffix + indexPath + "_";
 },
 GetMenuMainElementId: function(indexPath) {
  return this.name + "_DXME" + indexPath + "_";
 },
 GetMenuBorderCorrectorElementId: function(indexPath) {
  return this.name + "_DXMBC" + indexPath + "_";
 },
 GetMenuIFrameElementId: function(indexPath) {
  return this.name + "_DXMIF" + this.GetMenuLevel(indexPath);
 },
 GetScrollAreaId: function(indexPath) {
  return this.name + "_DXSA" + indexPath;
 },
 GetMenuTemplateContainerID: function(indexPath) {
  return this.name + "_MTCNT" + indexPath;
 },
 GetItemTemplateContainerID: function(indexPath) {
  return this.name + "_ITCNT" + indexPath;
 },
 GetScrollUpButtonId: function(indexPath) {
  return this.name + Constants.SBIdSuffix + indexPath + Constants.SBUIdEnd;
 },
 GetScrollDownButtonId: function(indexPath) {
  return this.name + Constants.SBIdSuffix + indexPath + Constants.SBDIdEnd;
 },
 GetItemElementId: function(indexPath) {
  return this.name + Constants.MIIdSuffix + indexPath + "_";
 },
 GetItemContentElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "T";
 },
 GetItemPopOutElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "P";
 },
 GetItemImageId: function(indexPath) {
  return this.GetItemElementId(indexPath) + Constants.ImagePostfix;
 },
 GetItemPopOutImageId: function(indexPath) {
  return this.GetItemElementId(indexPath) + Constants.PopupImagePostfix;
 },
 GetItemIndentElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "II";
 },
 GetItemSeparatorElementId: function(indexPath) {
  return this.GetItemElementId(indexPath) + "IS";
 },
 GetMenuElement: function (indexPath) { 
  if(indexPath == "")
   return this.GetMainElement();
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetMenuElementId(indexPath));
 },
 GetMenuIFrameElement: function(indexPath) {
  var elementId = this.GetMenuIFrameElementId(indexPath);
  var element = ASPx.GetElementById(elementId);
  if(!element && this.renderIFrameForPopupElements)
   return this.CreateIFrameElement(elementId);
  return element;
 },
 CreateIFrameElement: function(elementId) {
  var element = document.createElement("IFRAME");
  ASPx.Attr.SetAttribute(element, "id", elementId);
  ASPx.Attr.SetAttribute(element, "src", "javascript:false");
  ASPx.Attr.SetAttribute(element, "scrolling", "no");
  ASPx.Attr.SetAttribute(element, "frameborder", "0");
  if(this.accessibilityCompliant)
   ASPx.Attr.SetAttribute(element, "title", ASPx.AccessibilitySR.AccessibilityIFrameTitle);
  element.style.position = "absolute";
  element.style.display = "none";
  element.style.zIndex = "19997";
  element.style.filter = "progid:DXImageTransform.Microsoft.Alpha(Style=0, Opacity=0)";
  ASPx.InsertElementAfter(element, this.GetMainElement());
  return element;
 },
 GetMenuBorderCorrectorElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetMenuBorderCorrectorElementId(indexPath));
 },
 GetMenuMainElement: function(element) {
  var indexPath = this.GetIndexPathById(element.id, true);
  return ASPx.CacheHelper.GetCachedElement(this, "menuMainElement" + indexPath, 
   function() { 
    var shadowTable = ASPx.GetElementById(this.GetMenuMainElementId(indexPath));
    return shadowTable != null ? shadowTable : element;
   });
 },
 GetScrollAreaElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetScrollAreaId(indexPath));
 },
 GetScrollContentItemsContainer: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElement(this, "scrollContentItemsContainer" + indexPath, 
   function() { 
    return ASPx.GetNodeByTagName(this.GetScrollAreaElement(indexPath), "UL", 0);
   });
 },
 GetScrollUpButtonElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetScrollUpButtonId(indexPath));
 },
 GetScrollDownButtonElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetScrollDownButtonId(indexPath));
 },
 GetItemElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetItemElementId(indexPath));
 },
 GetItemTemplateElement: function(indexPath) { 
  return this.GetItemTextTemplateContainer(indexPath);
 },
 GetItemTemplateContainer: function(indexPath) {
  return this.GetItemElement(indexPath);
 },
 GetItemTextTemplateContainer: function(indexPath) {
  return this.GetItemContentElement(indexPath);
 },
 GetItemContentElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetItemContentElementId(indexPath));
 },
 GetItemPopOutElement: function(indexPath) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.GetItemPopOutElementId(indexPath));
 },
 GetPopOutElements: function() {
  return ASPx.GetNodesByClassName(this.GetMainElement().parentNode, "dxm-popOut");
 },
 GetPopOutImages: function() {
  return ASPx.GetNodesByClassName(this.GetMainElement().parentNode, "dxm-pImage");
 },
 GetSubMenuXPosition: function(indexPath, isVertical) {
  var itemElement = this.GetItemElement(indexPath);
  var pos = ASPx.GetAbsoluteX(itemElement) + (isVertical ? itemElement.clientWidth + itemElement.clientLeft : 0);
  if(ASPx.Browser.WebKitFamily && !this.IsParentElementPositionStatic(indexPath))
   pos -= document.body.offsetLeft;
  return pos;
 },
 GetSubMenuYPosition: function(indexPath, isVertical) {
  var position = 0;
  var element = this.GetItemElement(indexPath);
  if(element != null) {
   if(isVertical) {
    position = ASPx.GetAbsoluteY(element); 
   }
   else {
    if(ASPx.Browser.Opera && ASPx.Browser.Version >= 9 || ASPx.Browser.AndroidDefaultBrowser)
     position = ASPx.GetAbsoluteY(element) + element.offsetHeight - ASPx.GetClientTop(element);
    else
     position = ASPx.GetAbsoluteY(element) + element.clientHeight + ASPx.GetClientTop(element);
   }
  }
  if(ASPx.Browser.WebKitFamily && !this.IsParentElementPositionStatic(indexPath))
   position -= document.body.offsetTop;
  return position;
 },
 GetClientSubMenuXPosition: function(element, x, indexPath, isVertical) {
  var docClientWidth = ASPx.GetDocumentClientWidth();
  if(isVertical)
   return this.GetClientSubMenuXPositionVerticalCore(element, x, indexPath, isVertical, docClientWidth);
  return this.GetClientSubMenuXPositionHorizontalCore(element, x, indexPath, isVertical, docClientWidth);
 },
 GetClientSubMenuXPositionVerticalCore: function(element, x, indexPath, isVertical, docClientWidth) {
  var itemInfo = new MenuItemInfo(this, indexPath);
  var itemWidth = itemInfo.clientWidth;
  var subMenuWidth = this.GetMenuMainElement(element).offsetWidth;
  var left = x - ASPx.GetDocumentScrollLeft();
  var right = left + subMenuWidth;
  var toLeftX = x - subMenuWidth - itemWidth;
  var toLeftLeft = left - subMenuWidth - itemWidth;
  if(this.IsCorrectionDisableMethodRequired(indexPath))
   return this.GetCorrectionDisabledResult(x, toLeftX);
  if(this.popupToLeft) {
   if(toLeftLeft > this.maxHorizontalOverlap)
    return toLeftX;
   if(docClientWidth - right > this.maxHorizontalOverlap || !this.rtl) {
    this.popupToLeft = false;
    return x;
   }
   return ASPx.InvalidPosition;
  }
  else {
   if(docClientWidth - right > this.maxHorizontalOverlap)
    return x;
   if(toLeftLeft > this.maxHorizontalOverlap || this.rtl) {
    this.popupToLeft = true;
    return toLeftX;
   }
   return ASPx.InvalidPosition;
  }
 },
 GetClientSubMenuXPositionHorizontalCore: function(element, x, indexPath, isVertical, docClientWidth) {
  var itemInfo = new MenuItemInfo(this, indexPath);
  var itemOffsetWidth = itemInfo.offsetWidth;
  var subMenuWidth = this.GetMenuMainElement(element).offsetWidth;
  var left = x - ASPx.GetDocumentScrollLeft();
  if(this.popupToLeft) {
   var rtlX = left - subMenuWidth + itemOffsetWidth;
   return rtlX < 0 ? 0 : rtlX;
  }
  else {
   if(docClientWidth - (left + subMenuWidth) < 0) {
    x = docClientWidth - subMenuWidth;
    if(x < 0)
     x = 0;
    return x;
   }
   return x;
  }
 },
 GetClientSubMenuYPosition: function(element, y, indexPath, isVertical) {
  var itemInfo = new MenuItemInfo(this, indexPath);
  var itemHeight = itemInfo.offsetHeight;
  var subMenuHeight = this.GetMenuMainElement(element).offsetHeight;
  var menuItemTop = y - ASPx.GetDocumentScrollTop();
  var subMenuBottom = menuItemTop + subMenuHeight;
  var docClientHeight = ASPx.GetDocumentClientHeight();
  var clientSubMenuYPos = y;
  if(isVertical) {
   var notEnoughSpaceToShowDown = subMenuBottom > docClientHeight;
   var menuItemBottom = menuItemTop + itemHeight;
   if(menuItemBottom > docClientHeight) {
    menuItemBottom = docClientHeight;
    itemHeight = menuItemBottom - menuItemTop;
   }
   var notEnoughSpaceToShowUp = menuItemBottom < subMenuHeight;
   var subMenuIsFitToDisplayFrames = docClientHeight >= subMenuHeight;
   if(!subMenuIsFitToDisplayFrames) clientSubMenuYPos = y - menuItemTop;
   else if(notEnoughSpaceToShowDown) {
    if(notEnoughSpaceToShowUp) {
     var docClientBottom = ASPx.GetDocumentScrollTop() + docClientHeight;
     clientSubMenuYPos = docClientBottom - subMenuHeight;
    } else
     clientSubMenuYPos = y + itemHeight - subMenuHeight;
   }
  }
  else {
   if(this.IsHorizontalSubmenuNeedInversion(subMenuBottom, docClientHeight, menuItemTop, subMenuHeight, itemHeight))
    clientSubMenuYPos = y - subMenuHeight - itemHeight;
  }
  return clientSubMenuYPos;
 },
 IsHorizontalSubmenuNeedInversion: function(subMenuBottom, docClientHeight, menuItemTop, subMenuHeight, itemHeight) {
  return subMenuBottom > docClientHeight && menuItemTop - subMenuHeight - itemHeight > docClientHeight - subMenuBottom;
 },
 IsCorrectionDisableMethodRequired: function(indexPath) {
  return false;
 },
 HasChildren: function(indexPath) {
  return (this.GetMenuElement(indexPath) != null);
 },
 IsVertical: function(indexPath) {
  return true;
 },
 IsRootItem: function(indexPath) {
  return this.GetMenuLevel(indexPath) <= 1;
 },
 IsParentElementPositionStatic: function(indexPath) {
  return this.IsRootItem(indexPath);
 },
 GetItemIndexPath: function(indexes) {
  return aspxGetMenuCollection().GetItemIndexPath(indexes);
 },
 GetItemIndexes: function(indexPath) {
  return aspxGetMenuCollection().GetItemIndexes(indexPath);
 },
 GetItemIndexPathById: function(id) {
  return aspxGetMenuCollection().GetIndexPathById(id, Constants.MIIdSuffix);
 },
 GetMenuIndexPathById: function(id) {
  return aspxGetMenuCollection().GetIndexPathById(id, Constants.MMIdSuffix);
 },
 GetScrollButtonIndexPathById: function(id) {
  return aspxGetMenuCollection().GetIndexPathById(id, Constants.SBIdSuffix);
 },
 GetIndexPathById: function(id, checkMenu) {
  var indexPath = this.GetItemIndexPathById(id);
  if(indexPath == "" && checkMenu)
   indexPath = this.GetMenuIndexPathById(id);
  return indexPath;
 },
 GetMenuLevelInternal: function(indexPath) {
  if(indexPath == "")
   return 0;
  else {
   var indexes = this.GetItemIndexes(indexPath);
   return indexes.length;
  }
 },
 GetMenuLevel: function(indexPath) {
  var level = this.GetMenuLevelInternal(indexPath);
  if(this.IsAdaptiveMenuItem(indexPath))
   level ++;
  return level;
 },
 IsAdaptiveMenuItem: function(indexPath){
  var level = this.GetMenuLevelInternal(indexPath);
  while(level > 1){
   indexPath = this.GetParentIndexPath(indexPath);
   level = this.GetMenuLevelInternal(indexPath);
  }
  var itemElement = this.GetItemElement(indexPath);
  if(itemElement && ASPx.GetParentByClassName(itemElement, this.getAdaptiveMenuCssClass()))
   return true;
  return false;
 },
 IsAdaptiveItem: function(indexPath){
  var itemElement = this.GetItemElement(indexPath);
  if(itemElement && ASPx.ElementContainsCssClass(itemElement, this.getAdaptiveMenuItemCssClass()))
   return true;
  return false;
 },
 GetParentIndexPath: function(indexPath) {
  var indexes = this.GetItemIndexes(indexPath);
  indexes.length--;
  return (indexes.length > 0) ? this.GetItemIndexPath(indexes) : "";
 },
 IsLastElement: function(element) {
  return element && (!element.nextSibling || !element.nextSibling.tagName);
 },
 IsLastItem: function(indexPath) {
  var itemElement = this.GetItemElement(indexPath);
  return this.IsLastElement(itemElement);
 },
 IsFirstElement: function(element) {
  return element && (!element.previousSibling || !element.previousSibling.tagName);
 },
 IsFirstItem: function(indexPath) {
  var itemElement = this.GetItemElement(indexPath);
  return this.IsFirstElement(itemElement);
 },
 IsItemElement: function(element) {
  return ASPx.ElementContainsCssClass(element, MenuCssClasses.Item);
 },
 GetPreviousItem: function(itemPath, isItemNameUsed) {
  var indexPath = itemPath;
  if(isItemNameUsed) {
   var indexPath = this.GetMenuIndexPathById(itemPath);
   if(indexPath == "")
    indexPath = this.GetItemIndexPathById(itemPath);
  }
  var currentItem = this.GetItemByIndexPath(indexPath),
   previousItem = null;
  if(currentItem) {
   for(var i = currentItem.index - 1; i >= 0 && previousItem === null; i--) {
    if(currentItem.parent.items[i].GetVisible())
     previousItem = currentItem.parent.items[i];
   }
  }
  return previousItem;
 },
 GetClientSubMenuPos: function(element, indexPath, pos, isVertical, isXPos) {
  if(!ASPx.IsValidPosition(pos)) {
   pos = isXPos ? this.GetSubMenuXPosition(indexPath, isVertical) : this.GetSubMenuYPosition(indexPath, isVertical);
  }
  var clientPos = isXPos ? this.GetClientSubMenuXPosition(element, pos, indexPath, isVertical) : this.GetClientSubMenuYPosition(element, pos, indexPath, isVertical);
  var isInverted = pos != clientPos;
  if(clientPos !== ASPx.InvalidPosition){
   var offset = isXPos ? this.GetSubMenuXOffset(indexPath) : this.GetSubMenuYOffset(indexPath);
   clientPos += isInverted ? -offset : offset;
   clientPos -= ASPx.GetPositionElementOffset(this.GetMenuElement(indexPath), isXPos);
  }
  return new ASPx.PopupPosition(clientPos, isInverted);
 },
 GetSubMenuXOffset: function(indexPath) {
  if(indexPath == "")
   return 0;
  else if(this.IsRootItem(indexPath)) {
   if(this.IsFirstItem(indexPath))
    return this.rootSubMenuFIXOffset;
   else if(this.IsLastItem(indexPath))
    return this.rootSubMenuLIXOffset;
   else
    return this.rootSubMenuXOffset;
  }
  else {
   if(this.IsFirstItem(indexPath))
    return this.subMenuFIXOffset;
   else if(this.IsLastItem(indexPath))
    return this.subMenuLIXOffset;
   else
    return this.subMenuXOffset;
  }
 },
 GetSubMenuYOffset: function(indexPath) {
  if(indexPath == "")
   return 0;
  else if(this.IsRootItem(indexPath)) {
   if(this.IsFirstItem(indexPath))
    return this.rootSubMenuFIYOffset;
   else if(this.IsLastItem(indexPath))
    return this.rootSubMenuLIYOffset;
   else
    return this.rootSubMenuYOffset;
  }
  else {
   if(this.IsFirstItem(indexPath))
    return this.subMenuFIYOffset;
   else if(this.IsLastItem(indexPath))
    return this.subMenuLIYOffset;
   else
    return this.subMenuYOffset;
  }
 },
 CalculateSubMenuPosition: function(element, x, y, indexPath, enableAnimation) {
  var isVertical = this.IsVertical(indexPath);
  var horizontalPopupPosition = this.GetClientSubMenuPos(element, indexPath, x, isVertical, true);
  if(horizontalPopupPosition.position === ASPx.InvalidPosition) {
   isVertical = !isVertical;
   horizontalPopupPosition = this.GetClientSubMenuPos(element, indexPath, x, isVertical, true);
  }
  var verticalPopupPosition = this.GetClientSubMenuPos(element, indexPath, y, isVertical, false);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  var toTheLeft = horizontalPopupPosition.isInverted;
  var toTheTop = verticalPopupPosition.isInverted;
  clientY += this.GetScrollingCorrection(element, indexPath, clientY);
  verticalPopupPosition.position = clientY;
  var parentElement = this.GetItemContentElement(indexPath);
  var prevParentPos = ASPx.GetAbsoluteX(parentElement);
  ASPx.SetStyles(element, {
   left: clientX, top: clientY
  });
  if(ASPx.Browser.IE && ASPx.IsElementRightToLeft(document.body)) {
   ASPx.SetElementDisplay(element, false);
   ASPx.SetElementDisplay(element, true);
  }
  clientX += ASPx.GetAbsoluteX(parentElement) - prevParentPos;
  if(enableAnimation) {
   this.StartAnimation(element, indexPath, horizontalPopupPosition, verticalPopupPosition, isVertical);
  }
  else {
   ASPx.SetStyles(element, { left: clientX, top: clientY });
   ASPx.SetElementVisibility(element, true);
   if(this.enableSubMenuFullWidth)
    this.ApplySubMenuFullWidth(element);
   this.DoShowPopupMenuIFrame(element, clientX, clientY, ASPx.InvalidDimension, ASPx.InvalidDimension, indexPath);
   this.DoShowPopupMenuBorderCorrector(element, clientX, clientY, indexPath, toTheLeft, toTheTop);
  }
 },
 StartScrolling: function(buttonId, delay, step) {
  var indexPath = this.GetScrollButtonIndexPathById(buttonId);
  var level = this.GetMenuLevel(indexPath);
  aspxGetMenuCollection().DoHidePopupMenus(null, level, this.name, false, "");
  var direction = (buttonId.lastIndexOf(Constants.SBDIdEnd) == buttonId.length - Constants.SBDIdEnd.length) ? 1 : -1;
  var scrollHelper = this.GetScrollHelper(indexPath);
  if(scrollHelper) scrollHelper.StartScrolling(direction, delay, step);
 },
 StopScrolling: function(buttonId) {
  var indexPath = this.GetScrollButtonIndexPathById(buttonId);
  var scrollHelper = this.GetScrollHelper(indexPath);
  if(scrollHelper) scrollHelper.StopScrolling();
 },
 ClearAppearTimer: function() {
  aspxGetMenuCollection().ClearAppearTimer();
 },
 ClearDisappearTimer: function() {
  aspxGetMenuCollection().ClearDisappearTimer();
 },
 IsAppearTimerActive: function() {
  return aspxGetMenuCollection().IsAppearTimerActive();
 },
 IsDisappearTimerActive: function() {
  return aspxGetMenuCollection().IsDisappearTimerActive();
 },
 IsAdaptiveItemAnimationActive: function() {
  return this.inSubmenuShowAnimation;
 },
 GetAppearAfter: function(indexPath) {
  return this.appearAfter;
 },
 SetAppearTimer: function(indexPath, preventSubMenu) {
  aspxGetMenuCollection().SetAppearTimer(this.name, indexPath, this.GetAppearAfter(indexPath), preventSubMenu);
 },
 GetDisappearAfter: function() {
  return this.disappearAfter;
 },
 SetDisappearTimer: function() {
  aspxGetMenuCollection().SetDisappearTimer(this.name, this.GetDisappearAfter());
 },
 IsDropDownItem: function(indexPath) {
  return ASPx.ElementContainsCssClass(this.GetItemElement(indexPath), MenuCssClasses.ItemDropDownMode);
 },
 DoItemClick: function(indexPath, hasItemLink, htmlEvent) {
  aspxGetMenuCollection().LockMenusVisibility();
  var processOnServer = this.RaiseItemClick(indexPath, htmlEvent);
  if(processOnServer && !hasItemLink) {
   if(ASPx.Browser.IE || ASPx.Browser.Edge) { 
    var activeElement = document.activeElement;
    if(activeElement)
     activeElement.blur();
   }
   this.SendPostBack("CLICK:" + indexPath);
  }
  else {
   this.ClearDisappearTimer();
   this.ClearAppearTimer();
   if(this.CanCloseSubMenuOnClick(indexPath) && (!this.HasChildren(indexPath) || this.IsDropDownItem(indexPath)))
    aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
   else if(this.IsItemEnabled(indexPath) && !this.IsDropDownItem(indexPath))
    this.ShowSubMenu(indexPath);
  }
  aspxGetMenuCollection().UnlockMenusVisibility();
 },
 CanCloseSubMenuOnClick: function(indexPath) {
  return true;
 },
 HasContent: function(mainCell) {
  for(var i = 0; i < mainCell.childNodes.length; i++)
   if(mainCell.childNodes[i].tagName)
    return true;
  return false;
 },
 DoShowPopupMenu: function(element, x, y, indexPath) {
  var parent = this.GetItemByIndexPath(indexPath);
  var menuElement = this.GetMenuMainElement(element);
  var popupMenuHasVisibleContent = menuElement && (this.renderHelper.HasSubMenuTemplate(menuElement) || 
   ASPx.ElementContainsCssClass(menuElement, this.getAdaptiveMenuCssClass())) ||
   parent && this.HasVisibleItems(parent);
  if(popupMenuHasVisibleContent === false)
   return;
  if(element && this.IsCallbacksEnabled())
   this.ShowLoadingPanelInMenu(element);
  if(ASPx.GetElementVisibility(element))
   ASPx.SetStyles(element, { left: ASPx.InvalidPosition, top: ASPx.InvalidPosition });
  ASPx.SetElementDisplay(element, true);
  if(parent) {
   for(var i = 0; i < parent.GetItemCount() ; i++) {
    var item = parent.GetItem(i);
    this.SetPopOutElementVisible(item.indexPath, this.HasVisibleItems(item));
   }
  }
  this.renderHelper.CalculateSubMenu(element, false);
  if(this.popupCount == 0) this.popupToLeft = this.rtl;
  this.RaisePopUp(indexPath);
  this.CalculateSubMenuPosition(element, x, y, indexPath, this.enableAnimation);
  aspxGetMenuCollection().RegisterVisiblePopupMenu(this.name, element.id);
  this.popupCount++;
  ASPx.GetControlCollection().AdjustControls(element);
  this.CorrectVerticalAlignment(ASPx.AdjustHeight, this.GetPopOutElements, "PopOut");
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetPopOutImages, "PopOutImg");
 },
 ShowLoadingPanelInMenu: function(element) {
  var lpParent = this.GetMenuMainElement(element);
  if(lpParent && !this.HasContent(lpParent))
   this.CreateLoadingPanelInsideContainer(lpParent);
 },
 GetScrollSubMenuYCorrection: function(element, scrollHelper, clientY) {
  var absoluteClientY = clientY + ASPx.GetPositionElementOffset(element);
  var excessTop = this.GetScrollExcessTop(absoluteClientY);
  var excessBottom = this.GetScrollExcessBottom(element, absoluteClientY);
  var correction = 0;
  if(excessTop > 0)
   correction += excessTop + this.scrollVertOffset;
  if(excessBottom > 0 && (absoluteClientY + correction == ASPx.GetDocumentScrollTop())) {
   excessBottom += this.scrollVertOffset;
   correction += this.scrollVertOffset;
  }
  this.PrepareScrolling(element, scrollHelper, excessTop, excessBottom);
  return correction;
 },
 GetScrollExcessTop: function(clientY) {
  return ASPx.GetDocumentScrollTop() - clientY;
 },
 GetScrollExcessBottom: function(element, clientY) {
  ASPx.SetElementDisplay(element, false);
  var docHeight = ASPx.GetDocumentClientHeight();
  ASPx.SetElementDisplay(element, true);
  return clientY + element.offsetHeight - ASPx.GetDocumentScrollTop() - docHeight;
 },
 PrepareScrolling: function(element, scrollHelper, excessTop, excessBottom) {
  scrollHelper.Initialize();
  var corrector = element.offsetHeight - scrollHelper.GetScrollAreaHeight() + this.scrollVertOffset;
  if(excessTop > 0)
   scrollHelper.Calculate(element.offsetHeight - excessTop - corrector);
  if(excessBottom > 0)
   scrollHelper.Calculate(element.offsetHeight - excessBottom - corrector);
 },
 ApplySubMenuFullWidth: function(element) {
  ASPx.SetStyles(element, { left: 0, right: 0, width: "auto" });
  var menuElement = this.GetMenuMainElement(element);
  ASPx.SetStyles(menuElement, { width: "100%", "box-sizing": "border-box" });
  var templateElement = ASPx.GetChildByClassName(menuElement, "dx");
  if(templateElement) ASPx.SetStyles(templateElement, { width: "100%" });
 },
 DoShowPopupMenuIFrame: function(element, x, y, width, height, indexPath) {
  if(!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(!iFrame) {
   iFrame = this.GetMenuIFrameElement(indexPath);
   element.overflowElement = iFrame;
  }
  if(iFrame) {
   var menuElement = this.GetMenuMainElement(element);
   if(width < 0)
    width = menuElement.offsetWidth;
   if(height < 0)
    height = menuElement.offsetHeight;
   ASPx.SetStyles(iFrame, {
    width: width, height: height,
    left: x, top: y, display: ""
   });
  }
 },
 DoShowPopupMenuBorderCorrector: function(element, x, y, indexPath, toTheLeft, toTheTop) {
  var borderCorrectorElement = this.GetMenuBorderCorrectorElement(indexPath);
  if(borderCorrectorElement) {
   var params = this.GetPopupMenuBorderCorrectorPositionAndSize(element, x, y, indexPath, toTheLeft, toTheTop);
   var itemCell = this.GetItemContentElement(indexPath);
   var popOutImageCell = this.GetItemPopOutElement(indexPath);
   if(ASPx.Browser.IE && ASPx.Browser.MajorVersion == 9) { 
    var isVertical = this.IsVertical(indexPath);
    var itemBoundCoord = itemCell.getBoundingClientRect()[isVertical ? 'bottom' : 'right'];
    var itemBorderWidth = ASPx.PxToInt(ASPx.GetCurrentStyle(itemCell)[isVertical ? 'borderBottomWidth' : 'borderRightWidth']);
    if(popOutImageCell != null) {
     var popOutImageBoundCoord = popOutImageCell.getBoundingClientRect()[isVertical ? 'bottom' : 'right'];
     if(popOutImageBoundCoord > itemBoundCoord) {
      itemBoundCoord = popOutImageBoundCoord;
      itemBorderWidth = ASPx.PxToInt(ASPx.GetCurrentStyle(popOutImageCell)[isVertical ? 'borderBottomWidth' : 'borderRightWidth']);
     }
    }
    var menu = this.GetMainElement();
    itemBoundCoord -= Math.min(menu.getBoundingClientRect()[isVertical ? 'top' : 'left'], ASPx.GetPositionElementOffset(menu, !isVertical));
    if(isVertical) {
     var bottomsDifference = this.GetItemElement(indexPath).getBoundingClientRect().bottom -
      this.GetMenuElement(indexPath).getBoundingClientRect().bottom;
     itemBoundCoord -= bottomsDifference > 0 && bottomsDifference;
    }
    var borderCorrectorBoundCoord = isVertical ? params.top + params.height : params.left + params.width;
    if(itemBoundCoord - borderCorrectorBoundCoord != itemBorderWidth) {
     borderCorrectorBoundCoord = itemBoundCoord - itemBorderWidth;
     if(isVertical)
      params.height = borderCorrectorBoundCoord - params.top;
     else
      params.width = borderCorrectorBoundCoord - params.left;
    }
   }
   ASPx.SetStyles(borderCorrectorElement, {
    width: params.width, height: params.height,
    left: params.left, top: params.top,
    display: "", visibility: "visible"
   });
   element.borderCorrectorElement = borderCorrectorElement;
  }
 },
 GetPopupMenuBorderCorrectorPositionAndSize: function(element, x, y, indexPath, toTheLeft, toTheTop) {
  var result = {};
  var itemInfo = new MenuItemInfo(this, indexPath);
  var menuXOffset = ASPx.GetClientLeft(this.GetMenuMainElement(element));
  var menuYOffset = ASPx.GetClientTop(this.GetMenuMainElement(element));
  var menuElement = this.GetMenuMainElement(element);
  var menuClientWidth = menuElement.clientWidth;
  var menuClientHeight = menuElement.clientHeight;
  if(this.IsVertical(indexPath)) {
   var commonClientHeight = itemInfo.clientHeight < menuClientHeight
    ? itemInfo.clientHeight
    : menuClientHeight;
   result.width = menuXOffset;
   result.height = commonClientHeight + itemInfo.clientTop - menuYOffset;
   result.left = x;
   if(toTheLeft)
    result.left += menuClientWidth + menuXOffset;
   result.top = y + menuYOffset;
   if(toTheTop)
    result.top += menuClientHeight - result.height;
  }
  else {
   var itemWidth = itemInfo.clientWidth;
   if(this.IsDropDownItem(indexPath))
    itemWidth = this.GetItemContentElement(indexPath).clientWidth;
   var commonClientWidth = itemWidth < menuClientWidth
    ? itemWidth
    : menuClientWidth;
   result.width = commonClientWidth + itemInfo.clientLeft - menuXOffset;
   result.height = menuYOffset;
   result.left = x + menuXOffset;
   if(toTheLeft)
    result.left += menuClientWidth - result.width;
   result.top = y;
   if(toTheTop)
    result.top += menuClientHeight + menuYOffset;
  }
  return result;
 },
 DoHidePopupMenu: function(evt, element) {
  this.DoHidePopupMenuBorderCorrector(element);
  this.DoHidePopupMenuIFrame(element);
  var menuElement = this.GetMenuMainElement(element);
  ASPx.PopupUtils.StopAnimation(element, menuElement);
  ASPx.SetElementVisibility(element, false);
  ASPx.SetElementDisplay(element, false);
  this.CancelSubMenuItemHoverItem(element);
  aspxGetMenuCollection().UnregisterVisiblePopupMenu(this.name, element.id);
  this.popupCount--;
  var indexPath = this.GetIndexPathById(element.id, true);
  this.DoResetScrolling(element, indexPath);
  this.RaiseCloseUp(indexPath);
 },
 DoResetScrolling: function(element, indexPath) {
  var scrollHelper = this.GetScrollHelper(indexPath);
  if(scrollHelper) {
   element.style.height = "";
   scrollHelper.ResetScrolling();
  }
 },
 DoHidePopupMenuIFrame: function(element) {
  if(!this.renderIFrameForPopupElements) return;
  var iFrame = element.overflowElement;
  if(iFrame)
   ASPx.SetElementDisplay(iFrame, false);
 },
 DoHidePopupMenuBorderCorrector: function(element) {
  var borderCorrectorElement = element.borderCorrectorElement;
  if(borderCorrectorElement) {
   ASPx.SetElementVisibility(borderCorrectorElement, false);
   ASPx.SetElementDisplay(borderCorrectorElement, false);
   element.borderCorrectorElement = null;
  }
 },
 MarkPrecedingItem: function(currentItemName, className, isItemNameUsed) {
  this.MarkPrecedingItemCore(currentItemName, className, true, isItemNameUsed);
 },
 UnmarkPrecedingItem: function(currentItemName, className, isItemNameUsed) {
  this.MarkPrecedingItemCore(currentItemName, className, false, isItemNameUsed);
 },
 MarkPrecedingItemCore: function(currentItemName, className, addClass, isItemNameUsed) {
  var previousItem = this.GetPreviousItem(currentItemName, isItemNameUsed);
  if(previousItem) {
   var element = this.GetItemElement(previousItem.indexPath);
   if(addClass)
    ASPx.AddClassNameToElement(element, className);
   else
    ASPx.RemoveClassNameFromElement(element, className);
  }
 },
 SetHoverElement: function(element) {
  if(!this.IsStateControllerEnabled()) return;
  this.lockHoverEvents = true;
  ASPx.GetStateController().SetCurrentHoverElementBySrcElement(element);
  this.lockHoverEvents = false;
 },
 ApplySubMenuItemHoverItem: function(element, hoverItem, hoverElement) {
  if(!element.hoverItem && ASPx.GetElementDisplay(element)) {
   var newHoverItem = hoverItem.Clone();
   element.hoverItem = newHoverItem;
   element.hoverElement = hoverElement;
   newHoverItem.Apply(hoverElement);
  }
 },
 CancelSubMenuItemHoverItem: function(element) {
  if(element.hoverItem) {
   element.hoverItem.Cancel(element.hoverElement);
   element.hoverItem = null;
   element.hoverElement = null;
  }
 },
 ShowSubMenu: function(indexPath) {
  var element = this.GetMenuElement(indexPath);
  if(element != null) {
   var level = this.GetMenuLevel(indexPath);
   aspxGetMenuCollection().DoHidePopupMenus(null, level - 1, this.name, false, this.getExceptIdsForShowSubMenu(indexPath, element.id));
   if(!this.isSubMenuElementVisible(element) && this.IsItemEnabled(indexPath))
    this.DoShowPopupMenu(element, ASPx.InvalidPosition, ASPx.InvalidPosition, indexPath);
  }
  this.ClearAppearTimer();
 },
 getExceptIdsForShowSubMenu: function (itemIndexPath, exceptId) {
  return [exceptId];
 },
 isSubMenuElementVisible: function(subMenuElement) {
  return ASPx.GetElementDisplay(subMenuElement);
 },
 SelectItem: function(indexPath) {
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetItemContentElement(indexPath);
  if(element != null) {
   ASPx.GetStateController().SelectElementBySrcElement(element);
   if(this.sideMenuModeOn)
    this.MarkPrecedingItem(indexPath, PRE_SELECTED_ELEMENT_CLASS_NAME, false);
  }
 },
 DeselectItem: function(indexPath) {
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetItemContentElement(indexPath);
  if(element != null) {
   var hoverItem = null;
   var hoverElement = null;
   var menuElement = this.GetMenuElement(indexPath);
   if(menuElement && menuElement.hoverItem) {
    hoverItem = menuElement.hoverItem;
    hoverElement = menuElement.hoverElement;
    this.CancelSubMenuItemHoverItem(menuElement);
   }
   ASPx.GetStateController().DeselectElementBySrcElement(element);
   if(menuElement != null && hoverItem != null)
    this.ApplySubMenuItemHoverItem(menuElement, hoverItem, hoverElement);
   if(this.sideMenuModeOn)
    this.UnmarkPrecedingItem(indexPath, PRE_SELECTED_ELEMENT_CLASS_NAME, false);
  }
 },
 InitializeSelectedItem: function() {
  if(!this.allowSelectItem && !this.HasServerSideSelectedItem()) return;
  this.SelectItem(this.GetSelectedItemIndexPath());
  this.InitializeServerSideSelectedItem();
 },
 InitializeServerSideSelectedItem: function() {
  if(!this.allowSelectItem && this.sideMenuModeOn && this.HasServerSideSelectedItem())
   this.MarkPrecedingItem(this.serverSideSelectedItemPath, PRE_SELECTED_ELEMENT_CLASS_NAME, false);
 },
 HasServerSideSelectedItem: function() {
  return typeof (this.serverSideSelectedItemPath) !== "undefined";
 },
 GetSelectedItemIndexPath: function() {
  return this.selectedItemIndexPath;
 },
 SetSelectedItemInternal: function(indexPath, modifyHotTrackSelection) {
  if(modifyHotTrackSelection)
   this.SetHoverElement(null);
  this.DeselectItem(this.selectedItemIndexPath);
  this.selectedItemIndexPath = indexPath;
  var item = this.GetItemByIndexPath(indexPath);
  if(item == null || item.GetEnabled())
   this.SelectItem(this.selectedItemIndexPath);
  if(modifyHotTrackSelection) {
   var element = this.GetItemContentElement(indexPath);
   if(element != null)
    this.SetHoverElement(element);
  }
 },
 InitializeCheckedItems: function() {
  if(!this.allowCheckItems) return;
  var indexPathes = this.checkedState.split(";");
  for(var i = 0; i < indexPathes.length; i++) {
   if(indexPathes[i] != "") {
    this.checkedItems.push(indexPathes[i]);
    this.SelectItem(indexPathes[i]);
   }
  }
 },
 ChangeCheckedItem: function(indexPath) {
  this.SetHoverElement(null);
  var itemsGroup = this.GetItemsGroup(indexPath);
  if(itemsGroup != null) {
   if(itemsGroup.length > 1) {
    if(!this.IsCheckedItem(indexPath)) {
     for(var i = 0; i < itemsGroup.length; i++) {
      if(itemsGroup[i] == indexPath) continue;
      if(this.IsCheckedItem(itemsGroup[i])) {
       ASPx.Data.ArrayRemove(this.checkedItems, itemsGroup[i]);
       this.DeselectItem(itemsGroup[i]);
      }
     }
     this.SelectItem(indexPath);
     this.checkedItems.push(indexPath);
    }
   }
   else {
    if(this.IsCheckedItem(indexPath)) {
     ASPx.Data.ArrayRemove(this.checkedItems, indexPath);
     this.DeselectItem(indexPath);
    }
    else {
     this.SelectItem(indexPath);
     this.checkedItems.push(indexPath);
    }
   }
  }
  var element = this.GetItemContentElement(indexPath);
  if(element != null)
   this.SetHoverElement(element);
 },
 GetItemsGroup: function(indexPath) {
  for(var i = 0; i < this.itemCheckedGroups.length; i++) {
   if(ASPx.Data.ArrayIndexOf(this.itemCheckedGroups[i], indexPath) > -1)
    return this.itemCheckedGroups[i];
  }
  return null;
 },
 IsCheckedItem: function(indexPath) {
  return ASPx.Data.ArrayIndexOf(this.checkedItems, indexPath) > -1;
 },
 UpdateStateObject: function(){
  this.UpdateStateObjectWithObject({ selectedItemIndexPath: this.selectedItemIndexPath, checkedState: this.GetCheckedState() });
 },
 GetCheckedState: function() {
  var state = "";
  for(var i = 0; i < this.checkedItems.length; i++) {
   state += this.GetCheckedItemInfo(this.checkedItems[i]);
   if(i < this.checkedItems.length - 1)
    state += ";";
  }
  return state;
 },
 GetCheckedItemInfo: function(itemIndexPath) {
  return itemIndexPath;
 },
 GetAnimationVerticalDirection: function(indexPath, popupPosition, isVertical) {
  var verticalDirection = (this.IsRootItem(indexPath) && !isVertical) ? -1 : 0;
  if(popupPosition.isInverted) verticalDirection *= -1;
  return verticalDirection;
 },
 GetAnimationHorizontalDirection: function(indexPath, popupPosition, isVertical) {
  var horizontalDirection = (this.IsRootItem(indexPath) && !isVertical) ? 0 : -1;
  if(popupPosition.isInverted) horizontalDirection *= -1;
  return horizontalDirection;
 },
 StartAnimation: function(animationDivElement, indexPath, horizontalPopupPosition, verticalPopupPosition, isVertical) {
  this.inSubmenuShowAnimation = true;
  var element = this.GetMenuMainElement(animationDivElement);
  var clientX = horizontalPopupPosition.position;
  var clientY = verticalPopupPosition.position;
  ASPx.PopupUtils.InitAnimationDiv(animationDivElement, clientX, clientY, this.OnAnimationFinished.aspxBind(this), false);
  var verticalDirection = this.GetAnimationVerticalDirection(indexPath, verticalPopupPosition, isVertical);
  var horizontalDirection = this.GetAnimationHorizontalDirection(indexPath, horizontalPopupPosition, isVertical);
  var yPos = verticalDirection * element.offsetHeight;
  var xPos = horizontalDirection * element.offsetWidth;
  ASPx.SetStyles(element, { left: xPos, top: yPos });
  ASPx.SetElementVisibility(animationDivElement, true);
  if(this.enableSubMenuFullWidth)
   this.ApplySubMenuFullWidth(animationDivElement);
  this.DoShowPopupMenuIFrame(animationDivElement, clientX, clientY, 0, 0, indexPath);
  this.DoShowPopupMenuBorderCorrector(animationDivElement, clientX, clientY, indexPath,
   horizontalPopupPosition.isInverted, verticalPopupPosition.isInverted);
  ASPx.PopupUtils.StartSlideAnimation(animationDivElement, element, this.GetMenuIFrameElement(indexPath), this.slideAnimationDuration, this.enableSubMenuFullWidth, false);
 },
 OnAnimationFinished: function() {
  window.setTimeout(function() { this.inSubmenuShowAnimation = false; }.aspxBind(this), 100);
 },
 OnItemClick: function(indexPath, evt) {
  var sourceElement = ASPx.Evt.GetEventSource(evt);
  var clickedLinkElement = ASPx.GetParentByTagName(sourceElement, "A");
  var isLinkClicked = (clickedLinkElement != null && clickedLinkElement.href != ASPx.AccessibilityEmptyUrl);
  var element = this.GetItemContentElement(indexPath);
  var linkElement = (element != null) ? (element.tagName === "A" ? element : ASPx.GetNodeByTagName(element, "A", 0)) : null;
  if(linkElement != null && linkElement.href == ASPx.AccessibilityEmptyUrl)
   linkElement = null;
  if(this.allowSelectItem)
   this.SetSelectedItemInternal(indexPath, true);
  if(this.allowCheckItems || this.canCheckItem(element))
   this.ChangeCheckedItem(indexPath);
  this.DoItemClick(indexPath, isLinkClicked || (linkElement != null), evt);
  if(!isLinkClicked && linkElement != null && !(ASPx.Browser.WebKitTouchUI && this.HasChildren(indexPath)))
   ASPx.Url.NavigateByLink(linkElement);
 },
 canCheckItem: function (itemElement) {
  return false;
 },
 OnItemDropDownClick: function(indexPath, evt) {
  if(this.IsItemEnabled(indexPath)) {
   if(this.IsAdaptiveItem(indexPath))
    this.toggleAdaptiveSubmenu(indexPath);
   else
    this.keyboardHelper.ShowSubMenuAccessible(indexPath);
  }
 },
 toggleAdaptiveSubmenu: function(indexPath) {
  var element = this.GetMenuElement(indexPath);
  if(ASPx.GetElementDisplay(element) && !this.IsAdaptiveItemAnimationActive())
   this.DoHidePopupMenu(null, element);
  else
   this.keyboardHelper.ShowSubMenuAccessible(indexPath);
 },
 AfterItemOverAllowed: function(hoverItem) {
  return hoverItem.name != "" && !this.lockHoverEvents;
 },
 OnAfterItemOver: function(hoverItem, hoverElement) {
  if(!this.AfterItemOverAllowed(hoverItem)) return;
  if(!this.showSubMenus) {
   this.savedCallbackHoverItem = hoverItem;
   this.savedCallbackHoverElement = hoverElement;
   return;
  }
  this.ClearDisappearTimer();
  this.ClearAppearTimer();
  var indexPath = this.GetMenuIndexPathById(hoverItem.name);
  if(indexPath == "") {
   indexPath = this.GetItemIndexPathById(hoverItem.name);
   var canShowSubMenu = true;
   if(this.IsDropDownItem(indexPath)) {
    var popOutImageElement = this.GetItemPopOutElement(indexPath);
    if(popOutImageElement != null && popOutImageElement != hoverElement) {
     hoverItem.needRefreshBetweenElements = true;
     canShowSubMenu = false;
    }
   }
   var preventSubMenu = !(canShowSubMenu && hoverItem.enabled && hoverItem.kind == ASPx.HoverItemKind);
   this.SetAppearTimer(indexPath, preventSubMenu);
   this.RaiseItemMouseOver(indexPath);
  }
 },
 OnBeforeItemOver: function(hoverItem, hoverElement) {
  if(ASPx.Browser.NetscapeFamily && ASPx.IsExists(hoverElement.offsetParent) &&
    hoverElement.offsetParent.style.borderCollapse == "collapse") {
   hoverElement.offsetParent.style.borderCollapse = "separate";
   hoverElement.offsetParent.style.borderCollapse = "collapse";
  }
  var indexPath = this.GetItemIndexPathById(hoverItem.name);
  var element = this.GetMenuElement(indexPath);
  if(element) this.CancelSubMenuItemHoverItem(element);
 },
 OnItemOverTimer: function(indexPath, preventSubMenu) {
  var element = this.GetMenuElement(indexPath);
  if(element == null || preventSubMenu) {
   var level = this.GetMenuLevel(indexPath);
   aspxGetMenuCollection().DoHidePopupMenus(null, level - 1, this.name, false, this.getExceptIdsForItemOverTimer(indexPath));
  }
  if(this.IsAppearTimerActive() && !preventSubMenu) {
   this.ClearAppearTimer();
   if(this.GetItemContentElement(indexPath) != null || this.GetItemPopOutElement(indexPath) != null) {
    this.ShowSubMenu(indexPath);
   }
  }
 },
 getExceptIdsForItemOverTimer: function (indexPath) { return [""]; },
 OnBeforeItemDisabled: function(disabledItem, disabledElement) {
  this.ClearAppearTimer();
  var indexPath = this.GetItemIndexPathById(disabledElement.id);
  if(indexPath != "") {
   var element = this.GetMenuElement(indexPath);
   if(element != null) this.DoHidePopupMenu(null, element);
  }
 },
 OnAfterItemOut: function(hoverItem, hoverElement, newHoverElement) {
  if(!this.showSubMenus) {
   this.savedCallbackHoverItem = null;
   this.savedCallbackHoverElement = null;
  }
  if(hoverItem.name == "" || this.lockHoverEvents) return;
  if(hoverItem.IsChildElement(newHoverElement)) return;
  var indexPath = this.GetItemIndexPathById(hoverItem.name);
  var element = this.GetMenuElement(indexPath);
  this.ClearDisappearTimer();
  this.ClearAppearTimer();
  if(element == null || !ASPx.GetIsParent(element, newHoverElement))
   this.SetDisappearTimer();
  if(element != null)
   this.ApplySubMenuItemHoverItem(element, hoverItem, hoverElement);
  if(indexPath != "")
   this.RaiseItemMouseOut(indexPath);
 },
 OnItemOutTimer: function() {
  if(this.IsDisappearTimerActive()) {
   this.ClearDisappearTimer();
   if(aspxGetMenuCollection().CheckFocusedElement())
    this.SetDisappearTimer();
   else
    this.OnHideByItemOut();
  }
 },
 OnHideByItemOut: function() {
  aspxGetMenuCollection().DoHidePopupMenus(null, 0, this.name, true, "");
 },
 TryFocusItem: function(itemIndex) {
  var item = this.GetItem(itemIndex);
  if(item.GetVisible() && item.GetEnabled()) {
   this.FocusItemByIndexPath(item.GetIndexPath());
   return true;
  }
  return false;
 },
 Focus: function() {
  if(this.rootItem != null) { 
   for(var i = 0; i < this.GetItemCount() ; i++) {
    if(this.TryFocusItem(i))
     return true;
   }
  }
  else
   this.keyboardHelper.FocusNextItem("-1");
 },
 FocusLastItem: function() {
  if(this.rootItem != null) { 
   for(var i = this.GetItemCount() - 1; i >= 0; i--) {
    if(this.TryFocusItem(i))
     return true;
   }
  }
  else
   this.keyboardHelper.FocusPrevItem(this.GetItemCount() - 1);
 },
 FocusItemByIndexPath: function(indexPath) {
  this.keyboardHelper.FocusItemByIndexPath(indexPath);
 },
 OnFocusedItemKeyDown: function(evt, focusedItem) {
  this.keyboardHelper.OnFocusedItemKeyDown(evt, focusedItem);
 },
 ProcessLostFocus: function(evt) {
  if(!this.isContextMenu || !this.accessibilityCompliant) return;
  if(this.accessibleFocusElement)
   this.accessibleFocusElement.focus();
  this.Hide();
  if(evt)
   ASPx.Evt.PreventEventAndBubble(evt);
 },
 OnCallback: function(result) {
  ASPx.InitializeScripts(); 
  this.InitializeScrollableMenus();
  for (var indexPath in result) {
   if(result.hasOwnProperty(indexPath)) {
    var menuElement = this.GetMenuElement(indexPath);
    if(menuElement) {
     var menuResult = result[indexPath];
     if(aspxGetMenuCollection().IsSubMenuVisible(menuElement.id))
      this.ShowPopupSubMenuAfterCallback(menuElement, menuResult);
     else
      this.SetSubMenuInnerHtml(menuElement, menuResult);
    }
   }
  }
  this.ClearVerticalAlignedElementsCache();
  this.CorrectVerticalAlignment(ASPx.AdjustHeight, this.GetPopOutElements, "PopOut");
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetPopOutImages, "PopOutImg");
  this.InitializeInternal(false);
  if(!this.showSubMenus) {
   this.showSubMenus = true;
   if(this.savedCallbackHoverItem != null && this.savedCallbackHoverElement != null)
    this.OnAfterItemOver(this.savedCallbackHoverItem, this.savedCallbackHoverElement);
   this.savedCallbackHoverItem = null;
   this.savedCallbackHoverElement = null;
  }
 },
 SetSubMenuInnerHtml: function(menuElement, html) {
  ASPx.SetInnerHtml(this.GetMenuMainElement(menuElement), html);
  this.dropElementsCache = true;
  this.renderHelper.InlineInitializePopupMenuMenuElement(menuElement, this.GetIndexPathById(menuElement.id, true));
  this.renderHelper.CalculateSubMenu(menuElement, true);
 },
 ShowPopupSubMenuAfterCallback: function(element, callbackResult) {
  var indexPath = this.GetIndexPathById(element.id, true);
  var currentX = ASPx.PxToInt(element.style.left);
  var currentY = ASPx.PxToInt(element.style.top);
  var showedToTheTop = this.ShowedToTheTop(element, indexPath);
  var showedToTheLeft = this.ShowedToTheLeft(element, indexPath);
  ASPx.SetStyles(element, {
   left: ASPx.InvalidPosition, top: ASPx.InvalidPosition
  });
  this.SetSubMenuInnerHtml(element, callbackResult);
  var vertPos = this.GetClientSubMenuPos(element, indexPath, ASPx.InvalidPosition, this.IsVertical(indexPath), false);
  var clientY = vertPos.position;
  var toTheTop = vertPos.isInverted;
  if(!this.IsVertical(indexPath) && showedToTheTop != toTheTop) {
   clientY = currentY;
   toTheTop = showedToTheTop;
  }
  clientY += this.GetScrollingCorrection(element, indexPath, clientY);
  ASPx.SetStyles(element, { left: currentX, top: clientY });
  if(this.enableSubMenuFullWidth)
   this.ApplySubMenuFullWidth(element);
  this.DoShowPopupMenuIFrame(element, currentX, clientY, ASPx.InvalidDimension, ASPx.InvalidDimension, indexPath);
  this.DoShowPopupMenuBorderCorrector(element, currentX, clientY, indexPath, showedToTheLeft, toTheTop);
  ASPx.GetControlCollection().AdjustControls(element);
 },
 GetScrollingCorrection: function(element, indexPath, clientY) {
  var scrollHelper = this.GetScrollHelper(indexPath);
  if(scrollHelper) {
   var yClientCorrection = this.GetScrollSubMenuYCorrection(element, scrollHelper, clientY);
   if(yClientCorrection > 0)
    return yClientCorrection;
  }
  return 0;
 },
 ShowedToTheTop: function(element, indexPath) {
  var currentY = ASPx.PxToInt(element.style.top);
  var parentBottomY = this.GetSubMenuYPosition(indexPath, this.IsVertical(indexPath));
  return currentY < parentBottomY;
 },
 ShowedToTheLeft: function(element, indexPath) {
  var currentX = ASPx.PxToInt(element.style.left);
  var parentX = this.GetSubMenuXPosition(indexPath, this.IsVertical(indexPath));
  return currentX < parentX;
 },
 CreateItems: function(items) {
  if (items.length == 0)
   return;
  if(this.NeedCreateItemsOnClientSide())
   this.CreateClientItems(items);
  else
   this.CreateServerItems(items);
 },
 AddItem: function(item) {
  this.CreateClientItems([item]);
 },
 CreateClientItems: function(items) {
  this.PreInitializeClientMenuItems();
  this.rootItem.CreateItems(items);
  this.RenderItems(this.rootItem.items);
  this.InitializeClientItems();
 },
 CreateServerItems: function(items) {
  this.CreateRootItemIfRequired();
  this.rootItem.CreateItems(items);
 },
 PreInitializeClientMenuItems: function() {
  if(!this.rootMenuSample)
   this.InitializeMenuSamples();
  this.CreateRootItemIfRequired();
  if(!this.renderData)
   this.CreateRenderData();
 },
 InitializeClientItems: function() {
  this.dropElementsCache = true;
  this.renderHelper.InlineInitializeElements();
  this.ApplyItemsProperties(this.rootItem.items);
  this.InitializeEnabledAndVisible(true);
  if(this.isPopupMenu)
   this.renderHelper.CalculateSubMenu(this.GetMainElement(), true);
  else
   this.renderHelper.CalculateMenuControl(this.GetMainElement(), true);
 },
 ApplyItemsProperties: function(items) {
  var itemsCount = items.length;
  if(itemsCount == 0)
   return;
  for(var i = 0; i < itemsCount; i++) {
   var item = items[i];
   this.ApplyItemProperties(item);
   this.ApplyItemsProperties(item.items);
  }
 },
 ApplyItemProperties: function(item) {
  var indexPath = item.GetIndexPath();
  if(item.imageUrl)
   this.SetItemImageUrl(indexPath, item.imageUrl);
  if(item.imageClassName) {
   this.AddItemImageClassName(indexPath, item.imageClassName);
   this.AddItemAdditionalImageClassName(indexPath, item.imageClassName);
  }
  if(item.navigateUrl)
   this.SetItemNavigateUrl(indexPath, item.navigateUrl, item.target);
  if(item.tooltip != "")
   this.SetItemTooltip(indexPath, item.tooltip);
  this.FindTextNode(indexPath).parentNode.innerHTML = this.HtmlEncode(item.text);
  this.SetItemChecked(indexPath, item.checked);
  if(item.textTemplate)
   this.SetItemTextTemplate(indexPath, item.textTemplate);
 },
 ProcessItemGroupName: function(item, groupName) {
  if(this.allowSelectItem || !groupName)
   return;
  this.allowCheckItems = true;
  var groupNames = this.itemCheckedGroups.groupNames;
  if(groupNames[groupName])
   groupNames[groupName].push(item.indexPath);
  else {
   groupNames[groupName] = [item.indexPath];
   this.itemCheckedGroups.push(groupNames[groupName]);
  }
  item.checkedGroup = groupNames[groupName];
 },
 CreateRootItemIfRequired: function() {
  if(!this.rootItem) {
   var itemType = this.GetClientItemType();
   this.rootItem = new itemType(this, null, 0, "");
  }
 },
 ClearRootMenuElement: function() {
  var wrapperElement = this.GetMainElement().parentNode;
  wrapperElement.innerHTML = "";
  wrapperElement.appendChild(this.rootMenuSample.cloneNode(true));
  this.renderHelper.InlineInitializeScrollElements("", this.GetMainElement());
 }, 
 NeedAppendToRenderData: function(item) {
  return this.NeedCreateItemsOnClientSide() && item.visible || typeof(item.visible) == "undefined";
 },
 ClearItems: function() {
  this.PreInitializeClientMenuItems();
  this.ClearRootMenuElement();
  this.ClearRenderData();
  this.rootItem.items = [];
  this.checkedItems = [];
 },
 GetSampleNode: function(sampleHtml) {
  return ASPx.CreateHtmlElementFromString(sampleHtml);
 },
 GetParentItem: function(rootItemIndexPath) {
  if(!rootItemIndexPath)
   return this.rootItem;
  return this.GetItemByIndexPath(rootItemIndexPath);
 },
 RenderItems: function(items) {
  for(var i=0; i < items.length; i++) {
   var item = items[i];
   this.RenderItemIfRequired(item);
   this.RenderItems(item.items);
  }
 },
 RenderItemIfRequired: function(item) {
  if(!this.GetItemElement(item.indexPath)) {
   var isRootItem = !this.GetItemElement(item.parent.indexPath);
   var rootMenuElement = this.GetOrRenderRootItem(item, isRootItem);
   this.RenderItemInternal(rootMenuElement, item, isRootItem);
   this.ApplyStylesToRenderItem(item, isRootItem);
  }
 },
 ApplyStylesToRenderItem: function(item, isRootItem) {
  var styles = JSON.parse(JSON.stringify(isRootItem ? this.samples.itemsStyles : this.samples.subitemsStyles));
  var hoverStyle = styles.hover;
  var disabledStyle = styles.disable;
  var selectedStyle = styles.select;
  var checkedStyle = styles.check;
  var itemElementId = this.GetItemElementId(item.indexPath);
  if(item.styles && item.styles.ho) {
   var itemHover = item.styles.ho;
   if(!!itemHover.style)
    hoverStyle.cssTexts[0] = itemHover.style;
   if(!!itemHover.cssClass)
    hoverStyle.classNames[0] += " " + itemHover.cssClass;
  }
  if(item.styles && item.styles.st) {
   var itemElement = this.GetItemElement(item.indexPath);
   var style = item.styles.st;
   itemElement.setAttribute("style", style.style);
   if(!!style.cssClass)
    ASPx.AddClassNameToElement(itemElement, style.cssClass);
  }
  ASPx.GetStateController().AddHoverItem(itemElementId, hoverStyle.classNames || [MenuCssClasses.ItemHovered], hoverStyle.cssTexts || [""], hoverStyle.postfixes || [""], item.imageHottrackSrc ? [item.imageHottrackSrc] : null, [Constants.ImagePostfix, Constants.PopupImagePostfix], false);
  ASPx.GetStateController().AddDisabledItem(itemElementId, disabledStyle.classNames || [MenuCssClasses.Disabled], disabledStyle.cssTexts || [""], disabledStyle.postfixes || [""], null, null, false);
  if(selectedStyle && this.allowSelectItem)
   ASPx.GetStateController().AddSelectedItem(itemElementId, selectedStyle.classNames || [MenuCssClasses.ItemSelected], selectedStyle.cssTexts || [""], selectedStyle.postfixes || [""], null, null, false);
  else if (checkedStyle && this.allowCheckItems && item.checkedGroup.length) {
   var checkedClassName = null;
   if(!item.imageClassName)
    checkedClassName = [this.samples.checkedClassName];
   ASPx.GetStateController().AddSelectedItem(itemElementId, checkedStyle.classNames || [MenuCssClasses.ItemChecked], checkedStyle.cssTexts || [""], checkedStyle.postfixes || [""], checkedClassName, ['Img'], false);
  }
 },
 GetOrRenderRootItem: function(item, isRootItem) {
  if(!isRootItem) {
   var rootMenuElement = this.GetMenuElement(item.parent.indexPath);
   return rootMenuElement ? rootMenuElement : this.RenderSubMenuItem(item.parent.indexPath);
  } else
   return this.GetMenuElement("");
 },
 RenderItemInternal: function(rootItem, item, isRootItem) {
  var contentElement = this.renderHelper.GetContentElement(rootItem);
  var element = this.CreateItemElement(item, isRootItem);
  this.RenderSeparatorElementIfRequired(contentElement, item);
  this.RenderSpaceElementIfRequired(contentElement, item);
  contentElement.appendChild(element);
 },
 RenderSeparatorElementIfRequired: function(rootItem, item) {
  if(item.beginGroup && item.index > 0) {
   var separatorElement = this.CreateSeparatorElement(item.indexPath);
   rootItem.appendChild(separatorElement);
  }
 },
 RenderSpaceElementIfRequired: function(rootItem, item) {
  if(!item.beginGroup && item.index > 0 && rootItem.childNodes.length > 0) {
   if(this.samples.spacing) {
    var spacingElement = this.CreateSpacingElement(item.indexPath);
    rootItem.appendChild(spacingElement);
   }
  }
 },
 RenderSubMenuItem: function(indexPath) {
  var subMenuElement = this.CreateSubMenuElement(indexPath);
  this.GetMainElement().parentElement.appendChild(subMenuElement);
  return subMenuElement;
 },
 HasSeparatorOnCurrentPosition: function(itemElements, position) {
  return itemElements[position - 1 > 0 ? position - 1 : 0].className.indexOf(MenuCssClasses.Separator) > -1;
 },
 CreateItemElement: function(item, isRootItem) {
  var itemSample = isRootItem ? this.GetRootItemSample(item) : this.GetSubitemSample(item);
  var itemElement = itemSample.cloneNode(true);
  itemElement.id = this.GetItemElementId(item.indexPath);
  return itemElement;
 },
 GetRootItemSample: function(item) {
  return this.GetItemSample(this.samples.rootItems, item);
 },
 GetSubitemSample: function(item) {
  return this.GetItemSample(this.samples.submenuItems, item);
 },
 GetItemSample: function(samples, item) {
  var key = this.sampleItemsFlags.TextOnly;
  if(item.items.length > 0)
   key = key | this.sampleItemsFlags.SubItems;
  if(item.imageUrl)
   key = key | this.sampleItemsFlags.Image;
  if(item.navigateUrl)
   key = key | this.sampleItemsFlags.NavigateUrl;
  if(item.dropDownMode)
   key = key | this.sampleItemsFlags.DropDownMode;
  if(item.checkedGroup.length)
   key = key | this.sampleItemsFlags.CheckBox;
  if(item.imageClassName)
   key = key | this.sampleItemsFlags.ImageClassName;
  if(item.isSvg)
   key = key | this.sampleItemsFlags.Svg;
  return samples[key];
 },
 CreateSpacingElement: function(indexPath) {
  var item = this.samples.spacing.cloneNode();
  item.id = this.GetItemIndentElementId(indexPath);
  return item;
 },
 CreateSeparatorElement: function(indexPath) {
  var item = this.samples.separator.cloneNode(true);
  item.id = this.GetItemSeparatorElementId(indexPath);
  return item;
 },
 CreateSubMenuElement: function(indexPath) {
  var subMenu = this.samples.submenu.cloneNode(true);
  subMenu.id =  this.name + Constants.MMIdSuffix + indexPath + "_";
  return subMenu;
 },
 AppendToRenderData: function(rootItemIndexPath, index) {
  if(rootItemIndexPath) {
   if(!this.renderData[rootItemIndexPath])
    this.renderData[rootItemIndexPath] = [[index]];
   this.renderData[rootItemIndexPath][index] = [index];
  } else {
   this.renderData[""].push([[index]]);
  }
 },
 CreateRenderData: function() {
  this.renderData = {"" : []};
 },
 ClearRenderData: function() {
  this.renderData = null;
 },
 GetClientItemType: function() {
  return ASPxClientMenuItem;
 },
 GetItemByIndexPath: function(indexPath) {
  var item = this.rootItem;
  if(indexPath != "" && item != null) {
   var indexes = this.GetItemIndexes(indexPath);
   for(var i = 0; i < indexes.length; i++)
    item = item.GetItem(indexes[i]);
  }
  return item;
 },
 GetLinkElementByIndexPath: function(indexPath) {
  var itemElement = this.GetItemElement(indexPath);
  return this.renderHelper.GetItemLinkElement(itemElement);
 },
 SetItemChecked: function(indexPath, checked) {
  var itemsGroup = this.GetItemsGroup(indexPath);
  if(itemsGroup != null) {
   if(!checked && this.IsCheckedItem(indexPath)) {
    ASPx.Data.ArrayRemove(this.checkedItems, indexPath);
    this.DeselectItem(indexPath);
   }
   else if(checked && !this.IsCheckedItem(indexPath)) {
    if(itemsGroup.length > 1) {
     for(var i = 0; i < itemsGroup.length; i++) {
      if(itemsGroup[i] == indexPath) continue;
      if(this.IsCheckedItem(itemsGroup[i])) {
       ASPx.Data.ArrayRemove(this.checkedItems, itemsGroup[i]);
       this.DeselectItem(itemsGroup[i]);
      }
     }
    }
    this.SelectItem(indexPath);
    this.checkedItems.push(indexPath);
   }
   if(this.accessibilityCompliant) {
    var link = this.GetLinkElementByIndexPath(indexPath);
    if(link)
     ASPx.Attr.SetAttribute(link, "aria-checked", checked ? "true" : "false");
   }
  }
 },
 ChangeItemEnabledAttributes: function(indexPath, enabled) {
  this.renderHelper.ChangeItemEnabledAttributes(this.GetItemElement(indexPath), enabled, this.accessibilityCompliant);
 },
 IsItemEnabled: function(indexPath) {
  var item = this.GetItemByIndexPath(indexPath);
  return (item != null) ? item.GetEnabled() : true;
 },
 SetItemEnabled: function(indexPath, enabled, initialization) {
  if(indexPath == "" || !this.GetItemByIndexPath(indexPath).enabled) return;
  if(!enabled) {
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.DeselectItem(indexPath);
  }
  if(!initialization || !enabled)
   this.ChangeItemEnabledStateItems(indexPath, enabled);
  this.ChangeItemEnabledAttributes(indexPath, enabled);
  if(enabled) {
   if(this.GetSelectedItemIndexPath() == indexPath)
    this.SelectItem(indexPath);
  }
 },
 ChangeItemEnabledStateItems: function(indexPath, enabled) {
  if(!this.IsStateControllerEnabled()) return;
  var element = this.GetItemElement(indexPath);
  if(element)
   ASPx.GetStateController().SetElementEnabled(element, enabled);
 },
 GetItemImageUrl: function(indexPath) {
  var image = this.GetItemImage(indexPath);
  if(image)
   return image.src;
  return "";
 },
 SetItemImageUrl: function(indexPath, url) {
  var image = this.GetItemImage(indexPath);
  if(image)
   image.src = url;
 },
 AddItemImageClassName: function(indexPath, className) {
  var image = this.GetItemImage(indexPath);
  if(image) {
   var accessibilityElement = image.parentNode;
   if(accessibilityElement.tagName == "SPAN")
    ASPx.AddClassNameToElement(accessibilityElement, className);
   else
    ASPx.AddClassNameToElement(image, className);
  }
  else {
   var svgElement = this.getSvgElement(indexPath);
   if(svgElement) {
    ASPx.AddClassNameToElement(svgElement, className);
    var useElement = ASPx.GetNodeByTagName(svgElement, "use", 0);
    useElement.setAttributeNS('http://www.w3.org/1999/xlink', 'href', "#" + className);
   }
  }
 },
 AddItemAdditionalImageClassName: function(indexPath) {
 },
 getSvgElement: function(indexPath) {
  var element = this.GetItemContentElement(indexPath);
  if(element != null) {
   var svgElement = ASPx.GetNodeByTagName(element, "svg", 0);
   if(svgElement != null) {
    return svgElement;
   }
  }
 },
 GetItemImage: function(indexPath) {
  var element = this.GetItemContentElement(indexPath);
  if(element != null) {
   var img = ASPx.GetNodeByTagName(element, "IMG", 0);
   if(img != null)
    return img;
  }
 },
 GetItemNavigateUrl: function(indexPath) {
  var element = this.GetItemContentElement(indexPath);
  if(element != null && element.tagName === "A")
   return ASPx.Attr.GetAttribute(element, "savedhref") || element.href;
  if(element != null) {
   var link = ASPx.GetNodeByTagName(element, "A", 0);
   if(link != null)
    return ASPx.Attr.GetAttribute(link, "savedhref") || link.href;
  }
  return "";
 },
 SetUrl: function(link, url, target) {
  if(link != null) {
   if(ASPx.Attr.IsExistsAttribute(link, "savedhref"))
    ASPx.Attr.SetAttribute(link, "savedhref", url);
   else if(ASPx.Attr.IsExistsAttribute(link, "href"))
    link.href = url;
   if(!!target)
    link.target = target;
  }
 },
 SetItemNavigateUrl: function(indexPath, url, target) {
  var element = this.GetItemContentElement(indexPath);
  if(element != null) {
   if(element.tagName === "A")
    this.SetUrl(element, url, target);
   else {
    this.SetUrl(ASPx.GetNodeByTagName(element, "A", 0), url, target);
    this.SetUrl(ASPx.GetNodeByTagName(element, "A", 1), url, target);
   }
  }
 },
 FindTextNode: function(indexPath) {
  var contentElement = this.GetItemContentElement(indexPath);
  if(contentElement) {
   var link = this.GetLinkElementByIndexPath(indexPath);
   if(link)
    return ASPx.GetNormalizedTextNode(link);
   var spans = contentElement.querySelectorAll("span"),
    titleSpan = spans[spans.length - 1];
   if(titleSpan)
    return ASPx.GetNormalizedTextNode(titleSpan);
   return ASPx.GetNormalizedTextNode(contentElement);
  }
  return null;
 },
 GetItemText: function(indexPath) {
  var textNode = this.FindTextNode(indexPath);
  return textNode
   ? ASPx.Str.Trim(textNode.nodeValue) 
   : "";
 },
 SetItemText: function(indexPath, text) {
  var textNode = this.FindTextNode(indexPath);
  if(textNode) {
   textNode.nodeValue = text;
   var menuElement = this.GetMenuElement(this.GetParentIndexPath(indexPath));
   if(menuElement && (!this.IsRootItem(indexPath) || this.isPopupMenu))
    this.renderHelper.CalculateSubMenu(menuElement, true);
   if(this.IsRootItem(indexPath) && !this.isPopupMenu) {
    var itemElement = this.GetItemElement(indexPath);
    if(itemElement)
     this.renderHelper.CalculateItemMinSize(itemElement, true);
   }
   this.AdjustControl();
  }
 },
 SetItemTextTemplate: function(indexPath, textTemplate) {
  var contentElement = this.GetItemContentElement(indexPath),
   textElement = ASPx.GetChildByClassName(contentElement, MenuCssClasses.ItemTextElement, 1),
   container = document.createElement("DIV");
  container.innerHTML = textTemplate;
  contentElement.replaceChild(container.firstChild, textElement);
 },
 SetItemTooltip: function(indexPath, tooltip) {
  var itemElement = this.GetItemElement(indexPath);
  if(itemElement && tooltip)
   itemElement.title = tooltip;
 },
 SetItemVisible: function(indexPath, visible, initialization) {
  var item = this.GetItemByIndexPath(indexPath);
  if(indexPath == "" || !item.visible) return;
  if(visible && initialization) return;
  var element = this.GetItemElement(indexPath);
  if(element != null)
   this.SetElementDisplay(element, visible);
  this.SetIndentsVisiblility(indexPath);
  var parentIndexPath = this.GetParentIndexPath(indexPath);
  if(this.isPopupMenu && this.inPopUpHandler)
   this.postponeSetItemVisible(parentIndexPath);
  else
   this.SetSeparatorsVisiblility(parentIndexPath);
  if(!this.IsItemInAdaptiveMenu(item))
   this.UpdateItemCssClasses(indexPath, visible);
  var parent = this.GetItemByIndexPath(indexPath).parent;
  var parentHasVisibleItems = this.HasVisibleItems(parent);
  if(this.IsRootItem(indexPath) && !this.isPopupMenu) {
   if(this.clientVisible)
    this.SetElementDisplay(this.GetMainElement(), parentHasVisibleItems);
  }
  else
   this.SetPopOutElementVisible(parent.indexPath, parentHasVisibleItems);
  if(this.GetMenuLevel(parentIndexPath) !== 0 || this.isPopupMenu && !this.inPopUpHandler)
   this.calculateSubMenuByIndexPath(parentIndexPath);
  if(this.IsRootItem(indexPath) && !this.isPopupMenu) 
   this.renderHelper.CalculateMenuControl(this.GetMainElement(), true);
 },
 SetElementDisplay: function (element, visible) {
  ASPx.SetElementDisplay(element, visible);
 },
 prepareSideMenuCssClasses: function(addClass) {
  if(this.sideMenuModeOn) {
   this.MarkPrecedingItemCore(this.GetSelectedItemIndexPath(), PRE_SELECTED_ELEMENT_CLASS_NAME, addClass, false);
   if(this.hoverItemName)
    this.MarkPrecedingItemCore(this.hoverItemName, PRE_HOVERED_ELEMENT_CLASS_NAME, addClass, true);
  }
 },
 calculateSubMenuByIndexPath: function(indexPath) {
  var menuElement = this.GetMenuElement(indexPath);
  if(menuElement)
   this.renderHelper.CalculateSubMenu(menuElement, true);
 },
 postponeSetItemVisible: function(indexPath) {
  if(!this.postponedIndexPath)
   this.postponedIndexPath = [];
  for(var i = 0; i < this.postponedIndexPath.length; i++) {
   if(this.postponedIndexPath[i] === indexPath)
    return;
  }
  this.postponedIndexPath.push(indexPath);
 },
 postponedSetItemVisible: function() {
  if(!!this.postponedIndexPath && this.postponedIndexPath.length > 0)
   ASPx.Data.ForEach(this.postponedIndexPath, function(indexPath) {
    this.SetSeparatorsVisiblility(indexPath);
    this.calculateSubMenuByIndexPath(indexPath);
   }.aspxBind(this));
  this.postponedIndexPath = [];
 },
 SetIndentsVisiblility: function(indexPath) {
  var parent = this.GetItemByIndexPath(indexPath).parent;
  for(var i = 0; i < parent.GetItemCount(); i++) {
   var item = parent.GetItem(i);
   var separatorVisible = this.HasPrevVisibleItems(parent, i) && item.GetVisible();
   var element = this.GetItemIndentElement(item.GetIndexPath());
   if(element != null) ASPx.SetElementDisplay(element, separatorVisible);
  }
 },
 SetSeparatorsVisiblility: function(indexPath) {
  var parent = this.GetItemByIndexPath(indexPath);
  for(var i = 0; i < parent.GetItemCount(); i++) {
   var item = parent.GetItem(i);
   var separatorVisible = this.HasPrevVisibleItems(parent, i) && (item.GetVisible() || this.HasNextVisibleItemInGroup(parent, i));
   var element = this.GetItemSeparatorElement(item.GetIndexPath());
   if(element != null) ASPx.SetElementDisplay(element, separatorVisible);
  }
 },
 UpdateItemCssClasses: function(indexPath, visible) {
 },
 SetPopOutElementVisible: function(indexPath, visible) {
  var popOutElement = this.GetItemPopOutElement(indexPath);
  if(popOutElement)
   popOutElement.style.display = visible ? 'block' : 'none';
 },
 GetPrevVisibleItemInGroup: function(parent, index, skipItemsInAdaptiveMenu) {
  if(this.IsItemBeginsGroup(parent.GetItem(index)))
   return null;
  for(var i = index - 1; i >= 0; i--) {
   var item = parent.GetItem(i);
   if(item.GetVisible() && !this.IsAdaptiveItem(item.indexPath) && (!skipItemsInAdaptiveMenu || !this.IsItemInAdaptiveMenu(item)))
    return item;
   if(this.IsItemBeginsGroup(item))
    return null;
  }
  return null;
 },
 GetNextVisibleItemInGroup: function(parent, index, skipItemsInAdaptiveMenu) {
  for(var i = index + 1; i < parent.GetItemCount(); i++) {
   var item = parent.GetItem(i);
   if(this.IsItemBeginsGroup(item))
    return null;
   if(item.GetVisible() && !this.IsAdaptiveItem(item.indexPath) && (!skipItemsInAdaptiveMenu || !this.IsItemInAdaptiveMenu(item)))
    return item;
  }
  return null;
 },
 HasNextVisibleItemInGroup: function(parent, index, skipItemsInAdaptiveMenu) {
  return !!this.GetNextVisibleItemInGroup(parent, index, skipItemsInAdaptiveMenu);
 },
 IsItemBeginsGroup: function(item) {
  var itemSeparator = this.GetItemSeparatorElement(item.GetIndexPath());
  return itemSeparator && ASPx.ElementContainsCssClass(itemSeparator, this.getSeparatorCssClass());
 },
 getSeparatorCssClass: function() {
  return MenuCssClasses.Separator;
 },
 getAdaptiveMenuItemCssClass: function() {
  return MenuCssClasses.AdaptiveMenuItem;
 },
 getAdaptiveMenuItemSpacingCssClass: function() {
  return MenuCssClasses.AdaptiveMenuItemSpacing;
 },
 getAdaptiveMenuCssClass: function() {
  return MenuCssClasses.AdaptiveMenu;
 },
 IsItemInAdaptiveMenu: function(item) {
  return this.enableAdaptivity ? this.renderHelper.IsItemInAdaptiveMenu(item.index) : false;
 },
 HasVisibleItems: function(parent) {
  for(var i = 0; i < parent.GetItemCount() ; i++) {
   if(parent.GetItem(i).GetVisible())
    return true;
  }
  return false;
 },
 HasNextVisibleItems: function(parent, index, skipItemsInAdaptiveMenu) {
  for(var i = index + 1; i < parent.GetItemCount() ; i++) {
   var item = parent.GetItem(i);
   if(item.GetVisible() && (!skipItemsInAdaptiveMenu || !this.IsItemInAdaptiveMenu(item)))
    return true;
  }
  return false;
 },
 HasPrevVisibleItems: function(parent, index, skipItemsInAdaptiveMenu) {
  for(var i = index - 1; i >= 0; i--) {
   var item = parent.GetItem(i);
   if(item.GetVisible() && (!skipItemsInAdaptiveMenu || !this.IsItemInAdaptiveMenu(item)))
    return true;
  }
  return false;
 },
 NeedCollapseControlCore: function() {
  return this.enableAdaptivity || ASPxClientControl.prototype.NeedCollapseControlCore.call(this);
 },
 GetItemIndentElement: function(indexPath) {
  return ASPx.GetElementById(this.GetItemIndentElementId(indexPath));
 },
 GetItemSeparatorElement: function(indexPath) {
  return ASPx.GetElementById(this.GetItemSeparatorElementId(indexPath));
 },
 CreateItemClickEventArgs: function(processOnServer, item, htmlElement, htmlEvent) {
  return new ASPxClientMenuItemClickEventArgs(processOnServer, item, htmlElement, htmlEvent);
 },
 CreateItemMouseEventArgs: function(item, htmlElement) {
  return new ASPxClientMenuItemMouseEventArgs(item, htmlElement);
 },
 CreateItemEventArgs: function(item) {
  return new ASPxClientMenuItemEventArgs(item);
 },
 RaiseItemClick: function(indexPath, htmlEvent) {
  var processOnServer = this.autoPostBack || this.IsServerEventAssigned("ItemClick");
  if(!this.ItemClick.IsEmpty()) {
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemElement(indexPath);
   var args = this.CreateItemClickEventArgs(processOnServer, item, htmlElement, htmlEvent);
   this.ItemClick.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;
 },
 RaiseItemMouseOver: function(indexPath) {
  if(!this.ItemMouseOver.IsEmpty()) {
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemContentElement(indexPath);
   var args = this.CreateItemMouseEventArgs(item, htmlElement);
   this.ItemMouseOver.FireEvent(this, args);
  }
 },
 RaiseItemMouseOut: function(indexPath) {
  if(!this.ItemMouseOut.IsEmpty()) {
   var item = this.GetItemByIndexPath(indexPath);
   var htmlElement = this.GetItemContentElement(indexPath);
   var args = this.CreateItemMouseEventArgs(item, htmlElement);
   this.ItemMouseOut.FireEvent(this, args);
  }
 },
 RaisePopUp: function(indexPath) {
  var item = this.GetItemByIndexPath(indexPath);
  if(!this.PopUp.IsEmpty()) {
   var args = this.CreateItemEventArgs(item);
   this.inPopUpHandler = true;
   this.PopUp.FireEvent(this, args);
   this.inPopUpHandler = false;
   this.postponedSetItemVisible();
  }
 },
 RaiseCloseUp: function(indexPath) {
  var item = this.GetItemByIndexPath(indexPath);
  if(!this.CloseUp.IsEmpty()) {
   var args = this.CreateItemEventArgs(item);
   this.CloseUp.FireEvent(this, args);
  }
 },
 SetEnabled: function(enabled) {
  for(var i = this.GetItemCount() - 1; i >= 0; i--) {
   var item = this.GetItem(i);
   item.SetEnabled(enabled);
  }
 },
 SetVisible: function(visible) {
  ASPxClientControl.prototype.SetVisible.call(this, visible);
  if(visible && !this.HasVisibleItems(this))
   ASPx.SetElementDisplay(this.GetMainElement(), false);
 },
 GetItemCount: function() {
  return (this.rootItem != null) ? this.rootItem.GetItemCount() : 0;
 },
 GetItem: function(index) {
  return (this.rootItem != null) ? this.rootItem.GetItem(index) : null;
 },
 GetItemByName: function(name) {
  return (this.rootItem != null) ? this.rootItem.GetItemByName(name) : null;
 },
 GetSelectedItem: function() {
  var indexPath = this.GetSelectedItemIndexPath();
  if(indexPath != "")
   return this.GetItemByIndexPath(indexPath);
  return null;
 },
 SetSelectedItem: function(item) {
  var indexPath = (item != null) ? item.GetIndexPath() : "";
  this.SetSelectedItemInternal(indexPath, false);
 },
 GetRootItem: function() {
  return this.rootItem;
 }
});
ASPxClientMenuBase.GetMenuCollection = function() {
 return aspxGetMenuCollection();
};
var ASPxMenuKeyboardHelper = ASPx.CreateClass(null, {
 constructor: function(menu) {
  this.menu = menu;
  this.accessibilityCompliant = menu.accessibilityCompliant;
  this.isContextMenu = menu.isContextMenu;
  this.rtl = menu.rtl;
 },
 OnFocusedItemKeyDown: function(evt, focusedItem) {
  var indexPath = this.menu.GetItemIndexPathById(focusedItem.name);
  if(!this.IsAllowedItemAction(evt, focusedItem.enabled, indexPath))
   ASPx.Evt.PreventEventAndBubble(evt);
  else
   this.OnFocusedItemKeyDownInternal(evt, indexPath);
 },
 OnFocusedItemKeyDownInternal: function(evt, indexPath) {
  if(!indexPath)
   return;
  var keyKode = ASPx.Evt.GetKeyCode(evt);
  switch (keyKode) {
   case ASPx.Key.Tab:
    this.OnTab(indexPath, evt);
    break;
   case ASPx.Key.Down:
    this.OnArrowDown(indexPath, evt);
    break;
   case ASPx.Key.Up:
    this.OnArrowUp(indexPath, evt);
    break;
   case ASPx.Key.Left:
    if(this.rtl)
     this.OnArrowRight(indexPath, evt);
    else
     this.OnArrowLeft(indexPath, evt);
    break;
   case ASPx.Key.Right:
    if(this.rtl)
     this.OnArrowLeft(indexPath, evt);
    else
     this.OnArrowRight(indexPath, evt);
    break;
   case ASPx.Key.Esc:
    this.OnEscape(indexPath, evt);
    break;
   case ASPx.Key.Space: break;
   case ASPx.Key.Enter: break;
   case ASPx.Key.Shift: break;
   case ASPx.Key.Alt: break;
   case ASPx.Key.Ctrl: break;
   default:
    ASPx.Evt.PreventEventAndBubble(evt);
    break;
  }
 },
 OnTab: function(indexPath, evt) {
  var isRootItem = this.IsRootItem(indexPath);
  if(isRootItem && !this.accessibilityCompliant) return;
  if(this.IsLostFocus(indexPath, evt))
   this.menu.ProcessLostFocus(evt);
  else
   this.ProcessTab(indexPath, evt);
 },
 ProcessTab: function(indexPath, evt) {
  if(this.IsRootItem(indexPath))
   this.FocusRootItem(indexPath, evt);
  else
   this.FocusSubmenuItem(indexPath, evt);
 },
 OnArrowDown: function(indexPath, evt) {
  if(this.menu.IsVertical(indexPath))
   this.FocusNextItem(indexPath);
  else
   this.ShowSubMenuAccessible(indexPath);
  ASPx.Evt.PreventEventAndBubble(evt);
 },
 OnArrowUp: function(indexPath, evt) {
  if(this.menu.IsVertical(indexPath))
   this.FocusPrevItem(indexPath);
  else
   this.ShowSubMenuAccessible(indexPath);
  ASPx.Evt.PreventEventAndBubble(evt);
 },
 OnArrowLeft: function(indexPath, evt) {
  var isVertical = this.menu.IsVertical(indexPath);
  if(isVertical) {
   var isRootItem = this.IsRootItem(indexPath);
   if(isRootItem)
    this.FocusPrevItem(indexPath);
   else
    this.FocusItemByIndexPathAccessible(this.GetLeftParentIndexPath(indexPath));
  } else
   this.FocusPrevItem(indexPath);
  ASPx.Evt.PreventEventAndBubble(evt);
 },
 OnArrowRight: function(indexPath, evt) {
  var isVertical = this.menu.IsVertical(indexPath);
  if(isVertical) {
   var hasChildren = this.menu.HasChildren(indexPath);
   if(hasChildren)
    this.ShowSubMenuAccessible(indexPath);
   else
    this.FocusItemByIndexPathAccessible(this.GetRightRootParentIndexPath(indexPath));
  }
  else
   this.FocusNextItem(indexPath);
  ASPx.Evt.PreventEventAndBubble(evt);
 },
 OnEscape: function(indexPath, evt) {
  var needPreventEvent = true;
  if(this.IsRootItem(indexPath)) {
   aspxGetMenuCollection().DoHidePopupMenus(null, -1, this.name, false, "");
   this.menu.ProcessLostFocus(evt);
  }
  else {
   var parentIndexPath = this.menu.GetParentIndexPath(indexPath);
   this.FocusItemByIndexPathAccessible(parentIndexPath);
   var element = this.menu.GetMenuElement(parentIndexPath);
   if(element != null)
    this.menu.DoHidePopupMenu(null, element);
   else
    needPreventEvent = false;
  }
  if(needPreventEvent)
   ASPx.Evt.PreventEventAndBubble(evt);
 },
 IsLostFocus: function(indexPath, evt) {
  var keyCode = ASPx.Evt.GetKeyCode(evt);
  var isRootItem = this.IsRootItem(indexPath); 
  if(keyCode !== ASPx.Key.Tab || !isRootItem)
   return false;
  var canPrevItemGetFocus = evt.shiftKey && this.GetPrevSiblingIndexPath(indexPath);
  var canNextItemGetFocus = !evt.shiftKey && this.GetNextSiblingIndexPath(indexPath);
  return !canPrevItemGetFocus && !canNextItemGetFocus;
 },
 FocusRootItem: function(indexPath, evt) {
  if(evt.shiftKey)
   this.FocusPrevItem(indexPath, evt);
  else
   this.FocusNextItem(indexPath, evt);
  var isFocusElementChanged = ASPx.Evt.GetEventSource(evt) !== document.activeElement;
  if(isFocusElementChanged)
   ASPx.Evt.PreventEventAndBubble(evt);
 },
 FocusSubmenuItem: function(indexPath, evt) {
  if(evt.shiftKey)
   this.FocusPreviousSubmenuItem(indexPath, evt);
  else
   this.FocusNextSubmenuItem(indexPath, evt);
 },
 FocusPreviousSubmenuItem: function(indexPath, evt) {
  if(!this.GetPrevSiblingIndexPath(indexPath)) {
   var parentIndexPath = this.menu.GetParentIndexPath(indexPath);
   this.FocusItemByIndexPathAccessible(parentIndexPath);
  } else
   this.FocusPrevItem(indexPath);
  ASPx.Evt.PreventEventAndBubble(evt);
 },
 FocusNextSubmenuItem: function(indexPath, evt) {
  var nextIndexPath = this.GetNextIndexPath(indexPath);
  if(nextIndexPath) {
   var isLevelChanged = this.IsLevelChanged(indexPath, nextIndexPath);
   this.FocusItemCore(nextIndexPath, isLevelChanged); 
   ASPx.Evt.PreventEventAndBubble(evt);
  } else
   this.menu.ProcessLostFocus(evt);
 },
 GetNextIndexPath: function(indexPath) {
  var result = this.GetNextSiblingIndexPath(indexPath);
  if(!result) {
   var parentIndexPath = this.menu.GetParentIndexPath(indexPath);
   if(parentIndexPath)
    result = this.GetNextIndexPath(parentIndexPath);
  }
  return result;
 },
 GetRightRootParentIndexPath: function(indexPath) {
  var parentIndexPath = this.GetParentRootIndexPath(indexPath);
  return this.GetNextFocusableItemIndexPath(parentIndexPath);
 },
 GetLeftParentIndexPath: function(indexPath) {
  var parentIndexPath = this.menu.GetParentIndexPath(indexPath);
  if(!this.menu.IsVertical(parentIndexPath))
   parentIndexPath = this.GetPrevFocusableItemIndexPath(parentIndexPath);
  return parentIndexPath;
 },
 GetParentRootIndexPath: function(indexPath) {
  while(!this.IsRootItem(indexPath))
   indexPath = this.menu.GetParentIndexPath(indexPath);
  return indexPath;
 },
 ShowSubMenuAccessible: function(indexPath) {
  var newIndexPath = this.GetFirstChildIndexPath(indexPath),
   element = this.menu.GetMenuElement(indexPath);
  if(element && !this.menu.isSubMenuElementVisible(element))
   this.menu.ShowSubMenu(indexPath);
  if(!!newIndexPath)
   this.FocusItemByIndexPathAccessible(newIndexPath);
 },
 FocusItemByIndexPathAccessible: function(indexPath) {
  this.FocusItemCore(indexPath, true);
 },
 IsAllowedItemAction: function(evt, isEnabled, indexPath) {
  var isVertical = this.menu.IsVertical(indexPath);
  return !this.accessibilityCompliant ||
      isEnabled ||
      this.IsAllowedFocusMoving(evt) ||
      this.IsAllowedHorizontalFocusMoving(evt, isVertical) ||
      this.IsAllowedVerticalFocusMoving(evt, isVertical);
 },
 IsAllowedFocusMoving: function(evt) {
  return evt.keyCode == ASPx.Key.Tab || evt.keyCode == ASPx.Key.Esc;
 },
 IsAllowedHorizontalFocusMoving: function(evt, isVertical) {
  return !isVertical && (evt.keyCode == ASPx.Key.Left || evt.keyCode == ASPx.Key.Right);
 },
 IsAllowedVerticalFocusMoving: function(evt, isVertical) {
  return isVertical && (evt.keyCode == ASPx.Key.Up || evt.keyCode == ASPx.Key.Down);
 },
 FocusItemByIndexPath: function(indexPath) {
  var link = this.menu.GetLinkElementByIndexPath(indexPath);
  if(link != null) {
   if(this.accessibilityCompliant && !link.href)
    link.href = ASPx.AccessibilityEmptyUrl;
   ASPx.SetFocus(link);
  } else
   this.FocusTemplateItemActionElement(indexPath);
 },
 FocusTemplateItemActionElement: function(indexPath) {
  var element = this.menu.GetItemElement(indexPath);
  var focusableElement = ASPx.FindFirstChildActionElement(element);
  if(focusableElement)
   ASPx.SetFocus(focusableElement);
  else {
   var parentIndexPath = this.menu.GetParentIndexPath(indexPath);
   this.tryFocusColorPickerByIndexPath(parentIndexPath);
  }
 },
 tryFocusColorPickerByIndexPath: function(indexPath) {
  var colorPicker = this.getColorPickerByIndexPath(indexPath);
  if(colorPicker)
   colorPicker.Focus();
 },
 getColorPickerByIndexPath: function(indexPath) {
  var menuItem = this.menu.GetItemByIndexPath(indexPath);
  return menuItem.colorPicker;
 },
 PronounceItemDescription: function(indexPath) {
  var link = this.menu.GetLinkElementByIndexPath(indexPath);
  var span = ASPx.GetNodeByTagName(link, "SPAN", 0);
  if(!link) return;
  if(!!span && !span.id) {
   var spanID = this.GetAccessibilityTextSpanID(indexPath);
   span.id = spanID;
   ASPx.Attr.SetAttribute(link, "aria-describedby", spanID);
  }
  ASPx.Attr.SetAttribute(link, "aria-label", this.GetAccessibilityItemDescription(indexPath));
 },
 RemoveAccessibilityDescription: function(indexPath) {
  var link = this.menu.GetLinkElementByIndexPath(indexPath);
  if(link && ASPx.Attr.GetAttribute(link, "aria-label"))
   ASPx.Attr.RemoveAttribute(link, "aria-label");
 },
 GetAccessibilityTextSpanID: function(indexPath) {
  return this.name + Constants.ATSIdSuffix + indexPath;
 },
 GetAccessibilityItemDescription: function(indexPath) {
  var descriptionParts = [];
  descriptionParts.push(this.menu.IsVertical(indexPath) ? ASPx.AccessibilitySR.MenuVerticalText : ASPx.AccessibilitySR.MenuHorizontalText);
  descriptionParts.push(this.IsRootItem(indexPath) ? ASPx.AccessibilitySR.MenuBarText : ASPx.AccessibilitySR.MenuText);
  descriptionParts.push(this.menu.GetMenuLevel(indexPath));
  descriptionParts.push(ASPx.AccessibilitySR.MenuLevelText);
  return descriptionParts.join(' ');
 },
 FocusNextItem: function(indexPath) {
  var newIndexPath = this.GetNextFocusableItemIndexPath(indexPath);
  if(newIndexPath)
   this.FocusItemCore(newIndexPath, false);
 },
 FocusPrevItem: function(indexPath) {
  var newIndexPath = this.GetPrevFocusableItemIndexPath(indexPath);
  if(newIndexPath)
   this.FocusItemCore(newIndexPath, false);
 },
 FocusItemCore: function(indexPath, needDescription) {
  if(this.accessibilityCompliant) {
   if(needDescription)
    this.PronounceItemDescription(indexPath);
   else
    this.RemoveAccessibilityDescription(indexPath);
  }
  this.FocusItemByIndexPath(indexPath);
 },
 GetNextFocusableItemIndexPath: function(indexPath) {
  var newIndexPath = this.GetNextSiblingIndexPath(indexPath);
  if(newIndexPath == null)
   newIndexPath = this.GetFirstSiblingIndexPath(indexPath);
  if(indexPath != newIndexPath)
   return newIndexPath;
 },
 GetPrevFocusableItemIndexPath: function(indexPath) {
  var newIndexPath = this.GetPrevSiblingIndexPath(indexPath);
  if(newIndexPath == null)
   newIndexPath = this.GetLastSiblingIndexPath(indexPath);
  if(indexPath != newIndexPath)
   return newIndexPath;
 },
 GetFirstChildIndexPath: function(indexPath) {
  var indexes = this.menu.GetItemIndexes(indexPath);
  indexes[indexes.length] = 0;
  var newIndexPath = this.menu.GetItemIndexPath(indexes);
  return this.GetFirstSiblingIndexPath(newIndexPath);
 },
 GetFirstSiblingIndexPath: function(indexPath) {
  var indexes = this.menu.GetItemIndexes(indexPath);
  var i = 0;
  while(true) {
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.menu.GetItemIndexPath(indexes);
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsFocusableItem(newIndexPath))
    return newIndexPath;
   i++;
  }
  return null;
 },
 GetLastSiblingIndexPath: function(indexPath) {
  var indexes = this.menu.GetItemIndexes(indexPath);
  var parentItem = this.menu.GetItemByIndexPath(this.menu.GetParentIndexPath(indexPath));
  var i = parentItem ? parentItem.GetItemCount() - 1 : 0;
  while(true) {
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.menu.GetItemIndexPath(indexes);
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsFocusableItem(newIndexPath))
    return newIndexPath;
   i--;
  }
  return null;
 },
 GetNextSiblingIndexPath: function(indexPath) {
  if(this.menu.IsLastItem(indexPath)) return null;
  var indexes = this.menu.GetItemIndexes(indexPath);
  var i = indexes[indexes.length - 1] + 1;
  while(true) {
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.menu.GetItemIndexPath(indexes);
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsFocusableItem(newIndexPath))
    return newIndexPath;
   i++;
  }
  return null;
 },
 GetPrevSiblingIndexPath: function(indexPath) {
  if(this.menu.IsFirstItem(indexPath)) return null;
  var indexes = this.menu.GetItemIndexes(indexPath);
  var i = indexes[indexes.length - 1] - 1;
  while(true) {
   indexes[indexes.length - 1] = i;
   var newIndexPath = this.menu.GetItemIndexPath(indexes);
   if(!this.IsItemExist(newIndexPath))
    return null;
   if(this.IsFocusableItem(newIndexPath))
    return newIndexPath;
   i--;
  }
  return null;
 },
 IsItemExist: function(indexPath) {
  return !!this.menu.GetItemByIndexPath(indexPath);
 },
 IsItemVisible: function(indexPath) {
  var item = this.menu.GetItemByIndexPath(indexPath);
  return item ? item.GetVisible() : false;
 },
 IsFocusableItem: function(indexPath) {
  return this.IsItemVisible(indexPath) && (this.menu.IsItemEnabled(indexPath) || this.IsItemAccessibleEnabled(indexPath));
 },
 IsRootItem: function(indexPath) {
  return this.menu.IsRootItem(indexPath);
 },
 IsItemAccessibleEnabled: function(indexPath) {
  var item = this.menu.GetItemByIndexPath(indexPath);
  return this.accessibilityCompliant && item && item.enabled;
 },
 IsLevelChanged: function(firstIndexPath, secondIndexPath) {
  return this.menu.GetMenuLevel(firstIndexPath) !== this.menu.GetMenuLevel(secondIndexPath);
 }
});
var ASPxClientMenuCollection = ASPx.CreateClass(ASPxClientControlCollection, {
 constructor: function() {
  this.constructor.prototype.constructor.call(this);
  this.appearTimerID = -1;
  this.disappearTimerID = -1;
  this.currentShowingPopupMenuName = null;
  this.visibleSubMenusMenuName = "";
  this.visibleSubMenuIds = [];
  this.overXPos = -1;
  this.overYPos = -1;
 },
 GetCollectionType: function(){
  return "Menu";
 },
 Remove: function(element) {
  if(element.name === this.visibleSubMenusMenuName) {
   this.visibleSubMenusMenuName = "";
   this.visibleSubMenuIds = [ ];
  }
  ASPxClientControlCollection.prototype.Remove.call(this, element);
 },
 RegisterVisiblePopupMenu: function(name, id) {
  this.visibleSubMenuIds.push(id);
  this.visibleSubMenusMenuName = name;
 },
 UnregisterVisiblePopupMenu: function(name, id) {
  ASPx.Data.ArrayRemove(this.visibleSubMenuIds, id);
  if(this.visibleSubMenuIds.length == 0)
   this.visibleSubMenusMenuName = "";
 },
 IsSubMenuVisible: function(subMenuId) {
  for(var i = 0; i < this.visibleSubMenuIds.length; i++) {
   if(this.visibleSubMenuIds[i] == subMenuId)
    return true;
  }
  return false;
 },
 GetMenu: function(id) {
  return this.Get(this.GetMenuName(id));
 },
 GetMenuName: function(id) {
  return this.GetMenuNameBySuffixes(id, [Constants.MMIdSuffix, Constants.MIIdSuffix]);
 },
 GetMenuNameBySuffixes: function(id, idSuffixes) {
  for(var i = 0; i < idSuffixes.length; i++) {
   var pos = id.lastIndexOf(idSuffixes[i]);
   if(pos > -1)
    return id.substring(0, pos);
  }
  return id;
 },
 ClearCurrentShowingPopupMenuName: function() {
  this.SetCurrentShowingPopupMenuName(null);
 },
 SetCurrentShowingPopupMenuName: function(value) {
  this.currentShowingPopupMenuName = value;
 },
 NowPopupMenuIsShowing: function() {
  return this.currentShowingPopupMenuName != null;
 },
 GetMenuLevelById: function(id) {
  var indexPath = this.GetIndexPathById(id, Constants.MMIdSuffix);
  var menu = this.GetMenu(id);
  return menu.GetMenuLevel(indexPath);
 },
 GetIndexPathById: function(id, idSuffix) {
  var pos = id.lastIndexOf(idSuffix);
  if(pos > -1) {
   id = id.substring(pos + idSuffix.length);
   pos = id.lastIndexOf("_");
   if(pos > -1)
    return id.substring(0, pos);
  }
  return "";
 },
 GetItemIndexPath: function(indexes) {
  var indexPath = "";
  for(var i = 0; i < indexes.length; i++) {
   indexPath += indexes[i];
   if(i < indexes.length - 1)
    indexPath += ASPx.ItemIndexSeparator;
  }
  return indexPath;
 },
 GetItemIndexes: function(indexPath) {
  var indexes = indexPath.split(ASPx.ItemIndexSeparator);
  for(var i = 0; i < indexes.length; i++)
   indexes[i] = parseInt(indexes[i]);
  return indexes;
 },
 ClearAppearTimer: function() {
  this.appearTimerID = ASPx.Timer.ClearTimer(this.appearTimerID);
 },
 ClearDisappearTimer: function() {
  this.disappearTimerID = ASPx.Timer.ClearTimer(this.disappearTimerID);
 },
 IsAppearTimerActive: function() {
  return this.appearTimerID > -1;
 },
 IsDisappearTimerActive: function() {
  return this.disappearTimerID > -1;
 },
 SetAppearTimer: function(name, indexPath, timeout, preventSubMenu) {
  var menu = aspxGetMenuCollection().Get(name);
  if(menu && !menu.sideMenuModeOn)
   this.appearTimerID = window.setTimeout(function() {
    var menu = aspxGetMenuCollection().Get(name);
    if(menu != null) menu.OnItemOverTimer(indexPath, preventSubMenu);
   }, timeout);
 },
 SetDisappearTimer: function(name, timeout) {
  var menu = aspxGetMenuCollection().Get(name);
  if(menu && !menu.sideMenuModeOn)
   this.disappearTimerID = window.setTimeout(function() {
    var menu = aspxGetMenuCollection().Get(name);
    if(menu != null)
     menu.OnItemOutTimer();
   }, timeout);
 },
 GetMouseDownMenuLevel: function(evt) {
  var srcElement = ASPx.Evt.GetEventSource(evt);
  for(var i = this.visibleSubMenuIds.length - 1; i >= 0; i--) {
   var element = ASPx.GetParentById(srcElement, this.visibleSubMenuIds[i]);
   if(element != null)
    return this.GetMenuLevelById(this.visibleSubMenuIds[i]) + 1;
  }
  if(this.visibleSubMenusMenuName != "") {
   var element = ASPx.GetParentById(srcElement, this.visibleSubMenusMenuName);
   if(element != null) return 1;
  }
  if(ASPx.GetParentByClassName(srcElement, MenuCssClasses.AdaptiveMenuItem))
   return 1;
  return -1;
 },
 CheckFocusedElement: function() {
  var isValid = false;
  try {
   var activeElement = document.activeElement;
   if(activeElement != null) {
    for(var i = 0; i < this.visibleSubMenuIds.length; i++) {
     var menuElement = ASPx.GetElementById(this.visibleSubMenuIds[i]);
     if(menuElement != null && ASPx.GetIsParent(menuElement, activeElement)) {
      var tagName = activeElement.tagName;
      if(tagName != "A" || 
         !ASPx.ElementHasCssClass(activeElement, MenuCssClasses.ContentContainer) || 
         this.GetMenu(this.visibleSubMenusMenuName).accessibilityCompliant)
          isValid = true;
      break;
     }
    }
   }
  } catch (e) {
  }
  return isValid;
 },
 LockMenusVisibility: function() {
  this.visibilityLocked = true;
  this.visibilityLockedIds = [];
  for(var i = this.visibleSubMenuIds.length - 1; i >= 0 ; i--)
   this.visibilityLockedIds.push(this.visibleSubMenuIds[i]);
 },
 UnlockMenusVisibility: function() {
  this.visibilityLocked = false;
  this.visibilityLockedIds = [];
 },
 CanHideSubMenu: function(subMenuId) {
  return !this.visibilityLocked || this.visibilityLocked && this.visibilityLockedIds.indexOf(subMenuId) > -1;
 },
 DoHidePopupMenus: function(evt, level, name, leavePopups, exceptIds) {
  exceptIds = typeof exceptIds === 'string' ? [exceptIds] : (exceptIds || []);
  for(var i = this.visibleSubMenuIds.length - 1; i >= 0 ; i--) {
   var subMenuId = this.visibleSubMenuIds[i];
   if(this.CanHideSubMenu(subMenuId)) {
    var menu = this.GetMenu(subMenuId);
    if(menu != null && !menu.sideMenuModeOn) {
     var menuLevel = this.GetMenuLevelById(subMenuId);
     if((!leavePopups || menuLevel > 0) && ASPx.Data.ArrayIndexOf(exceptIds, subMenuId) === -1) {
      if(menuLevel > level || (menu.name != name && name != "")) {
       var element = ASPx.GetElementById(subMenuId);
       if(element != null)
        menu.DoHidePopupMenu(evt, element);
      }
     }
    }
   }
  }
 },
 DoShowAtCurrentPos: function(name, indexPath) {
  var pc = this.Get(name);
  var element = pc.GetMainElement();
  if(pc != null && !ASPx.GetElementDisplay(element))
   pc.DoShowPopupMenu(element, this.overXPos, this.overYPos, indexPath);
 },
 SaveCurrentMouseOverPos: function(evt, popupElement) {
  if(!this.NowPopupMenuIsShowing()) return;
  var currentShowingPopupMenu = this.Get(this.currentShowingPopupMenuName);
  if(currentShowingPopupMenu.popupElement == popupElement)
   if(!currentShowingPopupMenu.IsMenuVisible()) {
    this.overXPos = ASPx.Evt.GetEventX(evt);
    this.overYPos = ASPx.Evt.GetEventY(evt);
   }
 },
 OnMouseDown: function(evt) {
  var menuLevel = this.GetMouseDownMenuLevel(evt);
  this.DoHidePopupMenus(evt, menuLevel, "", false, "");
  if (ASPx.Browser.TouchUI && menuLevel == -1) 
   ASPx.SetHoverState(null);
 },
 RecalculateAll: function() {
  var visibleSubMenusLength = this.visibleSubMenuIds.length;
  for(var i = 0; i < visibleSubMenusLength; i++) {
   var menu = this.GetMenu(this.visibleSubMenuIds[i]);
   if(menu != null) {
    var element = ASPx.GetElementById(this.visibleSubMenuIds[i]);
    if(element != null) {
     var indexPath = this.GetIndexPathById(this.visibleSubMenuIds[i], Constants.MMIdSuffix);
     menu.CalculateSubMenuPosition(element, ASPx.InvalidPosition, ASPx.InvalidPosition, indexPath, false);
    }
   }
  }
 },
 HideAll: function() {
  this.DoHidePopupMenus(null, -1, "", false, "");
 },
 IsAnyMenuVisible: function() {
  return this.visibleSubMenuIds.length != 0;
 }
});
var menuCollection = null;
function aspxGetMenuCollection() {
 if(menuCollection == null)
  menuCollection = new ASPxClientMenuCollection();
 return menuCollection;
}
var ASPxClientMenuItem = ASPx.CreateClass(null, {
 constructor: function(menu, parent, index, name) {
  this.menu = menu;
  this.parent = parent;
  this.index = index;
  this.name = name;
  this.indexPath = "";
  this.text = "";
  this.imageUrl = "";
  this.imageClassName = "";
  this.tooltip = "";
  this.target = "";
  this.beginGroup = false;
  this.dropDownMode = false;
  if(parent) {
   this.indexPath = this.CreateItemIndexPath(parent);
  }
  this.enabled = true;
  this.clientEnabled = true;
  this.visible = true;
  this.clientVisible = true;
  this.items = [];
  this.colorPicker = null;
  this.checkedGroup = [];
  this.checked = false;
 },
 CreateItemIndexPath: function(parent) {
  return parent.indexPath ? parent.indexPath + ASPx.ItemIndexSeparator + this.index.toString() : this.index.toString();
 },
 CreateItems: function(itemsProperties) {
  for(var i = 0, len = itemsProperties.length; i < len; i++) {
   var itemProperties = itemsProperties[i],
    item = this.CreateItemInternal(itemProperties);
   if(itemProperties.items && itemProperties.items.length > 0)
    item.CreateItems(itemProperties.items);
  }
 },
 CreateItemInternal: function(itemProperties) {
  var itemName = itemProperties.name || "";
  var index = this.items.length;
  var itemType = this.menu.GetClientItemType();
  var item = new itemType(this.menu, this, index, itemName);
  if(ASPx.IsExists(itemProperties.text))
   item.text = itemProperties.text;
  if(ASPx.IsExists(itemProperties.imageUrl))
   item.imageUrl = itemProperties.imageUrl;
  if(ASPx.IsExists(itemProperties.imageHottrackSrc))
   item.imageHottrackSrc = itemProperties.imageHottrackSrc;
  if(ASPx.IsExists(itemProperties.imageClassName))
   item.imageClassName = itemProperties.imageClassName;
  if(ASPx.IsExists(itemProperties.navigateUrl))
   item.navigateUrl = itemProperties.navigateUrl;
  if(ASPx.IsExists(itemProperties.beginGroup))
   item.beginGroup = itemProperties.beginGroup;
  if(ASPx.IsExists(itemProperties.enabled) && !this.menu.NeedCreateItemsOnClientSide())
   item.enabled = itemProperties.enabled;
  if((ASPx.IsExists(itemProperties.clientEnabled) && !itemProperties.clientEnabled) || (ASPx.IsExists(itemProperties.enabled) && !itemProperties.enabled))
   item.clientEnabled = false;
  if(ASPx.IsExists(itemProperties.visible))
   item.visible = itemProperties.visible;
  if(ASPx.IsExists(itemProperties.clientVisible))
   item.clientVisible = itemProperties.clientVisible;
  if(ASPx.IsExists(itemProperties.groupName)) {
   this.menu.ProcessItemGroupName(item, itemProperties.groupName);
   item.checked = !!itemProperties.checked;
  }
  if(ASPx.IsExists(itemProperties.tooltip))
   item.tooltip = itemProperties.tooltip;
  if(ASPx.IsExists(itemProperties.target))
   item.target = itemProperties.target;
  if(ASPx.IsExists(itemProperties.dropDownMode))
   item.dropDownMode = itemProperties.dropDownMode;
  if(ASPx.IsExists(itemProperties.textTemplate))
   item.textTemplate = itemProperties.textTemplate;
  if(ASPx.IsExists(itemProperties.styles))
   item.styles = itemProperties.styles;
  if(ASPx.IsExists(itemProperties.isSvg))
   item.isSvg = itemProperties.isSvg;
  if(this.menu.NeedAppendToRenderData(item))
   this.menu.AppendToRenderData(this.indexPath, index);
  this.items.push(item);
  return item;
 },
 GetIndexPath: function() {
  return this.indexPath;
 },
 GetItemCount: function() {
  return this.items.length;
 },
 GetItem: function(index) {
  return (0 <= index && index < this.items.length) ? this.items[index] : null;
 },
 GetItemByName: function(name) {
  for(var i = 0; i < this.items.length; i++)
   if(this.items[i].name == name) return this.items[i];
  for(var i = 0; i < this.items.length; i++) {
   var item = this.items[i].GetItemByName(name);
   if(item != null) return item;
  }
  return null;
 },
 GetChecked: function() {
  var indexPath = this.GetIndexPath();
  return this.menu.IsCheckedItem(indexPath);
 },
 SetChecked: function(value) {
  var indexPath = this.GetIndexPath();
  this.menu.SetItemChecked(indexPath, value);
 },
 GetEnabled: function() {
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(value) {
  if(this.clientEnabled != value) {
   this.clientEnabled = value;
   this.menu.SetItemEnabled(this.GetIndexPath(), value, false);
  }
 },
 GetImage: function() {
  return this.menu.GetItemImage(this.GetIndexPath());
 },
 GetImageUrl: function() {
  return this.menu.GetItemImageUrl(this.GetIndexPath());
 },
 SetImageUrl: function(value) {
  var indexPath = this.GetIndexPath();
  this.menu.SetItemImageUrl(indexPath, value);
 },
 GetNavigateUrl: function() {
  var indexPath = this.GetIndexPath();
  return this.menu.GetItemNavigateUrl(indexPath);
 },
 SetNavigateUrl: function(value) {
  var indexPath = this.GetIndexPath();
  this.menu.SetItemNavigateUrl(indexPath, value);
 },
 GetText: function() {
  var indexPath = this.GetIndexPath();
  return this.menu.GetItemText(indexPath);
 },
 SetText: function(value) {
  var indexPath = this.GetIndexPath();
  this.menu.SetItemText(indexPath, value);
 },
 GetVisible: function() {
  return this.visible && this.clientVisible;
 },
 SetVisible: function(value) {
  if(this.clientVisible != value) {
   this.setClientVisibleInternal(value);
   this.menu.SetItemVisible(this.GetIndexPath(), value, false);
  }
 },
 InitializeEnabledAndVisible: function(recursive) {
  this.menu.SetItemEnabled(this.GetIndexPath(), this.clientEnabled, true);
  this.menu.SetItemVisible(this.GetIndexPath(), this.clientVisible, true);
  if(recursive) {
   for(var i = 0; i < this.items.length; i++)
    this.items[i].InitializeEnabledAndVisible(recursive);
  }
 },
 setClientVisibleInternal: function(value) {
  this.menu.prepareSideMenuCssClasses(false);
  this.clientVisible = value;
  this.menu.prepareSideMenuCssClasses(true);
 },
 GetOwnProperties: function() {
  return {
   menuItem: this,
   focusableElement: this.GetFocusableElement()
  };
 },
 GetFocusableElement: function() {
  return this.menu.GetLinkElementByIndexPath(this.indexPath);
 }
});
var subMenuStack = function() {
 this.stack = [];
 this.hasItems = function() {
  return this.stack.length > 1;
 };
 this.count = function() {
  return this.stack.length;
 };
 this.last = function() {
  return this.stack[this.stack.length - 1].element;
 };
 this.push = function(element, text) {
  this.stack.push({element: element, text: text});
 };
 this.pop = function() {
  return this.stack.pop().element;
 };
 this.text = function() {
  return this.stack[this.stack.length - 1].text;
 };
};
var appearPanelAction = ASPx.CreateClass({
 constructor: function(menu) {
  this.menu = menu;
  this.expanded = false;
  this.cashedHtmlOverflow = '';
  this.bodyLeftMargin = 0;
  this.clearWidth = 0;
  this.animationInProgress = false;
  this.panel = this.menu.GetMainElement().parentNode;
  this.burgerButton = this.createBurgerButton();
  this.overlayPanel = this.createOverlayElement();
  this.afterCollapsePanel = new ASPxClientEvent();
  ASPx.Evt.AttachEventToElement(this.burgerButton, 'click', function() { this.toggleExpanded(); }.bind(this), true);
  ASPx.Evt.AttachEventToElement(this.overlayPanel, 'click', function() { this.toggleExpanded(); }.bind(this), true);
 },
 get isLeftPosition() {
  return this.menu.position == 'left';
 },
 createBurgerButton: function() {
  var button = document.createElement('DIV');
  button.className = BURGER_CLASS_NAME;
  if(!!this.menu.hamburgerClass)
   ASPx.AddClassNameToElement(button, this.menu.hamburgerClass);
  var line = document.createElement('DIV');
  button.appendChild(line);
  this.panel.parentNode.appendChild(button);
  return button;
 },
 createOverlayElement: function() {
  var panel = document.createElement('DIV');
  panel.className = OVERLAY_PANEL_CLASS_NAME;
  this.panel.parentNode.appendChild(panel);
  return panel;
 },
 toggleExpanded: function() {
  this.setExpanded(!this.getExpanded());
 },
 getExpanded: function() {
  return this.expanded;
 },
 setExpanded: function(value) {
  if(this.expanded != value && !this.isAnimationInProgress()) {
   this.expanded = value;
   this.setExpandedCore();
  }
 },
 setExpandedCore: function() {
  if(this.expanded) {
   this.prepareForAnimateIn();
   this.animateIn();
  }
  else
   this.animateOut();
 },
 collapse: function() {
  this.expanded = false;
  this.rollbackAfterAnimateOut();
 },
 isAnimationInProgress: function() {
  return !!this.animationInProgress;
 },
 prepareForAnimateIn: function() {
  this.prepareDocument();
  this.prepareOverlayPanel();
  this.prepareSlidePanel();
 },
 prepareDocument: function() {
  this.cashedHtmlOverflow = document.documentElement.style.overflow;
  document.documentElement.style.overflow = 'hidden';
 },
 prepareOverlayPanel: function() {
  ASPx.SetStyles(this.overlayPanel, {
   opacity: '0',
   zIndex: SIDE_MENU_ZINDEX_VALUE,
   display: 'block'
  });
  ASPx.SetStyles(this.overlayPanel, {
   marginLeft: -ASPx.GetAbsoluteX(this.overlayPanel),
   marginTop: -ASPx.GetAbsoluteY(this.overlayPanel),
  });
 },
 prepareSlidePanel: function() {
  ASPx.SetStyles(this.panel, { display: 'block', width: '100%', zIndex: SIDE_MENU_ZINDEX_VALUE + 1 });
  this.menu.AdjustControl();
  var size = this.menu.calculateMaxSize();
  this.clearWidth = size.width;
  var width = size.width;
  var overflowY = '';
  if(size.height > window.innerHeight) {
   overflowY = 'scroll';
   width = size.width + ASPx.GetVerticalScrollBarWidth();
  }
  ASPx.SetStyles(this.panel, { 
   className: this.panel.className + ' ' + SLIDE_PANEL_EXPANDED_CLASS_NAME,
   overflowY: overflowY,
   width: width
  });
 },
 createTransition: function(element, obj) {
  return transition = ASPx.AnimationHelper.createAnimationTransition(element, {
   property: obj.property, unit: obj.unit, duration: SLIDE_DURATION_VALUE, transition: ASPx.AnimationConstants.Transitions.POW_EASE_OUT, onComplete: obj.onComplete
  });
 },
 getInTransitions: function() {
  var arr = [];
  arr.push({
   trans: this.createTransition(this.panel, { property: this.isLeftPosition ? 'left' : 'right', unit: 'px' }),
   start: -this.panel.offsetWidth,
   end: 0
  });
  arr.push({
   trans: this.createTransition(this.overlayPanel, {
    property: 'opacity',
    onComplete: function() {
     this.animationInProgress = false;
    }.aspxBind(this)
   }),
   start: 0,
   end: 100
  });
  return arr;
 },
 getOutTransitions: function() {
  var arr = [];
  arr.push({
   trans: this.createTransition(this.panel, { property: this.isLeftPosition ? 'left' : 'right', unit: 'px' }),
   start: 0,
   end: -this.panel.offsetWidth
  });
  arr.push({
   trans: this.createTransition(this.overlayPanel, {
    property: 'opacity',
    onComplete: function() {
     window.setTimeout(function() {
      this.rollbackAfterAnimateOut();
      this.animationInProgress = false;
     }.aspxBind(this), 0);
    }.aspxBind(this)
   }),
   start: 100,
   end: 0
  });
  return arr;
 },
 animateIn: function() {
  this.animate(this.getInTransitions());
 },
 animateOut: function() {
  this.animate(this.getOutTransitions());
 },
 animate: function(transitions) {
  this.animationInProgress = true;
  for(var i = 0, obj; obj = transitions[i]; i++)
   obj.trans.Start(obj.start, obj.end);
 },
 resetPanelStyle: function() {
  ASPx.SetStyles(this.panel, {
   className: this.panel.className.replace(SLIDE_PANEL_EXPANDED_CLASS_NAME, ''),
   left: '', width: '', display: '', zIndex: ''
  });
 },
 resetOverlayPanelStyle: function() {
  ASPx.SetStyles(this.overlayPanel, {
   display: '',
   zIndex: '',
   marginLeft: 0,
   marginTop: 0
  });
 },
 rollbackAfterAnimateOut: function() {
  this.resetPanelStyle();
  this.resetOverlayPanelStyle();
  document.documentElement.style.overflow = this.cashedHtmlOverflow;
  this.afterCollapsePanel.FireEvent();
 }
});
var appearPanelWithShiftBodyAction = ASPx.CreateClass(appearPanelAction, {
 constructor: function(menu) {
  this.cashedBodyMargin = '';
  this.cashedBodyWidth = '';
  this.constructor.prototype.constructor.call(this, menu);
 },
 getInTransitions: function() {
  var arr = appearPanelAction.prototype.getInTransitions.call(this);
  arr.push({
   trans: this.createTransition(document.body, { property: 'marginLeft', unit: 'px' }),
   start: this.bodyLeftMargin,
   end: (this.isLeftPosition ? 1 : -1) * (this.bodyLeftMargin + this.panel.offsetWidth)
  });
  return arr;
 },
 getOutTransitions: function() {
  var arr = appearPanelAction.prototype.getOutTransitions.call(this);
  arr.push({
   trans: this.createTransition(document.body, { property: 'marginLeft', unit: 'px' }),
   start: (this.isLeftPosition ? 1 : -1) * (this.bodyLeftMargin + this.panel.offsetWidth),
   end: this.bodyLeftMargin
  });
  return arr;
 },
 prepareForAnimateIn: function() {
  this.bodyLeftMargin = ASPx.PxToInt(ASPx.GetCurrentStyle(document.body).marginLeft);
  this.cashedBodyWidth = document.body.style.width;
  this.cashedBodyMargin = document.body.style.marginLeft;
  document.body.style.width = document.body.offsetWidth + 'px';
  appearPanelAction.prototype.prepareForAnimateIn.call(this);
 },
 rollbackAfterAnimateOut: function() {
  document.body.style.width = this.cashedBodyWidth;
  document.body.style.marginLeft = this.cashedBodyMargin;
  appearPanelAction.prototype.rollbackAfterAnimateOut.call(this);
 }
});
var ASPxClientMenu = ASPx.CreateClass(ASPxClientMenuBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isVertical = false;
  this.orientationChanged = false;
  this.firstSubMenuDirection = "Auto";
  this.enableSideMenu = false;
  this.sideMenuWindowInnerWidth = ASPx.MaxMobileWindowWidth;
  this.enableCollapseToIcons = false;
  this.collapseToIconsWindowInnerWidth = ASPx.MaxMobileWindowWidth;
  this.showPopOutImages = false;
  this.sideMenuModeOn = false;
  this.iconsViewModeOn = false;
  this.position = 'left'; 
  this.expandMode = 0; 
  this.direction = this.position == 'left' ? 1 : -1;
  this.appearAction = null;
  this.subMenuStack = null;
  this.breadCrumb = null;
 },
 InlineInitialize: function() {
  var mainElement = this.GetMainElement();
  if(this.enableSideMenu) {
   mainElement.parentNode.className += ' dxm-' + this.position;
   this.subMenuStack = new subMenuStack();
   this.subMenuStack.push(this.GetMainElement());
   this.appearAction = this.createAppearAction();
   this.breadCrumb = this.createBreadCrumbs();
   this.updateBreadCrumbsText('TEMP'); 
   this.switchMenuView(true);
  }
  this.switchBetweenTextAndIcons();
  this.renderHelper.ApplyItemsVerticalAlignment(mainElement);
  ASPxClientMenuBase.prototype.InlineInitialize.call(this);
 },
 BrowserWindowResizeSubscriber: function() {
  return ASPxClientMenuBase.prototype.BrowserWindowResizeSubscriber.call(this) || this.enableSideMenu || this.enableCollapseToIcons;
 },
 SetData: function(data){
  ASPxClientMenuBase.prototype.SetData.call(this, data);
  if(data.adaptiveModeData)
   this.SetAdaptiveMode(data.adaptiveModeData);
 },
 IsVertical: function(indexPath) {
  return this.isVertical || !this.IsRootItem(indexPath) || this.IsAdaptiveMenuItem(indexPath);
 },
 IsSidePanelExpanded: function() {
  return this.enableSideMenu && this.appearAction.getExpanded();
 },
 IsCorrectionDisableMethodRequired: function(indexPath) {
  return (indexPath.indexOf("i") == -1) && (this.firstSubMenuDirection == "RightOrBottom" || this.firstSubMenuDirection == "LeftOrTop");
 },
 SetAdaptiveMode: function(data) {
  this.enableAdaptivity = true;
  if(ASPx.Ident.IsArray(data))
   this.adaptiveItemsOrder = data;
  else
   for(var i = data - 1; i >= 0; i--)
    this.adaptiveItemsOrder.push(i.toString());
 }, 
 OnBrowserWindowResize: function(e) {
  if(this.KeyboardIsShownOnAndroid(e)) return;
  this.switchMenuView();
  this.switchBetweenTextAndIcons();
  this.AdjustControl();
 },
 KeyboardIsShownOnAndroid: function(e) {
  if(ASPx.Browser.AndroidMobilePlatform &&
   e && e.prevWndWidth !== undefined && e.wndWidth !== undefined && e.prevWndWidth === e.wndWidth) {
   var activeElement = document.activeElement;
   return !!activeElement && activeElement.tagName === "INPUT";
  }
  return false;
 },
 AdjustControlCore: function() {
  this.CorrectVerticalAlignment(ASPx.ClearHeight, this.GetPopOutElements, "PopOut", true);
  this.CorrectVerticalAlignment(ASPx.ClearVerticalMargins, this.GetPopOutImages, "PopOutImg", true);
  if(this.orientationChanged){
   this.renderHelper.ChangeOrientaion(this.GetMainElement(), this.isVertical);
   this.orientationChanged = false;
  }
  else
   this.renderHelper.CalculateMenuControl(this.GetMainElement());
  this.CorrectVerticalAlignment(ASPx.AdjustHeight, this.GetPopOutElements, "PopOut", true);
  this.CorrectVerticalAlignment(ASPx.AdjustVerticalMargins, this.GetPopOutImages, "PopOutImg", true);
 },
 GetCorrectionDisabledResult: function(x, toLeftX) {
  switch (this.firstSubMenuDirection) {
   case "RightOrBottom": {
    this.popupToLeft = false;
    return x;
   }
   case "LeftOrTop": {
    this.popupToLeft = true;
    return toLeftX;
   }
  }
 },
 IsHorizontalSubmenuNeedInversion: function(subMenuBottom, docClientHeight, menuItemTop, subMenuHeight, itemHeight) {
  if(this.firstSubMenuDirection == "Auto")
   return ASPxClientMenuBase.prototype.IsHorizontalSubmenuNeedInversion.call(this, subMenuBottom, docClientHeight, menuItemTop, subMenuHeight, itemHeight);
  return this.firstSubMenuDirection == "LeftOrTop";
 },
 createAppearAction: function() {
  var appearAction = this.expandMode == 0 ? new appearPanelWithShiftBodyAction(this) : new appearPanelAction(this);
  appearAction.afterCollapsePanel.AddHandler(function() {
   while(this.subMenuStack.hasItems())
    this.performBack(true);
   ASPx.SetStyles(this.subMenuStack.last(), { left: '', opacity: '', display: '' });
   ASPx.RemoveElement(this.breadCrumb);
  }.aspxBind(this));
  return appearAction;
 },
 createBreadCrumbs: function() {
  var element = document.createElement('DIV');
  element.className = BREAD_CRUMBS_CLASS_NAME;
  ASPx.Evt.AttachEventToElement(element, 'click', function() { this.performBack(); }.bind(this), true);
  var breadCrumbsBackImage = document.createElement('IMG');
  breadCrumbsBackImage.src = ASPx.EmptyImageUrl;
  breadCrumbsBackImage.className = BACK_ICON_CLASS_NAME;
  element.appendChild(breadCrumbsBackImage);
  var breadCrumbsTitle = document.createElement('SPAN');
  element.appendChild(breadCrumbsTitle);
  return element;
 },
 updateBreadCrumbsText: function() {
  var text = this.subMenuStack.text();
  if(text)
   this.breadCrumb.children[1].innerHTML = this.subMenuStack.text();
 },
 calculateMaxSize: function() {
  var mainElement = this.GetMainElement();
  var cachedWidth = mainElement.style.width;
  mainElement.style.width = '';
  var size = { width: mainElement.offsetWidth, height: mainElement.offsetHeight };
  this.foreachSubMenus(function(item, element) {
   if(!element) return;
   element.className += ' ' + TEMPORARY_VISIBILITY_CLASS_NAME;
   if(element.offsetWidth > size.width)
    size.width = element.offsetWidth;
   if(element.offsetHeight > size.height)
    size.height = element.offsetHeight;
   element.className = element.className.replace(' ' + TEMPORARY_VISIBILITY_CLASS_NAME, '');
  }.bind(this));
  mainElement.style.width = cachedWidth;
  return size;
 },
 foreachSubMenus: function(menuItem, callback) {
  if(arguments.length == 1) {
   callback = menuItem;
   menuItem = this.GetRootItem();
  }
  for(var i = 0, item; item = menuItem.items[i]; i++)
   this.foreachSubMenus(item, callback);
  if(menuItem.indexPath && menuItem.items.length)
   callback(menuItem, this.GetMenuElement(menuItem.indexPath));
 },
 switchMenuView: function(force) {
  if(this.enableSideMenu) {
   aspxGetMenuCollection().DoHidePopupMenus(null, 0, this.name, true, "");
   var prevSideMenuOn = this.sideMenuModeOn;
   this.sideMenuModeOn = window.innerWidth < this.sideMenuWindowInnerWidth;
   if(this.sideMenuModeOn != prevSideMenuOn || force)
    this.switchMenuViewCore();
  }
 },
 switchBetweenTextAndIcons: function() {
  if(this.enableCollapseToIcons) {
   var newIconsViewModeOn = window.innerWidth <= this.collapseToIconsWindowInnerWidth;
   if(this.iconsViewModeOn != newIconsViewModeOn)
    this.ToggleRootItemsCollapsed();
  }
 },
 ToggleRootItemsCollapsed: function() {
  this.iconsViewModeOn = !this.iconsViewModeOn;
  ASPx.ToggleClassNameToElement(this.GetMainElement(), "dxm-onlyIcons", this.iconsViewModeOn);
  if(this.isInitialized) {
   this.renderHelper.ResetMinSize();
   this.renderHelper.CalculateMenuControl(this.GetMainElement(), true);
  }
 },
 switchMenuViewCore: function() {
  if(this.sideMenuModeOn)
   this.switchToSideMenuView();
  else
   this.switchToDefaultMenuView();
 },
 switchToSideMenuView: function() {
  this.SetOrientation('Vertical');
  this.switchSideMenuClass();
  if(!this.showPopOutImages) {
   var mainElement = this.GetMainElement();
   this.replacePopupOutImages(MenuCssClasses.ItemWithoutSubMenu, MenuCssClasses.ItemWithSubMenu);
   mainElement.className = mainElement.className.replace(NO_MAIN_POP_OUT_CLASS_NAME, '');
  }
 },
 switchToDefaultMenuView: function() {
  if(!this.showPopOutImages) {
   var mainElement = this.GetMainElement();
   this.replacePopupOutImages(MenuCssClasses.ItemWithSubMenu, MenuCssClasses.ItemWithoutSubMenu);
   if(mainElement.className.indexOf(NO_MAIN_POP_OUT_CLASS_NAME) == -1)
    mainElement.className += ' ' + NO_MAIN_POP_OUT_CLASS_NAME;
  }
  this.SetOrientation('Horizontal');
  this.switchSideMenuClass();
  this.appearAction.collapse();
 },
 switchSideMenuClass: function() {
  var rootElement = this.GetMainElement().parentNode.parentNode;
  if(this.sideMenuModeOn) {
   if(rootElement.className.indexOf(SIDE_MENU_CLASS_NAME) == -1)
    rootElement.className += ' ' + SIDE_MENU_CLASS_NAME;
  }
  else
   rootElement.className = rootElement.className.replace(' ' + SIDE_MENU_CLASS_NAME, '');
 },
 replacePopupOutImages: function(firstClass, secondClass) {
  var elements = this.renderHelper.GetItemElements(this.GetMainElement());
  for(var i = 0, item = null; item = elements[i]; i++) {
   if(item.className.indexOf(firstClass))
    item.className = item.className.replace(firstClass, secondClass);
  }
 },
 CalculateSubMenuPosition: function(element, x, y, indexPath, enableAnimation) {
  if(this.sideMenuModeOn)
   this.performForward(indexPath);
  else
   ASPxClientMenuBase.prototype.CalculateSubMenuPosition.call(this, element, x, y, indexPath, enableAnimation);
 },
 startPanelAnimation: function(element, props, onComplete) {
  ASPx.AnimationHelper.createMultipleAnimationTransition(element, {
   duration: SLIDE_DURATION_VALUE,
   transition: ASPx.AnimationConstants.Transitions.POW_EASE_OUT,
   onComplete: onComplete
  }).Start(props);
 },
 changeBreadCrumbsParent: function(parent) {
  if(this.subMenuStack.count() == 1 && !parent.querySelector('.' + BREAD_CRUMBS_CLASS_NAME))
   parent.appendChild(this.breadCrumb);
 },
 performForward: function(indexPath) {
  var element = this.GetMenuElement(indexPath);
  if(element != null) {
   var currentSubMenu = this.subMenuStack.last();
   var currentSubMenuWidth = currentSubMenu.offsetWidth;
   var nextSubMenu = this.GetMenuElement(indexPath);
   this.setSubMenuVisible(nextSubMenu);
   this.changeBreadCrumbsParent(nextSubMenu);
   this.subMenuStack.push(nextSubMenu, this.GetItemByIndexPath(indexPath).GetText());
   this.updateBreadCrumbsText();
   this.setSubMenuSize(indexPath, nextSubMenu);
   this.startPanelAnimation(currentSubMenu, {
    left: { from: 0, to: this.direction * -(currentSubMenuWidth / 3), unit: "px" },
    opacity: { from: 1, to: 0 }
   }, function(el) { el.style.display = 'none'; el.style.opacity = ''; });
   window.setTimeout(function() {
    this.startPanelAnimation(nextSubMenu, {
     left: { from: this.direction * currentSubMenuWidth, to: 0, unit: "px" },
     opacity: { from: 0, to: 1 }
    }, function(element) { this.onNextSubmenuAnimationEnd(element); }.bind(this));
   }.bind(this), SLIDE_DURATION_VALUE / 3);
  }
 },
 setSubMenuVisible: function(subMenu) {
  ASPx.SetStyles(subMenu, {
   top: '', display: '', visibility: '', opacity: 0
  });
 },
 setSubMenuSize: function(indexPath, subMenu) {
  var menuElement = this.GetMenuElement(indexPath);
  menuElement.style.width = this.appearAction.clearWidth + 'px';
  subMenu.children[0].style.top = this.breadCrumb.offsetHeight + 'px';
 },
 onNextSubmenuAnimationEnd: function(element) {
  if(element.children.length > 1)
   element.parentNode.appendChild(this.breadCrumb);
 },
 performBack: function(skipAnimation) {
  if(this.subMenuStack.hasItems()) {
   var currentSubMenu = this.subMenuStack.pop();
   var prevSubMenu = this.subMenuStack.last();
   if(skipAnimation)
    this.performBackWithoutAnimation(currentSubMenu, prevSubMenu);
   else
    this.performBackWithAnimation(currentSubMenu, prevSubMenu);
  }
 },
 performBackWithoutAnimation: function(currentSubMenu, prevSubMenu) {
  this.DoHidePopupMenu(null, currentSubMenu);
 },
 performBackWithAnimation: function(currentSubMenu, prevSubMenu) {
  this.updateBreadCrumbsText();
  this.changeBreadCrumbsParent(currentSubMenu);
  var width = currentSubMenu.offsetWidth;
  prevSubMenu.style.opacity = '0';
  prevSubMenu.style.display = '';
  this.startPanelAnimation(currentSubMenu, {
   left: { from: 0, to: this.direction * (width / 3), unit: "px" },
   opacity: { from: 1, to: 0 }
  }, function(el) { el.style.opacity = ''; el.style.display = 'none'; this.DoHidePopupMenu(null, el); }.bind(this));
  window.setTimeout(function() {
   this.startPanelAnimation(prevSubMenu, {
    left: { from: this.direction * -width, to: 0, unit: "px" },
    opacity: { from: 0, to: 1 }
   });
  }.bind(this), SLIDE_DURATION_VALUE / 3);
 },
 GetOrientation: function() {
  return this.isVertical ? "Vertical" : "Horizontal";
 },
 SetOrientation: function(orientation) {
  var isVertical = orientation === "Vertical";
  if(this.isVertical !== isVertical){
   this.isVertical = isVertical;
   this.orientationChanged = true;
   this.ResetControlAdjustment();
   this.AdjustControl();
  }
 },
 ToggleSideMenu: function() {
  if(this.sideMenuModeOn)
   this.appearAction.toggleExpanded();
 }
});
ASPx.Ident.scripts.ASPxClientMenu = true;
ASPxClientMenu.Cast = ASPxClientControl.Cast;
var ASPxClientMenuExt = ASPx.CreateClass(ASPxClientMenu, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
 },
 NeedCreateItemsOnClientSide: function() {
  return true;
 }
});
var ASPxClientMenuItemEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(item) {
  this.constructor.prototype.constructor.call(this);
  this.item = item;
 }
});
var ASPxClientMenuItemMouseEventArgs = ASPx.CreateClass(ASPxClientMenuItemEventArgs, {
 constructor: function(item, htmlElement) {
  this.constructor.prototype.constructor.call(this, item);
  this.htmlElement = htmlElement;
 }
});
var ASPxClientMenuItemClickEventArgs = ASPx.CreateClass(ASPxClientProcessingModeEventArgs, {
 constructor: function(processOnServer, item, htmlElement, htmlEvent) {
  this.constructor.prototype.constructor.call(this, processOnServer);
  this.item = item;
  this.htmlElement = htmlElement;
  this.htmlEvent = htmlEvent;
 }
});
ASPx.Evt.AttachEventToDocument(ASPx.TouchUIHelper.touchMouseDownEventName, function(evt) {
 return aspxGetMenuCollection().OnMouseDown(evt);
});
function aspxAMIMOver(source, args) {
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnAfterItemOver(args.item, args.element);
}
function aspxBMIMOver(source, args) {
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnBeforeItemOver(args.item, args.element);
}
function aspxAMIMOut(source, args) {
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null) menu.OnAfterItemOut(args.item, args.element, args.toElement);
}
function aspxMSBOver(source, args) {
 var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
 if(menu != null) menu.ClearDisappearTimer();
}
ASPx.AddAfterSetFocusedState(aspxAMIMOver);
ASPx.AddAfterClearFocusedState(aspxAMIMOut);
ASPx.AddAfterSetHoverState(aspxAMIMOver);
ASPx.AddAfterClearHoverState(aspxAMIMOut);
ASPx.AddBeforeSetFocusedState(aspxBMIMOver);
ASPx.AddBeforeSetHoverState(aspxBMIMOver);
ASPx.AddAfterSetHoverState(aspxMSBOver);
ASPx.AddAfterSetPressedState(aspxMSBOver);
ASPx.AddBeforeDisabled(function(source, args) {
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null)
  menu.OnBeforeItemDisabled(args.item, args.element);
});
ASPx.AddFocusedItemKeyDown(function(source, args) {
 var menu = aspxGetMenuCollection().GetMenu(args.item.name);
 if(menu != null)
  menu.OnFocusedItemKeyDown(args.htmlEvent, args.item);
});
ASPx.AddAfterClearHoverState(function(source, args) {
 var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
 if(menu != null) menu.SetDisappearTimer();
});
ASPx.AddAfterSetPressedState(function(source, args) {
 var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
 if(menu) menu.StartScrolling(args.element.id, 1, 4);
});
ASPx.AddAfterClearPressedState(function(source, args) {
 var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
 if(menu) menu.StopScrolling(args.element.id);
});
if(!ASPx.Browser.TouchUI) {
 ASPx.AddAfterSetHoverState(function(source, args) {
  var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
  if(menu) menu.StartScrolling(args.element.id, 15, 1);
  if(!menu)
   menu = aspxGetMenuCollection().GetMenu(args.item.name);
  if(menu && menu.sideMenuModeOn && menu.IsItemElement(args.element)) {
   menu.hoverItemName = args.item.name;
   menu.MarkPrecedingItem(args.item.name, PRE_HOVERED_ELEMENT_CLASS_NAME, true);
  }
 });
 ASPx.AddAfterClearHoverState(function(source, args) {
  var menu = MenuScrollHelper.GetMenuByScrollButtonId(args.element.id);
  if(menu) menu.StopScrolling(args.element.id);
  if(!menu)
   menu = aspxGetMenuCollection().GetMenu(args.item.name);
  if(menu && menu.sideMenuModeOn && menu.IsItemElement(args.element)) {
   menu.hoverItemName = null;
   menu.UnmarkPrecedingItem(args.item.name, PRE_HOVERED_ELEMENT_CLASS_NAME, true);
  }
 });
}
ASPx.MIClick = function(evt, name, indexPath) {
 if(ASPx.TouchUIHelper.isMouseEventFromScrolling) return;
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemClick(indexPath, evt);
};
ASPx.MIDDClick = function(evt, name, indexPath) {
 var menu = aspxGetMenuCollection().Get(name);
 if(menu != null) menu.OnItemDropDownClick(indexPath, evt);
 if(!ASPx.Browser.NetscapeFamily)
  evt.cancelBubble = true;
};
ASPx.GetMenuCollection = aspxGetMenuCollection;
ASPx.MenuRenderHelper = MenuRenderHelper;
ASPx.MenuItemClasses = MenuCssClasses;
window.ASPxClientMenuBase = ASPxClientMenuBase;
window.ASPxClientMenuCollection = ASPxClientMenuCollection;
window.ASPxClientMenuItem = ASPxClientMenuItem;
window.ASPxClientMenu = ASPxClientMenu;
window.ASPxClientMenuExt = ASPxClientMenuExt;
window.ASPxClientMenuItemEventArgs = ASPxClientMenuItemEventArgs;
window.ASPxClientMenuItemMouseEventArgs = ASPxClientMenuItemMouseEventArgs;
window.ASPxClientMenuItemClickEventArgs = ASPxClientMenuItemClickEventArgs;
})();

(function () {
ASPxClientCallbackPanel = ASPx.CreateClass(ASPxClientPanel, {
 constructor: function (name) {
  this.constructor.prototype.constructor.call(this, name);
  this.hideContentOnCallback = true;
  this.isLoadingPanelTextEmpty = false;
 },
 OnCallback: function (result) {
  ASPx.SetInnerHtml(this.getContentElement(), result);
  if(this.touchUIScroller)
   this.touchUIScroller.ChangeElement(this.getContentElement());
 },
 ShowLoadingPanel: function () {
  var element = this.getContentElement();
  var mainElement = (element.tagName == "TD") ? this.GetMainElement() : element;
  if(!this.hideContentOnCallback)
   this.CreateLoadingPanelWithAbsolutePosition(this.GetMainElement().parentNode, mainElement);
  else
   this.CreateLoadingPanelInsideContainer(element, true, true, false);
 },
 ShowLoadingDiv: function () {
  this.CreateLoadingDiv(this.GetMainElement().parentNode, this.getContentElement());
 },
 GetCallbackAnimationElement: function() {
  return this.getContentElement();
 },
 PerformCallback: function (parameter, onSuccess) {
  this.CreateCallback(parameter, null, null, onSuccess);
 },
 CreateCallback: function (arg, command, callbackInfo, handler) {
  this.ShowLoadingElements();
  ASPxClientControl.prototype.CreateCallback.call(this, arg, command, handler);
 },
 GetLoadingPanelTextLabelID: function () {
  return this.name + "_TL";
 },
 GetLoadingPanelTextLabel: function () {
  return ASPx.GetElementById(this.GetLoadingPanelTextLabelID());
 },
 GetLoadingPanelText: function () {
  var textLabel = this.GetLoadingPanelTextLabel();
  if(textLabel && !this.isLoadingPanelTextEmpty)
   return textLabel.innerHTML;
  return "";
 },
 SetLoadingPanelText: function (text) {
  this.isLoadingPanelTextEmpty = text == null || text == "";
  var textLabel = this.GetLoadingPanelTextLabel();
  if(textLabel)
   textLabel.innerHTML = this.isLoadingPanelTextEmpty ? "&nbsp;" : text;
 },
 SetContentHtml: function (html, useAnimation) {
  ASPxClientPanel.prototype.SetContentHtml.call(this, html);
  if(useAnimation && typeof(ASPx.AnimationHelper) != "undefined")
   ASPx.AnimationHelper.fadeIn(this.getContentElement());
 }
});
ASPxClientCallbackPanel.Cast = ASPxClientControl.Cast;
window.ASPxClientCallbackPanel = ASPxClientCallbackPanel;
})();
(function() {
var ASPxClientEditBase = ASPx.CreateClass(ASPxClientControl, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.EnabledChanged = new ASPxClientEvent();
  this.captionPosition = ASPx.Position.Left;
  this.showCaptionColon = true;
  this.scPrefix = "dxe";
 },
 InlineInitialize: function(){
  ASPxClientControl.prototype.InlineInitialize.call(this);
  this.InitializeEnabled(); 
  this.InitializeEvents();
 },
 InitializeEnabled: function() {
  this.SetEnabledInternal(this.clientEnabled, true);
 },
 InitializeEvents: function() { },
 AddDefaultReadOnlyStateControllerItem: function(cssClass, mainElementId) {
  ASPx.AddReadOnlyItems(mainElementId, [[[cssClass], [''], ['']]]);
 },
 AddDefaultDisabledStateControllerItem: function(cssClass, mainElementId) {
  ASPx.AddDisabledItems(mainElementId, [[[cssClass], [''], ['']]]);
 },
 GetValue: function() {
  var element = this.GetMainElement();
  if(ASPx.IsExistsElement(element))
   return element.innerHTML;
  return "";
 },
 GetValueString: function(){
  var value = this.GetValue();
  return (value == null) ? null : value.toString();
 },
 EnsureValueStringIsActual: function() {
  if(this.maskInfo != null)
   this.ParseValue();
 },
 SetValue: function(value) {
  if(value == null)
   value = "";
  var element = this.GetMainElement();
  if(ASPx.IsExistsElement(element))
   element.innerHTML = value;
 },
 GetEnabled: function(){
  return this.enabled && this.clientEnabled;
 },
 SetEnabled: function(enabled){
  if(this.clientEnabled != enabled) {
   var errorFrameRequiresUpdate = this.GetIsValid && !this.GetIsValid();
   if(errorFrameRequiresUpdate && !enabled)
    this.UpdateErrorFrameAndFocus(false , null , true );
   this.clientEnabled = enabled;
   this.SetEnabledInternal(enabled, false);
   if(errorFrameRequiresUpdate && enabled)
    this.UpdateErrorFrameAndFocus(false );
   this.RaiseEnabledChangedEvent();
  }
 },
 SetEnabledInternal: function(enabled, initialization){
  if(!this.enabled) return;
  if(!initialization || !enabled)
   this.ChangeEnabledStateItems(enabled);
  this.ChangeEnabledAttributes(enabled);
  if(ASPx.Browser.Chrome) {   
   var mainElement = this.GetMainElement();
   if(mainElement)
    mainElement.className = mainElement.className;
  } 
 },
 ChangeEnabledAttributes: function(enabled){
 },
 ChangeEnabledStateItems: function(enabled){
 },
 RaiseEnabledChangedEvent: function(){
  if(!this.EnabledChanged.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.EnabledChanged.FireEvent(this, args);
  }
 },
 GetDecodeValue: function (value) { 
  if(typeof (value) == "string" && value.length > 1)
   value = this.SimpleDecodeHtml(value);
  return value;
 },
 SimpleDecodeHtml: function (html) {
  return ASPx.Str.ApplyReplacement(html, [
   [/&lt;/g, '<'],
   [/&amp;/g, '&'],
   [/&quot;/g, '"'],
   [/&#39;/g, '\''],
   [/&#32;/g, ' ']
  ]);
 },
 GetCachedElementById: function(idSuffix) {
  return ASPx.CacheHelper.GetCachedElementById(this, this.name + idSuffix);
 },
 GetCaptionCell: function() {
  return this.GetCachedElementById(EditElementSuffix.CaptionCell);
 },
 GetExternalTable: function() {
  return this.GetCachedElementById(EditElementSuffix.ExternalTable);
 },
 getCaptionRelatedCellCount: function() {
  if(!this.captionRelatedCellCount)
   this.captionRelatedCellCount = ASPx.GetNodesByClassName(this.GetExternalTable(), CaptionRelatedCellClassName).length;
  return this.captionRelatedCellCount;
 },
 addCssClassToCaptionRelatedCells: function() {
  if(this.captionPosition == ASPx.Position.Left || this.captionPosition == ASPx.Position.Right) {
   var captionRelatedCellsIndex = this.captionPosition == ASPx.Position.Left ? 0 : this.GetCaptionCell().cellIndex;
   for(var i = 0; i < this.GetExternalTable().rows.length; i++)
    ASPx.AddClassNameToElement(this.GetExternalTable().rows[i].cells[captionRelatedCellsIndex], CaptionRelatedCellClassName);
  }
  if(this.captionPosition == ASPx.Position.Top || this.captionPosition == ASPx.Position.Bottom)
   for(var i = 0; i < this.GetCaptionCell().parentNode.cells.length; i++)
    ASPx.AddClassNameToElement(this.GetCaptionCell().parentNode.cells[i], CaptionRelatedCellClassName);
 },
 GetCaption: function() {
  if(ASPx.IsExists(this.GetCaptionCell()))
   return this.getCaptionInternal();
  return "";
 },
 SetCaption: function(caption) {
  if(!ASPx.IsExists(this.GetCaptionCell()))
   return;
  if(this.getCaptionRelatedCellCount() == 0)
   this.addCssClassToCaptionRelatedCells();
  if(caption !== "")
   ASPx.RemoveClassNameFromElement(this.GetExternalTable(), ASPxEditExternalTableClassNames.TableWithEmptyCaptionClassName);
  else
   ASPx.AddClassNameToElement(this.GetExternalTable(), ASPxEditExternalTableClassNames.TableWithEmptyCaptionClassName);
  this.setCaptionInternal(caption);
 },
 getCaptionTextNode: function() {
  var captionElement = ASPx.GetNodesByPartialClassName(this.GetCaptionCell(), CaptionElementPartialClassName)[0];
  return ASPx.GetNormalizedTextNode(captionElement);
 },
 getCaptionInternal: function() {
  var captionText = this.getCaptionTextNode().nodeValue;
  if(captionText !== "" && captionText[captionText.length - 1] == ":")
   captionText = captionText.substring(0, captionText.length - 1);
  return captionText;
 },
 setCaptionInternal: function(caption) {
  caption = ASPx.Str.Trim(caption);
  var captionTextNode = this.getCaptionTextNode();
  if(this.showCaptionColon && caption[caption.length - 1] != ":" && caption !== "")
   caption += ":";
  captionTextNode.nodeValue = caption;
 },
 onVirtualKeyboardUITouchStart: function(evt) { }
});
var ValidationPattern = ASPx.CreateClass(null, {
 constructor: function(errorText) {
  this.errorText = errorText;
 }
});
var RequiredFieldValidationPattern = ASPx.CreateClass(ValidationPattern, {
 constructor: function(errorText) {
  this.constructor.prototype.constructor.call(this, errorText);
 },
 EvaluateIsValid: function(value) {
  return value != null && (value.constructor == Array || ASPx.Str.Trim(value.toString()) != "");
 }
});
var RegularExpressionValidationPattern = ASPx.CreateClass(ValidationPattern, {
 constructor: function(errorText, pattern) {
  this.constructor.prototype.constructor.call(this, errorText);
  this.pattern = pattern;
 },
 EvaluateIsValid: function(value) {
  if(value == null) 
   return true;
  var strValue = value.toString();
  if(ASPx.Str.Trim(strValue).length == 0)
   return true;
  var regEx = new RegExp(this.pattern);
  var matches = regEx.exec(strValue);
  return matches != null && strValue == matches[0];
 }
});
function _aspxIsEditorFocusable(inputElement) {
 return ASPx.IsFocusableCore(inputElement, function(container) {
  return container.getAttribute("errorFrame") == "errorFrame";
 });
}
var invalidEditorToBeFocused = null;
var ValidationType = {
 PersonalOnValueChanged: "ValueChanged",
 PersonalViaScript: "CalledViaScript",
 MassValidation: "MassValidation"
};
var ErrorFrameDisplay = {
 None: "None",
 Static: "Static",
 Dynamic: "Dynamic"
};
var EditElementSuffix = {
 ExternalTable: "_ET",
 ControlCell: "_CC",
 ErrorCell: "_EC",
 ErrorTextCell: "_ETC",
 ErrorImage: "_EI",
 CaptionCell: "_CapC",
 AccessibilityAdditionalTextRow: "_AHTR"
};
var ASPxEditExternalTableClassNames = {
 ValidStaticTableClassName: "dxeValidStEditorTable",
 ValidDynamicTableClassName: "dxeValidDynEditorTable",
 TableWithSeparateBordersClassName: "tableWithSeparateBorders",
 TableWithEmptyCaptionClassName: "tableWithEmptyCaption"
};
var CaptionRelatedCellClassName = "dxeCaptionRelatedCell";
var CaptionElementPartialClassName = "dxeCaption";
var AccessibilityAssistantID = "AcAs";
var ASPxClientEdit = ASPx.CreateClass(ASPxClientEditBase, {
 constructor: function(name) {
  this.constructor.prototype.constructor.call(this, name);
  this.isASPxClientEdit = true;
  this.inputElement = null;
  this.convertEmptyStringToNull = true;
  this.readOnly = false;
  this.clientReadOnly = false;
  this.focused = false;
  this.focusEventsLocked = false;
  this.receiveGlobalMouseWheel = true;
  this.styleDecoration = null;
  this.heightCorrectionRequired = false;
  this.customValidationEnabled = false;
  this.display = ErrorFrameDisplay.Static;
  this.initialErrorText = "";
  this.causesValidation = false;
  this.validateOnLeave = true;
  this.validationGroup = "";
  this.sendPostBackWithValidation = null;
  this.validationPatterns = [];
  this.setFocusOnError = false;
  this.errorDisplayMode = "it";
  this.errorText = "";
  this.isValid = true;
  this.errorImageIsAssigned = false;
  this.notifyValidationSummariesToAcceptNewError = false;
  this.isErrorFrameRequired = false;
  this.enterProcessed = false;
  this.keyDownHandlers = {};
  this.keyPressHandlers = {};
  this.keyUpHandlers = {};
  this.specialKeyboardHandlingUsed = false;
  this.onKeyDownHandler = null;
  this.onKeyPressHandler = null;
  this.onKeyUpHandler = null;
  this.onGotFocusHandler = null;
  this.onLostFocusHandler = null;
  this.GotFocus = new ASPxClientEvent();
  this.LostFocus = new ASPxClientEvent();
  this.Validation = new ASPxClientEvent();
  this.ValueChanged = new ASPxClientEvent();
  this.KeyDown = new ASPxClientEvent();
  this.KeyPress = new ASPxClientEvent();
  this.KeyUp = new ASPxClientEvent();
  this.eventHandlersInitialized = false;
  this.ariaExplanatoryTextManager = null;
 },
 SetData: function(data){
  if(data.decorationStyles){
   for(var i = 0; i < data.decorationStyles.length; i++)
    this.AddDecorationStyle(data.decorationStyles[i].key, 
     data.decorationStyles[i].className, 
     data.decorationStyles[i].cssText);
  }
 },
 Initialize: function() {
  this.initialErrorText = this.errorText;
  ASPxClientEditBase.prototype.Initialize.call(this);
  this.InitializeKeyHandlers();
  this.UpdateClientValidationState();
  this.UpdateValidationSummaries(null , true );
 },
 InlineInitialize: function() {
  ASPxClientEditBase.prototype.InlineInitialize.call(this);
  this.UpdateStyleDecorations();
  var externalTable = this.GetExternalTable();
  if(externalTable && ASPx.IsPercentageSize(externalTable.style.width)) {
   this.width = "100%";
   this.GetMainElement().style.width = "100%";
   if(this.isErrorFrameRequired)
    externalTable.setAttribute("errorFrame", "errorFrame");
  }
  this.ariaExplanatoryTextManager = this.CreateAriaExplanatoryTextManager();
  if(this.clientReadOnly)
   this.SetReadOnlyInternal(true);
  this.UpdateErrorCellParentRowVisibility();
 }, 
 AfterInitialize: function() {
  this.ariaExplanatoryTextManager.SetCaptionAssociating();
  this.ariaExplanatoryTextManager.UpdateText();
  this.ariaExplanatoryTextManager.UpdateValidationState();
  ASPxClientEditBase.prototype.AfterInitialize.call(this);
 },
 UpdateStyleDecorations: function() {
  if(this.styleDecoration)
   this.styleDecoration.Update();
 },
 InitSpecialKeyboardHandling: function(){
  var name = this.name;
  this.onKeyDownHandler = function(evt) { ASPx.KBSIKeyDown(name,evt); };
  this.onKeyPressHandler = function(evt) { ASPx.KBSIKeyPress(name, evt); };
  this.onKeyUpHandler = function(evt) { ASPx.KBSIKeyUp(name, evt); };
  this.onGotFocusHandler = function(evt) { ASPx.ESGotFocus(name); };
  this.onLostFocusHandler = function(evt) { ASPx.ESLostFocus(name); };
  this.specialKeyboardHandlingUsed = true;
  this.InitializeDelayedSpecialFocus();
 },
 InitializeKeyHandlers: function() {
 },
 AddKeyDownHandler: function(key, handler) {
  this.keyDownHandlers[key] = handler;
 },
 AddKeyPressHandler: function(key, handler) {
  this.keyPressHandlers[key] = handler;
 },
 ChangeSpecialInputEnabledAttributes: function(element, method, doNotChangeAutoComplete){
  if(!doNotChangeAutoComplete) 
   element.autocomplete = "off";
  if(this.onKeyDownHandler != null)
   method(element, "keydown", this.onKeyDownHandler);
  if(this.onKeyPressHandler != null)
   method(element, "keypress", this.onKeyPressHandler);
  if(this.onKeyUpHandler != null)
   method(element, "keyup", this.onKeyUpHandler);
  if(this.onGotFocusHandler != null)
   method(element, "focus", this.onGotFocusHandler);
  if(this.onLostFocusHandler != null)
   method(element, "blur", this.onLostFocusHandler);
 },
 CreateAriaExplanatoryTextManager: function() {
  if(this.accessibilityCompliant)
   return new EditAccessibilityExplanatoryTextManager(this);
  else 
   return new DisableAccessibilityExplanatoryTextManager(this);
 },
 UpdateClientValidationState: function() {
  if(!this.customValidationEnabled)
   return;
  var mainElement = this.GetMainElement();
  if(mainElement) {
   var validationState = !this.GetIsValid() ? ("-" + this.GetErrorText()) : "";
   this.UpdateStateObjectWithObject({ validationState: validationState });
  }
 },
 UpdateValidationSummaries: function(validationType, initializing) {
  if(ASPx.Ident.scripts.ASPxClientValidationSummary) {
   var summaryCollection = ASPx.GetClientValidationSummaryCollection();
   summaryCollection.OnEditorIsValidStateChanged(this, validationType, initializing && this.notifyValidationSummariesToAcceptNewError);
  }
 },
 FindInputElement: function(){
  return null;
 },
 GetInputElement: function(){
  if(!ASPx.IsExistsElement(this.inputElement))
   this.inputElement = this.FindInputElement();
  return this.inputElement;
 },
 GetFocusableInputElement: function() {
  return this.GetInputElement();
 },
 GetAccessibilityActiveElements: function() {
  return [this.GetInputElement()];
 },
 GetAccessibilityFirstActiveElement: function() {
  return this.accessibilityHelper ? 
    this.accessibilityHelper.getMainElement() : 
    this.GetAccessibilityActiveElements()[0];
 },
 GetAccessibilityAssistantElement: function() {
  return this.GetChildElement(AccessibilityAssistantID);
 },
 GetErrorImage: function() {
  return this.GetCachedElementById(EditElementSuffix.ErrorImage);
 },
 GetControlCell: function() {
  return this.GetCachedElementById(EditElementSuffix.ControlCell);
 },
 GetErrorCell: function() {
  return this.GetCachedElementById(EditElementSuffix.ErrorCell);
 },
 GetErrorTextCell: function() {
  return this.GetCachedElementById(this.errorImageIsAssigned ? EditElementSuffix.ErrorTextCell : EditElementSuffix.ErrorCell);
 },
 GetReadOnly: function() {
  return this.readOnly || this.clientReadOnly;
 },
 SetReadOnly: function(readOnly) {
  readOnly = !!readOnly;
  if(this.clientReadOnly === readOnly || this.readOnly)
   return;
  this.SetReadOnlyInternal(readOnly);
 },
 SetReadOnlyInternal: function(readOnly) {
  this.clientReadOnly = readOnly;
  this.ChangeReadOnlyStateItems(readOnly);
 },
 ChangeReadOnlyStateItems: function(readOnly) {
  ASPx.GetStateController().SetElementReadOnly(this.GetMainElement(), readOnly);
 },
 SetVisible: function (isVisible) {
  if(this.clientVisible == isVisible)
   return;
  var externalTable = this.GetExternalTable();
  if(externalTable) {
   ASPx.SetElementDisplay(externalTable, isVisible);
   if(this.customValidationEnabled) {
    var isValid = !isVisible ? true : void (0);
    this.UpdateErrorFrameAndFocus(false , true , isValid );
   }
  }
  ASPxClientControl.prototype.SetVisible.call(this, isVisible);
 },
 GetStateHiddenFieldName: function() {
  return this.uniqueID + "$State";
 },
 GetValueInputToValidate: function() {
  return this.GetInputElement();
 },
 IsVisible: function() {
  if(!this.clientVisible)
   return false;
  var element = this.GetMainElement();
  if(!element) 
   return false;
  while(element && element.tagName != "BODY") {
   if(element.getAttribute("errorFrame") != "errorFrame" && (!ASPx.GetElementVisibility(element) || !ASPx.GetElementDisplay(element)))
    return false;
   element = element.parentNode;
  }
  return true;
 },
 AdjustControlCore: function() {
  this.CollapseEditor();
  this.UnstretchInputElement();
  if(this.heightCorrectionRequired)
   this.CorrectEditorHeight();
 },
 CorrectEditorHeight: function() {
 },
 UnstretchInputElement: function() {
 },
 UseDelayedSpecialFocus: function() {
  return false;
 },
 GetDelayedSpecialFocusTriggers: function() {
  return [ this.GetMainElement() ];
 },
 InitializeDelayedSpecialFocus: function() {
  if(!this.UseDelayedSpecialFocus())
   return;
  this.specialFocusTimer = -1;    
  var handler = function(evt) { this.OnDelayedSpecialFocusMouseDown(evt); }.aspxBind(this);
  var triggers = this.GetDelayedSpecialFocusTriggers();
  for(var i = 0; i < triggers.length; i++)
   ASPx.Evt.AttachEventToElement(triggers[i], "mousedown", handler);
 },
 OnDelayedSpecialFocusMouseDown: function(evt) {
  window.setTimeout(function() { this.SetFocus(); }.aspxBind(this), 0);
 },
 IsFocusEventsLocked: function() {
  return this.focusEventsLocked;
 },
 LockFocusEvents: function() {
  if(!this.focused) return;
  this.focusEventsLocked = true;
 },
 UnlockFocusEvents: function() {
  this.focusEventsLocked = false;
 },
 ForceRefocusEditor: function(evt, isNativeFocus) {
  if(ASPx.Browser.VirtualKeyboardSupported && !this.ownerListBox) {
   var focusedEditor = ASPx.VirtualKeyboardUI.getFocusedEditor();
   if(ASPx.VirtualKeyboardUI.getInputNativeFocusLocked() && (!focusedEditor || focusedEditor === this))
     return;
   ASPx.VirtualKeyboardUI.setInputNativeFocusLocked(!isNativeFocus);
  }
  this.LockFocusEvents();
  this.BlurInputElement();
  window.setTimeout(function() { 
   if(ASPx.Browser.VirtualKeyboardSupported && !this.ownerListBox) {
    ASPx.VirtualKeyboardUI.setFocusEditorCore(this);
   } else {
    this.SetFocus();
   }
  }.aspxBind(this), 0);
 },
 BlurInputElement: function() {
  var inputElement = this.GetFocusableInputElement();
  if(inputElement && inputElement.blur)
   inputElement.blur();
 },
 IsEditorElement: function(element) {
  return this.GetMainElement() == element || ASPx.GetIsParent(this.GetMainElement(), element);
 },
 IsClearButtonElement: function(element) {
  return false;
 },
 IsElementBelongToInputElement: function(element) {
  return this.GetInputElement() == element;
 },
 OnFocusCore: function() {
  if(this.UseDelayedSpecialFocus())
   window.clearTimeout(this.specialFocusTimer);
  if(!this.IsFocusEventsLocked()){
   this.focused = true;
   ASPx.SetFocusedEditor(this);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   if(this.isInitialized)
    this.RaiseFocus();
  }
  else
   this.UnlockFocusEvents();
 },
 OnLostFocusCore: function() {
  if(!this.IsFocusEventsLocked()){
   this.focused = false;
   if(ASPx.GetFocusedEditor() === this)
    ASPx.SetFocusedEditor(null);
   if(this.styleDecoration)
    this.styleDecoration.Update();
   this.RaiseLostFocus();
  }
 },
 OnFocus: function() {
  if(!this.specialKeyboardHandlingUsed)
   this.OnFocusCore();
 },
 OnLostFocus: function() {
  if(this.isInitialized && !this.specialKeyboardHandlingUsed)
   this.OnLostFocusCore();
 },
 OnSpecialFocus: function() {
  if(this.isInitialized)
   this.OnFocusCore();
 },
 OnSpecialLostFocus: function() {
  if(this.isInitialized)
   this.OnLostFocusCore();
 },
 OnMouseWheel: function(evt){
 },
 OnValidation: function(validationType) {
  if(this.customValidationEnabled && this.isInitialized && ASPx.IsExistsElement(this.GetMainElement()) &&
   (!this.IsErrorFrameDisplayed() || this.GetElementRequiredForErrorFrame())) {
   this.BeginErrorFrameUpdate();
   try {
    if(this.validateOnLeave || validationType != ValidationType.PersonalOnValueChanged) {
     this.SetIsValid(true, true );
     this.SetErrorText(this.initialErrorText, true );
     this.ValidateWithPatterns();
     this.RaiseValidation();
    }
    this.UpdateErrorFrameAndFocus(this.editorFocusingRequired(validationType));
   } finally {
    this.EndErrorFrameUpdate();
   }
   this.UpdateValidationSummaries(validationType);
   this.ariaExplanatoryTextManager.UpdateValidationState(validationType);
  }
 },
 GetElementRequiredForErrorFrame: function() {
  return this.GetExternalTable();
 },
 editorFocusingRequired: function(validationType) {
  return !this.GetIsValid() &&
   validationType == ValidationType.PersonalViaScript && this.setFocusOnError;
 },
 OnValueChanged: function() {
  if(this.getProcessOnServerOnValueChanged())
   this.SendPostBackInternal("");
 },
 getProcessOnServerOnValueChanged: function() {
  var processOnServer = this.RaiseValidationInternal();
  return this.RaiseValueChangedEvent() && processOnServer;
 },
 ParseValue: function() {
 },
 RaisePersonalStandardValidation: function() {
  if(ASPx.IsFunction(window.ValidatorOnChange)) {
   var inputElement = this.GetValueInputToValidate();
   if(inputElement && inputElement.Validators)
    window.ValidatorOnChange({ srcElement: inputElement });
  }
 },
 RaiseValidationInternal: function() {
  if(this.isPostBackAllowed() && this.causesValidation && this.validateOnLeave)
   return ASPxClientEdit.ValidateGroup(this.validationGroup);
  else {
   this.OnValidation(ValidationType.PersonalOnValueChanged);
   return this.GetIsValid();
  }
 },
 RaiseValueChangedEvent: function(){
  return this.RaiseValueChanged();
 },
 SendPostBackInternal: function(postBackArg) {
  if(ASPx.IsFunction(this.sendPostBackWithValidation))
   this.sendPostBackWithValidation(postBackArg);
  else
   this.SendPostBack(postBackArg);
 },
 SetElementToBeFocused: function() {
  if(this.IsVisible())
   invalidEditorToBeFocused = this;
 },
 GetFocusSelectAction: function() {
  return null;
 },
 SetFocus: function() {
  var inputElement = this.GetFocusableInputElement();
  if(!inputElement) return; 
  var isIE9 = ASPx.Browser.IE && ASPx.Browser.Version >= 9;
  if((ASPx.GetActiveElement() != inputElement || isIE9) && _aspxIsEditorFocusable(inputElement))
   ASPx.SetFocus(inputElement, this.GetFocusSelectAction());
 },
 SetFocusOnError: function() {
  if(invalidEditorToBeFocused == this) {
   this.SetFocus();
   invalidEditorToBeFocused = null;
  }
 },
 BeginErrorFrameUpdate: function() {
  if(!this.errorFrameUpdateLocked)
   this.errorFrameUpdateLocked = true;
 },
 EndErrorFrameUpdate: function() {
  this.errorFrameUpdateLocked = false;
  var args = this.updateErrorFrameAndFocusLastCallArgs;
  if(args) {
   this.UpdateErrorFrameAndFocus(args[0], args[1]);
   delete this.updateErrorFrameAndFocusLastCallArgs;
  }
 },
 UpdateErrorFrameAndFocus: function(setFocusOnError, ignoreVisibilityCheck, isValid) {
  if(!this.GetEnabled() || !ignoreVisibilityCheck && !this.GetVisible())
   return;
  if(this.errorFrameUpdateLocked) {
   this.updateErrorFrameAndFocusLastCallArgs = [ setFocusOnError, ignoreVisibilityCheck ];
   return;
  }
  if(this.styleDecoration)
   this.styleDecoration.Update();
  if(typeof(isValid) == "undefined")
   isValid = this.GetIsValid();
  if(isValid && this.IsErrorFrameDisplayed())
   this.ChangeErrorFrameVisibility(false);
  else {
   var editorLocatedWithinVisibleContainer = this.IsVisible();
   if(this.IsErrorFrameDisplayed()) {
    this.UpdateErrorCellContent();
    this.ChangeErrorFrameVisibility(true);
   }
   if(editorLocatedWithinVisibleContainer) {
    if(setFocusOnError && this.setFocusOnError && invalidEditorToBeFocused == null) {
     this.SetElementToBeFocused();
     this.SetFocusOnError();
    }
   }
  }
 },
 ChangeErrorFrameVisibility: function(visible) {
  var externalTable = this.GetExternalTable();
  var isStaticDisplay = this.display == ErrorFrameDisplay.Static;
  if(!isStaticDisplay && visible) {
   this.EnsureControlCellStylesLoaded();
   this.RestoreControlCellStyles();
  }
  this.ChangeErrorCellVisibility(visible, isStaticDisplay);
  if(!isStaticDisplay && !visible) {
   this.EnsureControlCellStylesLoaded();
   this.ClearControlCellStyles();
  }
  var validExternalTableClassName = isStaticDisplay ? ASPxEditExternalTableClassNames.ValidStaticTableClassName
   : ASPxEditExternalTableClassNames.ValidDynamicTableClassName;
  ASPx.ToggleClassNameToElement(externalTable, validExternalTableClassName, !visible);
  this.UpdateErrorCellParentRowVisibility();
 },
 ChangeErrorCellVisibility: function(visible, useVisibilityAttribute) {
  var errorCell = this.GetErrorCell();
  if(errorCell) {
   if(useVisibilityAttribute)
    ASPx.SetElementVisibility(errorCell, visible);
   else
    ASPx.SetElementDisplay(errorCell, visible);
  }
 },
 UpdateErrorCellParentRowVisibility: function() {
  var errorCell = this.GetErrorCell();
  if(!errorCell || this.display == ErrorFrameDisplay.Static)
   return;
  var displayedCellCount = 0;
  var errorCellParentRow = errorCell.parentNode;
  for(var i = 0; i < errorCellParentRow.cells.length; i++) {
   var cell = errorCellParentRow.cells[i];
   if(ASPx.GetElementDisplay(cell))
    displayedCellCount++;
  }
  ASPx.SetElementDisplay(errorCellParentRow, displayedCellCount > 0);
 },
 EnsureControlCellStylesLoaded: function() {
  if(typeof(this.controlCellStyles) == "undefined") {
   var controlCell = this.GetControlCell();
   this.controlCellStyles = {
    cssClass: controlCell.className,
    style: this.ExtractElementStyleStringIgnoringVisibilityProps(controlCell)
   };
  }
 },
 ClearControlCellStyles: function() {
  this.ClearElementStyle(this.GetControlCell());
 },
 RestoreControlCellStyles: function() {
  var controlCell = this.GetControlCell();
  var externalTable = this.GetExternalTable();
  if(ASPx.Browser.WebKitFamily)
   this.MakeBorderSeparateForTable(externalTable);
  controlCell.className = this.controlCellStyles.cssClass;
  controlCell.style.cssText = this.controlCellStyles.style;
  if(ASPx.Browser.WebKitFamily)
   this.UndoBorderSeparateForTable(externalTable);
 },
 MakeBorderSeparateForTable: function(table) {
  ASPx.AddClassNameToElement(table, ASPxEditExternalTableClassNames.TableWithSeparateBordersClassName);
 },
 UndoBorderSeparateForTable: function(table) {
  setTimeout(function () {
   ASPx.RemoveClassNameFromElement(table, ASPxEditExternalTableClassNames.TableWithSeparateBordersClassName);
  }, 0);
 },
 ExtractElementStyleStringIgnoringVisibilityProps: function(element) {
  var savedVisibility = element.style.visibility;
  var savedDisplay = element.style.display;
  element.style.visibility = "";
  element.style.display = "";
  var styleStr = element.style.cssText;
  element.style.visibility = savedVisibility;
  element.style.display = savedDisplay;
  return styleStr;
 },
 ClearElementStyle: function(element) {
  if(!element)
   return;
  element.className = "";
  var excludedAttrNames = [
   "width", "display", "visibility",
   "position", "left", "top", "z-index",
   "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
   "float", "clear"
  ];
  var savedAttrValues = { };
  for(var i = 0; i < excludedAttrNames.length; i++) {
   var attrName = excludedAttrNames[i];
   var attrValue = element.style[attrName];
   if(attrValue)
    savedAttrValues[attrName] = attrValue;
  }
  element.style.cssText = "";
  for(var styleAttrName in savedAttrValues)
   if(savedAttrValues.hasOwnProperty(styleAttrName))
    element.style[styleAttrName] = savedAttrValues[styleAttrName];
 },
 Clear: function() {
  this.SetValue(null);
  this.SetIsValid(true);
  return true;
 },
 UpdateErrorCellContent: function() {
  if(this.errorDisplayMode.indexOf("t") > -1)
   this.UpdateErrorText();
  if(this.errorDisplayMode == "i")
   this.UpdateErrorImage();
 },
 UpdateErrorImage: function() {
  var image = this.GetErrorImage();
  if(ASPx.IsExistsElement(image)) {
   if(this.accessibilityCompliant) {
    ASPx.Attr.SetAttribute(image, "aria-label", this.errorText);
    var innerImg = ASPx.GetNodeByTagName(image, "IMG", 0);
    if(ASPx.IsExists(innerImg))
     innerImg.alt = this.errorText;
   }
   image.alt = this.errorText;
   image.title = this.errorText;
  } else {
   this.UpdateErrorText();
  }
 },
 UpdateErrorText: function() {
  var errorTextCell = this.GetErrorTextCell();
  if(ASPx.IsExistsElement(errorTextCell))
   errorTextCell.innerHTML = this.HtmlEncode(this.errorText);
 },
 ValidateWithPatterns: function() {
  if(this.validationPatterns.length > 0) {
   var value = this.GetValue();
   for(var i = 0; i < this.validationPatterns.length; i++) {
    var validator = this.validationPatterns[i];
    if(!validator.EvaluateIsValid(value)) {
     this.SetIsValid(false, true );
     this.SetErrorText(validator.errorText, true );
     return;
    }
   }
  }
 },
 OnSpecialKeyDown: function(evt){
  this.RaiseKeyDown(evt);
  var handler = this.keyDownHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnSpecialKeyPress: function(evt){
  this.RaiseKeyPress(evt);
  var handler = this.keyPressHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  if(ASPx.Browser.NetscapeFamily || ASPx.Browser.Opera){
   if(evt.keyCode == ASPx.Key.Enter)
    return this.enterProcessed;
  }
  return false;
 },
 OnSpecialKeyUp: function(evt){
  this.RaiseKeyUp(evt);
  var handler = this.keyUpHandlers[evt.keyCode];
  if(handler) 
   return this[handler](evt);
  return false;
 },
 OnKeyDown: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyDown(evt);
 },
 OnKeyPress: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyPress(evt);
 },
 OnKeyUp: function(evt) {
  if(!this.specialKeyboardHandlingUsed)
   this.RaiseKeyUp(evt);
 },
 RaiseKeyDown: function(evt){
  if(!this.KeyDown.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyDown.FireEvent(this, args);
  }
 },
 RaiseKeyPress: function(evt){
  if(!this.KeyPress.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyPress.FireEvent(this, args);
  }
 },
 RaiseKeyUp: function(evt){
  if(!this.KeyUp.IsEmpty()){
   var args = new ASPxClientEditKeyEventArgs(evt);
   this.KeyUp.FireEvent(this, args);
  }
 },
 RaiseFocus: function(){
  if(!this.GotFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.GotFocus.FireEvent(this, args);
  }
 },
 RaiseLostFocus: function(){
  if(!this.LostFocus.IsEmpty()){
   var args = new ASPxClientEventArgs();
   this.LostFocus.FireEvent(this, args);
  }
 },
 RaiseValidation: function() {
  if(this.customValidationEnabled && !this.Validation.IsEmpty()) {
   var currentValue = this.GetValue();
   var args = new ASPxClientEditValidationEventArgs(currentValue, this.errorText, this.GetIsValid());
   this.Validation.FireEvent(this, args);
   this.SetErrorText(args.errorText, true );
   this.SetIsValid(args.isValid, true );
   if(args.value != currentValue)
    this.SetValue(args.value);
  }
 },
 RaiseValueChanged: function(){
  var processOnServer = this.isPostBackAllowed();
  if(!this.ValueChanged.IsEmpty()){
   var args = new ASPxClientProcessingModeEventArgs(processOnServer);
   this.ValueChanged.FireEvent(this, args);
   processOnServer = args.processOnServer;
  }
  return processOnServer;  
 },
 isPostBackAllowed: function() {
  return this.autoPostBack;
 },
 AddDecorationStyle: function(key, className, cssText) {
  if(!this.styleDecoration) 
   this.RequireStyleDecoration();
  this.styleDecoration.AddStyle(key, className, cssText);
 }, 
 RequireStyleDecoration: function() {
  this.styleDecoration = this.CreateStyleDecoration();
  this.PopulateStyleDecorationPostfixes();
 },
 CreateStyleDecoration: function() {
  return new ASPx.EditorStyleDecoration(this);
 },
 PopulateStyleDecorationPostfixes: function() {
  this.styleDecoration.AddPostfix("");
 },
 LockStyleDecorationUpdate: function() {
  if(this.styleDecoration)
   this.styleDecoration.LockUpdate();
 },
 UnlockStyleDecorationUpdate: function() {
  if(this.styleDecoration)
   this.styleDecoration.UnlockUpdate();
 },
 Focus: function(){
  this.SetFocus();
 },
 GetIsValid: function() {
  var hasRequiredInputElement = !this.RequireInputElementToValidate() || ASPx.IsExistsElement(this.GetInputElement());
  if(!hasRequiredInputElement || this.IsErrorFrameDisplayed() && !ASPx.IsExistsElement(this.GetElementRequiredForErrorFrame()))
   return true;
  return this.isValid;
 },
 RequireInputElementToValidate: function() {
  return true;
 },
 IsErrorFrameDisplayed: function() {
  return this.display !== ErrorFrameDisplay.None;
 },
 GetErrorText: function(){
  return this.errorText;
 },
 SetIsValid: function(isValid, validating){
  if(this.customValidationEnabled && this.isValid != isValid) {
   this.isValid = isValid;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ValidationType.PersonalViaScript);
  }
 },
 SetErrorText: function(errorText, validating){
  if(this.customValidationEnabled && this.errorText != errorText) {
   this.errorText = errorText;
   this.UpdateErrorFrameAndFocus(false );
   this.UpdateClientValidationState();
   if(!validating)
    this.UpdateValidationSummaries(ValidationType.PersonalViaScript);
  }
 },
 Validate: function(){
  this.ParseValue();
  this.OnValidation(ValidationType.PersonalViaScript);
 },
 GetModifyEvent: function() {
  return this.ValueChanged;
 },
 EnsureRequiredNativeAttributesExists: function() { }
});
ASPx.Ident.scripts.ASPxClientEdit = true;
ASPx.focusedEditorName = "";
ASPx.GetFocusedEditor = function() {
 var focusedEditor = ASPx.GetControlCollection().Get(ASPx.focusedEditorName);
 if(focusedEditor && !focusedEditor.focused){
  ASPx.SetFocusedEditor(null);
  focusedEditor = null;
 }
 return focusedEditor;
};
ASPx.SetFocusedEditor = function(editor) {
 ASPx.focusedEditorName = editor ? editor.name : "";
};
ASPx.FindAssociatedLabelElements = function(editor) {
 var assocciatedLabels = [];
 var inputElement = editor.GetInputElement();
 if(!ASPx.IsExists(inputElement) || !inputElement.id) 
  return assocciatedLabels;
 var labels = ASPx.GetNodesByTagName(document, "LABEL");
 for(var i = 0; i < labels.length; i++) {
  if(!!labels[i].htmlFor && labels[i].htmlFor === inputElement.id)
   assocciatedLabels.push(labels[i]);
 }
 return assocciatedLabels;
};
var DisableAccessibilityExplanatoryTextManager = ASPx.CreateClass(null, {
 constructor: function(editor) {
  this.editor = editor;
 },
 GetAdditionalTextRowId: function() {
  return this.editor.name + EditElementSuffix.AccessibilityAdditionalTextRow;
 },
 GetErrorTextElement: function () {
  return !!this.editor.GetErrorTextCell() ? this.editor.GetErrorTextCell() : this.editor.GetErrorImage();
 },
 GetTextElement: function() { return null; },
 SetCaptionAssociating: function() { },
 UpdateText: function() { },
 UpdateValidationState: function(validationType) { },
 ToggleErrorAlert: function() { },
 SetOrRemoveText: function(accessibilityElements, textElement, setText, isLabel, isFirst) { }
});
var EditAccessibilityExplanatoryTextManager = ASPx.CreateClass(DisableAccessibilityExplanatoryTextManager, {
 constructor: function(editor) {
  this.constructor.prototype.constructor.call(this, editor);
  this.invisibleRowCssClassName = "dxAIR";
 },
 GetTextElement: function() {
  var mainElement = this.editor.GetMainElement();
  if(!mainElement) return null;
  var explanatoryText = "";
  var explanatoryTextElement = null;
  if(!!this.editor.nullText)
   explanatoryText = this.editor.nullText;
  else if(!!this.editor.helpTextObj)
   explanatoryTextElement = this.editor.helpTextObj.helpTextElement;
  else if(!!mainElement.title)
   explanatoryText = mainElement.title;
  if(explanatoryText && mainElement.tagName == "TABLE") {
   var assistantElement = this.editor.GetAccessibilityFirstActiveElement();
   if(assistantElement)
    ASPx.Attr.Aria.AppendLabel(assistantElement, explanatoryText, true);
  }
  return explanatoryTextElement;
 },
 SetCaptionAssociating: function() {
  var captionCell = this.editor.GetCaptionCell();
  if(!captionCell || captionCell.childNodes[0].tagName == "LABEL") return;
  var labelElement = captionCell.childNodes[0];
  ASPx.EditAccessibilityExplanatoryTextManager.SetLabelAssociating(this.editor, this.editor.GetAccessibilityFirstActiveElement(), labelElement);
 },
 UpdateText: function() {
  var additionalTextElement = this.GetTextElement();
  if(ASPx.IsExists(additionalTextElement)) {
   var pronounceElement = this.editor.GetAccessibilityFirstActiveElement();
   var hasAnyLabel = !!ASPx.Attr.GetAttribute(pronounceElement, "aria-label") || 
    !!ASPx.Attr.GetAttribute(pronounceElement, "aria-labelledby") ||
    ASPx.FindAssociatedLabelElements(this.editor).length > 0;
   this.SetOrRemoveText([pronounceElement], additionalTextElement, true, !hasAnyLabel, false);
  }
 },
 UpdateValidationState: function(validationType) {
  if(validationType == ValidationType.PersonalOnValueChanged && this.editor.accessibilityHelper) return;
  var accessibilityElements = this.editor.GetAccessibilityActiveElements();
  var errorTextElement = this.GetErrorTextElement();
  this.SetOrRemoveText(accessibilityElements, errorTextElement, !this.editor.isValid, false, true);
  if(accessibilityElements.length > 0 && !!errorTextElement) {
   for(var i = 0; i < accessibilityElements.length; i++) {
    if(!ASPx.IsExists(accessibilityElements[i])) continue;
    ASPx.Attr.SetOrRemoveAttribute(accessibilityElements[i], "aria-invalid", !this.editor.isValid);
   }
  }
 },
 ToggleErrorAlert: function() {
  var errorTextElement = this.GetErrorTextElement();
  ASPx.SetElementDisplay(errorTextElement, false);
  ASPx.Attr.SetAttribute(errorTextElement, 'role', 'alert');
  ASPx.SetElementDisplay(errorTextElement, true);
  setTimeout(function() { ASPx.Attr.RemoveAttribute(errorTextElement, 'role'); }, 500);
 },
 SetOrRemoveText: function(accessibilityElements, textElement, setText, isLabel, isFirst) {
  var idsRefAttribute = isLabel ? ASPx.Attr.Aria.labelled : ASPx.Attr.Aria.described;
  if(!textElement) return;
  var textId = !!textElement.id ? textElement.id : textElement.parentNode.id;
  for(var i = 0; i < accessibilityElements.length; i++) {
   if(!accessibilityElements[i]) continue;
   var descRefString = ASPx.Attr.GetAttribute(accessibilityElements[i], idsRefAttribute);
   var descRefIds = !!descRefString ? descRefString.split(" ") : [ ];
   var descIndex = descRefIds.indexOf(textId);
   if(setText && descIndex == -1) {
    if(isFirst)
     descRefIds.unshift(textId);
    else
     descRefIds.push(textId);
   }
   else if(!setText && descIndex > -1)
    descRefIds.splice(descIndex, 1);
   ASPx.Attr.SetOrRemoveAttribute(accessibilityElements[i], idsRefAttribute, descRefIds.join(" "));
  }
 }
});
ASPx.DisableAccessibilityExplanatoryTextManager = DisableAccessibilityExplanatoryTextManager;
ASPx.EditAccessibilityExplanatoryTextManager = EditAccessibilityExplanatoryTextManager;
ASPx.EditAccessibilityExplanatoryTextManager.SetLabelAssociating = function(editor, activeElement, labelElement) {
 var clickHandler = function(evt) {
  if(editor && editor.OnAssociatedLabelClick)
   editor.OnAssociatedLabelClick(evt);
  else
   activeElement.click();
 };
 ASPx.Evt.AttachEventToElement(labelElement, "click", clickHandler);
 if(!!editor) {
  var hasAriaLabel = !!ASPx.Attr.GetAttribute(activeElement, "aria-label");
  editor.ariaExplanatoryTextManager.SetOrRemoveText([activeElement], labelElement, true, !hasAriaLabel, true);
 }
};
ASPxClientEdit.ClearEditorsInContainer = function(container, validationGroup, clearInvisibleEditors) {
 invalidEditorToBeFocused = null;
 ASPx.ProcessEditorsInContainer(container, ASPx.ClearProcessingProc, ASPx.ClearChoiceCondition, validationGroup, clearInvisibleEditors, true );
 ASPxClientEdit.ClearExternalControlsInContainer(container, validationGroup, clearInvisibleEditors, true );
};
ASPxClientEdit.ClearEditorsInContainerById = function(containerId, validationGroup, clearInvisibleEditors) {
 var container = document.getElementById(containerId);
 this.ClearEditorsInContainer(container, validationGroup, clearInvisibleEditors);
};
ASPxClientEdit.ClearGroup = function(validationGroup, clearInvisibleEditors) {
 return this.ClearEditorsInContainer(null, validationGroup, clearInvisibleEditors);
};
ASPxClientEdit.ValidateEditorsInContainer = function(container, validationGroup, validateInvisibleEditors) {
 var summaryCollection;
 if(ASPx.Ident.scripts.ASPxClientValidationSummary) {
  summaryCollection = ASPx.GetClientValidationSummaryCollection();
  summaryCollection.AllowNewErrorsAccepting(validationGroup);
 }
 var validationResult = ASPx.ProcessEditorsInContainer(container, ASPx.ValidateProcessingProc, _aspxValidateChoiceCondition, validationGroup, validateInvisibleEditors,
  false );
 validationResult.isValid = ASPxClientEdit.ValidateExternalControlsInContainer(container, validationGroup, validateInvisibleEditors,
  false ) && validationResult.isValid;
 if(typeof(validateInvisibleEditors) == "undefined")
  validateInvisibleEditors = false;
 if(typeof(validationGroup) == "undefined")
  validationGroup = null;    
 validationResult.isValid = ASPx.GetControlCollection().RaiseValidationCompleted(container, validationGroup,
 validateInvisibleEditors, validationResult.isValid, validationResult.firstInvalid, validationResult.firstVisibleInvalid);
 if(summaryCollection)
  summaryCollection.ForbidNewErrorsAccepting(validationGroup);
 if(!validationResult.isValid && !!validationResult.firstVisibleInvalid && validationResult.firstVisibleInvalid.accessibilityCompliant && !validationResult.firstVisibleInvalid.setFocusOnError) {
  var accessInvalidControl = validationResult.firstVisibleInvalid;
  if(!summaryCollection && !accessInvalidControl.focused) {
   var beforeDelayActiveElement = ASPx.GetActiveElement();
   setTimeout(function() {
    var currentActiveElement = ASPx.GetActiveElement();
    if(accessInvalidControl.focused || (currentActiveElement != beforeDelayActiveElement && ASPx.Attr.IsExistsAttribute(currentActiveElement, 'role')))
     return;
    accessInvalidControl.ariaExplanatoryTextManager.ToggleErrorAlert();
   }, 500);    
  }
 }
 return validationResult.isValid;
};
ASPxClientEdit.ValidateEditorsInContainerById = function(containerId, validationGroup, validateInvisibleEditors) {
 var container = document.getElementById(containerId);
 return this.ValidateEditorsInContainer(container, validationGroup, validateInvisibleEditors);
};
ASPxClientEdit.ValidateGroup = function(validationGroup, validateInvisibleEditors) {
 return this.ValidateEditorsInContainer(null, validationGroup, validateInvisibleEditors);
};
ASPxClientEdit.AreEditorsValid = function(containerOrContainerId, validationGroup, checkInvisibleEditors) {
 var container = typeof(containerOrContainerId) == "string" ? document.getElementById(containerOrContainerId) : containerOrContainerId;
 var checkResult = ASPx.ProcessEditorsInContainer(container, ASPx.EditorsValidProcessingProc, _aspxEditorsValidChoiceCondition, validationGroup,
  checkInvisibleEditors, false );
 checkResult.isValid = ASPxClientEdit.AreExternalControlsValidInContainer(containerOrContainerId, validationGroup,
  checkInvisibleEditors, false ) && checkResult.isValid;
 return checkResult.isValid;
};
ASPxClientEdit.AreExternalControlsValidInContainer = function(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors) {
 if(ASPx.Ident.scripts.ASPxClientHtmlEditor)
  return ASPxClientHtmlEditor.AreEditorsValidInContainer(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors);
 return true;
};
ASPxClientEdit.ClearExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors) {
 if(ASPx.Ident.scripts.ASPxClientHtmlEditor)
  return ASPxClientHtmlEditor.ClearEditorsInContainer(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors);
 return true;
};
ASPxClientEdit.ValidateExternalControlsInContainer = function(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors) {
 if(ASPx.Ident.scripts.ASPxClientHtmlEditor)
  return ASPxClientHtmlEditor.ValidateEditorsInContainer(containerId, validationGroup, validateInvisibleEditors, processDisabledEditors);
 return true;
};
ASPxClientEdit.AttachEditorModificationListener = function(handler, predicate) {
 var processAction = function(event) { event.AddHandler(handler); };
 ASPxClientEdit.ProcessEditorModificationListener(handler, processAction, predicate);
};
ASPxClientEdit.DetachEditorModificationListener = function(handler, predicate) {
 var processAction = function(event) { event.RemoveHandler(handler); };
 ASPxClientEdit.ProcessEditorModificationListener(handler, processAction, predicate);
};
ASPxClientEdit.ProcessEditorModificationListener = function(handler, action, predicate) {
 ASPx.GetControlCollection().ForEachControl(function(control) {
  if(control.GetModifyEvent && predicate(control)) {
   if(control.isNative)
    control.EnsureRequiredNativeAttributesExists();
   action(control.GetModifyEvent());
  }
 });
};
var ASPxClientEditKeyEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(htmlEvent) {
  this.constructor.prototype.constructor.call(this);
  this.htmlEvent = htmlEvent;
 }
});
var ASPxClientEditValidationEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
 constructor: function(value, errorText, isValid) {
  this.constructor.prototype.constructor.call(this);
  this.errorText = errorText;
  this.isValid = isValid;
  this.value = value;
 }
});
ASPx.ProcessEditorsInContainer = function(container, processingProc, choiceCondition, validationGroup, processInvisibleEditors, processDisabledEditors) {
 var allProcessedSuccessfull = true;
 var firstInvalid = null;
 var firstVisibleInvalid = null;
 var invalidEditorToBeFocused = null;
 ASPx.GetControlCollection().ForEachControl(function(control) {
  var canValidate = ASPx.CanValidateControl(control, container, processingProc, choiceCondition, validationGroup, processInvisibleEditors, processDisabledEditors);
  if(!canValidate) return;
  var isSuccess = processingProc(control);
  if(!isSuccess) {
   allProcessedSuccessfull = false;
   if(firstInvalid == null)
    firstInvalid = control;
   var isVisible = control.IsVisible();
   if(isVisible && firstVisibleInvalid == null)
    firstVisibleInvalid = control;
   if(control.setFocusOnError && invalidEditorToBeFocused == null && isVisible)
    invalidEditorToBeFocused = control;
  }
 }, this);
 if(invalidEditorToBeFocused != null)
  invalidEditorToBeFocused.SetFocus();
 return new ASPxValidationResult(allProcessedSuccessfull, firstInvalid, firstVisibleInvalid);
};
ASPx.CanValidateControl = function(control, container, processingProc, choiceCondition, validationGroup, processInvisibleEditors, processDisabledEditors) {
 var needToProcessRatingControl = window.ASPxClientRatingControl && (control instanceof ASPxClientRatingControl) && processingProc === ASPx.ClearProcessingProc;
 var mainElement = control.GetMainElement(); 
 if(!ASPx.Ident.IsASPxClientEdit(control) && !needToProcessRatingControl)
  return false;
 if(ASPx.Ident.isDialogInvisibleControl(control) || ASPx.Ident.isBatchEditUnusedEditor(control))
  return false; 
 if(!processDisabledEditors && !control.GetEnabled())
  return false;
 if(!mainElement || (container && !ASPx.GetIsParent(container, mainElement)))
  return false;
 if(!processInvisibleEditors && !control.IsVisible())
  return false;
 if(choiceCondition && !choiceCondition(control, validationGroup))
  return false;
 return true;
};
var ASPxValidationResult = ASPx.CreateClass(null, {
 constructor: function(isValid, firstInvalid, firstVisibleInvalid) {
  this.isValid = isValid;
  this.firstInvalid = firstInvalid;
  this.firstVisibleInvalid = firstVisibleInvalid;
 }
});
ASPx.ClearChoiceCondition = function(edit, validationGroup) {
 return !ASPx.IsExists(validationGroup) || (edit.validationGroup == validationGroup);
};
function _aspxValidateChoiceCondition(edit, validationGroup) {
 return ASPx.ClearChoiceCondition(edit, validationGroup) && edit.customValidationEnabled;
}
function _aspxEditorsValidChoiceCondition(edit, validationGroup) {
 return _aspxValidateChoiceCondition(edit, validationGroup);
}
function wrapLostFocusHandler(handler) {
 if(ASPx.Browser.Edge) {
  return function(name) {
   var edit = ASPx.GetControlCollection().Get(name);
   if(edit && !ASPx.IsElementVisible(edit.GetMainElement()))
    setTimeout(handler, 0, name);
   else
    handler(name);
  };
 }
 return handler;
}
ASPx.EGotFocus = function(name) {
 var edit = ASPx.GetControlCollection().Get(name); 
 if(!edit) return;
 if(!edit.isInitialized){
  var inputElement = edit.GetFocusableInputElement();
  if(inputElement && inputElement === document.activeElement) {
   if(ASPx.Browser.Firefox)
    window.setTimeout(function() { document.activeElement.blur(); }, 0);
   else
    document.activeElement.blur();
  }
  return;
 }
 if(ASPx.Browser.VirtualKeyboardSupported && !edit.ownerListBox)
  ASPx.VirtualKeyboardUI.onCallingVirtualKeyboard(edit, false);
 else
  edit.OnFocus();
};
ASPx.ELostFocusCore = function(name) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(ASPx.Browser.VirtualKeyboardSupported && (!edit || !edit.ownerListBox)) {
  var supressLostFocus = ASPx.VirtualKeyboardUI.isInputNativeBluring();
  if(supressLostFocus)
   return;
  ASPx.VirtualKeyboardUI.resetFocusedEditor();
 }
 if(edit != null)
  edit.OnLostFocus();
};
ASPx.ELostFocus = wrapLostFocusHandler(ASPx.ELostFocusCore);
ASPx.ESGotFocus = function(name) {
 var edit = ASPx.GetControlCollection().Get(name); 
 if(!edit) return;
   if(ASPx.Browser.VirtualKeyboardSupported && !edit.ownerListBox) {
  ASPx.VirtualKeyboardUI.onCallingVirtualKeyboard(edit, true);
 } else {
  edit.OnSpecialFocus();
 }
};
ASPx.ESLostFocusCore = function(name) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(ASPx.Browser.VirtualKeyboardSupported && (!edit || !edit.ownerListBox)) {
  var supressLostFocus = ASPx.VirtualKeyboardUI.isInputNativeBluring();
  if(supressLostFocus)
   return;
  ASPx.VirtualKeyboardUI.resetFocusedEditor();
 }
 if(!edit) return;
 if(edit.UseDelayedSpecialFocus())
  edit.specialFocusTimer = window.setTimeout(function() { edit.OnSpecialLostFocus(); }, 30);
 else
  edit.OnSpecialLostFocus();
};
ASPx.ESLostFocus = wrapLostFocusHandler(ASPx.ESLostFocusCore);
ASPx.EValueChanged = function(name) {
 var edit = ASPx.GetControlCollection().Get(name);
 if(edit != null)
  edit.OnValueChanged();
};
ASPx.VirtualKeyboardUI = (function() {
 var focusedEditor = null;
 var inputNativeFocusLocked = false;
 function elementBelongsToEditor(element) {
  if(!element) return false;
  var isBelongsToEditor = false;
  ASPx.GetControlCollection().ForEachControl(function(control) {
   if(ASPx.Ident.IsASPxClientEdit(control) && control.IsEditorElement(element)) {
    isBelongsToEditor = true;
    return true;
   }
  }, this);
  return isBelongsToEditor;
 }
 function elementBelongsToFocusedEditor(element) {
  return focusedEditor && focusedEditor.IsEditorElement(element);
 }
 return {
  onTouchStart: function (evt) {
   if (!ASPx.Browser.VirtualKeyboardSupported || this.isGooglePlaceAutocompleteElementTap(evt)) return;
   inputNativeFocusLocked = false;
   if(focusedEditor)
    focusedEditor.onVirtualKeyboardUITouchStart(evt);
   if(ASPx.TouchUIHelper.pointerEnabled) {
    if(evt.pointerType !== ASPx.TouchUIHelper.pointerType.Touch ||
       ASPx.Browser.AndroidMobilePlatform) 
     return;
    this.processFocusEditorControl(evt);
   } else
    ASPx.TouchUIHelper.handleFastTapIfRequired(evt,  function(){ this.processFocusEditorControl(evt); }.aspxBind(this), false);
  },
  processFocusEditorControl: function(evt) {
   var evtSource = ASPx.Evt.GetEventSource(evt);
   var timeEditHasAppliedFocus = focusedEditor && (ASPx.Ident.IsASPxClientTimeEdit && ASPx.Ident.IsASPxClientTimeEdit(focusedEditor));
   var focusedTimeEditBelongsToDateEdit = timeEditHasAppliedFocus && focusedEditor.OwnerDateEdit && focusedEditor.OwnerDateEdit.GetShowTimeSection();
   if(focusedTimeEditBelongsToDateEdit) {
    focusedEditor.OwnerDateEdit.ForceRefocusTimeSectionTimeEdit(evtSource);
    return;
   }
   var elementWithNativeFocus = ASPx.GetActiveElement();
   var someEditorInputIsFocused = elementBelongsToEditor(elementWithNativeFocus);
   var touchKeyboardIsVisible = someEditorInputIsFocused;
   var tapOutsideEditorAndInputs = !elementBelongsToEditor(evtSource) && !ASPx.Ident.IsFocusableElementRegardlessTabIndex(evtSource);
   var blurToHideTouchKeyboard = touchKeyboardIsVisible && tapOutsideEditorAndInputs;
   if(blurToHideTouchKeyboard) {
    elementWithNativeFocus.blur();
    return;
   }
   var tapOutsideFocusedEditor = focusedEditor && !elementBelongsToFocusedEditor(evtSource);
   if(tapOutsideFocusedEditor) {
    var focusedEditorWithBluredInput = !elementBelongsToFocusedEditor(elementWithNativeFocus);
    if(focusedEditorWithBluredInput) 
     this.lostAppliedFocusOfEditor();
   }
  },
  smartFocusEditor: function(edit) {
   if(!edit.focused) {
    this.setInputNativeFocusLocked(true);
    this.setFocusEditorCore(edit);
   } else {
    edit.ForceRefocusEditor();
   }
  },
  setFocusEditorCore: function(edit) {
   if(ASPx.Browser.MacOSMobilePlatform) {
    var timeoutDuration = ASPx.Browser.Chrome ? 250 : 30;
    window.setTimeout(function(){ edit.SetFocus(); }, timeoutDuration);
   } else {
    edit.SetFocus();
   }
  },
  onCallingVirtualKeyboard: function(edit, isSpecial) {
   this.setAppliedFocusOfEditor(edit, isSpecial);
   if(edit.specialKeyboardHandlingUsed == isSpecial && inputNativeFocusLocked)
    edit.BlurInputElement();
  },
  isInputNativeBluring: function() {
   return focusedEditor && inputNativeFocusLocked;
  },
  setInputNativeFocusLocked: function(locked) {
   inputNativeFocusLocked = locked;
  },
  getInputNativeFocusLocked: function() {
   return inputNativeFocusLocked;
  },
  setAppliedFocusOfEditor: function(edit, isSpecial) {
   if(focusedEditor === edit) {
    if(edit.specialKeyboardHandlingUsed == isSpecial) {
     focusedEditor.UnlockFocusEvents();
     if(focusedEditor.EnsureClearButtonVisibility)
      focusedEditor.EnsureClearButtonVisibility();
    }
    return;
   }
   if(edit.specialKeyboardHandlingUsed == isSpecial) {
    this.lostAppliedFocusOfEditor();
    focusedEditor = edit;
    ASPx.SetFocusedEditor(edit);
   }
   if(isSpecial)
    edit.OnSpecialFocus();
   else
    edit.OnFocus();
  },
  lostAppliedFocusOfEditor: function() {
   if(!focusedEditor) return;
   var curEditorName = focusedEditor.name; 
   var skbdHandlingUsed = focusedEditor.specialKeyboardHandlingUsed;
   var focusedEditorInputElementExists = focusedEditor.GetInputElement();
   focusedEditor = null;
   if(!focusedEditorInputElementExists)
    return;
   ASPx.ELostFocusCore(curEditorName);
   if(skbdHandlingUsed)
    ASPx.ESLostFocusCore(curEditorName);
  },
  getFocusedEditor: function() {
   return focusedEditor;
  },
  resetFocusedEditor: function() {
   focusedEditor = null;
  },
  focusableInputElementIsActive: function(edit) {
   var inputElement = edit.GetFocusableInputElement();
   return !!inputElement ? ASPx.GetActiveElement() === inputElement : false;
  },
  isGooglePlaceAutocompleteElementTap: function(evt) {
   var googlePlaceAutocompleteContainer = ASPx.GetNodeByClassName(document.body, "pac-container", 0);
   if(!googlePlaceAutocompleteContainer)
    return false;
   return ASPx.GetParentByClassName(ASPx.Evt.GetEventSource(evt), "pac-container") != null;
  }
 };
})();
if(ASPx.Browser.VirtualKeyboardSupported) {
 var touchEventName = ASPx.TouchUIHelper.pointerEnabled ? ASPx.TouchUIHelper.pointerDownEventName : 'touchstart';
 ASPx.Evt.AttachEventToDocument(touchEventName, function(evt){ ASPx.VirtualKeyboardUI.onTouchStart(evt); });
}
ASPx.Evt.AttachEventToDocument("mousedown", function(evt) {
 var editor = ASPx.GetFocusedEditor();
 if(!editor) 
  return;
 var evtSource = ASPx.Evt.GetEventSource(evt);
 if(editor.IsClearButtonElement(evtSource))
  return;
 if(editor.OwnerDateEdit && editor.OwnerDateEdit.GetShowTimeSection()) {
  editor.OwnerDateEdit.ForceRefocusTimeSectionTimeEdit(evtSource);
  return;
 }
 if(editor.ownerListBox && editor.ownerListBox.IsEditorElement(evtSource) && !editor.IsEditorElement(evtSource)) {
  editor.ownerListBox.ForceRefocusEditor(evt);
  ASPx.SetFocusedEditor(editor.ownerListBox);
  return;
 }
 if(editor.IsEditorElement(evtSource) && !editor.IsElementBelongToInputElement(evtSource))
  editor.ForceRefocusEditor(evt);
});
ASPx.Evt.AttachEventToDocument(ASPx.Evt.GetMouseWheelEventName(), function(evt) {
 var editor = ASPx.GetFocusedEditor();
 if(editor != null && ASPx.IsExistsElement(editor.GetMainElement()) && editor.focused && editor.receiveGlobalMouseWheel)
  editor.OnMouseWheel(evt);
});
ASPx.KBSIKeyDown = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyDown(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
};
ASPx.KBSIKeyPress = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyPress(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
};
ASPx.KBSIKeyUp = function(name, evt){
 var control = ASPx.GetControlCollection().Get(name);
 if(control != null){
  var isProcessed = control.OnSpecialKeyUp(evt);
  if(isProcessed)
   return ASPx.Evt.PreventEventAndBubble(evt);
 }
};
ASPx.ClearProcessingProc = function(edit) {
 return edit.Clear();
};
ASPx.ValidateProcessingProc = function(edit) {
 edit.OnValidation(ValidationType.MassValidation);
 return edit.GetIsValid();
};
ASPx.EditorsValidProcessingProc = function(edit) {
 return edit.GetIsValid();
};
var CheckEditElementHelper = ASPx.CreateClass(ASPx.CheckableElementHelper, {
 AttachToMainElement: function(internalCheckBox) {
  ASPx.CheckableElementHelper.prototype.AttachToMainElement.call(this, internalCheckBox);
  this.AttachToLabelElement(this.GetLabelElement(internalCheckBox.container), internalCheckBox);
 },
 AttachToLabelElement: function(labelElement, internalCheckBox) {
  var _this = this;
  if(labelElement) {
   ASPx.Evt.AttachEventToElement(labelElement, "click", 
    function (evt) { 
     _this.InvokeClick(internalCheckBox, evt);
    }
   );
   ASPx.Evt.AttachEventToElement(labelElement, "mousedown",
    function (evt) {
     internalCheckBox.Refocus();
    }
   );
  }
 },
 GetLabelElement: function(container) {
  var labelElement = ASPx.GetNodeByTagName(container, "LABEL", 0);
  if(!labelElement) {
   var labelCell = ASPx.GetNodeByClassName(container, "dxichTextCellSys", 0);
   labelElement = ASPx.GetNodeByTagName(labelCell, "SPAN", 0);
  }
  return labelElement;
 }
});
CheckEditElementHelper.Instance = new CheckEditElementHelper();
var CalendarSharedParameters = ASPx.CreateClass(null, {
 updateCalendarCallbackCommand: "UPDATE",
 constructor: function() {
  this.minDate = null;
  this.maxDate = null;
  this.disabledDates = [];
  this.calendarCustomDraw = false;
  this.hasCustomDisabledDatesViaCallback = false;
  this.dateRangeMode = false;
  this.currentDateEdit = null;
  this.DaysSelectingOnMouseOver = new ASPxClientEvent();
  this.VisibleDaysMouseOut = new ASPxClientEvent();
  this.CalendarSelectionChangedInternal = new ASPxClientEvent();
 },
 Assign: function(source) {
  this.minDate = source.minDate ? source.minDate : null;
  this.maxDate = source.maxDate ? source.maxDate : null;
  this.calendarCustomDraw = source.calendarCustomDraw ? source.calendarCustomDraw : false;
  this.hasCustomDisabledDatesViaCallback = source.hasCustomDisabledDatesViaCallback ? source.hasCustomDisabledDatesViaCallback : false;
  this.disabledDates = source.disabledDates ? source.disabledDates : [];
  this.currentDateEdit = source.currentDateEdit ? source.currentDateEdit : null;
 },
 GetUpdateCallbackParameters: function() {
  var callbackArgs = this.GetCallbackArgs();
  callbackArgs = this.FormatCallbackArg(this.updateCalendarCallbackCommand, callbackArgs);
  return callbackArgs;
 },
 GetCallbackArgs: function() {
  var args = {};
  if(this.minDate)
   args.clientMinDate = ASPx.DateUtils.GetInvariantDateString(this.minDate);
  if(this.maxDate)
   args.clientMaxDate = ASPx.DateUtils.GetInvariantDateString(this.maxDate);
  if(args.clientMinDate || args.clientMaxDate) {
   var jsonArgs = JSON.stringify(args);
   return ASPx.Str.EncodeHtml(jsonArgs);
  }
  return null;
 },
 FormatCallbackArg: function(prefix, arg) {
  if(!arg) return prefix;
  return [prefix, '|', arg.length, ';', arg, ';'].join('');
 }
});
ASPx.CalendarSharedParameters = CalendarSharedParameters;
ASPx.ValidationType = ValidationType;
ASPx.ErrorFrameDisplay = ErrorFrameDisplay;
ASPx.EditElementSuffix = EditElementSuffix;
ASPx.ValidationPattern = ValidationPattern;
ASPx.RequiredFieldValidationPattern = RequiredFieldValidationPattern;
ASPx.RegularExpressionValidationPattern = RegularExpressionValidationPattern;
ASPx.CheckEditElementHelper = CheckEditElementHelper;
ASPx.IsEditorFocusable = _aspxIsEditorFocusable;
window.ASPxClientEditBase = ASPxClientEditBase;
window.ASPxClientEdit = ASPxClientEdit;
window.ASPxClientEditKeyEventArgs = ASPxClientEditKeyEventArgs;
window.ASPxClientEditValidationEventArgs = ASPxClientEditValidationEventArgs;
})();

(function() {
 var ASPxClientStaticEdit = ASPx.CreateClass(ASPxClientEditBase, { 
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.Click = new ASPxClientEvent();
  },
  OnClick: function(htmlEvent) {
   this.RaiseClick(this.GetMainElement(), htmlEvent);
  },
  RaiseClick: function(htmlElement, htmlEvent){
   if(!this.Click.IsEmpty()){
    var args = new ASPxClientEditClickEventArgs(htmlElement, htmlEvent);
    this.Click.FireEvent(this, args);
   }
  },
  ChangeEnabledAttributes: function(enabled){
   this.ChangeMainElementAttributes(this.GetMainElement(), ASPx.Attr.ChangeAttributesMethod(enabled));
  },
  ChangeEnabledStateItems: function(enabled){
   ASPx.GetStateController().SetElementEnabled(this.GetMainElement(), enabled);
  },
  ChangeMainElementAttributes: function(element, method){
   method(element, "onclick");
  }
 });
 var ASPxClientEditClickEventArgs = ASPx.CreateClass(ASPxClientEventArgs, {
  constructor: function(htmlElement, htmlEvent){
   this.constructor.prototype.constructor.call(this);
   this.htmlElement = htmlElement;
   this.htmlEvent = htmlEvent;
  }
 });
 var ASPxClientHyperLink = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.sizingConfig.allowSetWidth = false;
   this.sizingConfig.allowSetHeight = false;
  },
  Initialize: function() {
   ASPxClientControl.prototype.Initialize.call(this);
  },
  GetNavigateUrl: function(){
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    return element.href;
   return "";
  },
  SetNavigateUrl: function(url){
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    element.href = url;
  },
  GetText: function(){
   return this.GetValue();
  },
  SetText: function(value){
   this.SetValue(value);
  },
  ChangeMainElementAttributes: function(element, method){
   ASPxClientStaticEdit.prototype.ChangeMainElementAttributes.call(this, element, method);
   method(element, "href");
  }
 });
 ASPxClientHyperLink.Cast = ASPxClientControl.Cast;
 var ASPxClientImageBase = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.imageWidth = "";
   this.imageHeight = "";
  },
  GetWidth: function(){
   return this.GetSize(true);
  },
  GetHeight: function(){
   return this.GetSize(false);
  },
  SetWidth: function(width) {
   this.SetSize(width, this.GetHeight());
  },
  SetHeight: function(height) {
   this.SetSize(this.GetWidth(), height);
  },
  SetSize: function(width, height){
   this.imageWidth = width + "px";
   this.imageHeight = height + "px";
   var image = this.GetMainElement();
   if(ASPx.IsExistsElement(image))
    ASPx.ImageUtils.SetSize(image, width, height);
  },
  GetSize: function(isWidth){
   var image = this.GetMainElement();
   if(ASPx.IsExistsElement(image))
    return ASPx.ImageUtils.GetSize(image, isWidth);
   return -1;
  }
 });
 var ASPxClientImage = ASPx.CreateClass(ASPxClientImageBase, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.emptyImageUrl = "";
   this.emptyImageToolTip = "";
   this.emptyImageWidth = "";
   this.emptyImageHeight = "";
   this.imageAlt = "";
   this.imageToolTip = "";
   this.isEmpty = false;
  },
  GetValue: function () {
   if (!this.isEmpty) {
    var image = this.GetMainElement();
    if (ASPx.IsExistsElement(image))
     return image.src;
   }
   return "";
  },
  SetValue: function (value) {
   if (value == null) value = "";
   this.isEmpty = (value == "");
   var image = this.GetMainElement();
   if (ASPx.IsExistsElement(image)) {
    if(image.dxShowLoadingImage) {
     if(this.isEmpty)
      this.setEmptyImage();
     else
      this.setImageUrlInternal(value);
    }
    else
     image.src = value;
   }
  },
  GetImageUrl: function(url){
   return this.GetValue();
  },
  SetImageUrl: function (url) {
   this.SetValue(url);
  },
  setEmptyImage: function () {
   this.setImageUrlInternal(this.emptyImageUrl || ASPx.EmptyImageUrl);
  },
  setImageUrlInternal: function (realSrc) {
   this.prepareRealImage();
   this.requestViaFakeImage(realSrc);
  },
  saveAndClearImageSettings: function () {
   var image = this.GetMainElement();
   if (this.isEmpty) {
    image.style.width = this.emptyImageWidth;
    image.style.height = this.emptyImageHeight;
    if (ASPx.IsExists(this.emptyImageAlt)) 
     image.alt = this.emptyImageAlt;
    if (ASPx.IsExists(this.emptyImageToolTip)) 
     image.title = this.emptyImageToolTip;
   }
   this.imageSettings = {
    image: image,
    background: image.style.background,
    alt: image.alt,
    title: image.title
   };
   image.alt = "";
   var isOldIE = ASPx.Browser.IE && ASPx.Browser.Version < 9;
   ASPx.ASPxImageLoad.removeASPxImageBackground(image, isOldIE);
  },
  showLoadingImage: function () {
   var image = this.GetMainElement();
   ASPx.AddClassNameToElement(image, ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass);
   if (image.dxCustomLoadingImage)
    image.style.backgroundImage = image.dxCustomLoadingImage;
  },
  prepareRealImage: function () {
   this.saveAndClearImageSettings();
   this.showLoadingImage();
   var realImage = this.GetMainElement();
   realImage.src = "";
  },
  requestViaFakeImage: function (realSrc) {
   var fakeImage = document.createElement("IMG");
   fakeImage.imageSettings = this.imageSettings;
   fakeImage.restoreRealImage = this.restoreRealImage;
   this.addFakeImageHandlers(fakeImage);
   fakeImage.src = realSrc;
  },
  addFakeImageHandlers: function (fakeImage) {
   fakeImage.onload = this.onFakeImageLoad;
   fakeImage.onabort = this.onFakeImageLoad;
   fakeImage.onerror = this.onFakeImageLoad;
  },
  onFakeImageLoad: function () {
   this.restoreRealImage();
   var realImage = this.imageSettings.image;
   ASPx.RemoveClassNameFromElement(realImage, ASPx.ASPxImageLoad.dxDefaultLoadingImageCssClass);
  },
  restoreRealImage: function () {
   var  realImage = this.imageSettings.image;
   realImage.style.background = this.imageSettings.background;
   realImage.alt = this.imageSettings.alt;
   realImage.title = this.imageSettings.title;
   realImage.src = this.src;
  }
 });
 ASPxClientImage.Cast = ASPxClientControl.Cast;
 var ASPxClientLabel = ASPx.CreateClass(ASPxClientStaticEdit, {
  constructor: function(name) {
   this.constructor.prototype.constructor.call(this, name);
   this.sizingConfig.allowSetWidth = false;
   this.sizingConfig.allowSetHeight = false;
   this.accessibilityAssociatedElementID = "";
   this.accessibilityAssociatedControlName = "";
  },
  Initialize: function() {
   ASPxClientControl.prototype.Initialize.call(this);
   if(this.accessibilityAssociatedElementID !== "")
    this.SetAccessibilityAssociating();
  },
  GetAssociatedControl: function() {
   var endIndex = this.accessibilityAssociatedElementID.indexOf(this.accessibilityAssociatedControlName) + this.accessibilityAssociatedControlName.length;
   var associatedControlName = this.accessibilityAssociatedElementID.slice(0, endIndex);
   return ASPx.GetControlCollection().Get(associatedControlName);
  },
  SetAccessibilityAssociating: function() {
   var accessibilityAssociatedElement = ASPx.GetElementById(this.accessibilityAssociatedElementID);
   if(!accessibilityAssociatedElement) return;
   var associatedControl = this.GetAssociatedControl();
   ASPx.EditAccessibilityExplanatoryTextManager.SetLabelAssociating(associatedControl, accessibilityAssociatedElement, this.GetMainElement());
  },
  GetValue: function() { 
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element))
    return element.innerHTML;
  },
  SetValue: function(value) {
   if(value == null)
    value = "";
   var element = this.GetMainElement();
   if(ASPx.IsExistsElement(element)) 
    element.innerHTML = value;
  },
  SetVisible: function(visible){
   if(this.clientVisible != visible){
    this.clientVisible = visible;
    var element = this.GetMainElement();
    if(!visible)
     element.style.display = "none";
    else if((element.style.width != "" || element.style.height != "") && !ASPx.Browser.NetscapeFamily)
     element.style.display = "inline-block";
    else
     element.style.display = "";
   }
  },
  GetText: function(){
   return this.GetValue();
  },
  SetText: function(value){
   this.SetValue(value);
  },
  ChangeMainElementAttributes: function(element, method){
   ASPxClientStaticEdit.prototype.ChangeMainElementAttributes.call(this, element, method);
   method(element, "htmlFor");
  }
 });
 ASPxClientLabel.Cast = ASPxClientControl.Cast;
 ASPx.Ident.scripts.ASPxClientLabel = true;
 ASPx.SEClick = function(name, evt){
  var edit = ASPx.GetControlCollection().Get(name);
  if(edit != null) {
   edit.OnClick(evt);
   return evt.returnValue;
  }
 };
 ASPx.SELoad = function(evt) {
  var image = ASPx.Evt.GetEventSource(evt);
  if(!image.dxLoadingImageBackground)
   image.dxLoadingImageBackground = image.style.background;
  image.style.background = "";
 };
 window.ASPxClientStaticEdit = ASPxClientStaticEdit;
 window.ASPxClientEditClickEventArgs = ASPxClientEditClickEventArgs;
 window.ASPxClientHyperLink = ASPxClientHyperLink;
 window.ASPxClientImageBase = ASPxClientImageBase;
 window.ASPxClientImage = ASPxClientImage;
 window.ASPxClientLabel = ASPxClientLabel;
})();
