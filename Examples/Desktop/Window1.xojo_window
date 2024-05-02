#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   675012607
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Sentry Desktop Example"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin DesktopPagePanel PagePanel1
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   364
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   600
      Begin DesktopButton btAttachment
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Send Attachment"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   108
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopButton Button3
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Ask for user feedback"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   140
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopButton Button2
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Create an unhandled Exception"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   76
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopLabel lblStatus
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   117
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   199
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   560
      End
      Begin DesktopButton Button1
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Create an Exception"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   44
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopLabel lblStatusBreadcrumbs
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   78
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   2
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Text            =   "Click on the three buttons to create an exception."
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   116
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   230
      End
      Begin DesktopButton btBreadcrumb3
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Step 3: Save file"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   84
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   164
      End
      Begin DesktopButton btBreadcrumb2
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Step 2: Process file"
         Default         =   False
         Enabled         =   False
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   164
      End
      Begin DesktopButton btBreadcrumb1
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Step 1: Open file"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   164
      End
      Begin DesktopButton btTracing
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Start Tracing"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   189
      End
      Begin DesktopButton Button6
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Analyse URLConnection"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopLabel lblStatusTracing
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   118
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   3
         TabStop         =   True
         Text            =   "Untitled"
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   52
         Transparent     =   False
         Underline       =   False
         Visible         =   False
         Width           =   560
      End
      Begin DesktopButton btTestSentry
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "Test Sentry Integration"
         Default         =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   20
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   12
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   250
      End
      Begin DesktopProgressBar ProgressBar1
         AllowAutoDeactivate=   True
         AllowTabStop    =   True
         Enabled         =   True
         Height          =   20
         Indeterminate   =   True
         Index           =   -2147483648
         InitialParent   =   "PagePanel1"
         Left            =   221
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumValue    =   100
         Scope           =   0
         TabIndex        =   2
         TabPanelIndex   =   3
         Tooltip         =   ""
         Top             =   20
         Transparent     =   False
         Value           =   0.0
         Visible         =   False
         Width           =   359
      End
   End
   Begin Toolbar1 myToolbar
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      Visible         =   True
   End
   Begin Thread Thread1
      Index           =   -2147483648
      LockedInPosition=   False
      Priority        =   5
      Scope           =   0
      StackSize       =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

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
		  
		  lblStatusTracing.Text = ""
		  
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GotoSentry()
		  ShowURL("https://sentry.io")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GotoSentryPerformance()
		  
		  Dim url As String = "https://sentry.io/performance/?project=_ProjectID_&statsPeriod=7d&utc=true"
		  
		  System.GotoURL(url.Replace("_ProjectID_", app.sentry.ProjectID))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthyProcess()
		  var sp as SentrySpan = app.sentry.StartSpan(nil, "process", CurrentMethodName)
		  
		  
		  For i as Integer = 0 to 2
		    LengthySubProcess
		  Next
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthyProcess2()
		  var sp as SentrySpan = app.sentry.StartSpan(nil, "process", CurrentMethodName)
		  
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
		  var sp as SentrySpan = app.sentry.StartSpan(nil, "process", CurrentMethodName)
		  
		  Var endtime As Double = System.Microseconds + 1000*System.Random.InRange(200, 900)
		  
		  While System.Microseconds < endtime
		    Var i as Integer
		  Wend
		  
		  
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LengthySubProcess()
		  var sp as SentrySpan = app.sentry.StartSpan(nil, "process", CurrentMethodName)
		  
		  Var endtime As Double = System.Microseconds + 500*1000 + System.Random.InRange(200, 900)
		  
		  While System.Microseconds < endtime
		    Var i as Integer
		  Wend
		  
		  
		  
		  //When sp goes out of scope, it is automatically added to the trace
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events btAttachment
	#tag Event
		Sub Pressed()
		  
		  //Sentry allows sending attachments with an event
		  
		  Dim event_id As String = app.sentry.lastUUID
		  
		  //Create a dummy picture and send it to sentry
		  
		  Dim p As new Picture(200, 200)
		  Dim g As Graphics = p.Graphics
		  
		  Dim caption As String = "Just a test"
		  
		  g.DrawString(caption, (g.Width - g.TextWidth(caption))/2, (g.Height - g.TextHeight(caption, g.Width))/2)
		  
		  //Save the file
		  Dim f As FolderItem = SpecialFolder.Temporary.Child(event_id + ".png")
		  p.Save(f, Picture.Formats.PNG)
		  
		  if f <> nil then
		    
		    //Now send to Sentry
		    app.sentry.SendAttachment(event_id, f, "image/png")
		    
		    f.Delete
		  end if
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button3
	#tag Event
		Sub Pressed()
		  
		  Dim w As new wSentryUserFeedback(app.sentry.lastUUID)
		  
		  w.ShowModal(self)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  
		  Button3.Enabled = True
		  btAttachment.Enabled = True
		  
		  
		  
		  Dim dic As Dictionary
		  
		  
		  //This will produce a NilObjectException
		  Dim value As String = dic.Value("foo")
		  
		  
		  //This exception will be handled by App.UnhandledException event
		End Sub
	#tag EndEvent
