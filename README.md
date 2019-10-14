
# Login Widget
  
Show content depending on whether or not the user is logged in. Simply provide two arguments: A Widget to display when logged in, one to display when not. 

Relies on the firebase_auth and google_sign_in packages. This was written in about two hours to save time going forward, so pull requests are welcome if you can add to the package.

## Usage

The Login widget is meant to simplify the process of stateful content for logged-in / logged-out users, and it was designed to be as easy to use as possible. There are a few static methods (like `Login.signInWithGoogle` and `Login.signInWithEmail`)  that work out of the box, but you can use any of the login methods provided by `FirebaseAuth.instance` and easily verify there were no issues with `Login.checkUser(FirebaseUser user)`.

Declaring a Login widget:
```
@override
Widget build(BuildContext context) {
	return Login(
		loggedIn: myHomePage(),
		loggedOut: myLoginForm(),
	);
}
```
Inside `myLoginForm` (or any widget), you can simply call `Login.signInWithGoogle()` to call the google_sign_in plugin and automatically refresh the page when the user state changes.  This is especially helpful for buttons, i.e., inside `myLoginForm`:
```
RaisedButton(onPressed: Login.signInWithGoogle, child: Text("Sign in"))
```
For the Google sign-in case, the package includes a `GoogleSignInButton()` widget with the onPressed set to the static method `Login.signInWithGoogle` method. You can initialize this with *no arguments*, as seen in the example! Take notes, Mr. Sneath.

The `Login` Widget will automatically display the relevant content when the login status changes. In the above example, `myHomePage` will be shown when the user is logged in, and `myLoginForm` will be displayed when the user is not logged in (default).

Easy peeze. Additionally, because each app will (generally) only have one user, there is no harm (and tons of convenience) in exposing the current Firebase user data and login status as static properties `(FirebaseUser) Login.currentUser` and `(bool) Login.isLoggedIn`. You can access these at any time anywhere in your code.

*Pre-Installation & Debugging*

**1. Make sure you set up Firebase before using the widget, otherwise FirebaseAuth will not work.** For instance, the example included in this package displays the usage and general concept, but cannot actually change state without a google-services file or the [necessary configuration](https://firebase.google.com/docs/flutter/setup). Once Firebase is set up, you can simply depend on the Login package and it will work automatically.

**2. Make sure your Firebase project is [set up](https://console.firebase.google.com) with a support email in Project Settings or you may get backend errors.**

**3. Make sure you have sign-in methods enabled under Authentication.**