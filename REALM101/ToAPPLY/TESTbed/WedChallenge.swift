    
//
//

import UIKit

class LoginViewController: EntryModuleViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
    
    @IBOutlet weak var appTitle_label: UILabel!
    @IBOutlet weak var mobileNumber_textField: GBATitledTextField!
    @IBOutlet weak var password_textField: GBATitledTextField!
    
    @IBOutlet weak var createAccount_label: UILabel!
    @IBOutlet weak var forgotPassword_label: UILabel!
    
    private let defaultCountry:Countries = .Philippines
    
    private var loginForm: LoginFormEntity{
        return LoginFormEntity(mobile: mobileNumber, password: password_textField.text, uuid: "")
    }
    
    private var mobileNumber: String{
        return mobileNumber_textField.text
    }
    
    var currentPresenter: LoginPresenter{
        guard let prsntr = self.presenter as? LoginPresenter
            else{ fatalError("Error in parsing presenter for RegistrationViewController") }
        return prsntr
    }
    
    //*************************************************************************
    
    //Realm Q.Variables
    
    fileprivate var user: PrimaryUser{
        get{
            guard let usr = GBARealm.objects(PrimaryUser.self).first else{
                fatalError("User not found")
            }
            return usr
        }
    }
    //= GBARealm.object(ofType: PinUsers.self, forPrimaryKey: "\(user.mobile)") else{
