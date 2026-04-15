
var number = 3

func getFactorial(_ number:Int) -> Int{
    var factorial = 2
    if(number < 0){
        return number
    }
    if(number == 0 || number == 1 ){
        return 1
    }
    for i in 2 ... number{
        factorial *= i
    }
    return factorial
}

let result = getFactorial(number)
print("Get Factorial")
print("Result of number 3 = \(result)")
print("---")

// 2 - Calc Power
func calcPower(base: Int, power: Int) -> Int {
    if power == 0 {
        return 1
    }
    
    var result = 1
    
    for _ in 1...power {
        result *= base
    }
    
    return result
}

func calcPowerUsingRecursion( base : Int , power : Int ) -> Int{
    var power = power
    if(power == 0 ){
        return 1
    }
    power = power - 1
    return base * calcPowerUsingRecursion(base: base, power: power )
}
print("Calc Power")
print("2^0 = \(calcPower(base: 2, power: 0))")   // Output: 1
print("2^5 = \(calcPower(base: 2, power: 5))")   // Output: 32

print("2^5 = \(calcPowerUsingRecursion(base: 2, power: 5))")   // Output: 32

print("3^4 = \(calcPower(base: 3, power: 4))")   // Output: 81
print("5^3 = \(calcPower(base: 5, power: 3))")   // Output: 125
print("10^6 = \(calcPower(base: 10, power: 6))") // Output: 1000000

// 3 - Sort Array by Reference
func sortArray(arr: inout [Int]) {
    for i in 0..<arr.count {
        for j in 0..<arr.count - i - 1 {
            if arr[j] > arr[j + 1] {
                let temp = arr[j]
                arr[j] = arr[j + 1]
                arr[j + 1] = temp
            }
        }
    }
}
print("Sort Array")
var array1 = [5, 3, 8, 1, 2]
print("Before: \(array1)")
sortArray(arr: &array1)
print("After:  \(array1)")
print("---")

var array2 = [64, 34, 25, 12, 22, 11, 90]
print("Before: \(array2)")
sortArray(arr: &array2)
print("After:  \(array2)")
print("---")

var array3 = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
print("Before: \(array3)")
sortArray(arr: &array3)
print("After:  \(array3)")


