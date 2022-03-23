import Vapor

func routes(_ app: Application) throws {
    
    var queue: PriorityQueue<Person> = PriorityQueue()
    
    app.post("user") { req -> Int in
        guard let person = try? req.content.decode(Person.self) else {
            return 400
        }
        print("Successfully decoded input json \(person)")
        if queue.enqueue(person){
            return 200
        }
        return 400
    }
    
    app.get("user") { req -> [Person] in
        return queue.arr
    }
}