//    fileprivate var userLogInType: UserLogInTypes{
//       get{
//            guard let usr = GBARealm.object(ofType: UserLogInTypes.self, forPrimaryKey: "\(user.userNumber)") else{
//                fatalError("User not found")
//            }
//            return usr
//        }
//    }

    //*************************************************************************
    override func viewDidLoad() {
        addPrimaryLogInUser()
        self.newUserLogInValidator(userNumber: user.userNumber!, enteredLogInType: user.logInType!)
        (self._presenter as! LoginPresenter).dataBridgeToView = self
        
        self.setBackground()
        
        self.presenter.set(view: self)
        
        self.createAccount_label.isUserInteractionEnabled = true
        self.forgotPassword_label.isUserInteractionEnabled = true
        
        
        let createAccount_tap = UITapGestureRecognizer(target: self, action: #selector(createAccount_tapped))
        createAccount_label.gestureRecognizers = [createAccount_tap]
        let forgotPassword_tap = UITapGestureRecognizer(target: self, action: #selector(forgotPassword_tapped))
        forgotPassword_label.gestureRecognizers = [forgotPassword_tap]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logInTypeValidator()
        self.title = " "
        self.navigationController?.isNavigationBarHidden = true
        self.appTitle_label.textColor = GBAColor.darkGray.rawValue
 
        self.mobileNumber_textField
            .set(self)
            .set(placeholder: "Mobile Number")
            .set(alignment: .left)
            .set(inputType: .mobileNumber)
            .set(underlineColor: .gray)
            .set(text: "")
        
        self.password_textField
            .set(self)
            .set(placeholder: "Password")
            .set(alignment: .left)
            .set(returnKeyType: .done)
            .set(inputType: .freeText)
            .set(security: true)
            .set(underlineColor: .gray)
            .set(text: "")
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.mobileNumber_textField.set(text: "")
        self.password_textField.set(text: "")
    }
    
    fileprivate func setBackground(){
        let backgroundImage = UIImage(imageLiteralResourceName: "Login_BG").cgImage
        let layer = CALayer()
        let overlay = CAGradientLayer()
        
        layer.frame = UIScreen.main.bounds
        layer.contents = backgroundImage
        layer.contentsGravity = kCAGravityResizeAspectFill
        
        overlay.set(frame: self.view.bounds)
            .set(start: CGPoint(x: 0, y: 0))
            .set(end: CGPoint(x: 0, y: 1))
            .set(colors: [.white, .primaryBlueGreen])
            .set(locations: [0, 1.4])
            .opacity = 0.8
        
        self.view.layer.insertSublayer(layer, at: 0)
        self.view.layer.insertSublayer(overlay, at: 1)
        
    }
    
    @objc func createAccount_tapped(){
        let nav = UINavigationController()
        EntryWireframe(nav).navigate(to: .Registrationscreen)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @objc func forgotPassword_tapped(){
        let nav = UINavigationController()
        EntryWireframe(nav).navigate(to: .ForgotPasswordscreen)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func support_tapped(_ sender: UIButton) {
        let nav = UINavigationController()
        nav.navigationBar.barTintColor = GBAColor.primaryBlueGreen.rawValue
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: GBAColor.white.rawValue]
        nav.navigationBar.tintColor = GBAColor.white.rawValue
        nav.isNavigationBarHidden = false
        
        EntryWireframe(nav).navigate(to: .Supportscreen)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func login_tapped(_ sender: GBAButton) {
        
        if (self.mobileNumber_textField.text != "" && self.password_textField.text != "") {
            self.currentPresenter.processLogin(form: loginForm, controller: self)
            
            //exp. PinAuth Functions
            self.addNewUser(userNumber: self.mobileNumber_textField.text)
            
        } else {
            testRequiredFields()
        }
    }
    
    @IBAction func navigateATM_tapped(_ sender: UIButton) {
                self.presenter.wireframe.navigate(to: .AtmFinderscreen)
    }
    
    func testRequiredFields(){
        
        self.mobileNumber_textField
            .set(required: true)
        self.password_textField
            .set(required: true)
    }
 
    //*************************************************************************
    
    //EXPerimentor
    func newUserLogInValidator(userNumber: String, enteredLogInType: String) {
        let newUser = UserLogInTypes()
        newUser.userNumber = userNumber
        newUser.logInType  = enteredLogInType
        do {
            try GBARealm.write {
                GBARealm.add(newUser, update: true)
            }
        } catch {
            print(error.localizedDescription)
        }
        print(" ****** transactionSubmitted ****** ")

        
    }
    
    
//*************************************************************************
    
    func logInTypeValidator() {

        let appNav = self.navigationController!
        let logInUserProfile = self.user
        print(logInUserProfile.userNumber!)
        print(logInUserProfile.logInType!)

        if logInUserProfile.logInType == "0" {
            print("Default Log-In Set")
            return
        } else if logInUserProfile.logInType == "1" {
            print("PIN Code Set")
            EntryWireframe(appNav).navigate(to: .PinCodeLogIn)

        } else if logInUserProfile.logInType == "2"{
            print("Touch ID Log-In Set")
            EntryWireframe(appNav).navigate(to: .TouchIDLogIn)

        } else {
            print("Error in LogIn Type Occured")
            return
        }
    }
}
    
//*************************************************************************
    
extension LoginViewController{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
    
extension LoginViewController: DataDidRecievedFromLogin{
    func didRecieveVerificationData(code: String) {
        self.testRequiredFields()
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done{
            guard let nav = self.navigationController else { fatalError("navigation controller was not properly set") }
            DashboardWireframe(nav).navigate(to: .Dashboardscreen)
        }
        return true
    }
}

extension LoginViewController: GBAVerificationCodeDelegate{
    func ResendButton_tapped(sender: UIButton) {
        self.currentPresenter.resendVerificationCode()
    }
        
    func GBAVerification() {
        guard let nav = self.navigationController else{
            fatalError("Navigation View Controller was  not set in LiginViewController")
        }
        DashboardWireframe(nav).presentTabBarController()
    }
}
    
extension LoginViewController: SaveNewPinCodeUser {
    func addNewUser(userNumber: String) {
        do {
            if let pinUser = GBARealm.object(ofType: PinUsers.self, forPrimaryKey: "\(userNumber)"){
                //Nothing needs be done.
                print(pinUser)
                print("PinUser already existing")
            } else {
                let newUser = PinUsers()
                newUser.userNumber = userNumber
                GBARealm.beginWrite()
                GBARealm.create(PinUsers.self, value: newUser, update: true)
                try GBARealm.commitWrite()
                    }
                } catch {
            print("create and updating error")
        }
    }
}

extension LoginViewController: PrimaryUserLogIn {
    func addPrimaryLogInUser() {
        do {
            if let pinUser = GBARealm.object(ofType: PrimaryUser.self, forPrimaryKey: "Primary"){
                //Nothing needs be done.
                print(pinUser)
                print("PinUser already existing")
            } else {
                let newUser = PrimaryUser()
                newUser.userNumber = "0"
                newUser.userPassword = "0"
                newUser.logInType = "0"
                GBARealm.beginWrite()
                GBARealm.create(PrimaryUser.self, value: newUser, update: true)
                try GBARealm.commitWrite()
            }
        } catch {
            print("create and updating error")
        }

    }

}
    
    
    
    
