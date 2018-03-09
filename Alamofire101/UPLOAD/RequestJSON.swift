//

class NetworkingManager{
    
    private(set)var Token: (String, String) = (access: "", "")
    
    class func request(_ router: Router,
                       successHandler: @escaping (JSON, ServerReplyCode) -> Void,
                       errorHandler: @escaping (Error)->Void = errorAction){
        print(serverHeaders)
        do{
            
            var urlRequest = try router.asURLRequest()
            
            if let body = urlRequest.httpBody{
                let bodyString = String(data: body, encoding: String.Encoding.utf8)!
                var bodyDict = [String: String]()
                
                for keyValueString in bodyString.components(separatedBy: "&"){
                    var parts = keyValueString.components(separatedBy: "=")
                    
                    if parts.count < 2 { continue }
                    
                    let key = parts[0].removingPercentEncoding!
                    let value = parts[1].removingPercentEncoding!
                    
                    bodyDict[key] = value
                }
            }
            
            var loadingIndicator: LoadingIndicatorView?
            
            if router.route.waitUntilFinished {
                loadingIndicator = LoadingIndicatorView()
                UIApplication.shared.keyWindow!.addSubview(loadingIndicator!)
            }
            
            Alamofire.request(router).responseJSON{
                data in
                
                switch data.result{
                case .success(let json):
                    guard let statusCode = data.response?.statusCode else { fatalError("Status code not found in reply") }
                    print("Request Success from \(String(describing: urlRequest.url?.absoluteString))")
                    successHandler(json as? JSON ?? ["value": "nil"], ServerReplyCode(rawValue: statusCode)!)
                case .failure(let error):
                    print("\n\n===========Error===========")
                    print("Error Code: \(error._code)")
                    print("Error Messsage: \(error.localizedDescription)")
                    if let data = data.data, let str = String(data: data, encoding: String.Encoding.utf8){
                        print("Server Error: " + str)
                    }
                    debugPrint(error as Any)
                    print("===========================\n\n")
                }
                
                if let loadingIndicator = loadingIndicator {
                    loadingIndicator.removeFromSuperview()
                }
            }
            
        }catch{
            errorHandler(error)
        }
        
    }
