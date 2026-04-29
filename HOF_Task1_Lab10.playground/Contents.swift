var numbers = [1 , 2 , 3 , 4 , 5]
// 1 - [1, 2, 3, 4, 5] → [1.0, 3.0, 5.0]
var oddDoubleNumbers : [Double] = numbers.filter{$0 % 2 != 0 }.map{Double($0)}

print(oddDoubleNumbers)

// 2 - [["ali", "ahmed", "mohamed"], ["yasmeen", "mona"]] → ["Ali", "Ahmed", "Mohamed", "Yasmeen", "Mona"]


let names = [["ali", "ahmed", "mohamed"], ["yasmeen", "mona"]]

var result = names.flatMap { $0}
    .map {
        word in
            word.prefix(1).uppercased() + word.dropFirst()
        }
print(result)

// [10, 20, 30] → ["100", "200", "300"]
let values = [10, 20, 30]

let result3 = values
    .map { String($0 * 10) }

print(result3)

//["10", "20", "30"] → 6000
let stringNumbers = ["10", "20", "30"]

let result4 = stringNumbers
    .compactMap { Int($0) }
    .reduce(1) { $0 * $1 }

print(result4)
