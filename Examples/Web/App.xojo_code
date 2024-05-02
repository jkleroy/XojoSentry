#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Opening(args() As String)
		  
		  
		  
		  Dim DSN As String = "<<YOUR DSN>>"
		  
		  
		  
		  //Initialise Sentry
		  If DSN.IsEmpty or DSN = "<<YOUR DSN>>" then
		    Break //Get a DSN string from https://sentry.io
		    Quit
		    Return
		  End If
		  
		  self.sentry = SentryController.GetInstance( DSN )
		  
		  
		  //If necessary, Sentry has a few options
		  'self.sentry.Options.get_battery_status = True //Only relevant on iOS
		  self.sentry.Options.include_StackFrame_address = False
		  self.sentry.Options.max_breadcrumbs = 100
		  self.sentry.Options.sample_rate = 1.0 //Keep this value at 1.0 when debugging, change value for a released app
		  self.sentry.Options.save_before_sending = False //Set to True if your app will quit on exceptions
		  #if DebugBuild
		    self.sentry.Options.traces_sample_rate = 1.0 //Keep this value at 1.0 when debugging, change value for a released app
		  #else
		    self.sentry.Options.traces_sample_rate = 0.1
		  #endif
		  
		  
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
		      app.Sentry.SubmitException(error, "", CurrentMethodName, Xojo_Sentry.errorLevel.debug)
		    #else
		      app.Sentry.SubmitException(error, "", CurrentMethodName, Xojo_Sentry.errorLevel.error)
		    #endif
		    
		    
		    
		    //Make sure we do not create another exception by sending it to Sentry
		  Catch err
		    
		  end try
		  
		  //Return true to let the app running
		  Return True
		End Function
	#tag EndEvent


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


	#tag Property, Flags = &h0
		sentry As SentryController
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
