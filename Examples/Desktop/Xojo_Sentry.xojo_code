#tag Module
Protected Module Xojo_Sentry
	#tag DelegateDeclaration, Flags = &h0, CompatibilityFlags = (TargetAndroid and (Target64Bit))
		Delegate Sub SentryDelegate(data As String, error As RuntimeException, response As SentryResponse)
	#tag EndDelegateDeclaration


	#tag Note, Name = History
		# Version 0.8
		
		New
		Xojo_Sentry.kUseMBSPlugins constant. Set to True if you are using MBS Plugins with NSExceptionHandlerMBS
		
		# Version 0.7
		
		New
		SentryOptions.persistant_breadcrumbs defaults to 10
	#tag EndNote

	#tag Note, Name = Using Sentry for a Desktop Project
		
		# To use Sentry in your own Web project
		
		1. Register for an account at https://sentry.io
		2. You will get a project DSN from Sentry. Copy that value in the App.Opening event
		3. Copy/paste the Xojo_Sentry module into your project
		4. Copy/paste the code from App.Opening event into your project
		5. Copy/paste the code from App.UnhandledException event into your project
		
		
		
		# Optional
		
		## If you are using breadcrumbs
		6. Copy/paste the code from the following events to your project:
		- App.activated
		- App.CancelClosing
		- App.Deactivated 
		
		
		## If your app manages users
		7. Copy/paste the code from App.Opening event into your project, 
		in a relevant area where you have user information
	#tag EndNote

	#tag Note, Name = Using Sentry for a Web Project
		
		# To use Sentry in your own Web project
		
		1. Register for an account at https://sentry.io
		2. You will get a project DSN from Sentry. Copy that value in the App.Opening event
		3. Copy/paste the Xojo_Sentry module into your project
		4. Copy/paste the code from App.Opening event into your project
		5. Copy/paste the code from App.UnhandledException event into your project
		6. Copy/paste the code from Session.UnhandledException event into your project
		7. Copy/paste the code from Session.JavaScriptError event into your project
		
		
		# Optional
		
		## If you are using breadcrumbs
		8. Copy/paste the code from Session.Closing event into your project
		
		## If your app manages users
		9. Copy/paste the code from Session.Opening event into your project, 
		in a relevant area where you have user information
	#tag EndNote

	#tag Note, Name = Using Sentry for an iOS Project
		
		# To use Sentry in your own Web project
		
		1. Register for an account at https://sentry.io
		2. You will get a project DSN from Sentry. Copy that value in the App.Opening event
		3. Copy/paste the Xojo_Sentry module into your project
		4. Copy/paste the code from App.Opening event into your project
		5. Copy/paste the code from App.UnhandledException event into your project
		6. Copy/paste the code from App.LowMemoryWarning event into your project
		
		
		
		# Optional
		
		## If you are using breadcrumbs
		6. Copy/paste the code from App.Activated, App.Deactivating
		
		
		## If your app manages users
		7. Copy/paste the code from App.Opening event into your project, 
		in a relevant area where you have user information
	#tag EndNote


	#tag Constant, Name = kReleaseDate, Type = Double, Dynamic = False, Default = \"20241222", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kUseMBSPlugins, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kVerbose, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private, Description = 53657420746F205472756520666F7220646562756767696E67206D65737361676573202844656275674275696C64206F6E6C7929
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"0.8", Scope = Private
	#tag EndConstant


	#tag Enum, Name = errorLevel, Type = Integer, Flags = &h1
		fatal
		  error
		  warning
		  info
		debug
	#tag EndEnum

	#tag Enum, Name = sessionStatus, Type = Integer, Flags = &h1
		ok
		  exited
		  crashed
		abnormal
	#tag EndEnum


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
	#tag EndViewBehavior
End Module
#tag EndModule
