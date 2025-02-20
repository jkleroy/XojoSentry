[![XOJO 2023r3](https://img.shields.io/badge/XOJO-2024r1-71AF3A.svg)](https://www.xojo.com/)
![Platform Desktop](https://img.shields.io/badge/Platform-Desktop-lightgray.svg?style=flat)
![Platform Web](https://img.shields.io/badge/Platform-Web-lightgray.svg?style=flat)
[![Platform iOS](https://img.shields.io/badge/Platform-iOS-lightgray.svg?style=flat)](http://www.apple.com/ios/)

# Xojo Sentry Client
 API for using https://sentry.io

- Release date: 2023-01-10
- Latest update: 2025-02-20

Language: Xojo 2024r3 Desktop, Web & iOS Project

Author: Jeremie Leroy

Version 0.9

Based on the original code from Mike Cotrone https://github.com/mikecotrone/XojoSentryV2


## Overview
This is a full client written in Xojo for Sentry.io. The Sentry.io platform helps every developer diagnose, fix, and optimize the performance of their code. With Sentry, developers around the world save time, energy, and probably a few therapy sessions.


# Usage

Open one of the example projects

1. Copy/paste the Xojo_Sentry module into your project
2. Copy/paste the code from App.Opening event into your project
3. Copy/paste the code from App.UnhandledException event into your project
4. Register for an account at https://sentry.io
5. You will get a project DSN from Sentry. Copy that value in the App.Opening event


## Sentry Options
After initiliazing Sentry, there are a few options that can be set.

```xojo
//If necessary, Sentry has a few options
self.sentry.Options.app_name = "" //Your app's name

'self.sentry.Options.get_battery_status = True //Only relevant on iOS
self.sentry.Options.include_StackFrame_address = False
self.sentry.Options.max_breadcrumbs = 100 //The maximum amount of breadcrumbs to keep
self.sentry.Options.persistant_breadcrumbs = 10 //The maximum amount of persistant breadcrumbs to keep. Defaults to 10
self.sentry.Options.sample_rate = 1.0 //Configures the sample rate for error events, in the range of 0.0 to 1.0. The default is 1.0 which means that 100% of error events are sent. If set to 0.1 only 10% of error events will be sent. Events are picked randomly.
self.sentry.Options.save_before_sending = False //Saves the exception to disk before sending to Sentry. Set to True before sending an UnhandledException or when the app is about to crash
self.sentry.Options.traces_sample_rate = 0.1 //Configures the sample rate for tracing events, in the range of 0.0 to 1.0. The default is 0.1 which means that 10% of traces events are sent. Traces are picked randomly.
```


## The User Object
Assign a SentryUser to your instance of SentryController to retrieve useful information about the user.

```xojo
//If your app handles user authentication add the info to sentry

Var user as new Xojo_Sentry.SentryUser
user.email = "name@example.com"
user.language = "en" //The language the user is running the app in
user.locale = locale.Current
'user.ip = "1.1.1.1" //Uncomment this if necessary. Default is "{{auto}}"
user.user_id = "1234" //The user's unique ID

self.sentry.user = user
```


| Parameter | Explanation |
| -- | -- |
| email | As String. The user's email address. |
| ip | As String. The user's IP address. Default is {{auto}}. |
| language | As String. The language used by the app when running on this user's device. |
| locale | As Locale. Defaults to `Locale.current` |
| subscription | As String. The user's current subscription status.  |
| user_id | As String. The user's unique identifier. |

Sentry will then display user's information in the Contexts area

![image](./images/sentry_user_information.png)

## More information
https://github.com/getsentry/sentry
and
https://sentry.io
