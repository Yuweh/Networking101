//Realm Objects to Apply

//****************************************** OBJECTS ***********************************************************

//Create 2 Realm Objects:

//PinAuthentication.swift
//First:
class PinAuthentication: Object {
    dynamic var mobileNumber: String?
    var usersList: List<Users>()
}

//Second:
class Users: Object {
    dynamic var userNumber: String?
    dynamic var pinNumber: String?
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

@IBAction func addDog(){
    let newUser = Users()
    newUser.userNumber = "+639987771122"
    newUser.pinNumber = "0"

    pinUsers[0].usersList.append(newUser)
    // in this place my application crashed
}






