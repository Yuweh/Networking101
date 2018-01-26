
import Foundation
import RealmSwift

class PinAuthentication: Object {
    @objc dynamic var userMobileNumber: String = ""
    @objc dynamic var userPinNumber: String = ""
    
    var parentCategory = LinkingObjects(fromType: PinUsers.self, property: "users")
    //for comparison to existing users
    //let users = List<>()
    
}

class PinUsers: Object {
    let users = List<PinAuthentication>()
}

extension PinAuthentication: LocalEntityProcess{
    
    func writeEntity() {
        do{
            let obj = GBARealm.objects(PinAuthentication.self)
            print(obj)
            try GBARealm.write {
                GBARealm.add(self)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
