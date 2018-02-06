
//****************************************** Protocols @1st ViewController to ADD ***********************************************************

@IBAction
  self.processNewUser(newUserNumber: "\(String)")
  self.addNewUser(userName: String, pin: "0")

//Extensions
extension LoginViewController: SaveNewPinCodeUser {
//1.
    func addNewUser(userName: String, pin: String) {
      let newUser = Users()
      newUser.userNumber = userName
      newUser.pinNumber = pin
        do {
            try GBARealm.write {
                GBARealm.add(newUser, update: true)
                processPin.users.append(newUser)
                //pinUsers[0].usersList.append(newUser) 
            }
        } catch {
            print(error.localizedDescription)
        }
    }
//2.
    func processNewUser(newUserNumber: String){
      let pinUser = PinAuthentication()
      pinAuth.mobileNumber = newUserNumber
      try! realm.write {
          realm.add(PinAuthentication.self)
    }
}

//****************************************** UPDATED VERSION ***********************************************************

extension LoginViewController: SaveNewPinCodeUser {
    func addNewUser(userNumber: String) {
//        let newUser = PinUsers()
//        newUser.userNumber = userNumber
//        do {
//            try GBARealm.write {
//                GBARealm.add(newUser, update: true)
//                //newUser.usersList2.append(newUser)
//                //pinUsers.usersList.append(newUser)
//                //processPin.users.append(newUser)
//                //pinUsers[0].usersList.append(newUser)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        
        do {
            if let pinUser = GBARealm.object(ofType: PinUsers.self, forPrimaryKey: "\(userNumber)"){
                //Nothing needs be done.
                print(pinUser)
                print("PinUser already existing")
            } else {
                //Create Person and dogs and relate them.
                let newUser = PinUsers()
                newUser.userNumber = userNumber
                //newPerson.name = personName
                
                GBARealm.beginWrite()
                GBARealm.create(PinUsers.self, value: newUser, update: true)
                try GBARealm.commitWrite()
                    }
                } catch {
            print("create and updating error")
        }
    }
}
