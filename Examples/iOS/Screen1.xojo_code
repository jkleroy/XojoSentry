#tag MobileScreen
Begin MobileScreen Screen1
   BackButtonCaption=   ""
   Compatibility   =   ""
   ControlCount    =   0
   Device = 1
   HasNavigationBar=   True
   LargeTitleDisplayMode=   2
   Left            =   0
   Orientation = 0
   TabBarVisible   =   True
   TabIcon         =   0
   TintColor       =   &c00000000
   Title           =   "Sentry Example"
   Top             =   0
   Begin MobileButton Button1
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button1, 7, , 0, False, +1.00, 4, 1, 226, , True
      AutoLayout      =   Button1, 9, <Parent>, 9, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Button1, 3, <Parent>, 3, False, +1.00, 4, 1, 148, , True
      AutoLayout      =   Button1, 8, , 0, False, +1.00, 4, 1, 32, , True
      Caption         =   "Create an Exception"
      CaptionColor    =   &c000000
      ControlCount    =   0
      Enabled         =   True
      Height          =   32
      Left            =   47
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   "0"
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   148
      Visible         =   True
      Width           =   226
   End
   Begin MobileButton Button2
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button2, 8, , 0, False, +1.00, 4, 1, 32, , True
      AutoLayout      =   Button2, 1, <Parent>, 1, False, +1.00, 4, 1, 20, , True
      AutoLayout      =   Button2, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      AutoLayout      =   Button2, 3, <Parent>, 3, False, +1.00, 4, 1, 197, , True
      Caption         =   "Create an unhandled Exception"
      CaptionColor    =   &c000000
      ControlCount    =   0
      Enabled         =   True
      Height          =   32
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   "0"
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   197
      Visible         =   True
      Width           =   280
   End
   Begin MobileLabel lblStatus
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      Alignment       =   0
      AutoLayout      =   lblStatus, 8, , 0, False, +1.00, 4, 1, 190, , True
      AutoLayout      =   lblStatus, 1, <Parent>, 1, False, +1.00, 4, 1, 20, , True
      AutoLayout      =   lblStatus, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      AutoLayout      =   lblStatus, 3, Button3, 4, False, +1.00, 4, 1, 40, , True
      ControlCount    =   0
      Enabled         =   True
      Height          =   190
      Left            =   20
      LineBreakMode   =   0
      LockedInPosition=   False
      Scope           =   2
      SelectedText    =   ""
      SelectionLength =   0
      SelectionStart  =   0
      Text            =   "Sentry Status"
      TextColor       =   &c000000
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   341
      Visible         =   False
      Width           =   280
   End
   Begin MobileButton Button3
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button3, 9, <Parent>, 9, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Button3, 8, , 0, False, +1.00, 4, 1, 32, , True
      AutoLayout      =   Button3, 3, Button2, 4, False, +1.00, 4, 1, 40, , True
      AutoLayout      =   Button3, 7, , 0, False, +1.00, 4, 1, 226, , True
      Caption         =   "Try breadcrumbs"
      CaptionColor    =   &c000000
      ControlCount    =   0
      Enabled         =   True
      Height          =   32
      Left            =   47
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   "0"
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   269
      Visible         =   True
      Width           =   226
   End
   Begin MobileButton Button4
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button4, 1, Button3, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Button4, 7, , 0, False, +1.00, 4, 1, 226, , True
      AutoLayout      =   Button4, 3, <Parent>, 3, False, +1.00, 4, 1, 97, , True
      AutoLayout      =   Button4, 8, , 0, False, +1.00, 4, 1, 32, , True
      Caption         =   "Test Sentry Integration"
      CaptionColor    =   &c000000
      ControlCount    =   0
      Enabled         =   True
      Height          =   32
      Left            =   47
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   "0"
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   97
      Visible         =   True
      Width           =   226
   End
End
#tag EndMobileScreen

#tag WindowCode
	#tag Event
		Sub Opening()
		  
		  if app.sentry is nil then
		    
		    lblStatus.Text = "Sentry is not initialised. Make sure to setup the DSN in App.Opening event."
		    
		    Button1.Enabled = False
		    Button2.Enabled = False
		    
		    Button3.enabled = False
		    
		  else
		    
		    lblStatus.Text = "Sentry is ready. Click any button to create an exception"
		    
		  end if
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  
		  Dim dic As new Dictionary
		  
		  try
		    
		    
		    Dim value As String = dic.Value("foo")
		    
		  Catch err
		    //Catch the exception and send to Sentry
		    
		    app.sentry.SubmitException(err, CurrentMethodName)
		    
		    
		  end try
		  
		  Button3.Enabled = True
		  'btAttachment.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  
		  Button3.Enabled = True
		  'btAttachment.Enabled = True
		  
		  
		  
		  Dim dic As Dictionary
		  
		  
		  //This will produce a NilObjectException
		  Dim value As String = dic.Value("foo")
		  
		  
		  //This exception will be handled by App.UnhandledException event
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button3
	#tag Event
		Sub Pressed()
		  
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  
		  dim w As new Screen2
		  
		  app.sentry.AddBreadcrumbNavigation("Screen1", "Screen2", "")
		  
		  w.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button4
	#tag Event
		Sub Pressed()
		  
		  app.sentry.SendTestException
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="BackButtonCaption"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasNavigationBar"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIcon"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LargeTitleDisplayMode"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="MobileScreen.LargeTitleDisplayModes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabBarVisible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TintColor"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="ColorGroup"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlCount"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
