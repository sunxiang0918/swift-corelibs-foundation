// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2015 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//

/* NSRegularExpression is a class used to represent and apply regular expressions.  An instance of this class is an immutable representation of a compiled regular expression pattern and various option flags.
*/

public struct NSRegularExpressionOptions : OptionSetType {
    public let rawValue : UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static let CaseInsensitive = NSRegularExpressionOptions(rawValue: 1 << 0) /* Match letters in the pattern independent of case. */
    public static let AllowCommentsAndWhitespace = NSRegularExpressionOptions(rawValue: 1 << 1) /* Ignore whitespace and #-prefixed comments in the pattern. */
    public static let IgnoreMetacharacters = NSRegularExpressionOptions(rawValue: 1 << 2) /* Treat the entire pattern as a literal string. */
    public static let DotMatchesLineSeparators = NSRegularExpressionOptions(rawValue: 1 << 3) /* Allow . to match any character, including line separators. */
    public static let AnchorsMatchLines = NSRegularExpressionOptions(rawValue: 1 << 4) /* Allow ^ and $ to match the start and end of lines. */
    public static let UseUnixLineSeparators = NSRegularExpressionOptions(rawValue: 1 << 5) /* Treat only \n as a line separator (otherwise, all standard line separators are used). */
    public static let UseUnicodeWordBoundaries = NSRegularExpressionOptions(rawValue: 1 << 6) /* Use Unicode TR#29 to specify word boundaries (otherwise, traditional regular expression word boundaries are used). */
}

public class NSRegularExpression : NSObject, NSCopying, NSCoding {
    public override func copy() -> AnyObject {
        return copyWithZone(nil)
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        NSUnimplemented()
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        NSUnimplemented()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        NSUnimplemented()
    }
    
    /* An instance of NSRegularExpression is created from a regular expression pattern and a set of options.  If the pattern is invalid, nil will be returned and an NSError will be returned by reference.  The pattern syntax currently supported is that specified by ICU.
    */
    
    public init(pattern: String, options: NSRegularExpressionOptions) throws { NSUnimplemented() }
    
    public var pattern: String { NSUnimplemented() }
    public var options: NSRegularExpressionOptions { NSUnimplemented() }
    public var numberOfCaptureGroups: Int { NSUnimplemented() }
    
    /* This class method will produce a string by adding backslash escapes as necessary to the given string, to escape any characters that would otherwise be treated as pattern metacharacters.
    */
    public class func escapedPatternForString(string: String) -> String { NSUnimplemented() }
}

public struct NSMatchingOptions : OptionSetType {
    public let rawValue : UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static let ReportProgress = NSMatchingOptions(rawValue: 1 << 0) /* Call the block periodically during long-running match operations. */
    public static let ReportCompletion = NSMatchingOptions(rawValue: 1 << 1) /* Call the block once after the completion of any matching. */
    public static let Anchored = NSMatchingOptions(rawValue: 1 << 2) /* Limit matches to those at the start of the search range. */
    public static let WithTransparentBounds = NSMatchingOptions(rawValue: 1 << 3) /* Allow matching to look beyond the bounds of the search range. */
    public static let WithoutAnchoringBounds = NSMatchingOptions(rawValue: 1 << 4) /* Prevent ^ and $ from automatically matching the beginning and end of the search range. */
}

public struct NSMatchingFlags : OptionSetType {
    public let rawValue : UInt
    public init(rawValue: UInt) { self.rawValue = rawValue }
    
    public static let Progress = NSMatchingFlags(rawValue: 1 << 0) /* Set when the block is called to report progress during a long-running match operation. */
    public static let Completed = NSMatchingFlags(rawValue: 1 << 1) /* Set when the block is called after completion of any matching. */
    public static let HitEnd = NSMatchingFlags(rawValue: 1 << 2) /* Set when the current match operation reached the end of the search range. */
    public static let RequiredEnd = NSMatchingFlags(rawValue: 1 << 3) /* Set when the current match depended on the location of the end of the search range. */
    public static let InternalError = NSMatchingFlags(rawValue: 1 << 4) /* Set when matching failed due to an internal error. */
}

extension NSRegularExpression {
    
