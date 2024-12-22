#tag Class
Class SentryTrace
	#tag Method, Flags = &h0
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
		  
		  //Check value length
		  if value.IsNull = False and value.StringValue.Length > 200 then
		    #if DebugBuild
		      System.DebugLog CurrentMethodName + " value is too long. " + _
		      "Tag is ignored. Limit: 200 characters. See: https://develop.sentry.dev/sdk/data-handling/#variable-size"
		    #endif
		    
		    //ignore
		    Return
		  end if
		  
		  
		  
		  if tags is nil then
		    tags = New Dictionary
		  end if
		  
		  tags.Value(key) = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		  
		  if not stopped then
		    self.Finish()
		    
		  end if
		  
		  spans.ResizeTo(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 46696E697368657320746865205472616E73616374696F6E20616E642073656E647320746F2053656E747279
		Sub Finish(message As String = "", Session As Variant = nil, level As Xojo_Sentry.errorLevel = Xojo_Sentry.errorLevel.info)
		  self.timestamp = GetCurrentTimestamp()
		  self.stopped = True
		  
		  SentryController.GetInstance("").StopTracing(self, message, Session, level)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateJS() As Dictionary
		  
		  Var js As new Dictionary
		  
		  js.Value("trace_id") = self.trace_id
		  js.Value("span_id") = self.span_id
		  
		  
		  js.Value("op") = self.op
		  if self.description.IsEmpty = False then
		    js.Value("description") = self.description
		  end if
		  
		  if tags <> nil and tags.KeyCount > 0 then
		    try
		      
		      call GenerateJSON(tags)
		      js.Value("tags") = self.tags
		    Catch
		      //Unable to generate tags
		    end try
		  end if
		  
		  js.Value("type") = "trace"
		  
		  js.Value("status") = status
		  
		  
		  Return js
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

	#tag Method, Flags = &h0
		Function StartChild(operation As String, description As String = "") As SentrySpan
		  
		  return SentryController.GetInstance("").StartSpan(self, operation, description, self.span_id)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		description As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 456C61707365642074696D6520696E20746865205472616365
		#tag Getter
			Get
			  
			  if start_timestamp = 0.0 then
			    Return 0.0
			  end if
			  
			  if timestamp = 0.0 then
			    //Grab the current time in GMT
			    Dim GMTZone As New TimeZone("GMT")
			    Var now As DateTime
			    now = new DateTime(DateTime.now.SecondsFrom1970, GMTZone)
			    
			    return now.SecondsFrom1970 - start_timestamp
			    
			  else
			    
			    Return timestamp - start_timestamp
			    
			  end if
			End Get
		#tag EndGetter
		elapsed As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		event_id As String
	#tag EndProperty

	#tag Property, Flags = &h0
		level As Xojo_Sentry.errorLevel
	#tag EndProperty

	#tag Property, Flags = &h0
		op As String
	#tag EndProperty

	#tag Property, Flags = &h0
		spans() As SentrySpan
	#tag EndProperty

	#tag Property, Flags = &h0
		span_id As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 412074696D657374616D7020726570726573656E74696E67207768656E20746865206D6561737572696E672073746172746564
		start_timestamp As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		status As String = "ok"
	#tag EndProperty

	#tag Property, Flags = &h0
		Attributes( Hidden = True ) stopped As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		tags As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 412074696D657374616D7020726570726573656E74696E67207768656E20746865206D6561737572696E672066696E6973686564
		timestamp As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		trace_id As String
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
			Name="description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="event_id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="op"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="start_timestamp"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="timestamp"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="trace_id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="span_id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="stopped"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="status"
			Visible=false
			Group="Behavior"
			InitialValue="ok"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="elapsed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="level"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Xojo_Sentry.errorLevel"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
