#tag Class
Protected Class App
Inherits MobileApplication
	#tag CompatibilityFlags = TargetIOS
	#tag Event
		Sub Activated()
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb(CurrentMethodName, "")
		    
		    timer.CancelCallLater(AddressOf sentry.TerminateSession)
		    
		    app.sentry.SendSessionInfo(Xojo_Sentry.sessionStatus.ok)
		    
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub Closing()
		  if app.sentry <> nil then
		    
		    app.Sentry.SendSessionInfo(Xojo_Sentry.sessionStatus.exited)
		    
		    
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivating()
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb(CurrentMethodName, "")
		    
		    timer.CallLater(20000, AddressOf app.Sentry.TerminateSession)
		    
		    app.sentry.SendSessionInfo(Xojo_Sentry.sessionStatus.ok)
		    
		  end if
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub LowMemoryWarning()
		  
		  //Add a breadcrumb for LowMemoryWarning
		  
		  Dim message As String
		  
		  dim ObjectCount as integer
		  Dim memoryUsed As Integer
		  ObjectCount  = Runtime.ObjectCount
		  MemoryUsed  = Round(Runtime.MemoryUsed / 10000) / 100
		  
		  message = "ObjectCount: " + ObjectCount.ToString + EndOfLine + _
		  "MemoryUsed: " + memoryUsed.ToString + " MB"
		  
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb("info", CurrentMethodName, Xojo_Sentry.errorLevel.warning, _
		    new Dictionary("ObjectCount": ObjectCount, "MemoryUsed": memoryUsed.ToString + " MB"))
		  end if
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  
		  InitializeSentry()
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(exc As RuntimeException) As Boolean
		  #if DebugBuild
		    Dim reason As String
		    reason = exc.Message
		  #endif
		  
		  //Exception
		  
		  try
		    #if DebugBuild
		      app.Sentry.SubmitException(exc, "", "", Xojo_Sentry.errorLevel.debug)
		    #else
		      app.Sentry.SubmitException(exc, "", "", Xojo_Sentry.errorLevel.error)
		    #endif
		    
		    
		    
		    //Make sure we do not create another exception by sending it to Sentry
		  Catch err
		    
		  end try
		  
		  //Return true to let the app running
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub InitializeSentry()
		  
		  
		  Dim DSN As String = "<<YOUR DSN>>"
		  
		  
		  //Initialise Sentry
		  If DSN.IsEmpty or DSN = "<<YOUR DSN>>" then
		    Break //Get a DSN string from https://sentry.io
		    
		    Return
		  End If
		  
		  self.sentry = SentryController.GetInstance( DSN )
		  self.sentry.SendOfflineExceptions //Send exceptions that were triggered when offline
		  
		  
		  //If necessary, Sentry has a few options
		  self.sentry.Options.app_name = "" //Your app's name
		  
		  'self.sentry.Options.get_battery_status = True //Only relevant on iOS
		  self.sentry.Options.include_StackFrame_address = False
		  self.sentry.Options.max_breadcrumbs = 100 //The maximum amount of breadcrumbs to keep
		  self.sentry.Options.persistant_breadcrumbs = 10 //The maximum amount of persistant breadcrumbs to keep. Defaults to 10
		  self.sentry.Options.sample_rate = 1.0 //Configures the sample rate for error events, in the range of 0.0 to 1.0. The default is 1.0 which means that 100% of error events are sent. If set to 0.1 only 10% of error events will be sent. Events are picked randomly.
		  self.sentry.Options.save_before_sending = False //Saves the exception to disk before sending to Sentry. Set to True before sending an UnhandledException or when the app is about to crash
		  self.sentry.Options.traces_sample_rate = 0.1 //Configures the sample rate for tracing events, in the range of 0.0 to 1.0. The default is 0.1 which means that 10% of traces events are sent. Traces are picked randomly.
		  
		  
		  //If your app handles user authentication add the info to sentry
		  
		  Var user as new Xojo_Sentry.SentryUser
		  user.email = "name@example.com"
		  user.language = "en" //The language the user is running the app in
		  user.locale = locale.Current
		  'user.ip = "1.1.1.1" //Uncomment this if necessary. Default is "{{auto}}"
		  user.user_id = "1234" //The user's unique ID
		  
		  self.sentry.user = user
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		sentry As SentryController
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
			Name="_LaunchOptionsHandled"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TintColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ColorGroup"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconBadgeNumber"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
