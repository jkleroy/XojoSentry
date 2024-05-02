#tag WebContainerControl
Begin WebContainer ContainerTracing
   Compatibility   =   ""
   ControlCount    =   0
   ControlID       =   ""
   Enabled         =   True
   Height          =   250
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   250
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin Thread Thread1
      DebugIdentifier =   ""
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      ThreadID        =   0
      ThreadState     =   ""
   End
   Begin WebButton btTracing
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Start Tracing"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   1
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   2
      TabIndex        =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebProgressBar ProgressBar1
      AllowAnimation  =   True
      Animated        =   "True"
      Caption         =   ""
      ControlID       =   ""
      Enabled         =   True
      Height          =   16
      Indeterminate   =   True
      Index           =   -2147483648
      Indicator       =   0
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      MaximumValue    =   100
      Scope           =   2
      TabIndex        =   1
      TabStop         =   True
      Tooltip         =   ""
      Top             =   66
      Value           =   100
      Visible         =   False
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblStatusTracing
      Bold            =   False
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   83
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   2
      TabIndex        =   2
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c000000FF
      Tooltip         =   ""
      Top             =   97
      Underline       =   False
      Visible         =   False
      Width           =   210
      _mPanelIndex    =   -1
   End
   Begin WebLink Link1
      Appearance      =   0
      Bold            =   False
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   38
      Index           =   -2147483648
      indicator       =   0
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      PanelIndex      =   0
      Scope           =   0
      TabIndex        =   3
      TabStop         =   True
      Target          =   1
      Text            =   "Open Sentry"
      TextAlignment   =   0
      TextColor       =   &c0000FF00
      Tooltip         =   ""
      Top             =   188
      Underline       =   False
      URL             =   "https://sentry.io"
      Visible         =   False
      Width           =   133
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub GotoSentryPerformance()
		  
		  Dim url As String = "https://sentry.io/performance/?project=_ProjectID_&statsPeriod=7d&utc=true"
		  
		  Session.GotoURL(url.Replace("_ProjectID_", app.sentry.ProjectID))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthyProcess()
		  var sp as SentrySpan = app.sentry.StartSpan(currentTransaction, "process", CurrentMethodName)
		  
		  
		  For i as Integer = 0 to 2
		    LengthySubProcess
		  Next
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthyProcess2()
		  var sp as SentrySpan = app.sentry.StartSpan(currentTransaction, "process", CurrentMethodName)
		  
		  Var endtime As Double = System.Microseconds + 1000*System.Random.InRange(200, 900)
		  
		  While System.Microseconds < endtime
		    Var i as Integer
		  Wend
		  
		  LengthyProcess3
		  
		  
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthyProcess3()
		  var sp as SentrySpan = app.sentry.StartSpan(currentTransaction, "process", CurrentMethodName)
		  
		  Var endtime As Double = System.Microseconds + 1000*System.Random.InRange(200, 900)
		  
		  While System.Microseconds < endtime
		    Var i as Integer
		  Wend
		  
		  
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthySubProcess()
		  var sp as SentrySpan = app.sentry.StartSpan(currentTransaction, "process", CurrentMethodName)
		  
		  Var endtime As Double = System.Microseconds + 500*1000 + System.Random.InRange(200, 900)
		  
		  While System.Microseconds < endtime
		    Var i as Integer
		  Wend
		  
		  
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		currentTransaction As SentryTrace
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sessionID As String
	#tag EndProperty


#tag EndWindowCode

#tag Events Thread1
	#tag Event
		Sub Run()
		  Dim transaction as SentryTrace = app.sentry.StartTracing("thread", "Web_Test_Tracing")
		  self.currentTransaction = transaction
		  
		  LengthyProcess
		  
		  LengthyProcess2
		  
		  LengthyProcess3
		  
		  
		  
		  
		  //Random errors
		  if System.Random.InRange(0, 100) < 30 then
		    transaction.status = "internal_error"
		    transaction.Finish("something went wrong")
		  Else
		    
		    //Stop tracing
		    transaction.Finish("all good")
		  end if
		  
		  me.AddUserInterfaceUpdate("completed":transaction.elapsed)
		End Sub
	#tag EndEvent
	#tag Event
		Sub UserInterfaceUpdate(data() as Dictionary)
		  
		  for each dic as Dictionary in data
		    
		    Dim elapsed As Double
		    
		    elapsed = dic.Lookup("completed", -1)
		    
		    
		    lblStatusTracing.Text = "Long process took: " + elapsed.ToString + " seconds." + EndOfLine + "Now go to sentry/performance"
		    
		  next
		  
		  btTracing.Enabled = True
		  ProgressBar1.Visible = False
		  
		  lblStatusTracing.Visible = True
		  Link1.Visible = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btTracing
	#tag Event
		Sub Pressed()
		  
		  
		  me.Enabled = False
		  ProgressBar1.Visible = True
		  
		  self.sessionID = Session.Identifier
		  
		  Thread1.Run
		  
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Link1
	#tag Event
		Sub Opening()
		  
		  Dim url As String = "https://sentry.io/performance/?project=_ProjectID_&statsPeriod=7d&utc=true"
		  
		  me.URL = url.Replace("_ProjectID_", app.sentry.ProjectID)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
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
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group=""
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
