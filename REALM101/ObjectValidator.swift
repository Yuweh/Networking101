

func saveFunc() {

  do {

    let realm = try Realm()
    if let person = realm.objectForPrimaryKey(Person.self, key: personId){
       //Nothing needs be done.

    }else {

       //Create Person and dogs and relate them.

      let newPerson = Person()
      newPerson.id.value = personId
      newPerson.name = personName

      let newDog = Dog()
      if dogNameArray.count > 0 {
        for dog in dogNameArray {
          newDog.name = dog
          newPerson.dog.append(newDog)
        }
      }

      let realm = try Realm()
      realm.beginWrite()
      realm.create(Person.self, value: newPerson, update: true)
      try realm.commitWrite()
    }


  } catch {
    print("create and updating error"
}
