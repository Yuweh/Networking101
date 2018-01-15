
import Foundation

fileprivate enum APICalls: Router{
    
    var baseComponent: String { get { return "/public" } }
    
    //Cases
    case register(firstname: String, lastname: String, email: String, country_id: String, mobile: String, password: String, confirmation_password: String, uuid: String?)
    case submitRegistrationVerificationCode(mobile: String, code: String)
    case login(mobile: String, password: String, uuid: String?)
    case submitLoginVerificationCode(code: String)
    case sendVerificationTo(mobile: String)
    case sendForgotPasswordVerification(code: String, number: String)
    case sendNewPassword(code: String, password: String, confirm_password: String)
    case resendVerificationCode(number: String)
    case sendContactSupport(name: String, email: String, type: String, content: String)
    
    //Router Setup
    var route: Route {
        switch self {
        case .register(let firstname, let lastname, let email, let country_id, let mobile, let password, let confirmation_password, let uuid):
            return Route(method: .post,
                         suffix: "/register",
                         parameters:
                [   "firstname"         :   firstname,
                    "lastname"          :   lastname,
                    "email"             :   email,
                    "country_id"        :   country_id,
                    "mobile"            :   mobile,
                    "password"          :   password,
                    "password_confirm"  :   confirmation_password,
                    "uuid"              :   uuid ?? "" ],
                         waitUntilFinished: true)
        case .submitRegistrationVerificationCode(let mobile, let code):
            return Route(method: .post,
                         suffix: "register/verification",
                         parameters: [ "code"   :   code,
                                       "mobile"    :   mobile      ],
                         waitUntilFinished: true)
        case .login(let mobile, let password, let uid):
            return Route(method: .post,
                         suffix:  "auth",
                         parameters: [ "username"    : mobile,
                                       "password"    : password,
                                       "uuid"        : uid!      ],
                        waitUntilFinished: true)
        case .submitLoginVerificationCode(let code):
            return Route(method: .post,
                         suffix: "authVerification",
                         parameters: [ "code"   : code],
                         waitUntilFinished: true)
        case .sendVerificationTo(let mobile):
            return Route(method: .post,
                         suffix: "/forgot",
                         parameters: [ "mobile" : mobile],
                         waitUntilFinished: true)
        case .sendForgotPasswordVerification(let code,let mobile):
            return Route(method: .post,
                         suffix: "/forgot/verify",
                         parameters: ["mobile"  :   mobile,
                                      "code"    :   code],
                         waitUntilFinished: true)
        case .sendNewPassword(let code, let password, let confirm_password):
            return Route(method: .post,
                         suffix: "/new/password",
                         parameters: ["code"                :   code,
                                      "password"            :   password,
                                      "password_confirm"    : confirm_password],
                         waitUntilFinished: true)
        case .resendVerificationCode(let mobile):
            return Route(method: .post,
                         suffix: "register/resend",
                         parameters: ["mobile"    : mobile ],
                         waitUntilFinished: true)

        case .sendContactSupport(let name, let email, let type, let content):
            return Route(method: .post,
                         suffix: "/supports",
                         parameters: ["name" : name,
                                      "email" : email,
                                      "type": type,
                                      "content" : content],
                         waitUntilFinished: true)
        }
    }
}

class EntryRemoteInteractor: RootRemoteInteractor{
    private var fieldRegistrationForm: RegistrationFormEntity? = nil
    
    //Registration API Calls
    
    func Register(form: RegistrationFormEntity, errorHandler: (()->Void)? = nil, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        fieldRegistrationForm = form
        
        NetworkingManager
            .request(APICalls.register(firstname: form.firstname!,
                                        lastname: form.lastname!,
                                        email: form.email!,
                                        country_id: form.country_id!,
                                        mobile: form.mobile!,
                                        password: form.password!,
                                        confirmation_password: form.password_confirm!,
                                        uuid: form.uuid), successHandler: {
                                            (reply, statusCode) in
                                            successHandler(reply, statusCode)
            })
    }
    
    func SubmitRegistrationVerificationCode(code: String, to mobile: String, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        
        NetworkingManager
            .request(APICalls.submitRegistrationVerificationCode(mobile: mobile, code: code), successHandler: {
                (reply, statusCode) in
                successHandler(reply, statusCode)
        })
    }
    
    // Contact Support API Calls
    
    
    func SubmitContactSupportForm(form: ContactSupportEntity, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        NetworkingManager.request(APICalls.sendContactSupport(name: form.customerName!, email: form.customerEmail!, type: form.customerType!, content: form.customerConcern!),
                                  successHandler: {
                                    (reply, statusCode) in
                                    successHandler(reply, statusCode)
        })
    }
    
    //Login API Calls
    
    func Login(form: LoginFormEntity, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        
        NetworkingManager.request(APICalls.login(mobile: form.mobile, password: form.password, uuid: form.uuid),
                                  successHandler:  { (reply, statusCode) in
                                                    successHandler(reply, statusCode)
        })
    }
    
    func SubmitLoginVerificationCode(code: String, accessToken: String, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        
        NetworkingManager.request(APICalls.submitLoginVerificationCode(code: code), successHandler: successHandler)
    }
    
    func SendVerificationCode(to number: String,successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        NetworkingManager.request(APICalls.sendVerificationTo(mobile: number),
                                  successHandler: successHandler)
    }
    
    func SendForgotPasswordVerification(code: String, to number: String,successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        NetworkingManager.request(APICalls.sendForgotPasswordVerification(code: code, number: number),
                                  successHandler: successHandler)
    }
    
    func SendNewPassword(code: String, password: String, confirm_password: String, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        NetworkingManager.request(APICalls.sendNewPassword(code: code, password: password, confirm_password: confirm_password),
                                  successHandler: successHandler)
    }
    
    func ResendVerificationCode(to number: String, successHandler: @escaping ((JSON, ServerReplyCode)->Void)){
        NetworkingManager.request(APICalls.resendVerificationCode(number: number),
                                  successHandler: successHandler)
    }

}


