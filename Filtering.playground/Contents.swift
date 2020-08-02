import UIKit
import Foundation
import Combine

public func example(of description: String,
                    action: () -> Void) {
  print("\n——— Example of:", description, "———")
  action()
}

var subscriptions = Set<AnyCancellable>()
example(of:"filter"){
    let numbers = (1...10).publisher
    
    numbers.filter{
        $0.isMultiple(of: 3)
    }.sink(receiveValue: { n in
        print("\(n) is a multiple of 3!")
        }).store(in: &subscriptions)
}


example(of: "removeDuplicate"){
    let words = "hey hey there: want to listen to mister mister ?"
    .components(separatedBy: " ")
    .publisher
    
    words
    .removeDuplicates()
    .sink(receiveValue: { print($0)})
    .store(in: &subscriptions)
}


example(of: "compactMap"){
    let strings = ["a","1.24","3","def","45","0.23"].publisher
    
    strings.compactMap { Int($0) }
        .sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
}

example(of: "ignoreOutput"){
    let numbers = (0...1000).publisher
    
    numbers.ignoreOutput()
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
    .store(in: &subscriptions)
}

example(of: "first:where(:)"){
    let numbers = (1...9).publisher
    numbers
    .print("numbers")
    .first(where: { $0 % 2 == 0})
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
    .store(in: &subscriptions)
}

example(of: "dropFirst"){
    let numbers = (1...10).publisher
    
    numbers.dropFirst(8)
    .sink(receiveValue: {print($0)})
    .store(in: &subscriptions)
}

example(of: "dropWhile"){
    let numbers = (1...10).publisher
    
    numbers.drop(while: { $0 % 5 != 0})
    .sink(receiveValue: {print($0)})
    .store(in: &subscriptions)
}
