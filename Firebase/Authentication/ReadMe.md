## Authentication 

import Firebase

//AppDelegate
        FirebaseApp.configure()


//SignIn 

        Auth.auth().signIn(withEmail: userEmail, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration Successful and will be saved at keychain")

//CreateUser

        Auth.auth().createUser(withEmail: userEmail, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("Registration Successful and will be saved at keychain")

