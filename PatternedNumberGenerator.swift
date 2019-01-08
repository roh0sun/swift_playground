//
//  Created by YOUNG SUN ROH on 2019. 1. 8..
//  Copyright © 2019년 RYS. All rights reserved.
//

import Foundation

class PatternedNumberGenerator {
    private var numBase = [Int64]()
    private var numRange = [Range<Int>]()
    private var numIndex = [Int]()

    let count: Int
    var order: Int
    
    private let formatter = NumberFormatter()
    
    init(_ pattern: String) {
        formatter.minimumIntegerDigits = pattern.count
        
        if pattern.count > 0 {
            let begin = pattern.startIndex
            let end = pattern.endIndex
            var it = pattern.index(end, offsetBy: -1)
            
            var base: Int64 = 1
            while it >= begin {
                let c = pattern[it]
                if c == "*" {
                    let r = 0..<10
                    numIndex.append(0)
                    numRange.append(r)
                }
                else {
                    let i = Int(String(c))!
                    let r = i..<i+1
                    numIndex.append(i)
                    numRange.append(r)
                }
                
                numBase.append(base)
                base *= 10
                
                if it > begin {
                    it = pattern.index(it, offsetBy: -1)
                }
                else {
                    break
                }
            }
            
            var c = 1
            for v in numRange {
                c *= (v.upperBound - v.lowerBound)
            }
         
            count = c
            order = 0
        }
        else {
            count = 0
            order = 0
        }
    }

    private func inc(_ i: Int) {
        if numIndex[i] + 1 < numRange[i].upperBound {
            numIndex[i] += 1
        }
        else {
            if i + 1 < numIndex.count {
                inc(i + 1)
                numIndex[i] = numRange[i].lowerBound
            }
        }
    }
    
    func next() -> Int64 {
        if order < count {
            var num: Int64 = 0
            let cnt = numBase.count
            for i in 0 ..< cnt {
                let v = numIndex[i]
                num += Int64(v) * numBase[i]
            }
            
            inc(0)
            
            order += 1
            return num
        }
        else {
            return -1
        }
    }
    
    func nextStr() -> String {
        return formatter.string(from: NSNumber(value: next()))!
    }
    
    static func printAll(_ gen: PatternedNumberGenerator) {
        while gen.order < gen.count {
            print(gen.nextStr())
        }
    }
}

//print("---")
//PatternedNumberGenerator.printAll(PatternedNumberGenerator("*"))
//print("---")
//PatternedNumberGenerator.printAll(PatternedNumberGenerator("1"))
//print("---")
//PatternedNumberGenerator.printAll(PatternedNumberGenerator("1*"))
//print("---")
//PatternedNumberGenerator.printAll(PatternedNumberGenerator("*1"))
//print("---")
//PatternedNumberGenerator.printAll(PatternedNumberGenerator("**"))

PatternedNumberGenerator.printAll(PatternedNumberGenerator("*33*"))
//=>
//0330
//0331
//0332
//0333
//0334
//0335
//0336
//0337
//0338
//0339
//1330
//1331
//1332
//1333
//1334
//1335
//1336
//1337
//1338
//1339
//2330
//2331
//2332
//2333
//2334
//2335
//2336
//2337
//2338
//2339
//3330
//3331
//3332
//3333
//3334
//3335
//3336
//3337
//3338
//3339
//4330
//4331
//4332
//4333
//4334
//4335
//4336
//4337
//4338
//4339
//5330
//5331
//5332
//5333
//5334
//5335
//5336
//5337
//5338
//5339
//6330
//6331
//6332
//6333
//6334
//6335
//6336
//6337
//6338
//6339
//7330
//7331
//7332
//7333
//7334
//7335
//7336
//7337
//7338
//7339
//8330
//8331
//8332
//8333
//8334
//8335
//8336
//8337
//8338
//8339
//9330
//9331
//9332
//9333
//9334
//9335
//9336
//9337
//9338
//9339
