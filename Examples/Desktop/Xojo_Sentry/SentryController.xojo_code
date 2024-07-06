#tag Class
Class SentryController
	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit)), Description = 4164647320612062726561646372756D62207769746820616E206F7074696F6E616C206D6573736167652E
		Sub AddBreadcrumb(category as String, message as String = "", level as Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info)
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
		  dic.Value("timestamp") = now.SecondsFrom1970
		  
		  //Message
		  if message.isempty = False then
		    dic.Value("message") = Message
		  end if
		  
		  //ErrorLevel
		  Select case level
		  Case errorLevel.fatal
		    dic.Value("level") = "fatal"
		  Case errorLevel.error
		    dic.Value("level") = "error"
		  case errorLevel.warning
		    dic.Value("level") = "warning"
		  case errorLevel.info
		    dic.Value("level") = "info"
		  case errorLevel.debug
		    dic.Value("level") = "debug"
		  End Select
		  
		  
		  breadcrumbs.Add dic
		  
		  CleanupBreadcrumbs(breadcrumbs)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit)), Description = 4164647320612062726561646372756D62207769746820747970652C2063617465676F727920616E64206D65737361676520706172616D65746572732E
		Sub AddBreadcrumb(type as String, category as String, message as String, level as Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info)
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
		  
		  dic.Value("type") = type
		  dic.Value("category") = category
		  
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  dic.Value("timestamp") = now.SecondsFrom1970
		  
		  
		  
		  if message.isempty = False then
		    dic.Value("message") = Message
		  end if
		  
		  
		  //ErrorLevel
		  Select case level
		  Case errorLevel.fatal
		    dic.Value("level") = "fatal"
		  Case errorLevel.error
		    dic.Value("level") = "error"
		  case errorLevel.warning
		    dic.Value("level") = "warning"
		  case errorLevel.info
		    dic.Value("level") = "info"
		  case errorLevel.debug
		    dic.Value("level") = "debug"
		  End Select
		  
		  
		  breadcrumbs.Add dic
		  
		  CleanupBreadcrumbs(breadcrumbs)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
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
		  dic.Value("timestamp") = now.SecondsFrom1970
		  
		  Dim data As new Dictionary
		  data.Value("from") = fromScreen
		  data.Value("to") = toScreen
		  
		  dic.Value("data") = data
		  
		  if message.IsEmpty = False then
		    dic.Value("message") = Message
		  end if
		  
		  breadcrumbs.Add dic
		  
		  CleanupBreadcrumbs(breadcrumbs)
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
		  
		  if value.Type = Variant.TypeObject then
		    dim oTypeInfo as Introspection.TypeInfo = Introspection.GetType(value)
		    
		    
		    #if not TargetAndroid //Comment this line if your Xojo version doesn't support Android
		      '#if True //UNCOMMENT this line if your Xojo version doesn't support Android
		      
		      if oTypeInfo is nil then
		        //nothing
		      Elseif oTypeInfo.fullname = "Xojo.Core.dictionary" then
		        try
		          Dim str As String = xojo.data.generatejson(value)
		          value = str
		          break //Shouldn't be passing a xojo.core.dictionary here
		        Catch
		          value = "Couldn't parse Xojo.core.dictionary"
		        end try
		      End If
		    #endif
		    
		    
		    
		  end if
		  
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
		Sub AddWebBreadcrumb(SessionID as String, category as String, message as String = "", level as Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info)
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
		  
		  #if DebugBuild and kVerbose
		    System.DebugLog "🥖 AddWebBreadcrumb"  + " " + category + ": " + message
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
		  
		  //ErrorLevel
		  Select case level
		  Case errorLevel.fatal
		    dic.Value("level") = "fatal"
		  Case errorLevel.error
		    dic.Value("level") = "error"
		  case errorLevel.warning
		    dic.Value("level") = "warning"
		  case errorLevel.info
		    dic.Value("level") = "info"
		  case errorLevel.debug
		    dic.Value("level") = "debug"
		  End Select
		  
		  Dim sessionCrumbs() As Dictionary
		  if breadcrumbsWeb is nil then
		    breadcrumbsWeb = new Dictionary
		  end if
		  
		  if breadcrumbsWeb.HasKey(SessionID) then
		    sessionCrumbs = breadcrumbsWeb.Value(SessionID)
		  end if
		  
		  sessionCrumbs.Add dic
		  
		  
		  CleanupBreadcrumbs(sessionCrumbs)
		  
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
		  
		  
		  CleanupBreadcrumbs(sessionCrumbs)
		  
		  breadcrumbsWeb.Value(SessionID) = sessionCrumbs
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4164647320612053656E74727955736572206261736564206F6E207468652053657373696F6E2773204964656E746966696572
		Sub AddWebUser(user As SentryUser, sessionIdentifier As String)
		  if webUsers is nil then
		    webUsers = new Dictionary
		  end if
		  
		  webUsers.Value(sessionIdentifier) = user
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

	#tag Method, Flags = &h1, Description = 436C65616E732D7570207468652062726561646372756D6273206966206E6563657373617279
		Protected Sub CleanupBreadcrumbs(breadcrumbs() As Dictionary)
		  //new v0.7
		  
		  Static redactedCount as Integer = 0
		  
		  try
		    if self.Options <> nil and breadcrumbs.Count > Options.max_breadcrumbs then
		      
		      if Options.persistant_breadcrumbs <= 0 then
		        //Remove the first breadcrumb
		        breadcrumbs.RemoveAt(0)
		        
		      Elseif breadcrumbs.Count > Options.persistant_breadcrumbs then
		        
		        if Options.persistant_breadcrumbs > Options.max_breadcrumbs+1 then
		          break
		          // Options.persistant_breadcrumbs must be smaller than Options.max_breadcrumbs
		          
		          breadcrumbs.RemoveAt(0)
		          Return
		        end if
		        
		        redactedCount = redactedCount + 1
		        
		        Dim crumb As Dictionary = breadcrumbs(Options.persistant_breadcrumbs)
		        
		        crumb.Value("category") = "info"
		        crumb.Value("type") = "default"
		        crumb.Value("message") = "<redacted x " + redactedCount.ToString + ">"
		        crumb.Value("level") = "info"
		        
		        if crumb.HasKey("data") then
		          crumb.Remove("data")
		        end if
		        
		        
		        while breadcrumbs.Count > Options.max_breadcrumbs
		          breadcrumbs.RemoveAt(Options.persistant_breadcrumbs+1)
		        wend
		      end if
		      
		    end if
		  Catch
		    
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(DSN As String)
		  
		  
		  self.startTime = DateTime.Now
		  self.ParseDSN(dsn)
		  
		  
		  
		  #if TargetWeb
		    self.webUsers = new Dictionary
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446566696E657320746865204854545020726571756573742074686174206C6976657320756E74696C20616E20657863657074696F6E2069732073656E742E
		Sub DefineRequest(HTTPmethod As String, url As String, data As String = "", requestHeaders As Dictionary = nil)
		  
		  
		  Dim jRequest As new Dictionary
		  
		  jRequest.Value("method") = HTTPmethod
		  
		  
		  Dim qIndex As Integer = url.IndexOf("?")
		  if qIndex = -1 then
		    jRequest.Value("url") = url
		  Else
		    jRequest.Value("url") = url.Left(qIndex)
		    jRequest.Value("query_string") = url.Middle(qIndex+1)
		  end if
		  
		  if data.IsEmpty = False then
		    
		    if data.Bytes > 16 * 1024 then
		      #if DebugBuild
		        System.DebugLog CurrentMethodName + " Data is limited to 16kB. " + _
		        "Sentry might drop the event. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		      #endif
		    end if
		    
		    jRequest.Value("data") = data
		  end if
		  
		  if requestHeaders <> nil and requestHeaders.KeyCount > 0 then
		    jRequest.Value("headers") = requestHeaders
		    
		  end if
		  
		  
		  self.lastRequest = jRequest
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
		  
		  Dim sessionIdentifier As String
		  #if TargetWeb
		    try
		      if Session <> nil then
		        Dim aSession As WebSession = Session
		        sessionIdentifier = aSession.Identifier
		      end if
		    Catch
		    end try
		  #endif
		  
		  
		  
		  Dim include_address As Boolean = True
		  if self.Options <> nil then
		    include_address = self.Options.include_StackFrame_Address
		  end if
		  
		  Dim lastFrame As Dictionary
		  Dim jStack() As Dictionary
		  
		  // If your Xojo version does NOT support Android
		  // Comment this line of code ⬇️
		  #if TargetAndroid
		    
		    // If your Xojo version does NOT support Android
		    // Uncomment this line of code ⬇️
		    '#if False
		    
		    Dim stack() as String = mException.Stack
		    
		    Dim remove_line_numbers As Boolean = True
		    if options <> nil then
		      remove_line_numbers = self.Options.android_remove_line_numbers
		    end if
		    
		    For i as Integer = Stack.LastIndex DownTo 0
		      
		      Dim fname As String = stack(i)
		      
		      if remove_line_numbers and fname.Contains("#") then
		        fname = fname.Left(fname.IndexOf("#")-1)
		      end if
		      
		      Dim jframe As New Dictionary
		      jframe.Value("function") = fname
		      
		      
		      if fname.BeginsWith("Raise") = false and fname.BeginsWith("Runtime") = False then
		        lastFrame = jframe
		      end if
		      
		      jStack.Append jframe
		      
		    Next
		    
		  #else
		    
		    //The following code works on all targets except Android
		    
		    Dim stack() As StackFrame
		    stack = mException.StackFrames
		    
		    
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
		      
		      jStack.Add jframe
		    Next
		    
		  #endif
		  
		  //Adding current method name at the end
		  if currentFunction.isEmpty = False then
		    Dim firstFrame As New Dictionary
		    firstFrame.Value("function") = currentFunction
		    if include_address then
		      firstFrame.Value("filename") = "0"
		      
		    end if
		    firstFrame.Value("module")="-"
		    
		    jStack.Add firstFrame
		    
		  Elseif lastFrame <> nil then
		    Dim fname As String = lastFrame.Value("function")
		    
		    Dim firstFrame As New Dictionary
		    firstFrame.Value("function") = fname
		    if include_address then
		      firstFrame.Value("filename") = "0"
		      
		    end if
		    firstFrame.Value("module")="-"
		    
		    jStack.Add firstFrame
		  end if
		  
		  
		  Dim stacktrace As New Dictionary
		  stacktrace.Value("frames") = jStack
		  
		  
		  
		  
		  
		  // add general info
		  
		  dim j As New Dictionary
		  
		  //Required
		  j.Value("event_id") = GenerateUUID
		  j.Value("timestamp") = now.SecondsFrom1970
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
		  
		  Dim type As Introspection.TypeInfo = Introspection.GetType(mException)
		  
		  'j.Value("message") = type.name + &u0A + mException.Message + &u0A + "ErrorNumber: " + mException.ErrorNumber.ToString + &u0A + message
		  if message.IsEmpty = False then
		    j.Value("message") = message
		  end if
		  
		  'j.Value("stacktrace") = stacktrace
		  
		  //new v0.7
		  #if TargetIOS
		    if Options <> nil and Options.app_name.IsEmpty then
		      j.Value("release") = Options.app_name + "@" + getAppVersion
		    Else
		      j.Value("release") = getAppVersion
		    end if
		  #Else
		    if Options <> nil and Options.app_name.IsEmpty then
		      j.Value("release") = Options.app_name + "@" + getAppVersion
		    Else
		      j.Value("release") = app.ExecutableFile.name + "@" + getAppVersion
		    end if
		  #endif
		  
		  
		  
		  'if currentFunction.isEmpty = False then
		  'j.Value("culprit") = currentFunction
		  'end if
		  
		  
		  Dim jvalues() As Dictionary
		  Dim jException As new Dictionary
		  jException.Value("type") = type.Name
		  jException.Value("value") = if(mException.Message.IsEmpty, "", mException.Message + " - ") + "ErrorNumber: " + mException.ErrorNumber.ToString
		  jException.Value("stacktrace") = stacktrace
		  
		  //New v0.6
		  if currentFunction.IsEmpty or currentFunction = "App.UnhandledException" or currentFunction = "Session.UnhandledException" then
		    jException.Value("mechanism") = new Dictionary("type":"generic", "handled":false)
		  end if
		  
		  jvalues.Add jException
		  
		  j.value("exception") = jvalues
		  
		  if lastRequest <> nil then
		    j.Value("request") = lastRequest
		  end if
		  
		  ////////////////////
		  // Tags
		  ////////////////////
		  
		  dim tags As New Dictionary
		  
		  j.Value("tags") = GenerateTags(currentFunction, sessionIdentifier)
		  
		  //EXTRA
		  Dim extraDic As New Dictionary
		  'if extra.isEmpty = False then
		  'extraDic.Value("extra") = extra
		  'end if
		  
		  
		  try
		    if tempExtra <> nil then
		      for each entry as DictionaryEntry in tempExtra
		        
		        //First add to a temporary dictionary
		        Dim tempDic As new Dictionary
		        Dim hasError As Boolean
		        
		        try
		          tempDic.Value(entry.Key) = entry.Value
		          
		          //Try generating JSON from that tempDictionary
		          Dim a as String
		          a = GenerateJSON(tempDic)
		        Catch
		          hasError = True
		        end try
		        
		        if not hasError then
		          //If no error generating JSON, we can add it to the extraDic
		          extraDic.Value(entry.Key) = entry.Value
		        Else
		          extraDic.Value(entry.Key) = "ERROR PARSING VALUE"
		        end if
		      next
		    end if
		    
		    //Try again generating JSON (just in case)
		    Dim a As String
		    a = GenerateJSON(extraDic)
		    
		  Catch
		    //Something went wrong, removing all extra key values
		    extraDic.RemoveAll
		  end try
		  
		  if extraDic <> nil and extraDic.KeyCount > 0 then
		    j.Value("extra") = extraDic
		  end if
		  
		  //add os version info
		  dim contexts As New Dictionary
		  dim osinfo As New Dictionary
		  
		  osinfo = self.GenerateOSInfo()
		  
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
		      If iOS_isTestflightXC then
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
		    
		    //new v0.7
		    jApp.Value("app_memory") = Runtime.MemoryUsed
		    jApp.Value("object_count") = Runtime.ObjectCount
		    
		    //new v0.7
		    #if TargetDesktop or TargetWeb
		      #if TargetARM
		        #if Target32Bit
		          jApp.Value("app_arch") = "ARM 32-bit"
		        #elseif Target64Bit
		          jApp.Value("app_arch") = "ARM 64-bit"
		        #endif 
		      #elseif TargetX86
		        #if Target32Bit
		          jApp.Value("app_arch") = "x86 32-bit"
		        #elseif Target64Bit
		          jApp.Value("app_arch") = "x86 64-bit"
		        #endif
		      #endif
		    #endif
		    
		    
		    
		    contexts.Value("app") = jApp
		  End If
		  
		  
		  
		  
		  //Device
		  #if targetiOS
		    
		    Dim device As System.DeviceData = System.Device
		    
		    Dim jDevice As new Dictionary
		    
		    jDevice.Value("name") = Device.name
		    jDevice.Value("brand") = "Apple"
		    jDevice.Value("model") = device.Model
		    jDevice.Value("localizedmodel") = device.LocalizedModel
		    
		    
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
		  
		  
		  //info about the browser
		  #if TargetWeb
		    
		    try
		      if Session <> nil then
		        Dim aSession As WebSession = Session
		        
		        
		        Dim jBrowser As new Dictionary
		        jBrowser.Value("name") = web_GetBrowserInfo(Session, "Browser")
		        
		        Dim browser_version As String = web_GetBrowserInfo(Session, "Version")
		        if browser_version.IsEmpty = False then
		          jBrowser.Value("version") = browser_version
		        end if
		        
		        jBrowser.Value("UserAgent") = aSession.Header("User-Agent")
		        
		        jBrowser.Value("ClientWidth") = aSession.ClientWidth
		        jBrowser.Value("ClientHeight") = aSession.ClientHeight
		        jBrowser.Value("platform") = aSession.Platform
		        jBrowser.Value("IsDarkMode") = aSession.IsDarkMode
		        jBrowser.Value("ClientTime") = aSession.ClientTime.SQLDateTime
		        jBrowser.Value("RawHeaders") = aSession.RawHeaders
		        
		        contexts.Value("browser") = jBrowser
		        
		        
		        
		      end if
		    Catch
		    end try
		  #endif
		  
		  //info about user
		  Var currentUser As SentryUser
		  #if TargetWeb
		    currentUser = self.webUsers.Lookup(sessionIdentifier, nil)
		  #else
		    currentUser = self.user
		  #endif
		  if currentUser <> nil then
		    
		    //Adding a few tags
		    if currentUser.language.IsEmpty = False then
		      tags.Value("language") = currentUser.language
		    Else
		      Dim loc As Locale = locale.Current
		      if Loc.Identifier.IndexOf("_") > -1 then
		        tags.Value("language") = loc.Identifier.NthField("_", 1)
		      Else
		        tags.Value("language") = loc.Identifier
		      end if
		    end if
		    
		    if currentUser.locale <> nil then
		      tags.Value("locale") = currentUser.locale.Identifier
		    end if
		    
		    j.Value("user") = GenerateUserData(sessionIdentifier)
		    
		    
		  end if
		  
		  
		  
		  
		  //Culture
		  If True then
		    
		    Dim loc As Locale
		    
		    #if TargetWeb
		      if currentUser <> nil and currentUser.locale <> nil then
		        loc = currentUser.locale
		      end if
		    #else
		      loc = locale.Current
		    #endif
		    
		    
		    if loc <> nil then
		      
		      Dim jCulture As new Dictionary
		      'jCulture.Value("calendar") = //No easy way to get this in Xojo
		      'jCulture.Value("display_name") = //No easy way to get this in Xojo
		      jCulture.Value("locale") = loc.Identifier
		      'jCulture.Value("is_24_hour_format") = //No easy way to get this in Xojo
		      jCulture.Value("timezone") = TimeZone.Current.Abbreviation
		      jCulture.Value("locale.CurrencySymbol") = loc.CurrencySymbol
		      jCulture.Value("locale.DecimalSeparator") = loc.DecimalSeparator
		      jCulture.Value("locale.GroupingSeparator") = loc.GroupingSeparator
		      
		      contexts.Value("culture") = jCulture
		      
		    End If
		  End If
		  
		  
		  
		  //Breadcrumbs
		  #if TargetWeb
		    
		    if self.breadcrumbsWeb <> nil and Session <> nil and Session isa WebSession then
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
		    #Pragma Unused Session
		    
		    if self.breadcrumbs.Count > 0 then
		      
		      j.Value("breadcrumbs") = self.breadcrumbs
		      
		    end if
		  #endif
		  
		  
		  Return j
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateOSInfo() As Dictionary
		  
		  //OS Info isn't supposed to change
		  //So we keep it in cache
		  
		  Static osinfo As Dictionary
		  
		  if osinfo is nil or osinfo.KeyCount = 0 then
		    
		    osinfo = new Dictionary
		    
		    #if TargetIOS
		      
		      If true then
		        osinfo.Value("name") = "iOS"
		        Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		        declare function currentDevice_ lib "UIKit" selector "currentDevice" (clsRef as ptr) as ptr
		        declare function systemversion_ lib "UIKit" selector "systemVersion" (obj_id as ptr) as CFStringRef
		        Dim device as Ptr = currentDevice_(NSClassFromString("UIDevice"))
		        Dim systemVersion As String = systemversion_(device)
		        osinfo.Value("version") = systemVersion
		        
		        
		        osinfo.Value("device") = if(iOS_isiOSAppOnMac, "iOSAppOnMac", if(iOS_isIPad, "iPad", "iPhone"))
		        
		        Declare Function processInfo Lib "Foundation" Selector "processInfo" (ClassName As ptr) As ptr
		        Declare Function operatingSystemVersionString Lib "Foundation" Selector "operatingSystemVersionString" (prInfo As ptr) As CFStringRef
		        systemVersion = operatingSystemVersionString( processInfo( NSClassFromString("NSProcessInfo") ))
		        osinfo.Value("operatingSystemVersion") = systemVersion
		      End If
		      
		    #elseif TargetAndroid
		      
		      osinfo.Value("name") = "Android"
		      Var vData As System.VersionData = System.Version
		      osinfo.Value("version") = vData.MajorVersion.ToString + "." + vData.MinorVersion.ToString + " (" + vData.BuildVersion + ")"
		      
		      osinfo.Value("device") = System.device.model
		      
		    #elseif TargetXojoCloud
		      
		      Dim vdata As System.VersionData = System.Version
		      osinfo.Value("version") = vdata.ToString
		      
		    #elseif TargetLinux
		      
		      dim sh as new Shell
		      sh.Execute("lsb_release", "-is")
		      osinfo.Value("name")=sh.Result
		      sh.Execute("lsb_release", "-rs")
		      osinfo.Value("version")=sh.Result
		      
		      Dim vdata As System.VersionData = System.Version
		      osinfo.Value("System.Version") = vdata.ToString
		      
		      
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
		          dim res As MemoryBlock = r
		          osinfo.Value("version")=str(res.UInt16Value(18))+"."+str(res.UInt16Value(16))+" "+str(res.UInt16Value(22))+"."+str(res.UInt16Value(20))
		        end if
		      end if
		      
		    #Endif
		    
		  end if
		  
		  Return osinfo
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateTags(currentFunction As String, SessionIdentifier As String) As Dictionary
		  dim tags As New Dictionary
		  
		  tags.Value("offline") = False
		  
		  if currentFunction.isEmpty = False then
		    tags.Value("culprit") = currentFunction
		  end if
		  
		  
		  Var currentUser As SentryUser
		  #if TargetWeb
		    if Session <> nil then
		      Dim aSession As WebSession = Session
		      currentUser = self.webUsers.Lookup(asession.identifier, nil)
		      
		      tags.Value("Session.LanguageCode") = aSession.LanguageCode
		      tags.Value("Session.LanguageRightToLeft") = aSession.LanguageRightToLeft
		    end if
		  #else
		    currentUser = self.user
		  #endif
		  if currentUser <> nil and currentUser.language.IsEmpty = False then
		    
		    'if self.user <> nil and self.user.language.IsEmpty = False then
		    tags.Value("language") = currentUser.language
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
		  
		  Return tags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateUserData(sessionIdentifier As String = "") As Dictionary
		  
		  Var currentUser As SentryUser
		  #if TargetWeb
		    currentUser = self.webUsers.Lookup(sessionIdentifier, nil)
		  #else
		    currentUser = self.user
		  #endif
		  if currentUser <> nil then
		    
		    
		    Dim jUser As New Dictionary
		    jUser.Value("id") = currentUser.user_id
		    jUser.Value("lang") = currentUser.language
		    if currentUser.locale <> nil then
		      jUser.Value("locale") = currentUser.locale.Identifier
		    end if
		    jUser.Value("ip_address") = currentUser.ip
		    
		    If currentUser.email.isEmpty = False then
		      jUser.Value("email") = currentUser.email
		    End If
		    
		    if currentUser.subscription.isEmpty = False then
		      jUser.Value("subscription") = currentUser.subscription
		    end if
		    
		    Return jUser
		    
		  end if
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateUUID() As String
		  
		  
		  
		  
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
		    
		    self.mlastUUID = GUID.ReplaceAll("-", "").Lowercase
		    Return GUID
		    
		  #else
		    
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
		    result = result.LeftBytes(8) + "-" + result.MiddleBytes(8, 4) + "-" + result.MiddleBytes(12, 4) + "-" + result.MiddleBytes(16, 4) + _
		    "-" + result.RightBytes(12)
		    
		    result = result.Lowercase.ReplaceAll("-", "")
		    
		    self.mlastUUID = result
		    return result
		    
		    
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getAppVersion() As String
		  
		  #if TargetIOS
		    declare function NSClassFromString lib "Foundation" (clsName as CFStringRef) as ptr
		    declare function mainBundle lib "Foundation" selector "mainBundle" (clsRef as ptr) as ptr
		    declare function objectForInfoDictionaryKey lib "Foundation" selector "objectForInfoDictionaryKey:" _
		    (obj_id as ptr, key as CFStringRef) as CFStringRef
		    
		    
		    
		    Return objectForInfoDictionaryKey(mainBundle(NSClassFromString("NSBundle")), "CFBundleShortVersionString")
		    
		  #else
		    
		    Dim fullVersion As String
		    fullVersion = app.MajorVersion.ToString + "." + app.MinorVersion.ToString + "." _
		    + app.BugVersion.ToString + "+" + app.NonReleaseVersion.ToString
		    
		    Return fullVersion
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetCurrentTimestamp() As Double
		  //Grab the current time in GMT
		  Dim GMTZone As New TimeZone("GMT")
		  Var now As DateTime
		  now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		  
		  Return now.SecondsFrom1970
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetEnvelopeHeader() As String
		  return "Sentry sentry_version=7,sentry_client=Xojo-Sentry/"+kVersion+"," + _
		  "sentry_timestamp=" + DateTime.now.SecondsFrom1970.ToString(locale.Raw, "######") + "," + _
		  "sentry_key="+PublicKey '+ '"&" + _
		  '"sentry_secret="+SecretKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetInstance(DSN As String) As SentryController
		  // DSN:https://PROJECT_ID@ID.ingest.sentry.io/NUMBER
		  
		  Static sharedInstance as SentryController
		  
		  if sharedInstance is nil then
		    sharedInstance = new SentryController(DSN)
		    sharedInstance.Options = new SentryOptions
		  end if
		  
		  Return sharedInstance
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetSentryFolder() As FolderItem
		  Dim folder As FolderItem
		  
		  #if TargetIOS or TargetAndroid
		    
		    try
		      folder = SpecialFolder.ApplicationSupport
		      if not folder.Exists then folder.CreateFolder
		      
		      folder = folder.Child("sentry")
		      if not folder.Exists then folder.CreateFolder
		      
		    Catch err as IOException
		      //Disk is certainly full
		      Return nil
		    end try
		    
		  #elseif TargetXojoCloud
		    
		    try
		      folder = SpecialFolder.Temporary
		      if not folder.Exists then folder.CreateFolder
		      
		      folder = folder.Child("sentry")
		      if not folder.Exists then folder.CreateFolder
		      
		    Catch err as IOException
		      //Disk is certainly full
		      Return nil
		    end try
		    
		  #else
		    
		    try
		      
		      folder = SpecialFolder.Caches
		      if not folder.Exists then folder.CreateFolder
		      
		      
		      folder = folder.Child(app.ExecutableFile.Name)
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
		Private Function iOS_isiOSAppOnMac() As Boolean
		  
		  #if TargetIOS
		    if System.Version.MajorVersion >= 14 then
		      
		      //Detecting Apple silicon
		      Declare Function NSClassFromString Lib "Foundation" (name As CFStringRef) As Ptr
		      declare function processInfo_ lib "Foundation" selector "processInfo" (clsRef as ptr) as ptr
		      declare function isiOSAppOnMac_ lib "Foundation" selector "isiOSAppOnMac" (obj_id as ptr) as Boolean
		      dim AppOnMac as boolean = isiOSAppOnMac_(processInfo_(NSClassFromString("NSProcessInfo")))
		      
		      
		      Return AppOnMac
		    end if
		    
		  #endif
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

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetIOS and (Target64Bit))
		Protected Function iOS_isTestflightXC() As Boolean
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

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit)), Description = 52657475726E7320746865206C6173742062726561646372756D622E2050617373207468652073657373696F6E204964656E74696669657220696620696E2061205765622050726F6A656374
		Function LastBreadcrumb(sessionID As String = "") As Dictionary
		  #if TargetWeb
		    
		    if breadcrumbsWeb is nil then Return nil
		    
		    Dim sessionCrumbs() as Dictionary
		    
		    if breadcrumbsWeb.HasKey(SessionID) then
		      sessionCrumbs = breadcrumbsWeb.Value(SessionID)
		      
		      if sessionCrumbs.Count > 0 then
		        
		        Return sessionCrumbs(sessionCrumbs.LastIndex)
		        
		      end if
		    end if
		    
		    
		    
		  #else
		    
		    if breadcrumbs is nil then Return nil
		    
		    if breadcrumbs.Count > 0 then
		      
		      Return breadcrumbs(breadcrumbs.LastIndex)
		      
		      
		    end if
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseDSN(dsn As String)
		  
		  #if TargetAndroid //Comment if your Xojo version doesn't support Android
		    '#if False //UNCOMMENT if your Xojo version doesn't support Android
		    
		    Dim path As String
		    
		    PublicKey = dsn.NthField("://", 2).NthField("@", 1)
		    path = dsn.NthField("@", 2).NthField("/", 1)
		    
		    Dim temp() as String = dsn.Split("/")
		    mProjectID = temp(temp.LastIndex)
		    
		    uri = "https://" + path
		    
		    
		  #else
		    
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
		    
		    PublicKey= myRegExMatch.SubExpressionString(2)
		    Path = myRegExMatch.SubExpressionString(3) + "."
		    mProjectID= myRegExMatch.SubExpressionString(5)
		    URI = myRegExMatch.SubExpressionString(1) + "://" + path +myRegExMatch.SubExpressionString(4)
		    
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessQueue()
		  if queue is nil then Return
		  
		  if queue.KeyCount = 0 then
		    
		    #if DebugBuild and kVerbose
		      System.DebugLog CurrentMethodName + " queue is empty. Return"
		    #endif
		    
		    Return
		  end if
		  
		  
		  Dim event_id As String
		  
		  // If your Xojo version does NOT support Android
		  // Comment this line of code ⬇️
		  #if TargetAndroid
		    
		    // If your Xojo version does NOT support Android
		    // UNCOMMENT this line of code ⬇️
		    '#if False
		    
		    for each entry as DictionaryEntry in queue
		      event_id = entry.Key
		      
		      Dim data As String = entry.Value
		      
		      'System.DebugLog CurrentMethodName + EndOfLine + data
		      
		      self.SendToSentry_Android(event_id, data)
		      
		      //Send one at a time
		      exit
		    next
		    
		  #else
		    
		    for each entry as DictionaryEntry in queue
		      event_id = entry.Key
		      
		      Dim data As String = entry.Value
		      
		      self.SendToSentry(event_id, data)
		      
		      //Send one at a time
		      exit
		    next
		  #endif
		  
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

	#tag Method, Flags = &h0
		Sub RemoveExtraKeyValue(key As String)
		  if tempExtra is nil then
		    Return
		  end if
		  
		  if tempExtra.HasKey(key) then
		    tempExtra.Remove(key)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit)), Description = 52656D6F76657320746865206C6173742061646465642062726561646372756D622E2053657373696F6E4944206973207265636F6D6D656E646564206F6E205765622E
		Sub RemoveLastBreadcrumb(sessionID As String = "")
		  // Removes the last added breadcrumb. SessionID is recommended on Web.
		  // SessionID is ignored on other platforms
		  #if TargetWeb
		    
		    //Try getting the current session
		    if sessionID.IsEmpty then
		      if session is nil then Return 
		      Dim aSession As WebSession = Session
		      sessionID = aSession.Identifier
		    end if
		    
		    Dim sessionCrumbs() As Dictionary
		    if breadcrumbsWeb is nil then
		      breadcrumbsWeb = new Dictionary
		    end if
		    
		    if breadcrumbsWeb.HasKey(SessionID) then
		      sessionCrumbs = breadcrumbsWeb.Value(SessionID)
		    end if
		    
		    
		    
		    if sessionCrumbs.Count > 0 then
		      
		      sessionCrumbs.ResizeTo(sessionCrumbs.LastIndex-1)
		      
		      
		    end if
		    
		  #else
		    #Pragma Unused sessionID
		    
		    if breadcrumbs.Count > 0 then
		      
		      breadcrumbs.ResizeTo(breadcrumbs.LastIndex-1)
		      
		      
		    end if
		    
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656D6F76657320746865204854545020726571756573742074686174206C6976657320756E74696C20616E20657863657074696F6E2069732073656E742E
		Sub RemoveLastRequest()
		  
		  self.lastRequest = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)), Description = 52656D6F766573207468652053657373696F6E277320617373696F6369617465642062726561646372756D6273
		Sub RemoveSessionBreadcrumbs(SessionID As String)
		  
		  if breadcrumbsWeb <> nil and breadcrumbsWeb.HasKey(SessionID) then
		    
		    breadcrumbsWeb.Remove(SessionID)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)), Description = 4E6565647320746F2062652063616C6C65642066726F6D2057656253657373696F6E2E436C6F73696E67206576656E74
		Sub RemoveWebUser(sessionIdentifier As String)
		  #if TargetWeb
		    
		    //Removing the user as the session terminates
		    if webUsers <> nil and webUsers.HasKey(sessionIdentifier) then
		      webUsers.Remove(sessionIdentifier)
		    end if
		    
		    
		    //Removing the breadcrumbs too
		    if breadcrumbsWeb <> nil and breadcrumbsWeb.HasKey(sessionIdentifier) then
		      breadcrumbsWeb.Remove(sessionIdentifier)
		    end if
		    
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SaveOfflineException(event_id As String, content As Dictionary)
		  
		  
		  Dim jsData As String = xojo.GenerateJSON(content)
		  
		  
		  //Adding the offline tag
		  try
		    Dim js As Dictionary
		    #if TargetAndroid
		      //Because of https://tracker.xojo.com/xojoinc/xojo/-/issues/76200
		      
		      js = ParseJSON(jsData)
		    #else
		      js = content.Clone
		    #endif
		    
		    if js.HasKey("tags") then
		      
		      Dim jsTags As Dictionary = js.Value("tags")
		      jsTags.Value("offline") = true
		      
		      jsData = xojo.GenerateJSON(js)
		    end if
		    
		  Catch err
		    System.DebugLog "❌ " + CurrentMethodName + " error1: " + err.Message
		  end try
		  
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
		    
		    #if DebugBuild and kVerbose
		      System.DebugLog CurrentMethodName + " file saved: " + event_id + " encoding: " + jsData.Encoding.InternetName
		    #endif
		    
		  Catch err
		    
		    #if DebugBuild
		      System.DebugLog "❌ " + CurrentMethodName + " error2: " + err.Message
		    #endif
		    
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
		  
		  #if TargetAndroid //Comment if your Xojo version doesn't support Android
		    '#if False //UNCOMMENT if your Xojo version doesn't support Android
		    Dim sock As new URLConnection
		  #else
		    Dim sock As new SentrySocket
		  #endif
		  
		  
		  //Build the header to submit
		  dim header as String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/x-sentry-envelope"
		  
		  sock.SetRequestContent(envelope, "text/plain")
		  
		  
		  
		  'Dim tag As new Dictionary
		  'tag.Value("sentry-event_id") = event_id
		  'tag.Value("sentry-envelope") = envelope
		  
		  'sock.callBack = WeakAddressOf StartSession_Process
		  'sock.tag = tag
		  
		  sock.Send("POST", uri + "/api/" + ProjectID + "/envelope/")
		  
		  #if DebugBuild and kVerbose
		    System.DebugLog CurrentMethodName + " Attachment sent"
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53656E647320657863657074696F6E73207468617420776865726520736176656420746F204469736B
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
		      
		      Dim event_id As String = file.Name
		      
		      if event_id.Length <> 32 and event_id.Length <> 36 then
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

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)), Description = 53656E64732073657373696F6E20696E666F726D6174696F6E20746F2053656E7472792E20412053657373696F6E206973206E6F7420612057656253657373696F6E2E20412053657373696F6E20697320616E206F70656E696E67202F20636C6F73696E67206F6620616E20617070
		Sub SendSessionInfo(status As sessionStatus = Sessionstatus.ok, duration As Integer = 0)
		  // ⚠️ Warning, not available for Web projects at the moment.
		  
		  // A Session is not a WebSession. A Session is an opening / closing of an app
		  
		  //Documentation: https://develop.sentry.dev/sdk/sessions/
		  
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
		    
		    sessionStartTime = DateTime.Now
		  else
		    js.Value("sid") = self.sessionID
		  end if
		  
		  if self.user <> nil and self.user.user_id.IsEmpty = False then
		    js.Value("did") = self.user.user_id
		  end if
		  
		  if duration > 0 then
		    js.Value("duration") = duration
		  Elseif self.sessionStartTime <> nil then
		    duration = Round(DateTime.Now.SecondsFrom1970 - self.sessionStartTime.SecondsFrom1970)
		    if duration > 0 then
		      js.Value("duration") = duration
		    end if
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
		  
		  //new v0.7
		  #if TargetIOS
		    if Options <> nil and Options.app_name.IsEmpty then
		      attrs.Value("release") = Options.app_name + "@" + getAppVersion
		    Else
		      attrs.Value("release") = getAppVersion
		    end if
		  #Else
		    if Options <> nil and Options.app_name.IsEmpty then
		      attrs.Value("release") = Options.app_name + "@" + getAppVersion
		    Else
		      attrs.Value("release") = app.ExecutableFile.name + "@" + getAppVersion
		    end if
		  #endif
		  
		  
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
		  
		  
		  js.Value("attrs") = attrs
		  
		  
		  Dim envelope As String
		  envelope = "{}" + &u0A + _
		  "{""type"":""session""}" + &u0A + _
		  xojo.GenerateJSON(js, False)
		  
		  
		  
		  //We use  HTTPS
		  Dim sock As new SentrySocket
		  
		  
		  
		  //Build the header to submit
		  dim header as String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/x-sentry-envelope"
		  
		  
		  sock.SetRequestContent(envelope, "text/plain")
		  
		  'Dim tag As new Dictionary
		  'tag.Value("sentry-event_id") = event_id
		  'tag.Value("sentry-data") = data
		  
		  sock.callBack = WeakAddressOf StartSession_Process
		  
		  if status = sessionStatus.ok then
		    sock.Send("POST", uri + "/api/" + ProjectID + "/envelope/")
		  Else
		    //Send immediately
		    try
		      #Pragma BreakOnExceptions False
		      //Wrapping in try... catch as it can create an exception if not connected
		      call sock.SendSync("POST", uri + "/api/" + ProjectID + "/envelope/", 3) //3sec timeout
		    Catch
		    end try
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546573747320796F75722053656E74727920696E746567726174696F6E
		Sub SendTestException()
		  
		  Dim err As new RuntimeException
		  err.Message = "Test exception from XojoSentry"
		  
		  self.SubmitException(err, CurrentMethodName, "Only a test", errorLevel.debug)
		  
		  
		  Var url As String = "https://sentry.io/issues/?project=_PID_&statsPeriod=30d&utc=true"
		  url = url.Replace("_PID_", self.ProjectID)
		  
		  Dim openedInBrowser As Boolean
		  
		  #if TargetWeb
		    if Session <> nil then
		      Session.GoToURL(URL, True)
		      openedInBrowser = True
		    end if
		    
		  #elseif TargetConsole
		    
		  #elseif TargetDesktop
		    System.GotoURL(url)
		    openedInBrowser = True
		    
		    
		  #endif
		  
		  if openedInBrowser = False then
		    System.DebugLog CurrentMethodName + " now go to Sentry: " + url
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Private Sub SendToSentry(event_id As String, data As String)
		  
		  
		  Dim sock As new SentrySocket
		  
		  
		  //Build the header to submit
		  dim header As String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/json"
		  
		  
		  sock.SetRequestContent(data, "application/json")
		  
		  Dim tag As New Dictionary
		  tag.Value("sentry-event_id") = event_id
		  tag.Value("sentry-data") = data
		  
		  sock.tag = tag
		  
		  sock.callBack = WeakAddressOf SendToSentry_Process
		  sock.Send("POST", uri + "/api/" + ProjectID + "/store/")
		  
		  
		  #if DebugBuild and kVerbose
		    System.DebugLog CurrentMethodName + " Sent"
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetAndroid and (Target64Bit))
		Private Sub SendToSentry_Android(event_id As String, data As String)
		  
		  
		  //We use  HTTPS
		  Dim sock As new URLConnection
		  
		  AddHandler sock.ContentReceived, AddressOf Socket_ContentReceived
		  AddHandler sock.Error, AddressOf Socket_Error
		  
		  //Build the header to submit
		  dim header As String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
		  sock.RequestHeader("X-Sentry-Auth") = header
		  sock.RequestHeader("Content-Type") = "application/json"
		  
		  
		  sock.SetRequestContent(data, "application/json")
		  
		  Dim tag As New Dictionary
		  tag.Value("sentry-event_id") = event_id
		  tag.Value("sentry-data") = data
		  
		  'sock.tag = tag
		  
		  'sock.callBack = WeakAddressOf SendToSentry_Process
		  if Options <> nil and Options.send_sync then
		    Var result as string
		    try
		      result = sock.SendSync("POST", uri + "/api/" + ProjectID + "/store/", 60)
		    catch
		    end try
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + "_result: " + result
		    #endif
		  Else
		    sock.Send("POST", uri + "/api/" + ProjectID + "/store/", 60)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Private Sub SendToSentry_Process(content As String, error As RuntimeException, response As SentryResponse)
		  
		  if response is nil then Return
		  
		  if response.caller is nil then Return
		  if response.caller.tag is nil then Return
		  
		  
		  Dim tag As Dictionary = response.caller.tag
		  
		  //Getting event ID
		  Dim event_id As String = tag.Lookup("sentry-event_id", "")
		  
		  
		  Dim status As Integer = response.HTTPStatus
		  
		  if error <> nil or status > 200 then
		    
		    if Options <> nil and Options.save_before_sending then
		      //Exception should already be saved to disk
		      Return
		    end if
		    
		    Dim jsData As String = tag.Lookup("sentry-data", "")
		    
		    
		    if jsData.isEmpty = False then
		      
		      try
		        Var sentryContent As Dictionary = xojo.ParseJSON(jsData)
		        SaveOfflineException(event_id, sentryContent)
		        
		      Catch err
		        System.DebugLog "❌ " + CurrentMethodName + " Problem parsing/generating JSON"
		      end try
		      
		      
		    end if
		    
		  Else
		    
		    //Event logged OK
		    
		    //Check to see if there is an associated file to delete
		    Dim folder As FolderItem = GetSentryFolder
		    if folder <> nil then
		      
		      try
		        Dim file As FolderItem = folder.Child(event_id)
		        
		        if file <> nil and file.Exists then
		          'file.Name = "sent_" + file.Name
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
		  
		  #if TargetAndroid //Comment if your Xojo version doesn't support Android
		    '#if False //UNCOMMENT if your Xojo version doesn't support Android
		    Dim sock As new URLConnection
		  #else
		    Dim sock As new SentrySocket
		  #endif
		  
		  
		  
		  //Build the header to submit
		  dim header as String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
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

	#tag Method, Flags = &h21, Description = 54686520666F6C6465722077686572652053656E747279207361766573206F66666C696E6520657863657074696F6E73
		Private Sub Socket_ContentReceived(caller As URLConnection, URL As String, HTTPStatus As Integer, content As String)
		  
		  #if DebugBuild and kVerbose
		    System.DebugLog CurrentMethodName + " Success " + content + " " + HTTPStatus.ToString 
		    
		    Var headers() as String
		    For Each header As Pair In caller.ResponseHeaders
		      headers.Add(header.Left + ":" + header.Right)
		    Next
		    'System.DebugLog "Headers: " + EndOfLine + String.FromArray(headers, EndOfLine)
		  #endif
		  
		  
		  RemoveHandler caller.ContentReceived, AddressOf Socket_ContentReceived
		  RemoveHandler caller.Error, AddressOf Socket_Error
		  
		  
		  
		  if HTTPStatus > 200 then
		    
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " URLconnection error: " + content
		    #endif
		    
		  Else
		    
		    //Event logged OK
		    Dim event_id As String
		    
		    try
		      
		      var js As new JSONItem(content)
		      
		      event_id = js.Value("id").StringValue
		      
		      
		    Catch
		    end try
		    
		    Var file_removed As Boolean
		    
		    if event_id.IsEmpty = False then
		      //Check to see if there is an associated file to delete
		      Dim folder As FolderItem = GetSentryFolder
		      if folder <> nil then
		        
		        try
		          Dim file As FolderItem = folder.Child(event_id)
		          
		          if file <> nil and file.Exists then
		            file.Remove
		            file_removed = True
		          end if
		        Catch
		        end try
		        
		      end if
		    end if
		    
		    #if DebugBuild and kVerbose
		      System.DebugLog CurrentMethodName + " file_removed: " + file_removed.ToString
		    #endif
		    
		    
		    timer.CallLater(100, AddressOf ProcessQueue)
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Socket_Error(caller As URLConnection, e As RuntimeException)
		  
		  #if DebugBuild
		    System.DebugLog CurrentMethodName + " Error " + e.Message
		  #endif
		  
		  
		  RemoveHandler caller.ContentReceived, AddressOf Socket_ContentReceived
		  RemoveHandler caller.Error, AddressOf Socket_Error
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Protected Sub StartSession_Process(data As String, error As RuntimeException, response As SentryResponse)
		  #Pragma Unused data
		  #Pragma Unused Error
		  
		  Dim status As Integer = response.HTTPStatus
		  
		  if status = 429 then
		    
		    pauseUntil = DateTime.Now.AddInterval(0, 0, 0, 0, 0, 60)
		    Return
		    
		  end if
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41207370616E20697320612074696D6564206170706C69636174696F6E206576656E74207468617420686173206120737461727420616E6420656E642074696D65
		Function StartSpan(parentTrace As SentryTrace = nil, operation As String, description As String, Optional parent_span_id As String) As SentrySpan
		  //For a list of operations, see here: https://develop.sentry.dev/sdk/performance/span-operations/
		  
		  #if TargetWeb
		    if parentTrace is nil and session <> nil then
		      Dim sessionID As String = session.identifier
		      
		      if currentTraceWeb <> nil and currentTraceWeb.HasKey(sessionID) then
		        parentTrace = currentTraceWeb.Value(sessionID)
		      end if
		    end if
		    
		    
		    
		  #else
		    if parentTrace is nil then
		      parentTrace = currentTrace
		    end if
		  #endif
		  
		  if parentTrace is nil then
		    System.DebugLog CurrentMethodName + " " + "A call to StartTracing is required before starting a span."
		    Return nil
		  elseif parentTrace.stopped then
		    System.DebugLog CurrentMethodName + " " + "The parentTrace has already been Finished. Can't StartSpan on a finished Trace."
		    Return nil
		  end if
		  
		  
		  
		  Dim sp As new SentrySpan
		  sp.start_timestamp = GetCurrentTimestamp()
		  sp.parentTrace = parentTrace
		  
		  sp.span_id = GenerateUUID.ReplaceAll("-", "").Left(16)
		  
		  sp.op = operation
		  
		  if description.IsEmpty = False then
		    sp.description = description
		  end if
		  
		  if parent_span_id.IsEmpty then
		    //Try finding the current span_id
		    if currentSpansIDs.Count > 0 then
		      sp.parent_span_id = currentSpansIDs(currentSpansIDs.LastIndex)
		    Else
		      sp.parent_span_id = parentTrace.span_id
		    end if
		  else
		    sp.parent_span_id = parent_span_id
		  end if
		  
		  sp.trace_id = parentTrace.trace_id
		  
		  
		  currentSpansIDs.Add sp.span_id
		  
		  
		  Return sp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartTracing(operation As String, description As String, level As Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info) As SentryTrace
		  //For a list of operations, see here: https://develop.sentry.dev/sdk/performance/span-operations/
		  
		  Dim transaction As new SentryTrace
		  transaction.start_timestamp = GetCurrentTimestamp()
		  transaction.event_id = GenerateUUID
		  transaction.op = operation
		  transaction.description = description
		  transaction.trace_id = GenerateUUID
		  transaction.span_id = GenerateUUID.ReplaceAll("-", "").Left(16)
		  transaction.level = level
		  
		  
		  
		  
		  #if TargetWeb
		    Dim sessionID As String
		    if session <> nil then
		      sessionID = session.Identifier
		    end if
		    if not sessionID.IsEmpty then
		      if currentTraceWeb is nil then
		        currentTraceWeb = new Dictionary
		      end if
		      if currentTraceWeb.HasKey(sessionID) = False then
		        currentTraceWeb.Value(sessionID) = transaction
		      end if
		    end if
		    
		  #else
		    self.currentTrace = transaction
		    
		  #endif
		  
		  Return transaction
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopSpan(span As SentrySpan)
		  //Just in case
		  if span.stopped = False then
		    span.stopped = true
		    span.timestamp = GetCurrentTimestamp
		  end if
		  
		  Var span_id as String = span.span_id
		  Var trace_id as String = span.trace_id
		  
		  Var idx As Integer = currentSpansIDs.IndexOf(span_id)
		  
		  if idx > -1 then
		    currentSpansIDs.RemoveAt(idx)
		  end if
		  
		  Dim trace As SentryTrace = span.parentTrace
		  
		  'if currentTrace <> nil and trace_id = currentTrace.trace_id then
		  
		  if trace <> nil then
		    
		    Var sp As SentrySpan = span.clone
		    
		    trace.spans.add sp
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E69736865732074686520706173736564207472616E73616374696F6E2E2050617373206E696C20746F2066696E697368207468652053656E74727927732063757272656E74207472616E73616374696F6E
		Sub StopTracing(trace As SentryTrace = nil, message As String = "", Session As Variant = nil, level As Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info)
		  Dim sessionIdentifier As String
		  #if TargetWeb
		    if Session <> nil then
		      Dim aSession As WebSession = Session
		      sessionIdentifier = aSession.Identifier
		    end if
		  #endif
		  
		  
		  #if TargetWeb
		    
		    if not sessionIdentifier.IsEmpty then
		      
		      if currentTraceWeb <> nil and currentTraceWeb.HasKey(sessionIdentifier) then
		        
		        if trace is nil then
		          trace = currentTraceWeb.Value(sessionIdentifier)
		          currentTraceWeb.Remove(sessionIdentifier)
		        Elseif trace = currentTraceWeb.Value(sessionIdentifier) then
		          currentTraceWeb.Remove(sessionIdentifier)
		        end if
		      end if
		      
		    end if
		    
		    
		    
		    if trace is nil then Return
		  #else
		    if trace is nil and currentTrace is nil then Return
		    
		    
		    if trace is nil then
		      trace = currentTrace
		      self.currentTrace = nil
		    elseif trace = self.currentTrace then
		      self.currentTrace = nil
		    end if
		    
		  #endif
		  
		  if trace.timestamp = 0.0 then
		    trace.timestamp = GetCurrentTimestamp()
		  end if
		  
		  
		  
		  ////////////////////
		  // Sample rate
		  ////////////////////
		  if self.Options <> nil and self.Options.traces_sample_rate < 1.0 then
		    
		    Dim r As Double = System.Random.InRange(0, 100) / 100.0
		    
		    if r > self.Options.traces_sample_rate then
		      #if DebugBuild
		        System.DebugLog(CurrentMethodName + " SentryOptions.traces_sample_rate is smaller than 1.0. This trace was randomly dropped.")
		      #endif
		      Return
		      
		    end if
		  end if
		  
		  
		  
		  
		  ////////////////////
		  // Tags
		  ////////////////////
		  trace.tags = GenerateTags("", sessionIdentifier)
		  
		  
		  trace.level = level
		  
		  
		  
		  //Need to test with contexts.trace
		  '#if not DebugBuild 
		  '#Pragma Error "TODO"
		  '#endif
		  '
		  '//Need to test with measurements
		  '#if not DebugBuild
		  '#Pragma Error "TODO"
		  '#endif
		  
		  
		  
		  
		  Dim envelope As String
		  
		  Dim jsHeader As new Dictionary
		  jsHeader.Value("event_id") = trace.event_id
		  
		  Dim jsType As new Dictionary
		  jsType.Value("type") = "transaction"
		  
		  //Now concat all items into the envelope
		  envelope = xojo.GenerateJSON(jsHeader, False) + &u0A +_
		  xojo.GenerateJSON(jsType, False) + &u0A
		  
		  Dim js As new Dictionary
		  
		  js.Value("type") = "transaction"
		  
		  js.Value("event_id") = trace.event_id
		  js.Value("project") = self.ProjectID
		  js.Value("transaction") = trace.description
		  'if transaction.description.IsEmpty = False then
		  'js.Value("title") = transaction.description
		  'end if
		  
		  if message.IsEmpty = False then
		    js.Value("message") = message
		  end if
		  
		  js.Value("start_timestamp") = trace.start_timestamp
		  js.Value("timestamp") = trace.timestamp
		  
		  ////////////////////
		  // Contexts
		  ////////////////////
		  dim contexts As New Dictionary
		  
		  //add os version info
		  contexts.Value("os") = GenerateOSInfo()
		  
		  contexts.Value("trace") = trace.GenerateJS
		  
		  js.Value("contexts") = contexts
		  
		  ////////////////////
		  // Breadcrumbs
		  ////////////////////
		  #if TargetWeb
		    
		    if self.breadcrumbsWeb <> nil and Session <> nil then
		      
		      
		      Dim sessionCrumbs() As Dictionary
		      if breadcrumbsWeb.HasKey(sessionIdentifier) then
		        sessionCrumbs = breadcrumbsWeb.Value(sessionIdentifier)
		      end if
		      
		      if sessionCrumbs.Count > 0 then
		        js.Value("breadcrumbs") = sessionCrumbs
		      end if
		    end if
		    
		  #else
		    if self.breadcrumbs.Count > 0 then
		      
		      js.Value("breadcrumbs") = self.breadcrumbs
		      
		    end if
		  #endif
		  
		  ////////////////////
		  // ErrorLevel
		  ////////////////////
		  Select case level
		  Case errorLevel.fatal
		    js.Value("level") = "fatal"
		  Case errorLevel.error
		    js.Value("level") = "error"
		  case errorLevel.warning
		    js.Value("level") = "warning"
		  case errorLevel.info
		    js.Value("level") = "info"
		  case errorLevel.debug
		    js.Value("level") = "debug"
		  End Select
		  
		  ////////////////////
		  // Spans
		  ////////////////////
		  Var jsSpans() as Dictionary
		  For each sp as SentrySpan in trace.spans
		    jsSpans.Add sp.GenerateJS
		  Next
		  js.Value("spans") = jsSpans
		  
		  
		  
		  ////////////////////
		  // User
		  ////////////////////
		  #if TargetWeb
		    if Session <> nil then
		      js.Value("user") = GenerateUserData(sessionIdentifier)
		    end if
		  #else
		    if self.user <> nil then
		      js.Value("user") = GenerateUserData
		    end if
		  #endif
		  
		  
		  
		  // GENERATING ENVELOPE
		  envelope = envelope + xojo.GenerateJSON(js, False) + &u0A
		  
		  
		  
		  
		  //We use  HTTPS
		  Dim sock As new URLConnection
		  
		  AddHandler sock.ContentReceived, AddressOf Socket_ContentReceived
		  AddHandler sock.Error, AddressOf Socket_Error
		  
		  
		  //Build the header to submit
		  dim header as String
		  header=GetEnvelopeHeader()
		  
		  
		  sock.RequestHeader("User-Agent") = "Xojo-Sentry/"+kVersion
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

	#tag Method, Flags = &h0, Description = 53656E647320616E20657863657074696F6E20746F2053656E747279
		Sub SubmitException(mException As RuntimeException, currentFunction As String, message As String = "", level As errorLevel = ErrorLevel.error, aWebSession As Variant = Nil)
		  try
		    
		    if level = errorLevel.error or level = errorLevel.fatal then
		      self.errorCount = errorCount + 1
		    end if
		    
		    #if TargetWeb
		      if aWebSession is nil then
		        aWebSession = Session
		      end if
		    #endif
		    
		    //Grab the current time in GMT
		    Dim GMTZone As New TimeZone("GMT")
		    now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
		    
		    //Create the JSONItem that contains all the relevalt data
		    dim content As Dictionary = self.GenerateJSON(mException, currentFunction, message, level, aWebSession)
		    
		    
		    If CancelSend(mException, content) then
		      self.RemoveAllExtra
		      self.RemoveAllTags
		      self.lastRequest = nil
		      self.mlastUUID = ""
		      Return
		    End If
		    
		    self.BeforeSend(mException, content)
		    
		    
		    
		    if Options <> nil and Options.save_before_sending then
		      SaveOfflineException(mlastUUID, content)
		    end if
		    
		    Dim data As String = xojo.GenerateJSON(content)
		    
		    #if TargetAndroid
		      self.SendToSentry_Android(lastUUID, data)
		    #else
		      self.SendToSentry(lastUUID, data)
		    #endif
		    
		    self.AfterSend(mException, content)
		    
		    self.RemoveAllExtra
		    self.RemoveAllTags
		    
		    self.lastRequest = nil
		  Catch
		    
		  end try
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Sub TerminateSession()
		  #if DebugBuild
		    System.DebugLog CurrentMethodName
		  #endif
		  
		  SendSessionInfo(sessionStatus.exited)
		  
		  //Make sure next session starts with 0 errors
		  self.errorCount = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit))
		Private Sub web_GetBrowserInfo(vSession As Variant, Type As String)
		  #if TargetWeb
		    Dim Session As WebSession = vSession
		    
		    Var UserAgent As String = Session.Header("User-Agent") 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/605.1.15 (KHTML,like Gecko) Version/13.1.1 Safari/605.1.15
		    
		    Var VersionNumber As String
		    
		    Select Case Type
		    Case "Cookie"
		      Return Session.Header("Cookie")
		      
		    Case "Host"
		      Return Session.Header("Host")
		      
		    Case "Accept"
		      Return Session.Header("Accept")
		      
		    Case "Accept-Language"
		      Return Session.Header("Accept-Language")
		      
		    Case "Accept-Encoding"
		      Return Session.Header("Accept-Encoding")
		      
		    Case "Connection"
		      Return Session.Header("Connection")
		      
		    Case "HTTPS"
		      Return Session.Header("HTTPS")
		      
		    Case "SCRIPT_NAME"
		      Return Session.Header("SCRIPT_NAME")
		      
		    Case "Browser"
		      
		      If UserAgent.IndexOf("Blackberry") >= 0 Then
		        Return "Blackberry"
		      ElseIf UserAgent.IndexOf("Chrome") >= 0 Then
		        Return "Chrome"
		      Elseif UserAgent.IndexOf("CriOS") >= 0 then
		        Return "Chrome"
		      ElseIf UserAgent.IndexOf("ChromeOS") >= 0 Then
		        Return "ChromeOS"
		      ElseIf UserAgent.IndexOf("Firefox") >= 0 Then
		        Return "Firefox"
		      ElseIf UserAgent.IndexOf("Internet Explorer") >= 0 Then
		        Return "Internet Explorer"
		        
		      ElseIf UserAgent.IndexOf("Edg") >= 0 Then
		        Return "Edge"
		        
		      ElseIf UserAgent.IndexOf("Opera") >= 0 Then
		        Return "Opera"
		      ElseIf UserAgent.IndexOf("Opera Mini") >= 0 Then
		        Return "Opera Mini"
		      ElseIf UserAgent.IndexOf("Safari") >= 0 Then
		        Return "Safari"
		        
		      ElseIf UserAgent.IndexOf("Unknown") >= 0 Then
		        Return "Unknown"
		      Else
		        Return "Unknown"
		      End If
		      
		    Case "SmallScreen" 'check if on a small screen device device
		      If UserAgent.IndexOf("Android") >= 0 Or UserAgent.IndexOf("Blackberry") >= 0 Or UserAgent.IndexOf("Opera Mini") >= 0 Or UserAgent.IndexOf("Safari Mobile") >= 0 Then
		        Return "True"
		      Else
		        Return ""
		      End If
		      
		      If UserAgent.IndexOf("Phone") >= 0 Or UserAgent.IndexOf("iPhone") >= 0 Or UserAgent.IndexOf("iPod") >= 0 Then 'iPod Touch
		        Return "True"
		      Else
		        Return ""
		      End If
		      
		    Case "Mobile" 'check if on a mobile device
		      If UserAgent.IndexOf("Android") >= 0 Or UserAgent.IndexOf("Blackberry") >= 0 Or UserAgent.IndexOf("Opera Mini") >= 0 Or UserAgent.IndexOf("Mobile") >= 0 Then 'Safari Mobile
		        Return "True"
		      Else
		        Return ""
		      End If
		      
		      If UserAgent.IndexOf("Phone") >= 0 Or UserAgent.IndexOf("iPhone") >= 0 Or UserAgent.IndexOf("iPod") >= 0 Or UserAgent.IndexOf("iPad") >= 0 Or UserAgent.IndexOf("Tablet") >= 0 Then
		        Return "True"
		      Else
		        Return ""
		      End If
		      
		    Case "Platform"
		      If UserAgent.IndexOf("Android") >= 0 And UserAgent.IndexOf("Phone") >= 0 Then
		        Return "AndroidPhone"
		      ElseIf UserAgent.IndexOf("Android") >= 0 And UserAgent.IndexOf("Tablet") >= 0 Then
		        Return "AndroidTablet"
		      ElseIf UserAgent.IndexOf("Blackberry") >= 0 Then
		        Return "Blackberry"
		      ElseIf UserAgent.IndexOf("iPad") >= 0 Then
		        Return "iPad"
		      ElseIf UserAgent.IndexOf("iPhone") >= 0 Then
		        Return "iPhone"
		      ElseIf UserAgent.IndexOf("iPod") >= 0 Then
		        Return "iPodTouch"
		      ElseIf UserAgent.IndexOf("Linux") >= 0 Then
		        Return "Linux"
		      ElseIf UserAgent.IndexOf("Macintosh") >= 0 Then
		        Return "macOS"
		        
		      ElseIf UserAgent.IndexOf("Windows") >= 0 Then
		        Return "Windows"
		      ElseIf UserAgent.IndexOf("Unknown") >= 0 Then
		        Return "Unknown"
		      Else
		        Return "Unknown"
		      End If
		      
		    Case "RenderingEngine"
		      If UserAgent.IndexOf("Gecko") >= 0 Then
		        Return "Gecko"
		      ElseIf UserAgent.IndexOf("Presto") >= 0 Then
		        Return "Presto"
		      ElseIf UserAgent.IndexOf("Trident") >= 0 Then
		        Return "Trident"
		      ElseIf UserAgent.IndexOf("WebKit") >= 0 Then
		        Return "WebKit"
		      ElseIf UserAgent.IndexOf("Unknown") >= 0 Then
		        Return "Unknown"
		      Else
		        Return "Unknown"
		      End If
		      
		    Case "Version" 'Version/13.1.1 Safari/605.1.15
		      
		      if UserAgent.Contains("Version") then
		        
		        VersionNumber = UserAgent.NthField("Version", 2) 'get from Version on
		        VersionNumber = VersionNumber.NthField(" ", 1) 'remove excess after space
		        VersionNumber = ReplaceAll(VersionNumber, "/", "").Trim 'remove any leading or trailing slashes and spaces
		        
		      Elseif UserAgent.Contains("Chrome") then
		        VersionNumber = UserAgent.NthField("Chrome", 2) 'get from Version on
		        VersionNumber = VersionNumber.NthField(" ", 1) 'remove excess after space
		        VersionNumber = ReplaceAll(VersionNumber, "/", "").Trim 'remove any leading or trailing slashes and spaces
		        
		      Elseif UserAgent.Contains("CriOS") then
		        VersionNumber = UserAgent.NthField("CriOS", 2) 'get from Version on
		        VersionNumber = VersionNumber.NthField(" ", 1) 'remove excess after space
		        VersionNumber = ReplaceAll(VersionNumber, "/", "").Trim 'remove any leading or trailing slashes and spaces
		        
		      Elseif UserAgent.Contains("Firefox") then
		        VersionNumber = UserAgent.NthField("Firefox", 2) 'get from Version on
		        VersionNumber = VersionNumber.NthField(" ", 1) 'remove excess after space
		        VersionNumber = ReplaceAll(VersionNumber, "/", "").Trim 'remove any leading or trailing slashes and spaces
		        
		      end if
		      
		    End Select
		    
		    Return VersionNumber
		    End Select
		    
		    Return ""
		    
		    'Select Case Type
		    'Case "Browser"
		    'Select Case Session.Browser
		    'Case WebSession.BrowserType.Android
		    'Return "Android"
		    'Case WebSession.BrowserType.Blackberry
		    'Return "Blackberry"
		    'Case WebSession.BrowserType.Chrome
		    'Return "Chrome"
		    'Case WebSession.BrowserType.ChromeOS
		    'Return "ChromeOS"
		    'Case WebSession.BrowserType.Firefox
		    'Return "Firefox"
		    'Case WebSession.BrowserType.InternetExplorer
		    'Return "Internet Explorer"
		    'Case WebSession.BrowserType.Opera
		    'Return "Opera"
		    'Case WebSession.BrowserType.OperaMini
		    'Return "Opera Mini"
		    'Case WebSession.BrowserType.Safari
		    'Return "Safari"
		    'Case WebSession.BrowserType.SafariMobile
		    'Return "Safari Mobile"
		    'Case WebSession.BrowserType.Unknown
		    'Return "Unknown"
		    'Case Else
		    'Return "Unknown"
		    'End Select
		    '
		    'Case "SmallScreen" 'check if on a small screen device device
		    'Select Case Session.Browser
		    'Case WebSession.BrowserType.Android, WebSession.BrowserType.Blackberry, WebSession.BrowserType.OperaMini, WebSession.BrowserType.SafariMobile
		    'Return "True"
		    'End Select
		    'Select Case Session.Platform
		    'Case WebSession.PlatformType.AndroidPhone, WebSession.PlatformType.Blackberry, WebSession.PlatformType.iPhone, WebSession.PlatformType.iPodTouch
		    'Return "True"
		    'Case Else
		    'Return ""
		    'End Select
		    '
		    'Case "Mobile" 'check if on a mobile device
		    'Select Case Session.Browser
		    'Case WebSession.BrowserType.Android, WebSession.BrowserType.Blackberry, WebSession.BrowserType.OperaMini, WebSession.BrowserType.SafariMobile
		    'Return "True"
		    'End Select
		    'Select Case Session.Platform
		    'Case WebSession.PlatformType.AndroidPhone, WebSession.PlatformType.AndroidTablet, WebSession.PlatformType.Blackberry, WebSession.PlatformType.iPad, WebSession.PlatformType.iPhone, WebSession.PlatformType.iPodTouch
		    'Return "True"
		    'Case Else
		    'Return ""
		    'End Select
		    '
		    'Case "Platform"
		    'Select Case Session.Platform
		    'Case WebSession.PlatformType.AndroidPhone
		    'Return "AndroidPhone"
		    'Case WebSession.PlatformType.AndroidTablet
		    'Return "AndroidTablet"
		    'Case WebSession.PlatformType.Blackberry
		    'Return "Blackberry"
		    'Case WebSession.PlatformType.iPad
		    'Return "iPad"
		    'Case WebSession.PlatformType.iPhone
		    'Return "iPhone"
		    'Case WebSession.PlatformType.iPodTouch
		    'Return "iPodTouch"
		    'Case WebSession.PlatformType.Linux
		    'Return "Linux"
		    'Case WebSession.PlatformType.Macintosh
		    'Return "Macintosh"
		    'Case WebSession.PlatformType.PS3
		    'Return "PS3"
		    'Case WebSession.PlatformType.Unknown
		    'Return "Unknown"
		    'Case WebSession.PlatformType.WebOS
		    'Return "WebOS"
		    'Case WebSession.PlatformType.Wii
		    'Return "Wii"
		    'Case WebSession.PlatformType.Windows
		    'Return "Windows"
		    'Case Else
		    'Return "Unknown"
		    'End Select
		    '
		    'Case "RenderingEngine"
		    'Select Case Session.RenderingEngine
		    'Case WebSession.EngineType.Gecko
		    'Return "Gecko"
		    'Case WebSession.EngineType.Presto
		    'Return "Presto"
		    'Case WebSession.EngineType.Trident
		    'Return "Trident"
		    'Case WebSession.EngineType.Unknown
		    'Return "Unknown"
		    'Case WebSession.EngineType.WebKit
		    'Return "WebKit"
		    'Case Else
		    'Return "Unknown"
		    'End Select
		    '
		    'Case "Version"
		    'Return Session.BrowserVersion
		    '
		    'End Select
		    
		    'Return ""
		    
		    
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
		Protected breadcrumbs() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target64Bit))
		Protected breadcrumbsWeb As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected currentSpansIDs() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected currentTrace As SentryTrace
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentTraceWeb As Dictionary
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

	#tag Property, Flags = &h1
		Protected lastRequest As Dictionary
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
		Private mProjectID As String
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

	#tag ComputedProperty, Flags = &h0, Description = 53656E74727927732070726F6A6563742049442E2028526561642D6F6E6C7929
		#tag Getter
			Get
			  Return mProjectID
			End Get
		#tag EndGetter
		ProjectID As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private PublicKey As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected queue As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sessionID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected sessionStartTime As DateTime
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

	#tag Property, Flags = &h1
		Protected URI As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
		user As Xojo_Sentry.SentryUser
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected webUsers As Dictionary
	#tag EndProperty


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
		#tag ViewProperty
			Name="ProjectID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
