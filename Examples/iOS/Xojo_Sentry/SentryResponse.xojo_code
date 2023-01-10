#tag Class
Private Class SentryResponse
	#tag Method, Flags = &h0
		Sub Constructor(URL As String, HTTPStatus As Integer, caller As SentrySocket)
		  
		  mURL = url
		  mHTTPStatus = HTTPStatus
		  mcaller = caller
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mcaller
			End Get
		#tag EndGetter
		caller As SentrySocket
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mHTTPStatus
			End Get
		#tag EndGetter
		HTTPStatus As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mcaller As SentrySocket
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHTTPStatus As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mURL As String
	#tag EndProperty

	#tag Property, Flags = &h0
		processTime As Double
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mURL
			End Get
		#tag EndGetter
		URL As String
	#tag EndComputedProperty


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
			Name="URL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="processTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