#tag EndEvents
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
		  btAttachment.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btBreadcrumb3
	#tag Event
		Sub Pressed()
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  try
		    Dim error As new IllegalCastException
		    raise error
		    
		  Catch err
		    app.sentry.SubmitException(err, CurrentMethodName, "Testing Breadcrumbs")
		    
		  end try
		  
		  
		  lblStatusBreadcrumbs.text = "Now head over to Sentry to see the breadcrumbs."
		  
		  
		  timer.CallLater(1000, AddressOf GotoSentry)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btBreadcrumb2
	#tag Event
		Sub Pressed()
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  btBreadcrumb3.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btBreadcrumb1
	#tag Event
		Sub Pressed()
		  
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  
		  
		  btBreadcrumb2.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btTracing
	#tag Event
		Sub Pressed()
		  
		  
		  
		  
		  me.Enabled = False
		  ProgressBar1.Visible = True
		  
		  Thread1.Run
		  
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button6
	#tag Event
		Sub Pressed()
		  
		  Dim socket As new URLConnection
		  
		  Dim HTTPmethod As String = "GET"
		  Dim url As String = "https://httpbin.org/status/500"
		  Dim requestContent As String = "some content"
		  
		  
		  //Log in Sentry
		  app.sentry.DefineRequest(HTTPmethod, url, requestContent)
		  
		  //Now prepare the socket
		  socket.SetRequestContent(requestContent, "text/plain")
		  
		  
		  Dim result As String = socket.SendSync(HTTPmethod, url)
		  
		  //Log on Sentry if something happened
		  if socket.HTTPStatusCode > 200 then
		    app.sentry.AddExtraKeyValue("socket.result", result)
		    app.sentry.AddExtraKeyValue("HTTPStatus", socket.HTTPStatusCode)
		    
		    Dim err As new NetworkException
		    err.Message = "HTTPStatusCode: " + socket.HTTPStatusCode.ToString
		    
		    app.sentry.SubmitException(err, CurrentMethodName)
		    
		  Else
		    //All good
		    app.sentry.RemoveLastRequest()
		    
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btTestSentry
	#tag Event
		Sub Pressed()
		  
		  app.sentry.SendTestException()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events myToolbar
	#tag Event
		Sub Pressed(item As DesktopToolbarItem)
		  app.sentry.AddBreadcrumb("ui.click", CurrentMethodName + "_" + item.Caption)
		  
		  Select case item.Caption
		    
		  Case "Simple"
		    
		    PagePanel1.SelectedPanelIndex = 0
		    
		  Case "Breadcrumbs"
		    
		    PagePanel1.SelectedPanelIndex = 1
		    
		  Case "Tracing"
		    
		    PagePanel1.SelectedPanelIndex = 2
		    
		  Case "HTTPRequest"
		    
		    PagePanel1.SelectedPanelIndex = 3
		    
		    
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Thread1
	#tag Event
		Sub Run()
		  Dim transaction as SentryTrace = app.sentry.StartTracing("thread", "Desktop_Test_Tracing")
		  
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
		  
		  lblStatusTracing.Visible = True
		  
		  btTracing.Enabled = True
		  ProgressBar1.Visible = False
		  
		  timer.CallLater(1000, AddressOf GotoSentryPerformance)
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
