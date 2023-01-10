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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
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
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   151
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   52
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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   250
   End
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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   250
   End
   Begin DesktopButton Button4
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Try out Breadcrumbs"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
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
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   360
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   170
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
		  btAttachment.Enabled = True
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
#tag Events Button3
	#tag Event
		Sub Pressed()
		  
		  Dim w As new wSentryUserFeedback(app.sentry.lastUUID)
		  
		  w.ShowModal(self)
		End Sub
	#tag EndEvent
#tag EndEvents
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
#tag Events Button4
	#tag Event
		Sub Pressed()
		  
		  app.sentry.AddBreadcrumb("ui.click",  CurrentMethodName)
		  
		  
		  dim w As new Window2
		  
		  app.sentry.AddBreadcrumbNavigation("Window1", "Window2", "")
		  
		  w.Show
		End Sub
	#tag EndEvent
#tag EndEvents