    /* The fundamental matching method on NSRegularExpression is a block iterator.  There are several additional convenience methods, for returning all matches at once, the number of matches, the first match, or the range of the first match.  Each match is specified by an instance of NSTextCheckingResult (of type NSTextCheckingTypeRegularExpression) in which the overall match range is given by the range property (equivalent to rangeAtIndex:0) and any capture group ranges are given by rangeAtIndex: for indexes from 1 to numberOfCaptureGroups.  {NSNotFound, 0} is used if a particular capture group does not participate in the match.
    */
    
    public func enumerateMatchesInString(string: String, options: NSMatchingOptions, range: NSRange, usingBlock block: (NSTextCheckingResult?, NSMatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Void) { NSUnimplemented() }
    
    public func matchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> [NSTextCheckingResult] { NSUnimplemented() }
    public func numberOfMatchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> Int { NSUnimplemented() }
    public func firstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSTextCheckingResult? { NSUnimplemented() }
    public func rangeOfFirstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSRange { NSUnimplemented() }
}

/* By default, the block iterator method calls the block precisely once for each match, with a non-nil result and appropriate flags.  The client may then stop the operation by setting the contents of stop to YES.  If the NSMatchingReportProgress option is specified, the block will also be called periodically during long-running match operations, with nil result and NSMatchingProgress set in the flags, at which point the client may again stop the operation by setting the contents of stop to YES.  If the NSMatchingReportCompletion option is specified, the block will be called once after matching is complete, with nil result and NSMatchingCompleted set in the flags, plus any additional relevant flags from among NSMatchingHitEnd, NSMatchingRequiredEnd, or NSMatchingInternalError.  NSMatchingReportProgress and NSMatchingReportCompletion have no effect for methods other than the block iterator.

NSMatchingHitEnd is set in the flags passed to the block if the current match operation reached the end of the search range.  NSMatchingRequiredEnd is set in the flags passed to the block if the current match depended on the location of the end of the search range.  NSMatchingInternalError is set in the flags passed to the block if matching failed due to an internal error (such as an expression requiring exponential memory allocations) without examining the entire search range.

NSMatchingAnchored, NSMatchingWithTransparentBounds, and NSMatchingWithoutAnchoringBounds can apply to any match or replace method.  If NSMatchingAnchored is specified, matches are limited to those at the start of the search range.  If NSMatchingWithTransparentBounds is specified, matching may examine parts of the string beyond the bounds of the search range, for purposes such as word boundary detection, lookahead, etc.  If NSMatchingWithoutAnchoringBounds is specified, ^ and $ will not automatically match the beginning and end of the search range (but will still match the beginning and end of the entire string).  NSMatchingWithTransparentBounds and NSMatchingWithoutAnchoringBounds have no effect if the search range covers the entire string.

NSRegularExpression is designed to be immutable and threadsafe, so that a single instance can be used in matching operations on multiple threads at once.  However, the string on which it is operating should not be mutated during the course of a matching operation (whether from another thread or from within the block used in the iteration).
*/

extension NSRegularExpression {
    
    /* NSRegularExpression also provides find-and-replace methods for both immutable and mutable strings.  The replacement is treated as a template, with $0 being replaced by the contents of the matched range, $1 by the contents of the first capture group, and so on.  Additional digits beyond the maximum required to represent the number of capture groups will be treated as ordinary characters, as will a $ not followed by digits.  Backslash will escape both $ and itself.
    */
    public func stringByReplacingMatchesInString(string: String, options: NSMatchingOptions, range: NSRange, withTemplate templ: String) -> String { NSUnimplemented() }
    public func replaceMatchesInString(string: NSMutableString, options: NSMatchingOptions, range: NSRange, withTemplate templ: String) -> Int { NSUnimplemented() }
    
    /* For clients implementing their own replace functionality, this is a method to perform the template substitution for a single result, given the string from which the result was matched, an offset to be added to the location of the result in the string (for example, in case modifications to the string moved the result since it was matched), and a replacement template.
    */
    public func replacementStringForResult(result: NSTextCheckingResult, inString string: String, offset: Int, template templ: String) -> String { NSUnimplemented() }
    
    /* This class method will produce a string by adding backslash escapes as necessary to the given string, to escape any characters that would otherwise be treated as template metacharacters. 
    */
    public class func escapedTemplateForString(string: String) -> String { NSUnimplemented() }
}

