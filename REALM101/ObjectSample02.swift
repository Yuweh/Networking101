

// Realm Objects

final class PinUserObject: Object {
    @objc dynamic var indentifier = 0
    @objc dynamic var pinUserNumber = ""
    override static func primaryKey() -> String? {
        return "indentifier"
    }
}

final class PinCodeObject: Object {
    @objc dynamic var indentifier = 0
    @objc dynamic var pinCode = ""
    override static func primaryKey() -> String? {
        return "indentifier"
    }
}

//Mapping

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

//Model conform to Persistable Protocol

/*
//extension PinUser: Persistable {

 public init(managedObject: PinCodeObject) {
 identifier = managedObject.identifier
 pinCode = managedObject.pinCode
 pinUserNumber = managedObject.pinUserNumber.flatMap(PinUser.init(managedObject:))
 }
 
 public func managedObject() -> PinCodeObject {
 let pinUser = PinUser()
 
 pinUser.identifier = identifier
 pinUser.pinCode = pinCode
 pinUser.pinUserNumber = pinUserNumber?.managedObject()
 
 return pinUser
 }
 
//}
 
 */
