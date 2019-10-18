
  # Login Widget  
 Show content depending on whether or not the user is logged in. Simply provide two arguments: A Widget to display when logged in, one to display when not.  The goal is to make setting up a login page and handling that process *much* less of a hassle, and I am shaming Google hardcore for not building *something* like this this for the core framework or the FlutterFire package.
  
*Relies on the firebase_auth and google_sign_in packages. This was written in about two hours to save time going forward, so pull requests are welcome if you can add to the package.*
  
## Usage  
  
The Login widget is meant to simplify the process of stateful content for logged-in / logged-out users, and it was designed to be as easy to use as possible. There are a few static methods (like `Login.signInWithGoogle` and `Login.signInWithEmail`)  that work out of the box, but you can use any of the login methods provided by `FirebaseAuth.instance` and easily verify there were no issues with `Login.checkUser(FirebaseUser user)`.  
  
Declaring a Login widget:  
```  
Login(
	loggedIn: myHomePage(), 
	loggedOut: myLoginForm(), 
)
```
Yup. That's it.  

## Sign in with Google
Inside `myLoginForm` (or any widget), you could simply call `Login.signInWithGoogle()` to call the google_sign_in plugin and automatically refresh the page when the user state changes.  This is especially helpful for buttons, i.e., inside `myLoginForm`:  
```  
RaisedButton(onPressed: Login.signInWithGoogle, child: Text("Sign in"))  
```  
For this specific case, the work has been done for you, and the package includes a helper widget with the onPressed set to the static method `Login.signInWithGoogle`. 
```
GoogleSignInButton()
```

Effortless. You can initialize this with *no arguments*, as seen above. (Take notes, Mr. Sneath.)   All of the branding guidelines provided by Google have been incorporated into the widget.

![enter image description here](https://developers.google.com/identity/images/google_button_spec.png)

The `Login` Widget will automatically display the relevant content when the login status changes using the `FirebaseAuth.instance.onAuthStateChanged` listener. In the first example under the *Usage* section, `myHomePage` will be shown when the user is logged in, and `myLoginForm` will be displayed when the user is not logged in.
  
Easy peeze. Additionally, because each app will (generally) only have one user, there is no harm (and tons of convenience) in exposing the current Firebase user data and login status as static properties `(FirebaseUser) Login.currentUser` and `(bool) Login.isLoggedIn`. You can access these at any time anywhere in your code.  

## Login Fields
There are now standard static TextFields available at `Login.email` and `Login.password`. The controller logic is handled by the Login package. Reference these static widgets wherever you want to accept an email or password for logging in, and customize the styling in your app's `ThemeData`.

`Login.signInWithEmail` will automatically read the text from its private TextEditingControllers (email and password) for the sign-in process, same with `Login.resetPassword`.  These static TextFields will share the same controllers no matter where they're initialized, which can be an inconvenience but can also be useful - for instance, initializing *both* a sign-in form and a "forgot password" form with `Login.email` will mean text is shared across the two fields. A user who types their email to sign in, and then opens the Forgot Password page, will automatically have that text inputted for them - they are, quite literally, the same field. 

Before, these functions accepted TextEditingControllers when invoked, but this package is really meant to be as simple to use as possible so those parameters have been removed.  Simply place these static widgets somewhere and call `Login.signInWithEmail()` on a button press to attempt the sign-in.

## Automatic Snackbars
Most of the sign-in functions accept a `BuildContext context` to trigger a relevant Snackbar message. For instance, calling `Login.resetPassword(context: context)` will show a message saying "Check your email for a password reset link." Failed logins will behave similarly.

## Theming
Any theming you wish to do can be done in your app's `ThemeData`, including the email and password TextFields and Snackbars.
  
*Pre-Installation & Debugging*  
  
**1. Make sure you set up Firebase before using the widget, otherwise FirebaseAuth will not work.** For instance, the example included in this package displays the usage and general concept, but cannot actually change state without a google-services file or the [necessary configuration](https://firebase.google.com/docs/flutter/setup). Once Firebase is set up, you can simply depend on the Login package and it will work automatically.  
  
**2. Make sure your Firebase project is [set up](https://console.firebase.google.com) with a support email in Project Settings or you may get backend errors.**  
  
**3. Make sure you have sign-in methods enabled under Authentication.**