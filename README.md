# Connectify

<img class="round" src="./assets/images/logo.png" width="100" height="100"/>

Fremont High School Mobile App Development
<br/>
Date of submission: 2/24/21

# Overview
Welcome to Connectify, an amazing app that allows you to seamlessly connect and network with other students! Connectify is designed to provide users with a platform to post about their hobbies and proffesional interests, create and explore a myriad of innovative and fresh startups, chat with people looking to network, build a expansive portfolio, and gives them the ability to find other likeminded individuals. 

Additionally, Connectify implements several API's that enhance the user experience, such as the Google Authentication API, Cloud Firestore API, Dropbox API, and more! With the power of our speedy database and the cloud, Connectify provides a real time data flow that dynamically updates information that the user needs, allowing them to interact with other users efficiently. 


# Portfolio
<img src="assets/portfolio/slanding.png" width="430" /><img src="assets/portfolio/ssign.png" width="430" /> <img src="assets/portfolio/slog.png" width="430" />
<img src="assets/portfolio/sgoogle.png" width="430" /> <img src="assets/portfolio/sstate.png" width="430" /><img src="assets/portfolio/sschool.png" width="430" />
<img src="assets/portfolio/sintro.png" width="430" /><img src="assets/portfolio/ssplash.png" width="430" /><img src="assets/portfolio/shome.png" width="430" />
<img src="assets/portfolio/spost.png" width="430" /><img src="assets/portfolio/sstartup.png" width="430" /><img src="assets/portfolio/screate.png" width="430" />
<img src="assets/portfolio/schat.png" width="430" /><img src="assets/portfolio/ssearch.png" width="430" /><img src="assets/portfolio/sprofile.png" width="430" />
<img src="assets/portfolio/sedit.png" width="430" /><img src="assets/portfolio/ssettings.png" width="430" /><img src="assets/portfolio/srefresh.png" width="430" />
<img src="assets/portfolio/sdark.png" width="430" />


