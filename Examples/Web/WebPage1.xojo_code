#tag WebPage
Begin WebPage WebPage1
   AllowTabOrderWrap=   True
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   False
   Height          =   400
   ImplicitInstance=   True
   Index           =   -2147483648
   Indicator       =   0
   IsImplicitInstance=   False
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   MinimumHeight   =   400
   MinimumWidth    =   600
   TabIndex        =   0
   Title           =   "Sentry Web Example"
   Top             =   0
   Visible         =   True
   Width           =   600
   _ImplicitInstance=   False
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebButton Button1
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Create an Exception"
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
      Scope           =   0
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   282
      _mPanelIndex    =   -1
   End
   Begin WebButton Button2
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Create an unhandled Exception"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   2
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   1
      Tooltip         =   ""
      Top             =   66
      Visible         =   True
      Width           =   282
      _mPanelIndex    =   -1
   End
   Begin WebButton Button3
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "Navigate"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   6
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   2
      TabStop         =   True
      Tooltip         =   ""
      Top             =   342
      Visible         =   True
      Width           =   282
      _mPanelIndex    =   -1
   End
   Begin WebLabel lblStatus
      Bold            =   False
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   0.0
      Height          =   56
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   28
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   True
      Scope           =   0
      TabIndex        =   3
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   112
      Underline       =   False
      Visible         =   False
      Width           =   552
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
      Indicator       =   ""
      Italic          =   False
      Left            =   28
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      TabIndex        =   4
      TabStop         =   True
      Target          =   1
      Text            =   "Open Sentry"
      TextAlignment   =   0
      TextColor       =   &c0000FF00
      Tooltip         =   ""
      Top             =   176
      Underline       =   False
      URL             =   "https://sentry.io"
      Visible         =   False
      Width           =   133
      _mPanelIndex    =   -1
   End
   Begin WebButton Button4
      AllowAutoDisable=   False
      Cancel          =   False
      Caption         =   "⚙️"
      ControlID       =   ""
      Default         =   False
      Enabled         =   True
      Height          =   38
      Index           =   -2147483648
      Indicator       =   5
      Left            =   520
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   5
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Visible         =   True
      Width           =   60
      _mPanelIndex    =   -1
   End
End
#tag EndWebPage

#tag WindowCode
#tag EndWindowCode

#tag Events Button1
	#tag Event
		Sub Pressed()
		  //Add a breadcrumb
		  Session.AddBreadcrumb("ui.click", CurrentMethodName)
		  
		  Dim dic As new Dictionary
		  
		  try
		    
		    
		    Dim value As String = dic.Value("foo")
		    
		  Catch err
		    //Catch the exception and send to Sentry
		    
		    Dim optionalMessage As String = "Testing out Sentry"
		    
		    app.sentry.user = Session.sentry_user
		    app.sentry.SubmitException(err, CurrentMethodName, optionalMessage, Xojo_Sentry.errorLevel.warning, Session)
		    
		  Finally
		    app.sentry.user = nil
		    
		  end try
		  
		  
		  
		  
		  lblStatus.Text = "You have created your first Exception." + EndOfLine + "Now click the link to open Sentry."
		  lblStatus.Visible = True
		  Link1.Visible = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button2
	#tag Event
		Sub Pressed()
		  Session.AddBreadcrumb("ui.click", CurrentMethodName)
		  
		  
		  
		  lblStatus.Text = "You have created your first Exception." + EndOfLine + "Now click the link to open Sentry."
		  lblStatus.Visible = True
		  Link1.Visible = True
		  
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
		  Session.AddBreadcrumb("ui.click", CurrentMethodName)
		  
		  //Add a navigation breadcrumb
		  Session.AddBreadcrumbNavigation(self.Name, "WebPage2")
		  
		  
		  WebPage2.Show
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Button4
	#tag Event
		Sub Pressed()
		  
		  Dim dlg As new WebDialogSentryOptions
		  
		  dlg.Show
		End Sub
	#tag EndEvent
#tag EndEvents
