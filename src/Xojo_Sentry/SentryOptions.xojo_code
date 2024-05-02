#tag Class
Protected Class SentryOptions
	#tag Method, Flags = &h0
		Sub Constructor()
		  #if XojoVersion > 2023.02
		    save_before_sending = TargetAndroid
		  #endif
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 496620547275652C2072656D6F766573206C696E65206E756D6265727320696E2074686520737461636B206672616D657320666F72206265747465722067726F7570696E67206F66206973737565732E2044656661756C7420697320547275652E
		android_remove_line_numbers As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)), Description = 436F6E74726F6C73207765746865722053656E7472792077696C6C206C6F6720746865206261747465727920737461747573206F662074686520617070207768656E207375626D697474696E6720616E20657863657074696F6E2E2044656661756C742069732046616C73652E
		get_battery_status As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		include_StackFrame_address As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E74726F6C732074686520746F74616C20616D6F756E74206F662062726561646372756D627320746861742073686F756C642062652063617074757265642E20546869732064656661756C747320746F20313030
		max_breadcrumbs As Integer = 100
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E66696775726573207468652073616D706C65207261746520666F72206572726F72206576656E74732C20696E207468652072616E6765206F6620302E3020746F20312E302E205468652064656661756C7420697320312E30207768696368206D65616E7320746861742031303025206F66206572726F72206576656E7473206172652073656E742E2049662073657420746F20302E31206F6E6C7920313025206F66206572726F72206576656E74732077696C6C2062652073656E742E204576656E747320617265207069636B65642072616E646F6D6C792E
		sample_rate As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53617665732074686520657863657074696F6E20746F206469736B206265666F72652073656E64696E672E2044656661756C747320746F2054727565206F6E20416E64726F6964
		save_before_sending As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = (TargetAndroid and (Target64Bit)), Description = 5B416E64726F6964206F6E6C795D20496620547275652C2053656E6453796E63206973207573656420696E7374656164206F66204173796E6368726F6E6F75732053656E64
		send_sync As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 436F6E66696775726573207468652073616D706C65207261746520666F722074726163696E67206576656E74732C20696E207468652072616E6765206F6620302E3020746F20312E302E205468652064656661756C7420697320302E31207768696368206D65616E73207468617420313025206F6620747261636573206576656E7473206172652073656E742E2054726163657320617265207069636B65642072616E646F6D6C792E
		traces_sample_rate As Double = 0.1
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
			Name="max_breadcrumbs"
			Visible=false
			Group="Behavior"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="sample_rate"
			Visible=false
			Group="Behavior"
			InitialValue="1.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="get_battery_status"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="include_StackFrame_address"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="traces_sample_rate"
			Visible=false
			Group="Behavior"
			InitialValue="0.1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="save_before_sending"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="android_remove_line_numbers"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