# Brainstorming and Planning
- [App Design Flow](https://docs.google.com/document/d/1HiQpNK7N295IVqAyzwiOjUOHYOlEwiSwyGvqaZ7WNi0/edit)
- [App Brainstorm](https://docs.google.com/document/d/1ZdlabqNYcHull3JlMOZ7KsLOXtSgzFny4yDk9xCPQ4U/edit)
- [Youtube](https://www.youtube.com/channel/UCt45kKvhf02NO_vPSu0RsZQ/featured)

# Core Features

Performance
 
- Native performance on both iOS and Android
- Fully responsive and adaptable UI to any screen dimensions, including tablets
- Robust backend for Authentication 
    - Built-in encryption on database for user passwords (UUID, Firebase)
- Email/Password login for extensive accessibility with Firebase Authentication
- Google sign-in for convenience and accessibility (OAuth, Google Cloud API)
- Powerful cloud database with Cloud Firestore
    - Secure, speedy, and reliable
- High Bandwith and Quality Cloud Storage with Dropbox API
    - Fast video streams, image storage

Application
- Seamless Setup Process
    - Autofill completion for state and school information
    - Intro slider screen to guide the user
- Dynamic feed that fetches posts using the power of the cloud
    - Tracks information such as date published, relevance, etc.
- Algorithm loads post from your school or related schools
    - Utilizes Machine Learning on School Object data, such as proximity, type of school
- Social Media Integration to share on many platforms such as Facebook, Twitter, Messenger, Messages, and much more! (Must have correlated apps installed for integration)
- Seamless integration for creating a post
    - Post is added to our database
    - Employs cloud data persistence
    - Error handling incase the upload cannot be performed
- An innovative solution to create and explore startups
    - Embedded Web Viewers to learn more about the startup
    - Image to promote branding and convey central purpose of startup
    - Description to provide context and overview of startup
- Seamless integration for creating a startup
    - Startup is added to our database
    - Employs cloud data persistence
    - Error handling incase the upload cannot be performed
- Global Messaging Networking Portal
    - Users can ask questions, learn more about subject areas, and network with other likeminded students
    - Powered by Cloud Storage Streaming
- Smart Cloud-Powered Search Engine
    - Finds posts and startups based on the entry query
    - Designed around the query networking model  (OSI Model)
- Beautiful Profile Page that allows the user to view detailed and impressive portfolios
    - The profile image, name, and description can all be changed
    - You can also view other people's portfolios by clicking on their image
    - Integrated with Google Auth to automatically create account with Google information if you use a Google Sign In
- Easy to Access Settings Page
    - Straightforward signing out process
    - Simple toggle for dark mode, which reduces energy usage and is better for the eyes in a dark room
    - Disable analytics option, as we believe that it is the right of the user to decide how and where their data is used
- Feedback and Bug Report Form in the Settings Page
    - Allows user to request new features as well as report bugs so we can make the Connectify experience as flawless as possible
- Blazing Fast Local Database Using Hive
    - Stores login information and dark mode preferences so the user does not have to sign in or enable dark mode every time they open Connectify
- Smart Analytics and data aggregation on user metrics such as User Retention, Device Info, etc.

# Technologies and API's used

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Google Cloud Platform](https://cloud.google.com/)
- [Firebase Authentication](https://firebase.google.com/products/auth)
- [Firebase Cloud Firestore](https://firebase.google.com/products/firestore)
- [Firebase Cloud Storage](https://firebase.google.com/products/storage)
- [Firebase Cloud Functions](https://firebase.google.com/products/functions)
- [Firebase Crashlytics](https://firebase.google.com/products/crashlytics)
- [Firebase Performance Monitoring](https://firebase.google.com/products/performance)
- [Google Analytics](https://analytics.google.com/)
- [flutter_sms](https://pub.dev/packages/flutter_sms)
- [http](https://pub.dev/packages/http)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [hive](https://pub.dev/packages/hive)
- [provider](https://pub.dev/packages/provider)
- [custom_navigation_bar](https://pub.dev/packages/custom_navigation_bar)
- [introduction_screen](https://pub.dev/packages/introduction_screen)
- [material_dialogs](https://pub.dev/packages/material_dialogs)
- [modal_progress_hud](https://pub.dev/packages/modal_progress_hud)
- [flutter_typeahead](https://pub.dev/packages/flutter_typeahead)
- [google_sign_in](https://pub.dev/packages/google_sign_in)
- [animations](https://pub.dev/packages/animations)
- [pull_to_refresh](https://pub.dev/packages/pull_to_refresh)
- [url_launcher](https://pub.dev/packages/url_launcher)
- [dropbox_client](https://pub.dev/packages/dropbox_client)
- [path_provider](https://pub.dev/packages/path_provider)
- [cloud_firestore](https://pub.dev/packages/cloud_firestore)
- [firebase_auth](https://pub.dev/packages/firebase_auth)
- [firebase_core](https://pub.dev/packages/firebase_core)
- [file_picker](https://pub.dev/packages/file_picker)
- [uuid](https://pub.dev/packages/uuid)
- [image_picker](https://pub.dev/packages/image_picker)
- [better_player](https://pub.dev/packages/better_player)
- [tab_indicator_styler](https://pub.dev/packages/tab_indicator_styler)
- [device_info](https://pub.dev/packages/device_info)
- [xlive_switch](https://pub.dev/packages/xlive_switch)
- [hive_flutter](https://pub.dev/packages/hive_flutter)
- [share](https://pub.dev/packages/share)
- [hive_flutter](https://pub.dev/packages/hive_flutter)

This application was programmed completely in Google's Flutter Framework.

# License
ChapterTree is licensed under the MIT License - Please view [LICENCE](https://github.com/msoham123/ChapterTree/blob/master/LICENSE) for more details

# Copyright Information
* Login and Signup user authentication powered by Firebase and consistent with their API usage policies
* Facebook Logo used for application graphics with explicit permission from Facebook Brand Resources.
* Twitter Logo used for application graphics with explicit permission from Twitter Brand Resources.
* Instagram Logo used for application graphics with explicit permission from Twitter Brand Resources.
* Google logo used for application graphics in accordance with [Google Trademark Policy](https://www.google.com/permissions/trademark/rules.html).
* The App Store, Xcode, iPad, iPhone, and IOS are all registered trademarks of Apple Inc.
* The following image acknowledgements are in accordance with the Google Images [copyright policy](https://support.google.com/websearch/answer/29508?hl=en).
    - "Colusa" image from Google
    - "Los Osos" image from Google
    - "Ontario" image from Google
    - "Pasadena" image from Google
    - "Redwood" image from Google
    - "SaltLakeCity" image from Google
    - "Valencia" image from Google
    - "Westmoor" image from Google
    - "TreeIcon" image from Google
    - "GoogleLogo" image from Google
* The following image acknowledgements are in accordance with the Undraw [license](https://undraw.co/license).
    - "Attendance" image from Undraw
    - "Calendar" image from Undraw
    - "Events" image from Undraw
    - "Map" image from Undraw
    - "Messages" image from Undraw


# Developers
* Aryan Vichare - <i>User Interface (UI), Backend, Database, API integration, Server Side Code</i>
* Soham Manoli - <i>User Interface (UI), User Experience (UX), API integration</i>
