func sumOfOddNumber() -> Int{
    var sum = 0
    for i in 1...1000{
        if i % 2 != 0{
            sum += i
        }
    }
    return sum
}
sumOfOddNumber()