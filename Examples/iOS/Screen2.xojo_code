#tag MobileScreen
Begin MobileScreen Screen2
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
   Title           =   "Breadcrumbs"
   Top             =   0
   Begin MobileButton Button1
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button1, 1, <Parent>, 1, False, +1.00, 4, 1, *kStdGapCtlToViewH, , True
      AutoLayout      =   Button1, 7, , 0, False, +1.00, 4, 1, 100, , True
      AutoLayout      =   Button1, 3, TopLayoutGuide, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      AutoLayout      =   Button1, 8, , 0, False, +1.00, 4, 1, 30, , True
      Caption         =   "Step 1"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   True
      Height          =   30
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   73
      Visible         =   True
      Width           =   100
   End
   Begin MobileButton Button2
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button2, 1, Button1, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Button2, 7, , 0, False, +1.00, 4, 1, 100, , True
      AutoLayout      =   Button2, 3, Button1, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      AutoLayout      =   Button2, 8, , 0, False, +1.00, 4, 1, 30, , True
      Caption         =   "Step 2"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   False
      Height          =   30
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   111
      Visible         =   True
      Width           =   100
   End
   Begin MobileButton Button3
      AccessibilityHint=   ""
      AccessibilityLabel=   ""
      AutoLayout      =   Button3, 1, Button2, 1, False, +1.00, 4, 1, 0, , True
      AutoLayout      =   Button3, 7, , 0, False, +1.00, 4, 1, 100, , True
      AutoLayout      =   Button3, 3, Button2, 4, False, +1.00, 4, 1, *kStdControlGapV, , True
      AutoLayout      =   Button3, 8, , 0, False, +1.00, 4, 1, 30, , True
      Caption         =   "Step 3"
      CaptionColor    =   &c007AFF00
      ControlCount    =   0
      Enabled         =   False
      Height          =   30
      Left            =   20
      LockedInPosition=   False
      Scope           =   2
      TextFont        =   ""
      TextSize        =   0
      TintColor       =   &c000000
      Top             =   149
      Visible         =   True
      Width           =   100
   End
   Begin MobileLabel lblStatus
      Alignment       =   ""
      AutoLayout      =   lblStatus, 8, , 0, False, +1.00, 4, 1, 80, , True
      AutoLayout      =   lblStatus, 1, , 0, False, +1.00, 4, 1, 20, , True
      AutoLayout      =   lblStatus, 2, <Parent>, 2, False, +1.00, 4, 1, -*kStdGapCtlToViewH, , True
      AutoLayout      =   lblStatus, 3, , 0, False, +1.00, 4, 1, 268, , True
      Enabled         =   True
      Height          =   80
      Left            =   20
      LineBreakMode   =   ""
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
      Text            =   "Click on the three buttons to create an exception."
      TextColor       =   &c000000
      TextFont        =   ""
      TextSize        =   0
      Top             =   268
      Visible         =   True
      Width           =   280
   End
End
#tag EndMobileScreen

#tag WindowCode
#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  
		  
		  Button2.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  Button3.Enabled = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button3
	#tag Event
		Sub Pressed()
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  try
		    Dim error As new IllegalCastException
		    raise error
		    
		  Catch err
		    app.sentry.SubmitException(err, CurrentMethodName)
		    
		  end try
		  
		  
		  lblStatus.text = "Now head over to Sentry to see the breadcrumbs."
		  
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
