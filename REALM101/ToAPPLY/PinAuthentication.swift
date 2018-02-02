//Realm Objects to Apply

//****************************************** OBJECTS ***********************************************************

//Create 2 Realm Objects:

//PinAuthentication.swift
//First:
class PinAuthentication: Object {
    @objc dynamic var mobileNumber: String?
    var usersList = List<Users>()
}

//Second:
class Users: Object {
   @objc dynamic var userNumber: String?
   @objc dynamic var pinNumber: String?
}

//****************************************** 1st VC ***********************************************************

//now in ViewController in 'viewDidLoad' Create object Person with empty List and save it in Realm

func viewDidLoad(){
    let pinUser = PinAuthentication()
    pinAuth.mobileNumber = "+639978882211" or "\(userNumber)"
    try! realm.write {
        realm.add(PinAuthentication.self)
    }
}
//it works great and it now created PinAuthentication Object,

//****************************************** 2nd VC ***********************************************************

//Read this data in SecondViewController in ViewDidLoad
var pinUsers: Results<PinAuthentication>?

func viewDidLoad(){
    pinUsers = try! realm.allObjects()
}
//and try to add new Dog to List doing it in button action:

//****************************************** IBaction ***********************************************************

@IBAction func addNewPinUser(){
    let newUser = Users()
    newUser.userNumber = "+639987771122"
    newUser.pinNumber = "0"

    pinUsers[0].usersList.append(newUser)
    // in this place my application crashed
}

//****************************************** Validation / Querying / Filter ***********************************************************




//****************************************** Protocols ***********************************************************

//Protocols
protocol SaveNewPinCodeUser {
    func addNewUser(userName: String, pin: String)
    func processNewUser(newUserNumber: String)
}

//Log-in Tapped
self.processNewUser(newusernumber: self.mobileNumber_textField.text, pin: "0")

//Extensions
extension LoginViewController: SaveNewPinCodeUser {
//1.
    func addNewUser(user: String, pin: String) {
        let newUser = PinCodeUser(id: UserNumber, mobile: String, pin: String)
        do {
            try GBARealm.write {
                GBARealm.add(newUser, update: true)
                processPin.users.append(newUser)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
//2.
    func processNewUser(newusernumber: String, pin: String){
    }
}


