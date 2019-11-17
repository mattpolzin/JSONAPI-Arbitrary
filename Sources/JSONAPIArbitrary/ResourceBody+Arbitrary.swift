//
//  ResourceBody+Arbitrary.swift
//  JSONAPIArbitrary
//
//  Created by Mathew Polzin on 1/21/19.
//

import SwiftCheck
import JSONAPI

extension SingleResourceBody: Arbitrary where PrimaryResource: Arbitrary {
	public static var arbitrary: Gen<SingleResourceBody<PrimaryResource>> {
		return PrimaryResource.arbitrary.map(SingleResourceBody.init(resourceObject:))
	}
}

extension ManyResourceBody: Arbitrary where PrimaryResource: Arbitrary {
	public static var arbitrary: Gen<ManyResourceBody<PrimaryResource>> {
		return PrimaryResource.arbitrary.proliferate.map(ManyResourceBody.init(resourceObjects:))
	}
}

extension NoResourceBody: Arbitrary {
	public static var arbitrary: Gen<NoResourceBody> {
		return Gen.pure(.none)
	}
}
