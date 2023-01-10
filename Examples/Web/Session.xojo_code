#tag Class
Protected Class Session
Inherits WebSession
#tag Session
  interruptmessage=We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect.
  disconnectmessage=You have been disconnected from this application.
  confirmmessage=
  AllowTabOrderWrap=True
#tag EndSession
	#tag Event
		Sub Closing(appQuitting as Boolean)
		  //Removes the session breadcrumbs
		  app.sentry.RemoveSessionBreadcrumbs(self.Identifier)
		End Sub
	#tag EndEvent

	#tag Event
		Sub JavaScriptError(ErrorName as String, ErrorMessage as String, ErrorStack as String)
		  
		  
		  
		  dim error As new RuntimeException
		  error.Message = ErrorName + &u0A + ErrorMessage + &u0A + ErrorStack
		  
		  try
		    
		    
		    //Current page
		    If self.CurrentPage <> nil then
		      Dim name As String
		      Dim type As Introspection.TypeInfo = Introspection.GetType(Session.CurrentPage)
		      
		      name = type.Name
		      app.sentry.AddExtraKeyValue("Session.CurrentPage", name)
		    End If
		    
		    //URL parameters
		    If Self.URLParameterCount > 0 Then
		      Dim parameterName, value As String
		      Dim params() as String
		      For i As Integer = 0 To Self.URLParameterCount - 1
		        parameterName = Self.URLParameterName(i)
		        value = Self.URLParameter(parameterName)
		        
		        params.Add parameterName + "=" + value
		      Next
		      
		      app.sentry.AddExtraKeyValue("URL", app.URL + "?" + String.FromArray(params, "&") + if(self.HashTag.IsEmpty, "", "#" + self.HashTag))
		    Else
		      app.sentry.AddExtraKeyValue("URL", app.URL + if(self.HashTag.IsEmpty, "", "#" + self.HashTag))
		    End If
		    
		    if self.HashTag.IsEmpty = False then
		      app.sentry.AddExtraKeyValue("Session.HashTag", self.HashTag)
		    end if
		    
		    app.sentry.AddExtraKeyValue("Session.LanguageCode", self.LanguageCode)
		    app.sentry.AddTag("LanguageCode", self.LanguageCode)
		    
		    app.sentry.AddExtraKeyValue("Session.RawHeaders", self.RawHeaders)
		    
		    
		    
		    app.sentry.user = self.sentry_user
		    
		    #if DebugBuild
		      app.Sentry.SubmitException(error, CurrentMethodName, "SessionLevel", Xojo_Sentry.errorLevel.debug, self)
		    #else
		      app.Sentry.SubmitException(error, CurrentMethodName, "SessionLevel", Xojo_Sentry.errorLevel.fatal, self)
		    #endif
		    
		    
		    
		    
		  Catch err
		    
		  Finally
		    app.sentry.user = nil
		    
		  end try
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  //If you want to use breadcrumbs, now is a good time to start
		  self.AddBreadcrumb("Session", "Start")
		  
		  
		  
		  //If your app handles user authentication add the info to sentry
		  Dim user as new Xojo_Sentry.SentryUser
		  user.email = "name@example.com"
		  user.language = Session.LanguageCode
		  
		  //The user's locale
		  Dim loc As Locale
		  try
		    loc = new Locale(Session.LanguageCode)
		  Catch err 
		    loc = locale.Current //Default to current locale
		    
		  end try
		  user.locale = loc
		  'user.ip = "1.1.1.1" //Uncomment this if necessary. Default is "{{auto}}"
		  user.user_id = "1234" //The user's unique ID
		  
		  
		  
		  self.sentry_user = user
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(Error As RuntimeException) As Boolean
		  
		  try
		    
		    //Current page
		    If self.CurrentPage <> nil then
		      Dim name As String
		      Dim type As Introspection.TypeInfo = Introspection.GetType(Session.CurrentPage)
		      
		      name = type.Name
		      app.sentry.AddExtraKeyValue("Session.CurrentPage", name)
		    End If
		    
		    //URL parameters
		    If Self.URLParameterCount > 0 Then
		      Dim parameterName, value As String
		      Dim params() as String
		      For i As Integer = 0 To Self.URLParameterCount - 1
		        parameterName = Self.URLParameterName(i)
		        value = Self.URLParameter(parameterName)
		        
		        params.Add parameterName + "=" + value
		      Next
		      
		      app.sentry.AddExtraKeyValue("URL", app.URL + "?" + String.FromArray(params, "&") + if(self.HashTag.IsEmpty, "", "#" + self.HashTag))
		    Else
		      app.sentry.AddExtraKeyValue("URL", app.URL + if(self.HashTag.IsEmpty, "", "#" + self.HashTag))
		    End If
		    
		    if self.HashTag.IsEmpty = False then
		      app.sentry.AddExtraKeyValue("Session.HashTag", self.HashTag)
		    end if
		    
		    app.sentry.AddExtraKeyValue("Session.LanguageCode", self.LanguageCode)
		    app.sentry.AddTag("LanguageCode", self.LanguageCode)
		    
		    app.sentry.AddExtraKeyValue("Session.RawHeaders", self.RawHeaders)
		    
		    app.sentry.user = self.sentry_user
		    
		    #if DebugBuild
		      app.Sentry.SubmitException(error, "", "SessionLevel", Xojo_Sentry.errorLevel.debug, self)
		    #else
		      app.Sentry.SubmitException(error, "", "SessionLevel", Xojo_Sentry.errorLevel.error, self)
		    #endif
		    
		    
		    
		    
		  Catch err
		    
		  Finally
		    app.sentry.user = nil
		    
		  end try
		  
		  Return True
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit))
		Sub AddBreadcrumb(category As String, message As String = "")
		  
		  app.sentry.AddWebBreadcrumb(self.Identifier, category, message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target64Bit))
		Sub AddBreadcrumbNavigation(fromScreen As String, toScreen As String, message As String = "")
		  
		  app.sentry.AddWebBreadcrumbNavigation(self.Identifier, fromScreen, toScreen, message)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		sentry_user As Xojo_Sentry.SentryUser
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="HashTag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Identifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LanguageRightToLeft"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScaleFactor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UserTimeout"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_baseurl"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue="You have been disconnected from this application."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InterruptionMessage"
			Visible=true
			Group="Behavior"
			InitialValue="We are having trouble communicating with the server. Please wait a moment while we attempt to reconnect."
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_LastMessageTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabOrderWrap"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ConfirmDisconnectMessage"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Platform"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsDarkMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClientWidth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
