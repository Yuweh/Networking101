
import Foundation
import UIKit

protocol DataRecievedContactSupport{
    func didRecievedVerificationData(code: String)
}

    /**************************************************************************/

class ContactSupportPresenter: EntryRootPresenter{
    
    var submittedForm: ContactSupportEntity? = nil
    var dataBridge: DataRecievedContactSupport? = nil
    
    func processContactSupport(submittedForm: ContactSupportEntity){
        self.submittedForm = submittedForm
        guard let bridge = dataBridge else { fatalError("dataBridge was not implemented in ContactSupportPresenter") }
        
        self.interactor.remote.SubmitContactSupportForm(form: submittedForm, successHandler: {
            (reply, statusCode) in
            print(reply)
            print(statusCode)
            
            switch statusCode{
            case .dataCreated:
                guard let message = reply["message"] as? String else{
                    fatalError("message not found in server reply: [\(reply)]")
                }
                let messages = NSAttributedString(string: "Thank you for using GBA Mobile Banking Application. Our team will review and analyze your issue/concern and we will get back to you as soon as we find a way to resolve it.", attributes: [NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: GBAText.Size.subContent.rawValue)!])
                
                let content = NSMutableAttributedString()
                content.append(messages)
                
                self.wireframe.presentSuccessPage(title: "Support", message: content, doneAction: {
                    self.wireframe.popToRootViewController(true)
                })
                bridge.didRecievedVerificationData(code: "\(message)")
                
    /**************************************************************************/
                
            case .badRequest:
                guard let messages = reply["message"] as? [String:Any] else{
                    fatalError("Message not found")
                }
                
                var message: String?
                
                messages.forEach{
                    message = ($0.value as? [String])?.first
                    return
                }
                
                self.showAlert(with: "Message", message: message ?? "message not found", completion: { () })
            default: break
            }
        })
    }
}

    /**************************************************************************/
    /**************************************************************************/
