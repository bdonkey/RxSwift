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

example("dictionary") {
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
