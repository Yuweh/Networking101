
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

//****************************************** Protocols @2nd ViewController to QUERY and UPDATE ***********************************************************


