#tag Class
Class SentrySpan
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
		Attributes( Hidden = True )  Function Clone() As SentrySpan
		  
		  Var sp As new SentrySpan
		  
		  sp.stopped = true
		  
		  sp.data = self.data
		  sp.description = self.description
		  sp.op = self.op
		  sp.parent_span_id = self.parent_span_id
		  sp.start_timestamp = self.start_timestamp
		  sp.tags = self.tags
		  sp.timestamp = self.timestamp
		  sp.trace_id = self.trace_id
		  sp.span_id = self.span_id
		  sp.status = self.status
		  
		  Return sp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  self.data = new Dictionary
		  
		  Start
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		  
		  if not stopped then
		    self.Finish()
		    
		  end if
		  
		  mparentTrace = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4175746F6D61746963616C6C792063616C6C65642062792044657374727563746F722E2043616C6C2074686973206D6574686F6420696620796F75206E65656420746F2066696E697368207468652074696D696E67206561726C6965722E
		Sub Finish(status As span_status = span_status.ok)
		  timestamp = GetCurrentTimestamp
		  self.stopped = True
		  
		  self.SetStatus(status)
		  
		  SentryController.GetInstance("").StopSpan(self)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateJS() As Dictionary
		  
		  Var j As new Dictionary
		  
		  j.Value("span_id") = span_id
		  
		  if parent_span_id.IsEmpty = False then
		    j.Value("parent_span_id") = parent_span_id
		  end if
		  
		  j.Value("start_timestamp") = start_timestamp
		  j.Value("timestamp") = timestamp
		  
		  if description.IsEmpty = False then
		    j.Value("description") = description
		  end if
		  
		  
		  j.Value("op") = op
		  j.Value("trace_id") = trace_id
		  
		  if status.isempty = False then
		    j.Value("status") = status
		  end if
		  
		  
		  if data <> nil and data.KeyCount > 0 then
		    try
		      //Trying to export data as JSON
		      Dim dataOutput As String
		      dataOutput = GenerateJSON(data)
		      
		      j.Value("data") = data
		      
		    Catch
		    end try
		  end if
		  
		  if tags <> nil then
		    try
		      //Trying to export tags as JSON
		      Dim dataOutput As String
		      dataOutput = GenerateJSON(tags)
		      
		      j.Value("tags") = tags
		      
		    Catch
		    end try
		  end if
		  
		  
		  Return j
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

	#tag Method, Flags = &h0, Description = 536574732074686520737461747573206F6620746865207370616E
		Sub SetStatus(status_value As span_status)
		  Select case status_value
		    
		  Case span_status.none
		    status = ""
		    
		  Case span_status.aborted
		    status = "aborted"
		  Case span_status.already_exists
		    status = "already_exists"
		  Case span_status.cancelled
		    status = "cancelled"
		  Case span_status.data_loss
		    status = "data_loss"
		  Case span_status.deadline_exceeded
		    status = "deadline_exceeded"
		  Case span_status.failed_precondition
		    status = "failed_precondition"
		  Case span_status.internal_error
		    status = "internal_error"
		  Case span_status.invalid_argument
		    status = "invalid_argument"
		  Case span_status.not_found
		    status = "not_found"
		  Case span_status.ok
		    status = "ok"
		  Case span_status.out_of_range
		    status = "out_of_range"
		  Case span_status.permission_denied
		    status = "permission_denied"
		  Case span_status.resource_exhausted
		    status = "resource_exhausted"
		  Case span_status.unauthenticated
		    status = "unauthenticated"
		  Case span_status.unavailable
		    status = "unavailable"
		  Case span_status.unimplemented
		    status = "unimplemented"
		  Case span_status.unknown
		    status = "unknown"
		    
		  Else
		    Break
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4175746F6D61746963616C6C792063616C6C656420627920436F6E7374727563746F722E2043616C6C2074686973206D6574686F6420696620796F75206E65656420746F207265736574207468652073746172745F74696D65
		Sub Start()
		  start_timestamp = GetCurrentTimestamp
		End Sub
	#tag EndMethod


	#tag Note, Name = SpanOperations
		
		https://develop.sentry.dev/sdk/performance/span-operations/
	#tag EndNote


	#tag Property, Flags = &h0
		data As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		description As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return timestamp - start_timestamp
			End Get
		#tag EndGetter
		Private duration As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 456C61707365642074696D6520696E20746865205370616E
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

	#tag Property, Flags = &h21
		Private mparentTrace As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		op As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mparentTrace <> nil then
			    
			    Return SentryTrace(mparentTrace.Value)
			    
			  end if
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mparentTrace = new WeakRef(value)
			End Set
		#tag EndSetter
		parentTrace As SentryTrace
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		parent_span_id As String
	#tag EndProperty

	#tag Property, Flags = &h0
		span_id As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 412074696D657374616D7020726570726573656E74696E67207768656E20746865206D6561737572696E672073746172746564
		start_timestamp As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		status As String
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


	#tag Enum, Name = span_status, Type = Integer, Flags = &h0
		ok = 200
		  cancelled = 499
		  unknown = 500
		  invalid_argument = 400
		  deadline_exceeded=504
		  not_found=404
		  already_exists=409
		  permission_denied=403
		  resource_exhausted=429
		  failed_precondition=400
		  aborted=409
		  out_of_range=400
		  unimplemented=501
		  internal_error=500
		  unavailable=503
		  data_loss=500
		  unauthenticated=401
		none = 0
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
		#tag ViewProperty
			Name="start_timestamp"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="span_id"
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
			Name="parent_span_id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			InitialValue=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
