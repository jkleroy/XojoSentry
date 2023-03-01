#tag Class
Class SentryController
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub AddBreadcrumb(category As String, message As String = "")
		  #if False
		    {
		    "type": "navigation",
		    "category": "navigation",
		    "timestamp": "2016-04-20T20:55:53.845Z",
		    "data": {
		    "from": "/login",
		    "to": "/dashboard"
		    }
		    }
		    
		  #endif
		  
		  Dim dic As new Dictionary
		  
		  'dic.Value("type") = "default"
		  dic.Value("category") = category
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  dic.Value("timestamp") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  
		  
		  
		  if message.isempty = False then
		    dic.Value("message") = Message
		  end if
		  
		  breadcrumbs.Add dic
		  
		  if self.Options <> nil and breadcrumbs.Count > Options.max_breadcrumbs then
		    breadcrumbs.RemoveAt(0)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub AddBreadcrumbNavigation(fromScreen As String, toScreen As String, message As String = "")
		  #if False
		    {
		    "type": "navigation",
		    "category": "navigation",
		    "timestamp": "2016-04-20T20:55:53.845Z",
		    "data": {
		    "from": "/login",
		    "to": "/dashboard"
		    }
		    }
		    
		  #endif
		  
		  Dim dic As new Dictionary
		  
		  dic.Value("type") = "navigation"
		  dic.Value("category") = "navigation"
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  dic.Value("timestamp") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  
		  Dim data As new Dictionary
		  data.Value("from") = fromScreen
		  data.Value("to") = toScreen
		  
		  dic.Value("data") = data
		  
		  if message.IsEmpty = False then
		    dic.Value("message") = Message
		  end if
		  
		  breadcrumbs.Add dic
		  
		  if breadcrumbs.Count > Options.max_breadcrumbs then
		    breadcrumbs.RemoveAt(0)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732061206B65792F76616C75652074686174206C6976657320756E74696C20616E20657863657074696F6E2069732073656E74
		Sub AddExtraKeyValue(key As String, value As Variant)
		  
		  if tempExtra is nil then
		    tempExtra = New Dictionary
		  end if
		  
		  
		  //Check value length
		  if value.Type = Variant.TypeString or value.Type = Variant.TypeText then
		    
		    Dim stringValue As String = value.StringValue
		    if stringValue.Bytes > 16 * 1024 then
		      #if DebugBuild
		        System.DebugLog CurrentMethodName + " Extra value is limited to 16kB. " + _
		        "Sentry might drop the event. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		      #endif
		    end if
		    
		  End if
		  
		  
		  
		  tempExtra.Value(key) = value
		  
		  
		  
		  
		  //Check key count
		  if tempExtra.KeyCount > 50 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " Extra data is limited to 50 item pairs. " + _
		      "Sentry might drop the event. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206120676C6F62616C20746167
		Sub AddGlobalTag(key As String, value As Variant)
		  
		  if globalTags is nil then
		    globalTags = New Dictionary
		  end if
		  
		  //Check length of Key
		  if key.Length > 32 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " key is too long. " + _
		      "Global Tag is ignored. Limit: 32 characters. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		  
		  //Check that value is serializable to string
		  try
		    Dim variantString As String = value.StringValue
		  Catch err
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " value is not serializable to String (json). " + _
		      "Global Tag is ignored."
		    #endif
		    
		    Return
		  end try
		  
		  
		  
		  //Check value length
		  if value.IsNull = False and value.StringValue.Length > 200 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " value is too long. " + _
		      "Global Tag is ignored. Limit: 200 characters. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		  
		  globalTags.Value(key) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 416464732061207461672074686174206C6976657320756E74696C20616E20657863657074696F6E2069732073656E74
		Sub AddTag(key As String, value As Variant)
		  
		  //Check length of Key
		  if key.Length > 32 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " key is too long. " + _
		      "Tag is ignored. Limit: 32 characters. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		  
		  //Check that value is serializable to string
		  try
		    Dim variantString As String
		    variantString = value.StringValue
		  Catch err
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " value is not serializable to String (json). " + _
		      "Tag is ignored."
		    #endif
		    
		    Return
		  end try
		  
		  
		  
		  //Check value length
		  if value.IsNull = False and value.StringValue.Length > 200 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " value is too long. " + _
		      "Tag is ignored. Limit: 200 characters. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		  
		  
		  
		  if tempTags is nil then
		    tempTags = New Dictionary
		  end if
		  
		  tempTags.Value(key) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit))
		Sub AddWebBreadcrumb(SessionID As String, category As String, message As String = "")
		  #if False
		    {
		    "type": "navigation",
		    "category": "navigation",
		    "timestamp": "2016-04-20T20:55:53.845Z",
		    "data": {
		    "from": "/login",
		    "to": "/dashboard"
		    }
		    }
		    
		  #endif
		  
		  Dim dic As new Dictionary
		  
		  'dic.Value("type") = "default"
		  dic.Value("category") = category
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  dic.Value("timestamp") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  
		  
		  
		  if message.isempty = False then
		    dic.Value("message") = Message
		  end if
		  
		  Dim sessionCrumbs() As Dictionary
		  if breadcrumbsWeb is nil then
		    breadcrumbsWeb = new Dictionary
		  end if
		  
		  if breadcrumbsWeb.HasKey(SessionID) then
		    sessionCrumbs = breadcrumbsWeb.Value(SessionID)
		  end if
		  
		  sessionCrumbs.Add dic
		  
		  
		  if self.Options <> nil and sessionCrumbs.Count > Options.max_breadcrumbs then
		    sessionCrumbs.RemoveAt(0)
		  end if
		  
		  breadcrumbsWeb.Value(SessionID) = sessionCrumbs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit))
		Sub AddWebBreadcrumbNavigation(SessionID As String, fromScreen As String, toScreen As String, message As String = "")
		  #if False
		    {
		    "type": "navigation",
		    "category": "navigation",
		    "timestamp": "2016-04-20T20:55:53.845Z",
		    "data": {
		    "from": "/login",
		    "to": "/dashboard"
		    }
		    }
		    
		  #endif
		  
		  Dim dic As new Dictionary
		  
		  dic.Value("type") = "navigation"
		  dic.Value("category") = "navigation"
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  dic.Value("timestamp") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  
		  Dim data As new Dictionary
		  data.Value("from") = fromScreen
		  data.Value("to") = toScreen
		  
		  dic.Value("data") = data
		  
		  if message.IsEmpty = False then
		    dic.Value("message") = Message
		  end if
		  
		  Dim sessionCrumbs() As Dictionary
		  if breadcrumbsWeb is nil then
		    breadcrumbsWeb = new Dictionary
		  end if
		  
		  if breadcrumbsWeb.HasKey(SessionID) then
		    sessionCrumbs = breadcrumbsWeb.Value(SessionID)
		  end if
		  
		  sessionCrumbs.Add dic
		  
		  
		  if self.Options <> nil and sessionCrumbs.Count > Options.max_breadcrumbs then
		    sessionCrumbs.RemoveAt(0)
		  end if
		  
		  breadcrumbsWeb.Value(SessionID) = sessionCrumbs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AfterSend(mException As RuntimeException, content As Dictionary)
		  
		  //Subclass this method in your own implementation of Sentry 
		  //if you want to do something after the exception is sent to Sentry
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub BeforeSend(mException As RuntimeException, content As Dictionary)
		  
		  //Subclass this method in your own implementation of Sentry
		  //if you want to add/remove some items
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CancelSend(mException As RuntimeException, content As Dictionary) As Boolean
		  
		  //Subclass this method in your own implementation of Sentry
		  //if you want to cancel sending some events
		  
		  if self.Options <> nil and self.Options.Sample_rate < 1.0 then
		    
		    Dim r As Double = System.Random.InRange(0, 100) / 100.0
		    
		    if r > self.Options.sample_rate then Return True
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(DSN As String)
		  
		  
		  self.startTime = DateTime.Now
		  self.ParseDSN(dsn)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GenerateAttachmentEnvelope(file As FolderItem, contentType As String) As String
		  
		  Dim js As new Dictionary
		  
		  js.Value("type") = "attachment"
		  
		  if file is nil or file.Exists = False then
		    js.Value("length") = 0
		    
		    Return GenerateJSON(js) + &u0A + &u0A
		    
		  Else
		    
		    
		    
		    //Maximum file size is 20MiB
		    if file.Length > 20 * 1024 * 1024 then
		      System.DebugLog CurrentMethodName + " attachment discarded (over 20MiB)"
		      Return ""
		    end if
		    
		    js.Value("length") = file.Length
		    js.Value("filename") = file.Name
		    
		    if contentType.IsEmpty = False then
		      js.Value("content_type") = contentType
		    end if
		    
		    
		    Dim tis As TextInputStream = TextInputStream.Open(file)
		    
		    Return GenerateJSON(js) + &u0A + tis.ReadAll + &u0A
		    
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GenerateJSON(mException As RuntimeException, currentFunction As String, message As String = "", level As errorLevel = ErrorLevel.error, Session As Variant = nil) As Dictionary
		  
		  // Message length limitation https://develop.sentry.dev/sdk/data-handling/#variable-size
		  #if DebugBuild
		    If message.Length > 8192 then
		      System.DebugLog CurrentMethodName + " message is limited to 8192 characters. " + _
		      "Sentry will either drop the event or trim the message"
		    End If
		  #endif
		  
		  
		  Dim stack() As StackFrame
		  
		  stack = mException.StackFrames
		  
		  Dim jStack() As Dictionary
		  
		  Dim include_address As Boolean = True
		  if self.Options <> nil then
		    include_address = self.Options.include_StackFrame_Address
		  end if
		  
		  Dim lastFrame As Dictionary
		  
		  for i as integer = stack.Ubound downto 0
		    
		    dim frame as StackFrame = stack(i)
		    
		    Dim fname As String = frame.Name
		    Dim fAddressInt As UInteger = UInteger(frame.Address)
		    Dim fAddress As String = fAddressInt.toString
		    
		    Dim jframe As New Dictionary
		    jframe.Value("function") = fname
		    if include_address then
		      jframe.Value("filename") = fAddress
		      jframe.Value("module")="-"
		    end if
		    
		    
		    if fname.BeginsWith("Raise") = false and fname.BeginsWith("Runtime") = False then
		      lastFrame = jframe
		    end if
		    
		    jStack.Append jframe
		  Next
		  
		  //Adding current method name at the end
		  if currentFunction.isEmpty = False then
		    Dim firstFrame As New Dictionary
		    firstFrame.Value("function") = currentFunction
		    if include_address then
		      firstFrame.Value("filename") = "0"
		      
		    end if
		    firstFrame.Value("module")="-"
		    
		    jStack.Append firstFrame
		    
		  Elseif lastFrame <> nil then
		    Dim fname As String = lastFrame.Value("function")
		    
		    Dim firstFrame As New Dictionary
		    firstFrame.Value("function") = fname
		    if include_address then
		      firstFrame.Value("filename") = "0"
		      
		    end if
		    firstFrame.Value("module")="-"
		    
		    jStack.Append firstFrame
		  end if
		  
		  
		  Dim stacktrace As New Dictionary
		  stacktrace.Value("frames") = jStack
		  
		  
		  
		  
		  
		  // add general info
		  
		  dim j As New Dictionary
		  
		  //Required
		  j.Value("event_id") = GenerateUUID
		  j.Value("timestamp") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  j.Value("platform") = "other"
		  
		  //ErrorLevel
		  Select case level
		  Case errorLevel.fatal
		    j.Value("level") = "fatal"
		  Case errorLevel.error
		    j.Value("level") = "error"
		  case errorLevel.warning
		    j.Value("level") = "warning"
		  case errorLevel.info
		    j.Value("level") = "info"
		  case errorLevel.debug
		    j.Value("level") = "debug"
		  End Select
		  
		  #if TargetIOS
		    If iOS_isTestflightXC then
		      j.Value("environment") = "testflight"
		    Else
		      j.Value("environment") = if(DebugBuild, "simulator", "release")
		    End If
		  #else
		    j.Value("environment") = if(DebugBuild, "debug", "release")
		  #endif
		  
		  //j.Value("fingerprint") = ["myrpc", "POST", "/foo.bar"]
		  
		  Dim type As xojo.Introspection.TypeInfo = xojo.Introspection.GetType(mException)
		  
		  j.Value("message") = type.name + &u0A + mException.Message + &u0A + "ErrorNumber: " + mException.ErrorNumber.ToString + &u0A + message
		  j.Value("stacktrace") = stacktrace
		  j.Value("release") = getAppVersion
		  'if currentFunction.isEmpty = False then
		  'j.Value("culprit") = currentFunction
		  'end if
		  
		  dim tags As New Dictionary
		  
		  tags.Value("offline") = False
		  
		  if currentFunction.isEmpty = False then
		    tags.Value("culprit") = currentFunction
		  end if
		  
		  if self.user <> nil and self.user.language.IsEmpty = False then
		    tags.Value("language") = self.user.language
		  Else
		    Dim loc As Locale = locale.Current
		    if Loc.Identifier.IndexOf("_") > -1 then
		      tags.Value("language") = loc.Identifier.NthField("_", 1)
		    Else
		      tags.Value("language") = loc.Identifier
		    end if
		  end if
		  
		  
		  //Global tags
		  if globalTags <> nil and globalTags.KeyCount > 0 then
		    try
		      //Trying to export tags as JSON
		      Dim tagOutput As String
		      tagOutput = GenerateJSON(globalTags)
		      
		      //JSON Export success, we can add each key to the tags
		      For each entry as DictionaryEntry in globalTags
		        tags.Value(entry.key) = entry.Value
		      Next
		    Catch
		      globalTags = nil
		    end try
		  end if
		  
		  //Additionnal tags
		  if tempTags <> nil and tempTags.KeyCount > 0 then
		    try
		      //Trying to export tags as JSON
		      Dim tagOutput As String
		      tagOutput = GenerateJSON(tempTags)
		      
		      //JSON Export success, we can add each key to the tags
		      For each entry as DictionaryEntry in tempTags
		        tags.Value(entry.key) = entry.Value
		      Next
		    Catch
		      tempTags = nil
		    end try
		  end if
		  
		  j.Value("tags") = tags
		  
		  //EXTRA
		  Dim extraDic As New Dictionary
		  'if extra.isEmpty = False then
		  'extraDic.Value("extra") = extra
		  'end if
		  try
		    if tempExtra <> nil then
		      for each entry as DictionaryEntry in tempExtra
		        extraDic.Value(entry.Key) = entry.Value
		      next
		    end if
		    Dim a As String
		    a = GenerateJSON(extraDic)
		  Catch
		    extraDic.RemoveAll
		  end try
		  
		  if extraDic <> nil and extraDic.KeyCount > 0 then
		    j.Value("extra") = extraDic
		  end if
		  
		  //add os version info
		  dim contexts As New Dictionary
		  dim osinfo As New Dictionary
		  
		  #if TargetIOS
		    
		    If true then
		      osinfo.Value("name") = "iOS"
		      Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		      declare function currentDevice_ lib "UIKit" selector "currentDevice" (clsRef as ptr) as ptr
		      declare function systemversion_ lib "UIKit" selector "systemVersion" (obj_id as ptr) as CFStringRef
		      Dim device as Ptr = currentDevice_(NSClassFromString("UIDevice"))
		      Dim systemVersion As String = systemversion_(device)
		      osinfo.Value("version") = systemVersion
		      osinfo.Value("device") = if(iOS_isIPad, "iPad", "iPhone")
		    End If
		    
		    
		  #elseif TargetLinux
		    dim sh as new Shell
		    sh.Execute("lsb_release", "-is")
		    osinfo.Value("name")=sh.Result
		    sh.Execute("lsb_release", "-rs")
		    osinfo.Value("version")=sh.Result
		  #elseif TargetMacOS
		    dim sh as new Shell
		    osinfo.Value("name")="MacOS"
		    sh.Execute("sw_vers -productVersion")
		    osinfo.Value("version")=sh.Result
		  #Elseif TargetWindows
		    'dim sh as new Shell
		    osinfo.Value("name")="Windows"
		    //hoops to get win os version
		    declare Function GetFileVersionInfoA lib "Api-ms-win-core-version-l1-1-0.dll" (filename as cstring,handle as uint32,len as uint32,p as ptr) as Boolean
		    declare Function GetFileVersionInfoSizeA lib "Api-ms-win-core-version-l1-1-0.dll" (filename as cstring,byref o as uint32) as uint32
		    declare Function VerQueryValueA lib "Api-ms-win-core-version-l1-1-0.dll" (block as ptr,name  as cstring,byref buffer as ptr,byref sze as uint32) as Boolean
		    dim o as uint32
		    dim s as uint32=GetFileVersionInfoSizeA("user32.dll",o)
		    dim v as new MemoryBlock(s)
		    dim r as ptr
		    v.UInt32Value(0)=s
		    if GetFileVersionInfoA("User32.dll",0,s,v) then
		      if VerQueryValueA(v,"\",r,o) then
		        'dim res As Xojo.Core.MemoryBlock=r
		        dim res As New Xojo.Core.MemoryBlock(r,o)
		        osinfo.Value("version")=str(res.UInt16Value(18))+"."+str(res.UInt16Value(16))+" "+str(res.UInt16Value(22))+"."+str(res.UInt16Value(20))
		      end if
		    end if
		  #Endif
		  
		  contexts.Value("os")=osinfo
		  
		  //info about the app
		  If True then
		    Dim jApp As New Dictionary
		    Dim GMTZone As New TimeZone("GMT")
		    Dim d As DateTime = new DateTime(self.startTime.SecondsFrom1970, GMTZone)
		    jApp.Value("app_start_time") = d.SQLDateTime.Replace(" ", "T") + "Z"
		    #if DebugBuild
		      #if TargetIOS
		        jApp.Value("build_type") = "simulator"
		      #Else
		        jApp.Value("build_type") = "debug"
		      #endif
		    #elseif TargetIOS
		      If ExtensionsXC.IsTestflightXC then
		        jApp.Value("build_type") = "testflight"
		      End If
		    #else
		      jApp.Value("build_type") = "release"
		    #endif
		    
		    #if TargetIOS
		      declare function NSClassFromString lib "Foundation" (clsName as CFStringRef) as ptr
		      declare function mainBundle lib "Foundation" selector "mainBundle" (clsRef as ptr) as ptr
		      Declare Function getbundleIdentifier lib "Foundation" selector "bundleIdentifier" (id as ptr) as CFStringRef
		      
		      Dim identifier As String = getbundleIdentifier(mainBundle(NSClassFromString("NSBundle")))
		      jApp.Value("app_identifier") = identifier
		      
		      'jApp.Value("app_name") = infoPlist.CFBundleDisplayName
		      
		      
		      
		    #elseif TargetDesktop or TargetWeb
		      
		      jApp.Value("app_name") = app.ExecutableFile.Name
		      
		    #endif
		    
		    jApp.Value("app_version") = getAppVersion
		    
		    contexts.Value("app") = jApp
		  End If
		  
		  
		  #if TargetWeb
		    
		    if Session <> nil then
		      Dim aSession As WebSession = Session
		      
		      Dim jBrowser As new Dictionary
		      jBrowser.Value("name") = aSession.Header("User-Agent")
		      jBrowser.Value("ClientWidth") = aSession.ClientWidth
		      jBrowser.Value("ClientHeight") = aSession.ClientHeight
		      jBrowser.Value("platform") = aSession.Platform
		      jBrowser.Value("IsDarkMode") = aSession.IsDarkMode
		      jBrowser.Value("ClientTime") = aSession.ClientTime.SQLDateTime
		      
		      contexts.Value("browser") = jBrowser
		    end if
		  #endif
		  
		  
		  //Culture
		  If True then
		    
		    Dim loc As Locale
		    
		    #if TargetWeb
		      if self.user <> nil and self.user.locale <> nil then
		        loc = self.user.locale
		      end if
		    #else
		      loc = locale.Current
		    #endif
		    
		    
		    if loc <> nil then
		      
		      Dim jCulture As new Dictionary
		      'jCulture.Value("calendar") = //No easy way to get this in Xojo
		      'jCulture.Value("display_name") = //No easy way to get this in Xojo
		      jCulture.Value("locale") = loc.Identifier.ToText
		      'jCulture.Value("is_24_hour_format") = //No easy way to get this in Xojo
		      jCulture.Value("timezone") = TimeZone.Current.Abbreviation
		      jCulture.Value("locale.CurrencySymbol") = loc.CurrencySymbol
		      jCulture.Value("locale.DecimalSeparator") = loc.DecimalSeparator
		      jCulture.Value("locale.GroupingSeparator") = loc.GroupingSeparator
		      
		      contexts.Value("culture") = jCulture
		      
		    End If
		  End If
		  
		  //Device
		  #if targetiOS
		    
		    Dim device As System.DeviceData = System.Device
		    
		    Dim jDevice As new Dictionary
		    
		    jDevice.Value("name") = Device.name.ToText
		    jDevice.Value("brand") = "Apple"
		    jDevice.Value("model") = device.Model.ToText
		    jDevice.Value("localizedmodel") = device.LocalizedModel.ToText
		    
		    
		    #if DebugBuild
		      jDevice.Value("simulator") = true
		    #endif
		    
		    
		    Dim orientation As Text
		    Select case device.orientation
		    Case System.DeviceData.Orientations.FaceDown
		      orientation = "FaceDown"
		    Case System.DeviceData.Orientations.FaceUp
		      orientation = "FaceUp"
		    Case System.DeviceData.Orientations.LandscapeLeft, System.DeviceData.Orientations.LandscapeRight
		      orientation = "Landscape"
		    Case System.DeviceData.Orientations.Portrait, System.DeviceData.Orientations.PortraitUpsideDown
		      orientation = "Portrait"
		    Case System.DeviceData.Orientations.Unknown
		      orientation = "Unknown"
		    End Select
		    jDevice.Value("orientation") = orientation
		    
		    //Getting battery status if option enabled
		    if self.Options.get_battery_status then
		      device.BatteryMonitoringEnabled = True
		      jDevice.Value("battery_level") = device.BatteryLevel * 100
		      Select case device.BatteryState
		      case System.DeviceData.BatteryStates.Charging
		        jDevice.Value("battery_status") = "Charging"
		        
		      case System.DeviceData.BatteryStates.Full
		        jDevice.Value("battery_status") = "Full"
		        
		      case System.DeviceData.BatteryStates.Unknown
		        jDevice.Value("battery_status") = "Unknown"
		        
		      case System.DeviceData.BatteryStates.Unplugged
		        jDevice.Value("battery_status") = "Unplugged"
		        
		      End Select
		      device.BatteryMonitoringEnabled = False
		    end if
		    
		    contexts.Value("device") = jDevice
		    
		  #EndIf
		  
		  
		  
		  //info about the version of Xojo
		  dim runtime As New Dictionary
		  runtime.Value("name") = "Xojo"
		  runtime.Value("version") = XojoVersionString
		  contexts.Value("runtime") = runtime
		  j.Value("contexts") = contexts
		  
		  
		  
		  //info about user
		  if self.user <> nil then
		    Dim jUser As New Dictionary
		    jUser.Value("id") = self.user.user_id
		    jUser.Value("lang") = self.user.language
		    if self.user.locale <> nil then
		      jUser.Value("locale") = self.user.locale.Identifier
		    end if
		    jUser.Value("ip_address") = self.user.ip
		    
		    If self.user.email.isEmpty = False then
		      jUser.Value("email") = self.user.email
		    End If
		    
		    if self.user.subscription.isEmpty = False then
		      jUser.Value("subscription") = self.user.subscription
		    end if
		    
		    j.Value("user") = jUser
		  end if
		  '{
		  '"user": {
		  '"id": "unique_id",
		  '"username": "my_user",
		  '"email": "foo@example.com",
		  '"ip_address": "127.0.0.1",
		  '"subscription": "basic"
		  '}
		  '}
		  
		  //Breadcrumbs
		  #if TargetWeb
		    
		    if self.breadcrumbsWeb <> nil and Session <> nil then
		      Dim aSession As WebSession = Session
		      
		      Dim sessionCrumbs() As Dictionary
		      if breadcrumbsWeb.HasKey(aSession.Identifier) then
		        sessionCrumbs = breadcrumbsWeb.Value(aSession.Identifier)
		      end if
		      
		      if sessionCrumbs.Count > 0 then
		        j.Value("breadcrumbs") = sessionCrumbs
		      end if
		    end if
		    
		  #else
		    if self.breadcrumbs.Count > 0 then
		      
		      j.Value("breadcrumbs") = self.breadcrumbs
		      
		    end if
		  #endif
		  
		  
		  Return j
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GenerateUUID() As String
		  
		  
		  
		  
		  #if TargetIOS
		    
		    Dim GUID As String
		    
		    declare function NSClassFromString lib "Foundation" (clsName as CFStringRef) as ptr
		    Declare Function init Lib "Foundation" Selector "init" (obj_id As ptr) As ptr
		    Declare Function alloc Lib "Foundation" Selector "alloc" (clsref As Ptr) As ptr
		    declare sub release lib "Foundation" selector "release" (obj_id as ptr)
		    
		    Dim nsuuidPtr As ptr = init(alloc(NSClassFromString("NSUUID")))
		    
		    Declare Function UUIDString Lib "Foundation" selector "UUIDString" (obj_id As ptr) As CFStringRef
		    GUID = UUIDString(nsuuidPtr)
		    
		    release( nsuuidPtr )
		    
		    self.mlastUUID = GUID
		    Return GUID
		    
		  #elseif TargetWeb or TargetDesktop
		    
		    // From http://www.cryptosys.net/pki/uuid-rfc4122.html
		    //
		    // Generate 16 random bytes (=128 bits)
		    // Adjust certain bits according to RFC 4122 section 4.4 as follows:
		    // set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
		    // set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
		    // Convert the adjusted bytes to 32 hexadecimal digits
		    // Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
		    // Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
		    
		    dim randomBytes as MemoryBlock = Crypto.GenerateRandomBytes(16)
		    randomBytes.LittleEndian = false
		    
		    //
		    // Adjust seventh byte
		    //
		    dim value as byte = randomBytes.Byte(6)
		    value = value and &b00001111 // Turn off the first four bits
		    value = value or &b01000000 // Turn on the second bit
		    randomBytes.Byte(6) = value
		    
		    //
		    // Adjust ninth byte
		    //
		    value = randomBytes.Byte(8)
		    value = value and &b00111111 // Turn off the first two bits
		    value = value or &b10000000 // Turn on the first bit
		    randomBytes.Byte(8) = value
		    
		    
		    dim result as string = EncodeHex(randomBytes)
		    result = result.LeftB(8) + "-" + result.MidB(9, 4) + "-" + result.MidB(13, 4) + "-" + result.MidB(17, 4) + _
		    "-" + result.RightB(12)
		    
		    
		    self.mlastUUID = result
		    return result
		    
		    
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getAppVersion() As String
		  
		  #if TargetIOS
		    declare function NSClassFromString lib "Foundation" (clsName as CFStringRef) as ptr
		    declare function mainBundle lib "Foundation" selector "mainBundle" (clsRef as ptr) as ptr
		    declare function objectForInfoDictionaryKey lib "Foundation" selector "objectForInfoDictionaryKey:" _
		    (obj_id as ptr, key as CFStringRef) as CFStringRef
		    
		    
		    
		    Return objectForInfoDictionaryKey(mainBundle(NSClassFromString("NSBundle")), "CFBundleShortVersionString")
		    
		  #else
		    
		    Dim fullVersion As String
		    fullVersion = app.MajorVersion.ToString + "." + app.MinorVersion.ToString + "." _
		    + app.BugVersion.ToString + "." + app.NonReleaseVersion.ToString
		    
		    Return fullVersion
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetInstance(DSN As String) As SentryController
		  https://PROJECT_ID@ID.ingest.sentry.io/NUMBER
		  
		  Static sharedInstance as SentryController
		  
		  if sharedInstance is nil then
		    sharedInstance = new SentryController(DSN)
		    sharedInstance.Options = new SentryOptions
		  end if
		  
		  Return sharedInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSentryFolder() As FolderItem
		  Dim folder As FolderItem
		  
		  #if TargetIOS
		    try
		      folder = SpecialFolder.ApplicationSupport
		      if not folder.Exists then folder.CreateFolder
		      
		      folder = folder.Child("sentry")
		      if not folder.Exists then folder.CreateFolder
		      
		    Catch err as IOException
		      //Disk is certainly full
		      Return nil
		    end try
		    
		  #else
		    
		    try
		      folder = SpecialFolder.ApplicationData
		      if not folder.Exists then folder.CreateFolder
		      
		      folder = folder.Child("sentry")
		      if not folder.Exists then folder.CreateFolder
		      
		    Catch err as IOException
		      //Disk is certainly full
		      Return nil
		    end try
		    
		  #endif
		  
		  
		  Return folder
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target64Bit))
		Private Function iOS_isIPad() As Boolean
		  
		  #if TargetIOS
		    Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		    declare function currentDevice_ lib "UIKit" selector "currentDevice" (clsRef as ptr) as ptr
		    declare function model_ lib "UIKit" selector "model" (obj_id as ptr) as CFStringRef
		    dim model as Text = model_(currentDevice_(NSClassFromString("UIDevice")))
		    dim isPad as boolean = model.BeginsWith("iPad")
		    
		    
		    
		    Return isPad
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetIOS and (Target64Bit))
		Private Function iOS_isTestflightXC() As Boolean
		  #if TargetIOS
		    Declare Function mainBundle Lib "Foundation" selector "mainBundle" (clsRef As ptr) As ptr
		    Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		    Declare Function appStoreReceiptURL lib "Foundation" selector "appStoreReceiptURL" (obj as ptr) as ptr
		    Declare function path lib "Foundation" selector "path" (obj as ptr) as CFStringRef
		    
		    Dim theURL As Ptr = appStoreReceiptURL(mainBundle(NSClassFromString("NSBundle")))
		    
		    if theURL <> nil then
		      Dim receiptURLString as Text = path(theURL)
		      
		      if receiptURLString.IndexOf("sandboxReceipt") > -1 then 
		        Return True
		      end if
		    end if
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseDSN(dsn As String)
		  
		  
		  // CURRENT DSN FORMAT: {PROTOCOL}://{PUBLIC_KEY}@{HOST}/{PATH}{PROJECT_ID}
		  Dim myPatternStr as String = "(.*):\/\/(.*)\@(.*)\.(.*)\/(.*)\Z(.*)"
		  Dim myRegEx as New RegEx
		  Dim myRegExMatch As RegExMatch
		  
		  myRegEx.Options.CaseSensitive = False
		  myRegEx.Options.Greedy = False
		  myRegEx.Options.StringBeginIsLineBegin = True
		  myRegEx.Options.StringEndIsLineEnd = True
		  myRegEx.Options.MatchEmpty = True
		  myRegEx.Options.TreatTargetAsOneLine = False
		  myRegEx.Options.DotMatchAll = false
		  myRegEx.SearchPattern = myPatternStr
		  myRegExMatch = myRegEx.Search(dsn)
		  
		  Dim path As String
		  
		  PublicKey= myRegExMatch.SubExpressionString(2).ToText
		  Path = myRegExMatch.SubExpressionString(3).ToText + "."
		  ProjectID= myRegExMatch.SubExpressionString(5).ToText
		  URI = myRegExMatch.SubExpressionString(1).ToText+"://" + path +myRegExMatch.SubExpressionString(4).ToText
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessQueue()
		  if queue is nil then Return
		  
		  if queue.KeyCount = 0 then Return
		  
		  
		  Dim event_id As String
		  
		  for each entry as DictionaryEntry in queue
		    event_id = entry.Key
		    
		    Dim data As String = entry.Value
		    
		    self.SendToSentry(event_id, data)
		    
		    //Send one at a time
		    exit
		  next
		  
		  if event_id.isempty = False then
		    queue.Remove(event_id)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C206578747261206B65792F76616C756573
		Sub RemoveAllExtra()
		  if tempExtra <> nil then
		    tempExtra.RemoveAll
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C20476C6F62616C2054616773
		Sub RemoveAllGlobalTags()
		  if globalTags <> nil then
		    globalTags.RemoveAll
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320616C6C2054616773
		Sub RemoveAllTags()
		  if tempTags <> nil then
		    tempTags.RemoveAll
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)), Description = 52656D6F766573207468652053657373696F6E277320617373696F6369617465642062726561646372756D6273
		Sub RemoveSessionBreadcrumbs(SessionID As String)
		  
		  if breadcrumbsWeb <> nil and breadcrumbsWeb.HasKey(SessionID) then
		    
		    breadcrumbsWeb.Remove(SessionID)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveOfflineException(event_id As String, jsData As String)
		  
		  Dim js As Dictionary = ParseJSON(jsData)
		  
		  
		  //Adding the offline tag
		  if js.HasKey("tags") then
		    Dim jsTags As Dictionary = js.Value("tags")
		    jsTags.Value("offline") = true
		    
		    jsData = xojo.GenerateJSON(js)
		  end if
		  
		  Dim folder As FolderItem = GetSentryFolder
		  if folder is nil then Return
		  
		  
		  try
		    Dim file As FolderItem = folder.Child(event_id)
		    
		    //Event already logged, nothing to do
		    if file.Exists then Return
		    
		    //Saving log to file
		    Dim tos As TextOutputStream = TextOutputStream.Create(file)
		    
		    tos.Write(jsData)
		    tos.Close
		  Catch
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656E647320616E206174746163686D656E74
		Sub SendAttachment(event_uuid As String, attachment As FolderItem = nil, attachmentContentType As String = "")
		  //Parameters: event_uuid As String, email As String, name As String, comments As String, attachment As FolderItem = nil, attachmentContentType As String = ""
		  
		  if event_uuid.IsEmpty then Return
		  if attachment is nil then Return
		  
		  
		  
		  Dim js As new Dictionary
		  
		  js.Value("event_id") = event_uuid
		  
		  
		  
		  Dim envelope As String
		  
		  Dim jsHeader As new Dictionary
		  jsHeader.Value("event_id") = event_uuid
		  
		  Dim jsType As new Dictionary
		  jsType.Value("type") = "attachment"
		  
		  //Now concat all items into the envelope
		  envelope = xojo.GenerateJSON(jsHeader, False) + &u0A
		  
		  
		  
		  #if true
		    if attachment <> nil and attachment.Exists then
		      
		      envelope = envelope + GenerateAttachmentEnvelope(attachment, attachmentContenttype)
		      
		    end if
		  #endif
		  
		  //We use  HTTPS
		  Dim sock As new SentrySocket
		  
		  
		  
		  //Build the header to submit
		  dim header as String
		  header="Sentry sentry_version=7,sentry_client=Xojo-Sentry/"+Version+"," + _
		  "sentry_timestamp=" + DateTime.now.SecondsFrom1970.ToString(locale.Raw, "######") + "," + _
		  "sentry_key="+PublicKey '+ '"&" + _
		  '"sentry_secret="+SecretKey
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+Version
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/x-sentry-envelope"
		  
		  sock.SetRequestContent(envelope, "text/plain")
		  
		  
		  
		  'Dim tag As new Dictionary
		  'tag.Value("sentry-event_id") = event_id
		  'tag.Value("sentry-envelope") = envelope
		  
		  'sock.callBack = WeakAddressOf StartSession_Process
		  'sock.tag = tag
		  
		  sock.Send("POST", uri + "/api/" + ProjectID + "/envelope/")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendOfflineExceptions()
		  //Path to sentry offline folder
		  Dim folder As FolderItem = GetSentryFolder
		  if folder is nil then Return
		  
		  
		  
		  //No pending exceptions
		  if folder.Count = 0 then Return
		  
		  //Check for connectivity
		  #if TargetIOS
		    Dim www As new Xojo_Sentry.iOSReachability
		    if www.isReachable = False then Return
		    
		  #elseif TargetDesktop or TargetConsole
		    If System.network.isConnected = False then 
		      Return
		    End If
		  #endif
		  
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  
		  if queue is nil then
		    queue = new Dictionary
		  end if
		  
		  For each file as FolderItem in folder.Children
		    
		    try
		      
		      Dim event_id As String = file.Name.ToText
		      
		      if event_id.Length <> 36 then
		        //Might be a system file
		        //Ignore it
		        Continue
		      end if
		      
		      //Read contents oof file
		      Dim tis As TextInputStream = TextInputStream.Open(file)
		      Dim data As String = tis.ReadAll
		      
		      queue.Value(event_id) = data
		      
		    Catch
		    end try
		    
		  Next
		  
		  ProcessQueue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)), Description = 53656E64732073657373696F6E20696E666F726D6174696F6E
		Sub SendSessionInfo(status As sessionStatus = Sessionstatus.ok, duration As Integer = 0)
		  //Warning, not available for Web projects at the moment.
		  
		  if self.Options.sample_rate < 1.0 then
		    
		    Dim r As Double = System.Random.InRange(0, 100)/100.0
		    if r > self.Options.sample_rate then 
		      Return
		    end if
		  end if
		  
		  
		  #if false
		    https://develop.sentry.dev/sdk/sessions/
		    {
		    
		    "sid": "7c7b6585-f901-4351-bf8d-02711b721929",
		    "did": "optional distinct user id",
		    "started": "2020-02-07T14:16:00Z",
		    "duration": 60,
		    "status": "exited",
		    "errors": 0,
		    "attrs": {
		    "release": "my-project-name@1.0.0",
		    "environment": "environment name",
		    "ip_address": "optional user ip address for filtering",
		    "user_agent": "optional user agent for filtering"
		    }
		    }
		  #endif
		  
		  Dim js As new Dictionary
		  
		  
		  if self.sessionID.IsEmpty then
		    self.sessionID = GenerateUUID
		    js.Value("sid") = self.sessionID
		    js.Value("init") = true
		    
		    //Grab the current time in GMT
		    Dim GMTZone As New TimeZone(0)
		    Dim now As new DateTime(DateTime.Now.SecondsFrom1970, GMTZone)
		    
		    js.Value("started") = now.SQLDateTime.Replace(" ", "T") + "Z"
		  else
		    js.Value("sid") = self.sessionID
		  end if
		  if self.user <> nil and self.user.user_id.IsEmpty = False then
		    js.Value("did") = self.user.user_id
		  end if
		  'js.Value("seq") = 
		  if duration > 0 then
		    js.Value("duration") = duration
		  end if
		  
		  Select case status
		  case sessionStatus.exited
		    js.Value("status") = "exited"
		    self.sessionID = "" //Forces next call to create a new session
		    
		  Case sessionStatus.ok
		    js.Value("status") = "ok"
		    
		  Case sessionStatus.crashed
		    js.Value("status") = "crashed"
		    self.sessionID = "" //Forces next call to create a new session
		    
		  Case sessionStatus.abnormal
		    js.Value("status") = "abnormal"
		    self.sessionID = "" //Forces next call to create a new session
		    
		  End Select
		  
		  if self.errorCount > 0 then
		    js.Value("errors") = self.errorCount
		  end if
		  
		  Dim attrs as new Dictionary
		  attrs.Value("release") = getAppVersion
		  
		  #if TargetIOS
		    If iOS_isTestflightXC then
		      attrs.Value("environment") = "testflight"
		    Else
		      attrs.Value("environment") = if(DebugBuild, "simulator", "release")
		    End If
		  #elseif TargetDesktop
		    #if TargetMacOS
		      attrs.Value("environment") = "MacOS"
		    #elseif TargetWindows
		      attrs.Value("environment") = "Windows"
		    #elseif TargetLinux
		      attrs.Value("environment") = "Linux"
		    #endif
		  #endif
		  
		  'attrs.Value("ip_address") = "Linux"
		  'attrs.Value("user_agent") = "Linux"
		  
		  js.Value("attrs") = attrs
		  
		  
		  Dim envelope As String
		  envelope = "{}" + &u0A + _
		  "{""type"":""session""}" + &u0A + _
		  xojo.GenerateJSON(js, False)
		  
		  
		  
		  //We use  HTTPS
		  'dim sock as new Xojo.Net.HTTPSocket
		  Dim sock As new SentrySocket
		  
		  
		  
		  //Build the header to submit
		  dim header as String
		  header="Sentry sentry_version=7,sentry_client=Xojo-Sentry/"+Version+"," + _
		  "sentry_timestamp=" + DateTime.now.SecondsFrom1970.ToString(locale.Raw, "######") + "," + _
		  "sentry_key="+PublicKey '+ '"&" + _
		  '"sentry_secret="+SecretKey
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+Version
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/x-sentry-envelope"
		  
		  
		  sock.SetRequestContent(envelope, "text/plain")
		  
		  'Dim tag As new Dictionary
		  'tag.Value("sentry-event_id") = event_id
		  'tag.Value("sentry-data") = data
		  
		  sock.callBack = WeakAddressOf StartSession_Process
		  sock.Send("POST", uri + "/api/" + ProjectID + "/envelope/")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendToSentry(event_id As String, data As String)
		  //We use  HTTPS
		  
		  Dim sock As new SentrySocket
		  
		  
		  
		  //Build the header to submit
		  dim header As String
		  header="Sentry sentry_version=7,sentry_client=Xojo-Sentry/"+Version+"," + _
		  "sentry_timestamp=" + now.SecondsFrom1970.ToString(locale.Raw, "######") + "," + _
		  "sentry_key="+PublicKey '+ '"&" + _
		  '"sentry_secret="+SecretKey
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+Version
		  sock.RequestHeader("X-Sentry-Auth") = header.ToText
		  sock.RequestHeader("Content-Type") = "application/json"
		  
		  
		  sock.SetRequestContent(data.ToText, "application/json")
		  
		  Dim tag As New Dictionary
		  tag.Value("sentry-event_id") = event_id
		  tag.Value("sentry-data") = data
		  
		  sock.tag = tag
		  
		  sock.callBack = WeakAddressOf SendToSentry_Process
		  sock.Send("POST", uri + "/api/" + ProjectID + "/store/")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SendToSentry_Process(content As String, error As RuntimeException, response As SentryResponse)
		  
		  if response is nil then Return
		  
		  
		  Dim tag As Dictionary = response.caller.tag
		  
		  //Getting event ID
		  Dim event_id As String = tag.Lookup("sentry-event_id", "")
		  
		  
		  Dim status As Integer = response.HTTPStatus
		  
		  if error <> nil or status > 200 then
		    
		    Dim jsData As String = tag.Lookup("sentry-data", "")
		    
		    
		    if jsData.isEmpty = False then
		      
		      
		      SaveOfflineException(event_id, jsData)
		      
		      
		      
		    end if
		    
		  Else
		    
		    //Event logged OK
		    
		    //Check to see if there is an associated file to delete
		    Dim folder As FolderItem = GetSentryFolder
		    if folder <> nil then
		      
		      try
		        Dim file As FolderItem = folder.Child(event_id)
		        
		        if file <> nil and file.Exists then
		          file.Remove
		        end if
		      Catch
		      end try
		      
		    end if
		    
		    
		    timer.CallLater(100, AddressOf ProcessQueue)
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656E6473207573657220666565646261636B
		Sub SendUserFeedback(event_uuid As String, email As String, name As String, comments As String, attachment As FolderItem = nil, attachmentContentType As String = "")
		  //Parameters: event_uuid As String, email As String, name As String, comments As String, attachment As FolderItem = nil, attachmentContentType As String = ""
		  
		  if event_uuid.IsEmpty then Return
		  
		  //Check if there user added some comments
		  if comments.IsEmpty then
		    
		    If attachment <> nil then
		      //User didn't comment but sent a file
		      self.SendAttachment(event_uuid, attachment, attachmentContentType)
		    End If
		    
		    Return
		  end if
		  
		  
		  #if false
		    https://develop.sentry.dev/sdk/sessions/
		    {"event_id":"9ec79c33ec9942ab8353589fcb2e04dc",
		    "email":"john@me.com",
		    "name":"John Me",
		    "comments":"It broke."}\n
		    }
		  #endif
		  
		  Dim js As new Dictionary
		  
		  js.Value("event_id") = event_uuid
		  
		  if email.IsEmpty = False then
		    js.Value("email") = email
		  end if
		  
		  if name.IsEmpty = False then
		    js.Value("name") = name
		  end if
		  
		  if comments.IsEmpty = False then
		    js.Value("comments") = comments
		  end if
		  
		  
		  
		  Dim envelope As String
		  
		  Dim jsHeader As new Dictionary
		  jsHeader.Value("event_id") = event_uuid
		  
		  Dim jsType As new Dictionary
		  jsType.Value("type") = "user_report"
		  
		  //Now concat all items into the envelope
		  envelope = xojo.GenerateJSON(jsHeader, False) + &u0A + _
		  xojo.GenerateJSON(jsType, False) + &u0A + _
		  Xojo.GenerateJSON(js, False) + &u0A
		  
		  
		  
		  
		  #if true
		    if attachment <> nil and attachment.Exists then
		      
		      envelope = envelope + GenerateAttachmentEnvelope(attachment, attachmentContenttype)
		      
		    end if
		  #endif
		  
		  //We use  HTTPS
		  Dim sock As new SentrySocket
		  
		  
		  
		  //Build the header to submit
		  dim header as String
		  header="Sentry sentry_version=7,sentry_client=Xojo-Sentry/"+Version+"," + _
		  "sentry_timestamp=" + Datetime.now.SecondsFrom1970.ToString(locale.Raw, "######") + "," + _
		  "sentry_key="+PublicKey '+ '"&" + _
		  '"sentry_secret="+SecretKey
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+Version
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/x-sentry-envelope"
		  
		  sock.SetRequestContent(envelope, "text/plain")
		  
		  
		  
		  'Dim tag As new Dictionary
		  'tag.Value("sentry-event_id") = event_id
		  'tag.Value("sentry-envelope") = envelope
		  
		  'sock.callBack = WeakAddressOf StartSession_Process
		  'sock.tag = tag
		  
		  sock.Send("POST", uri + "/api/" + ProjectID + "/envelope/")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartSession_Process(data As String, error As RuntimeException, response As SentryResponse)
		  #Pragma Unused data
		  #Pragma Unused Error
		  
		  Dim status As Integer = response.HTTPStatus
		  
		  if status = 429 then
		    
		    pauseUntil = DateTime.Now.AddInterval(0, 0, 0, 0, 0, 60)
		    Return
		    
		  end if
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656E647320616E20657863657074696F6E20746F2053656E747279
		Sub SubmitException(mException As RuntimeException, currentFunction As String, message As String = "", level As errorLevel = ErrorLevel.error, aWebSession As Variant = Nil)
		  try
		    
		    
		    
		    //Grab the current time in GMT
		    Dim GMTZone As New TimeZone("GMT")
		    now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		    
		    //Create the JSONItem that contains all the relevalt data
		    dim content As Dictionary = self.GenerateJSON(mException, currentFunction, message, level, aWebSession)
		    Dim data As String = xojo.GenerateJSON(content)
		    
		    If CancelSend(mException, content) then
		      self.RemoveAllExtra
		      self.RemoveAllTags
		      self.mlastUUID = ""
		      Return
		    End If
		    
		    self.BeforeSend(mException, content)
		    
		    self.SendToSentry(lastUUID, data)
		    
		    self.AfterSend(mException, content)
		    
		    self.RemoveAllExtra
		    self.RemoveAllTags
		    
		  Catch
		    
		  end try
		  
		  //send off the report
		  'dim res as string = sock.SendRequest("POST",uri+"/api/"+ProjectID+"/store/",100)
		  'if sock.ErrorCode=0 then
		  'Return new JSONItem(res) //contains a report id
		  'else
		  'Return content //Something failed.. we could save this for submission on next run
		  'end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Protected breadcrumbs() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target64Bit))
		Protected breadcrumbsWeb As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dicReportingFilter As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected errorCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private globalTags As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206964656E74696669657220285555494429206F6620746865206C6173742073656E7420457863657074696F6E2E
		#tag Getter
			Get
			  Return mlastUUID
			End Get
		#tag EndGetter
		lastUUID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mlastUUID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private now As DateTime
	#tag EndProperty

	#tag Property, Flags = &h0
		Options As Xojo_Sentry.SentryOptions
	#tag EndProperty

	#tag Property, Flags = &h0
		pauseUntil As DateTime
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ProjectID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private PublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected queue As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sessionID As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startTime As DateTime
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected tempExtra As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected tempTags As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private URI As String
	#tag EndProperty

	#tag Property, Flags = &h0
		user As Xojo_Sentry.SentryUser
	#tag EndProperty


	#tag Constant, Name = Version, Type = Text, Dynamic = False, Default = \"0.4", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lastUUID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
