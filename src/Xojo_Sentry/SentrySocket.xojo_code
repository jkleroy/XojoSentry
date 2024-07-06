#tag Class
Private Class SentrySocket
Inherits URLConnection
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  #if DebugBuild and kVerbose
		    System.DebugLog CurrentMethodName + " HTTPStatus: "  + HTTPStatus.ToString '+ EndOfLine + content
		  #endif
		  
		  Dim response As new SentryResponse(URL, HTTPStatus, self)
		  
		  try
		    if callBack <> Nil then
		      callBack.Invoke(content, Nil, response)
		      Return
		    end if
		  Catch
		    
		  end try
		  
		  
		  response = nil
		  callBack = nil
		End Sub
	#tag EndEvent

	#tag Event
		Sub Error(e As RuntimeException)
		  
		  #if DebugBuild and kVerbose
		    System.DebugLog CurrentMethodName + " " + e.Message
		  #endif
		  
		  Dim response As new SentryResponse("", 0, self)
		  
		  
		  try
		    if callBack <> Nil then
		      callBack.Invoke("", e, response)
		      Return
		    End If
		  Catch
		    
		  End Try
		  
		  
		  response = nil
		  callBack = nil
		End Sub
	#tag EndEvent


	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub SentryDelegate(data As String, error As RuntimeException, response As SentryResponse)
	#tag EndDelegateDeclaration


	#tag Property, Flags = &h0
		callBack As SentryDelegate
	#tag EndProperty

	#tag Property, Flags = &h0
		tag As Dictionary
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
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
