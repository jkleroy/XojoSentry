#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub Activated()
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb(CurrentMethodName, "")
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Function CancelClosing() As Boolean
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb(CurrentMethodName, "")
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Sub Deactivated()
		  if app.Sentry <> nil then
		    app.Sentry.AddBreadcrumb(CurrentMethodName, "")
		  end if
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  
		  
		  
		  Dim DSN As String = "<<YOUR DSN>>"
		  
		  //Initialise Sentry
		  If DSN.IsEmpty or DSN = "<<YOUR DSN>>" then
		    Break //Get a DSN string from https://sentry.io
		    Quit
		    Return
		  End If
		  
		  self.sentry = SentryController.GetInstance( DSN )
		  self.sentry.SendOfflineExceptions //Send exceptions that were triggered when offline
		  
		  
		  //If necessary, Sentry has a few options
		  'self.sentry.Options.get_battery_status = True //Only relevant on iOS
		  self.sentry.Options.include_StackFrame_address = False
		  self.sentry.Options.max_breadcrumbs = 100
		  self.sentry.Options.sample_rate = 1.0 //Keep this value at 1.0 when debugging, change value for a released app
		  
		  
		  
		  //If your app handles user authentication add the info to sentry
		  
		  Var user as new Xojo_Sentry.SentryUser
		  user.email = "name@example.com"
		  user.language = "en" //The language the user is running the app in
		  user.locale = locale.Current
		  'user.ip = "1.1.1.1" //Uncomment this if necessary. Default is "{{auto}}"
		  user.user_id = "1234" //The user's unique ID
		  
		  self.sentry.user = user
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  #if DebugBuild
		    Dim reason As String
		    reason = error.Message
		  #endif
		  
		  //Exception
		  
		  try
		    #if DebugBuild
		      app.Sentry.SubmitException(error, "", "", Xojo_Sentry.errorLevel.debug)
		    #else
		      app.Sentry.SubmitException(error, "", "", Xojo_Sentry.errorLevel.error)
		    #endif
		    
		    
		    
		    //Make sure we do not create another exception by sending it to Sentry
		  Catch err
		    
		  end try
		  
		  //Return true to let the app running
		  Return True
		End Function
	#tag EndEvent


	#tag Property, Flags = &h0
		sentry As SentryController
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
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
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="RegionCode"
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
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
