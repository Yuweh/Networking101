
    //****************************************** Custom Functions to Validate ***********************************************************


    // header_label .set(value: "Enter PIN code") & subscript_label: .set(value: "We need your PIN code for you to access Settings")
    
    //Exp. PinUser Validator
    func newPinUserValidator() {
        
        let pinUserProfile = self.pinUsers
        print(pinUserProfile.userNumber!)
        
        if pinUserProfile.pinNumber != nil {
            print("Existing PinUser")
            return
        } else {
            self.header_label.set(value: "Set PIN Code")
            self.subscript_label.set(value: "Enter 6 digits to set a New PIN Code")
        }
        
    }
    
    //Existing PinUser Code Re-Entry
    func existingPinUserCodeRepeater(enteredPinCode: String) {
        
        let newUser = pinUsers
        newUser.pinNumber = enteredPinCode
        let pinUserProfile = self.pinUsers
        print(pinUserProfile.userNumber!)
        
        if self.userPinCode == "" {
            self.header_label.set(value: "Re-Enter PIN Code")
            self.subscript_label.set(value: "Re-Enter the PIN Code to access Settings")
            self.userPinCode = enteredPinCode
            do {
                try GBARealm.write {
                    GBARealm.add(newUser, update: true)
                }
            } catch {
                print(error.localizedDescription)
            }
            self.input_textField.reloadInputViews()
            self.layoutToggleViews()
            
        } else if self.userPinCode != "" {
            self.existingPinUserValidator(enteredPinCode: enteredPinCode)
        } else {
            print("Error")
        }
    }
    
    //For Existing PinUsers
    func existingPinUserValidator(enteredPinCode: String) {
        if enteredPinCode == self.userPinCode {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.subscript_label.set(value: "Entered PIN Code is incorrect, please try again")
            self.input_textField.reloadInputViews()
        }
    }
    
    //New PinUser Code Re-Entry
    func newPinUserCodeRepeater(enteredPinCode: String) {
        
        let newUser = pinUsers
        newUser.pinNumber = enteredPinCode
        let pinUserProfile = self.pinUsers
        print(pinUserProfile.userNumber!)
        
        if pinUserProfile.pinNumber == nil {
            self.header_label.set(value: "Re-Enter PIN Code")
            self.subscript_label.set(value: "Re-Enter the PIN Code to access Settings")
            self.userPinCode = enteredPinCode
            do {
                try GBARealm.write {
                    GBARealm.add(newUser, update: true)
                }
            } catch {
                print(error.localizedDescription)
            }
            self.input_textField.reloadInputViews()
            self.layoutToggleViews()
            
        } else {
            print("PinUser already set a PINcode")
            return
        }
    }\\
