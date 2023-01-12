#tag Class
Protected Class SentryUser
	#tag Method, Flags = &h0
		Sub Constructor()
		  self.ip = "{{auto}}"
		  self.locale = locale.Current
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652075736572277320656D61696C2061646472657373
		email As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652075736572277320697020616464726573732E2044656661756C74206973207B7B6175746F7D7D
		ip As String = "{{auto}}"
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652075736572277320707265666572726564206C616E6775616765
		language As String
	#tag EndProperty

	#tag Property, Flags = &h0
		locale As Locale
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652075736572277320737562736372697074696F6E207374617465
		subscription As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652075736572277320656D61696C2061646472657373
		username As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652075736572277320756E697175652049442C20757375616C6C792061205555494420737472696E67
		user_id As String
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
			Name="user_id"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="language"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ip"
			Visible=false
			Group="Behavior"
			InitialValue="{{auto}}"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="email"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="subscription"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
