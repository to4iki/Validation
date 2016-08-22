import Foundation
import ListK

/// Nel
/// A singly-linked list that is guaranteed to be non-empty.
public struct NonEmptyList<Element> {

    public let head: Element

    public let tail: List<Element>

    public init(head: Element, tail: List<Element>) {
        self.head = head
        self.tail = tail
    }

    public init(head: Element, tail: NonEmptyList<Element>) {
        self.head = head
        self.tail = tail.toList()
    }

    public init?(_ list: List<Element>) {
        switch list {
        case .None:
            return nil
        case let .Some(h, t):
            self.init(head: h, tail: t())
        }
    }
}

extension NonEmptyList {

    func toList() -> List<Element> {
        return List(head: head, tail: self.tail)
    }
}

// MARK: - CustomStringConvertible

extension NonEmptyList: CustomStringConvertible {

    public var description: String {
        let xs = flatMap({ "\($0)" }).joinWithSeparator(",")
        return "[\(xs)]"
    }
}

// MARK: - SequenceType

extension NonEmptyList: SequenceType {

    public func generate() -> AnyGenerator<Element> {
        var current = self.toList()
        return AnyGenerator {
            defer {
                current = current.tail
            }
            return current.head
        }
    }
}

// MARK: - CollectionType

extension NonEmptyList: CollectionType {

    public typealias Index = Int

    public subscript(index: Index) -> Element {
        if index == 0 {
            return head
        } else {
            return tail[index.predecessor()]!
        }
    }

    public var startIndex: Index { return 0 }

    public var endIndex: Index { return count }
}

// MARK: Append

public func + <Element>(lhs: NonEmptyList<Element>, x: Element) -> NonEmptyList<Element> {
    return NonEmptyList(head: lhs.head, tail: lhs.tail + List(x))
}

public func + <Element>(x: Element, rhs: NonEmptyList<Element>) -> NonEmptyList<Element> {
    return NonEmptyList(head: x, tail: rhs.toList())
}

public func + <Element>(lhs: NonEmptyList<Element>, xs: List<Element>) -> NonEmptyList<Element> {
    return NonEmptyList(head: lhs.head, tail: lhs.tail + xs)
}

public func + <Element>(xs: List<Element>, rhs: NonEmptyList<Element>) -> NonEmptyList<Element> {
    switch xs {
    case .None:
        return rhs
    case let .Some(h, t):
        return NonEmptyList(head: h, tail: t() + rhs.toList())
    }
}

// MARK: - Equatable

public func == <Element: Equatable>(lhs: NonEmptyList<Element>, rhs: NonEmptyList<Element>) -> Bool {
    return lhs.toList() == rhs.toList()
}

public func != <Element: Equatable>(lhs: NonEmptyList<Element>, rhs: NonEmptyList<Element>) -> Bool {
    return lhs.toList() != rhs.toList()
}
