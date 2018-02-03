
//****************************************** @2nd ViewController to QUERY ***********************************************************

    //Realm Q.Variables
    fileprivate var user: User{
        get{
            guard let usr = GBARealm.objects(User.self).first else{
                fatalError("User not found")
            }
            return usr
        }
    }
    
    fileprivate var pinUsers: PinUsers{
        get{                //GBARealm.objects(PinUsers.self).first else{ //to be tested
            guard let pinUser = GBARealm.object(ofType: PinUsers.self, forPrimaryKey: "\(user.mobile)") else{
                fatalError("User not found")
            }
            return pinUser
        }
    }
    
    //****************************************** SEE Custom Functions to Validate NEXT ***********************************************************

