import Foundation

public enum Validation<E, A> {
    case Success(A)
    case Failure(E)
}

extension Validation {

    var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }

    var isFalure: Bool {
        return !isSuccess
    }
}

extension Validation where E: Semigroup, A: Semigroup {

    func append(other: Validation<E, A>) -> Validation<E, A> {
        switch (self, other) {
        case let (.Success(a1), .Success(a2)):
            return .Success(a1.append(a2))
        case (.Success, .Failure):
            return self
        case (.Failure, .Success):
            return other
        case let (.Failure(e1), .Failure(e2)):
            return .Failure(e1.append(e2))
        }
    }
}
