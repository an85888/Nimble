import Foundation


// Implement this protocol if you want full control over to() and toNot() behaviors
protocol Matcher {
    typealias ValueType
    func matches(actualExpression: Expression<ValueType>, failureMessage: FailureMessage) -> Bool
    func doesNotMatch(actualExpression: Expression<ValueType>, failureMessage: FailureMessage) -> Bool
}

// Implement this protocol if you just want a simplier matcher. The negation
// is provided for you automatically.
protocol BasicMatcher {
    typealias ValueType
    func matches(actualExpression: Expression<ValueType>, failureMessage: FailureMessage) -> Bool
}

// Protocol for types that support contain() matcher
@objc protocol KICContainer {
    func containsObject(object: AnyObject!) -> Bool
}
extension NSArray : KICContainer {}
extension NSSet : KICContainer {}
extension NSHashTable : KICContainer {}

// Protocol for types that support beginWith() and endWith() matcher
@objc protocol KICOrderedCollection {
    func indexOfObject(object: AnyObject!) -> Int
    var count: Int { get }
}
extension NSArray : KICOrderedCollection {}

// Protocol for types to support beCloseTo() matcher
@objc protocol KICDoubleConvertible {
    var doubleValue: CDouble { get }
}
extension NSNumber : KICDoubleConvertible { }
extension NSDecimalNumber : KICDoubleConvertible { } // TODO: not the best to downsize

// Protocol for types to support beLessThan(), beLessThanOrEqualTo(),
//  beGreaterThan(), beGreaterThanOrEqualTo(), and equal() matchers.
//
// Types that conform to Swift's Comparable protocol will work implicitly too
protocol KICComparable {
    func KIC_compare(otherObject: Self!) -> NSComparisonResult
}
extension NSNumber : KICComparable {
    func KIC_compare(otherObject: NSNumber!) -> NSComparisonResult {
        return compare(otherObject)
    }
}
extension NSString : KICComparable {
    func KIC_compare(otherObject: NSString!) -> NSComparisonResult {
        return compare(otherObject)
    }
}