//
//

import UIKit
import Alamofire
import AVFoundation

class SelfieVerificationViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, Subscriber, AVCaptureMetadataOutputObjectsDelegate{
    
    private struct Storyboard{
        static let SuccessfullySubmittedSelfieViewControllerID = "SuccessfullySubmittedSelfieViewControllerID"
    }
    
    var typeOfImage: String = ""
    var img = UIImageView ()
    var id : Int? = 0
    var isApprove: Bool = false
    @IBOutlet weak var imgSelf: UIImageView!
    @IBOutlet weak var sendImage: UIImageView!
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:self, action:#selector(self.backButtonPressedWithValidation(_:)));
       
       self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigation_back.png"), style: .plain, target:self, action:#selector(self.backButtonPressedWithValidation(_:)));
        
       self.navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "Submit", style:.plain, target:self, action:#selector(submit(sender:)));

        self.navigationItem.title = "Photo Verification"
        
        if sendImage.image == nil{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        userPoint.subscribe(self)
        userPoint.requestForState(self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userPoint.unsubscribe(self)
    }
    
    
    
    func updateFromState<S: State>(_ state: S) {
        switch state {
        case let state as UserDataState:
            id = state.id
        default: break
        }
        
    }

    @IBAction func submit(sender: UIButton) {
        if sendImage.image == nil {
            // Create the alert controller
            let alertController = UIAlertController(title: "Upload", message: "Please click below to upload.", preferredStyle: .alert)
            
                let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)

        }
        else{
            // Create the alert controller
            let alertController = UIAlertController(title: "Upload", message: "Are you sure you want to upload this photo?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                 self.uploadWithAlamofire()
                NSLog("OK Pressed")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        
       
    }
    
    @IBAction func btnUpload(sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
            if status == .authorized {
                // authorized
                isApprove = true
                showActionSheetForPhoto()
                print("authorized")
            }
            else if status == .denied {
                // denied
                isApprove = false
                showActionSheetForPhoto()
                print("denied")
            }
            else if status == .restricted {
                // restricted
                print("restricted")
            }
            else if status == .notDetermined {
                // not determined
                AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {(_ granted: Bool) -> Void in
                    if granted {
                        print("Granted access")
                    }
                    else {
                        print("Not granted access")
                    }
                })
            }
        }

    }
    
    
    func showActionSheetForPhoto(){
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 2
        let takeAPhoto = UIAlertAction(title: "Take a Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                if self.isApprove{
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                    imagePicker.allowsEditing = false
                    self.typeOfImage = Constants.Camera
                    self.present(imagePicker, animated: true, completion: nil)

                }else{
                    self.alertPromptToAllowCameraAccessViaSettings()
                }
        }
            
        })
        let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                self.typeOfImage = Constants.Upload
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                //imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(takeAPhoto)
        optionMenu.addAction(gallery)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            img = UIImageView(image: image)
            switch typeOfImage {
            case Constants.Camera:
                savePhoto()
                sendImage.image = image
            default:
                sendImage.image = image
                picker.dismiss(animated: true, completion: nil)
                break
            }
            viewLabel.alpha = 0
            imgSelf.alpha = 0
            sendImage.alpha = 1
            
        } else{
            print("Something went wrong")
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        //self.dismiss(animated: true, completion: nil)
    }

    
    func savePhoto(){
        
        let imageData = UIImageJPEGRepresentation(img.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    // import Alamofire
    func uploadWithAlamofire() {
      
        var loadingIndicator: LoadingIndicatorView?
        
        let image = sendImage.image!
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if let imageData = UIImageJPEGRepresentation(image, 0.5) {
                    multipartFormData.append(imageData, withName: "uploadedImage", fileName: "\(self.id!)_\(Timestamp).png", mimeType: "image/png")
                }
            },
            to: "\(Constants.productionServerLocal)/api/kyc/\(id!)/upload/kycselfphoto/uploadImageMobile",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    loadingIndicator = LoadingIndicatorView()
                    UIApplication.shared.keyWindow!.addSubview(loadingIndicator!)
                    
                    
                    upload.uploadProgress(closure: { (Progress) in
                        print("Upload Progress: \(Progress.fractionCompleted)")
                    })
                    
                    
                    upload.responseJSON { response in
                        debugPrint(response)
                        
                        if let loadingIndicator = loadingIndicator {
                            loadingIndicator.removeFromSuperview()
                        }
                        
                        userPoint.requestForState(self)
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.SuccessfullySubmittedSelfieViewControllerID) as! SuccessfullySubmittedSelfieViewController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }

}

extension Constants{
    static let Camera = "Camera"
    static let Upload = "Upload"
}

extension UIViewController {
    
    func alertPromptToAllowCameraAccessViaSettings() {
        let alert = UIAlertController(title: Constants.ValidationTitle, message: Constants.ValidationCamera, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Open Settings", style: .cancel) { alert in
            //Analytics.track(event: .permissionsPrimeCameraOpenSettings)
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        })
        present(alert, animated: true, completion: nil)
    }

}
