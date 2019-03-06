

public class HorticultureManager: NSObject {
    
    static let sharedInstance = HorticultureManager() // Singleton
    
    public let coreDataManager = CoreDataManager.sharedInstance
    
    public func loadGrowingProfiles() {
        // 1. Read JSON from bundle and convert it to data
        let url = Bundle.main.url(forResource: "plants", withExtension: "json")
        
        if let url = url{
            let data = NSData(contentsOf: url)
            
            // 2. serialize JSON from Data
            if let fetchedData = data {
                let convertedData = Data(referencing: fetchedData)
                if let json = try? JSON(data: convertedData) {
                    //Globals.log("SwiftyJSON:\(String(describing: json))")
                    
                    let allPlants = json["plants"].arrayValue
                    
                    for plant in allPlants {
                        
                        let plantID = plant["id"].intValue
                        let plantName = plant["name"].stringValue
                        
                        let plantDataToSave = PlantDataProfile(id: plantID, name: plantName)
                        self.savePlantData(plantDataToSave)
                        
                        let growingProfilesArray = plant["growing_profiles"].arrayValue
                        
                        for plantProfile in growingProfilesArray {
                            let profileID = plantProfile["id"].intValue
                            let stage = plantProfile["stage"].stringValue
                            let days = plantProfile["days"].intValue
                            let minTemp = plantProfile["minimum_temperature"].floatValue
                            let maxTemp = plantProfile["maximum_temperature"].floatValue
                            let minHum = plantProfile["minimum_humidity"].floatValue
                            let maxHum = plantProfile["maximum_humidity"].floatValue
                            let plantID = plantProfile["plant_id"].intValue
                            let stageOrder = plantProfile["stage_order"].intValue
                            
                            let plantProfileToSave = GrowingProfilesData(id: profileID,
                                                                         stage: stage,
                                                                         days: days,
                                                                         minimum_temperature: minTemp,
                                                                         maximum_temperature: maxTemp,
                                                                         minimum_humidity: minHum,
                                                                         maximum_humidity: maxHum,
                                                                         plant_id: plantID,
                                                                         stage_order: stageOrder)
                            self.saveGrowingProfile(plantProfileToSave)
                        }
                        
                    }

                }
            }
        }
    }

    public func saveGrowingProfile(_ profile: GrowingProfilesData) {
        print("GrowingProfile id:\(profile.id), stage:\(profile.stage), days:\(profile.days), minTemp:\(profile.minimum_temperature), maxTemp:\(profile.maximum_temperature), minHum:\(profile.minimum_humidity), maxHum:\(profile.maximum_humidity), plantID:\(profile.plant_id), stageOrder:\(profile.stage_order)")
    }
    
    public func savePlantData(_ plantData: PlantDataProfile) {
        print("PlantData id:\(plantData.id) & name:\(plantData.name)")
    }
    
}
