//
//

import Foundation
import SwiftyJSON

public class HorticultureManager: NSObject {
    
    static let sharedInstance = HorticultureManager() // Singleton
    
    public let coreDataManager = CoreDataManager.sharedInstance
    
    public func loadGrowingProfiles() {
        // 1. Read JSON from bundle and convert it to data
        let url = Bundle.main.url(forResource: "plants", withExtension: "json")
        
        if let url = url{
            let data = NSData(contentsOf: url)
            
            // 2. serialize JSON from Data
            if let data = data {

                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    
                    // 3. get or read data from Dictionary from jsonObject
                    if let object = jsonObject as? [String: AnyObject] {
                        if let allplants = object["plants"] as? [[String:AnyObject]] {
                            for plants in allplants {
                                
                                // 4. print(allPersonnel)
                                    //print("plants:\(plants)")
                                for plant in plants {
                                    if (plant.key == "id") || (plant.key == "name") {
                                        print("plant:\(plant)")
                                    }
                                    
                                    if (plant.key == "growing_profiles") {
                                        self.getGrowingProfiles(values: plant.value as! Array<Any>)
                                    }
                                }
                            }
                            

                        }
                    }
                } catch {
                    print("error")
                }
            }
        }
    }
    
    public func getGrowingProfiles(values: Array<Any>) {
        for value in values {
            print("value.key:\(value)")
        }
    }
    
    
}
