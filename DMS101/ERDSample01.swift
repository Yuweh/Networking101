
import Foundation

struct RegistrationFormEntity: Decodable{
    var firstname: String? = ""
    var lastname: String? = ""
    var email: String? = ""
    var country_id: String? = ""
    var mobile: String? = ""
    var password: String? = ""
    var password_confirm: String? = ""
    var uuid: String? = nil
    
    init(firstname: String, lastname: String, email: String, country_id: String, mobile: String, password: String, password_confirm: String, uuid: String? = nil){
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.country_id = country_id
        self.mobile = mobile
        self.password = password
        self.password_confirm = password_confirm
        self.uuid = uuid
    }
}

struct ContactSupportEntity: Decodable{
    var customerName: String? = ""
    var customerEmail: String? = ""
    var customerType: String? = ""
    var customerConcern: String? = ""
}


struct LoginFormEntity: Decodable{
    var mobile: String = ""
    var password: String = ""
    var uuid: String? = ""
    
}

struct UserAuthenticationEntity: Decodable{
    var expires_in: Int = 0
    var access_token: String = ""
    var refresh_token: String = ""
    var auth_level: Int = 1
    var token_type: String = "Bearer"
    var device_type: Int = 0
}
