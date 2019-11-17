//
//  Error+Arbitrary.swift
//  JSONAPIArbitrary
//
//  Created by Mathew Polzin on 1/21/19.
//

import SwiftCheck
import JSONAPI

extension UnknownJSONAPIError: Arbitrary {
	public static var arbitrary: Gen<UnknownJSONAPIError> {
		return Gen.pure(.unknownError)
	}
}

extension GenericJSONAPIError: Arbitrary where ErrorPayload: Arbitrary {
    public static var arbitrary: Gen<GenericJSONAPIError<ErrorPayload>> {
        return Gen.one(of: [
            .pure(.unknownError),
            ErrorPayload.arbitrary.map { .error($0) }
        ])
    }
}

extension BasicJSONAPIErrorPayload: Arbitrary where IdType: Arbitrary {
    public static var arbitrary: Gen<BasicJSONAPIErrorPayload<IdType>> {
        return Gen.compose { c in
            return BasicJSONAPIErrorPayload(
                id: c.generate(),
                status: c.generate(),
                code: c.generate(),
                title: c.generate(),
                detail: c.generate(),
                source: c.generate())
        }
    }
}

extension BasicJSONAPIErrorPayload.Source: Arbitrary {
    public static var arbitrary: Gen<Self> {
        return Gen
            .zip(String?.arbitrary, String?.arbitrary)
            .map { Self(pointer: $0.0, parameter: $0.1) }
    }
}
