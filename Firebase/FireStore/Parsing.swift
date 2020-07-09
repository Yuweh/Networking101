   //Variables
    var categories = [Category]()
    var selectedCategory: Category!
    var firestoreDB: Firestore!
    var listener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firestoreDB = Firestore.firestore()


fileprivate func fetchCollection() {
        let collectionReference = self.firestoreDB.collection("categories")
        listener = collectionReference.addSnapshotListener({ (snap, error) in
            self.categories.removeAll()
            guard let documents = snap?.documents else { return }
            for document in documents {
                let data = document.data()
                let newCategory = Category.init(data: data)
                self.categories.append(newCategory)
            }
            self.collectionView.reloadData()
        })
        
//        collectionReference.getDocuments { (snap, error) in
//            guard let documents = snap?.documents else { return }
//            for document in documents {
//                let data = document.data()
//                let newCategory = Category.init(data: data)
//                self.categories.append(newCategory)
//            }
//            self.collectionView.reloadData()
//        }
    }
    
    func fetchDocument() {
        let docRef = self.firestoreDB.collection("categories").document("")
        
        docRef.addSnapshotListener { (snap, error) in
            self.categories.removeAll()
            guard let data = snap?.data() else { return }
            let newCategory = Category.init(data: data)
            self.categories.append(newCategory)
            self.collectionView.reloadData()
        }
        
//        docRef.getDocument { (snap, error) in
//            guard let data = snap?.data() else { return }
//            let newCategory = Category.init(data: data)
//            self.categories.append(newCategory)
//            self.collectionView.reloadData()
//        }
    }
