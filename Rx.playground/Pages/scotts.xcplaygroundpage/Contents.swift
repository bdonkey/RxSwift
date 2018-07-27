//: [Previous](@previous)

import RxSwift

extension ObservableType {
  
  /**
   Add observer with `id` and print each emitted event.
   - parameter id: an identifier for the subscription.
   */
  func addObserver(_ id: String) -> Disposable {
    return subscribe { print("Subscription:", id, "Event:", $0) }
  }
  
}

print("hello")
example("map") {
  let disposeBag = DisposeBag()
  Observable.of(1, 2, 3)
    .map { $0 * $0 }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
}

example("dictionary Observable") {
  let disposeBag = DisposeBag()
  var d = ["scott":"schmidt1"]
  let od = Observable.of(d)
  od
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
  
  d["schmidt"] = "scott"
  od
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
  
  print(d)

}

example("dict Observable 1"){
    let bag = DisposeBag()
    var d: [Int:Int] = [:]
    var od: Observable<[Int:Int]> = Observable.of([:])
    
    for index in 1...5 {
        d[index] = index * 5
        print(d)
    }
    od = Observable.of(d)
    od
        .subscribe(
            onNext: {item in
                print("item = \(item)")
        })
        .disposed(by: bag)
}

example("dict Observable 2"){
    let bag = DisposeBag()
    var d: [Int:Int] = [:]
    var od: Observable<[Int:Int]> = Observable.of([:])
    
    for index in 1...5 {
        od = Observable.of([index: index * 120])
        d[index] = index * 5
        print(d)
    }
    od
        .subscribe(
            onNext: {item in
                print("item = \(item)")
        })
        .disposed(by: bag)
}

func getDictOb(_ index: Int) -> Observable<[Int:Int]> {
    let ob = Observable.of([index: index * 100])
    return ob
}

example("dict Observable 3"){
    let bag = DisposeBag()
    var d: [Int:Int] = [:]
    var od: Observable<[Int:Int]> = Observable.of([:])
    
    print("above returns [:]")
    od
        .subscribe(
            onNext: {item in
                print("item = \(item)")
        })
        .disposed(by: bag)

    for index in 1...5 {
        od = getDictOb(index)
        od
        .subscribe(
            onNext: { item in
                print("subscribe in loop = \(item)")
        })
    }
    print("below returns last dict item")
    od
        .subscribe(
            onNext: {item in
                print("item = \(item)")
        })
        .disposed(by: bag)

}


example("BehaviorSubject") {
  let disposeBag = DisposeBag()
  var d = ["scott":"schmidt1"]
  let subject = BehaviorSubject(value: d)
  d["schmidt"] = "scott"

  subject.addObserver("1").disposed(by: disposeBag)
   subject.onNext(["Jake": "Jones"])
    subject.onNext(d)

}

example("Variable") {
  let disposeBag = DisposeBag()
  var d = ["scott":"schmidt"]
   d["schmidt"] = "scott"
  let dv = Variable(d)
  dv.asObservable().addObserver("1").disposed(by: disposeBag)
  d["time"] = "is infinite"
  dv.value = d
  dv.value["RxSift"] = "is hard"
  dv.value = ["this kill": "prior rx"] // this kills prior dv values
  
}

example("Variable1") {
  
  let disposeBag = DisposeBag()
  var d: [String:String] = [:]
  var dv = Variable(d)
  
}

example("test swift map") {
  let xray = [1,2,3]
  let j = xray.map({$0 * $0})
  print(j)
}
//: [Next](@next)
