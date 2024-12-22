#tag Class
Protected Class MBSExceptionHandler
Inherits NSExceptionHandlerMBS
	#tag Event
		Sub CaughtException(e as NSExceptionMBS, isMainThread as boolean)
		  Break
		  
		  //Make sure that the exception is saved to disk as Sentry might not have time
		  // to send the exception before the app is shut down.
		  app.sentry.Options.save_before_sending = True
		  app.sentry.SubmitException(e, "", CurrentMethodName)
		  
		  app.sentry.SendSessionInfo(Xojo_Sentry.sessionStatus.crashed)
		  
		  
		End Sub
	#tag EndEvent


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
			InitialValue=""
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
