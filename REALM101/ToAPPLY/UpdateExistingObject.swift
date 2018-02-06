//same procedure like creating an object, declare name and input new item to be added

    //Existing PinUser ChangePin
    func pinUserChangePin(userNumber: String, enteredPinCode: String){
        
        let newUser = PinUsers()
        newUser.userNumber = userNumber
        newUser.pinNumber  = enteredPinCode
        do {
            try GBARealm.write {
                GBARealm.add(newUser, update: true)
            }
        } catch {
            print(error.localizedDescription)
        }
        print(" ****** transactionSubmitted ****** ")
        guard let navController = self.navigationController else { return }
        SettingsWireframe(navController).repeatPinCodeVC()
        
    }
