//
//  Relationship+Arbitrary.swift
//  JSONAPIArbitrary
//
//  Created by Mathew Polzin on 1/15/19.
//

import SwiftCheck
import JSONAPI

extension ToOneRelationship: Arbitrary where Identifiable.ID: Arbitrary, IdMetaType: Arbitrary, MetaType: Arbitrary, LinksType: Arbitrary {
	public static var arbitrary: Gen<ToOneRelationship<Identifiable, IdMetaType, MetaType, LinksType>> {
		return Gen.compose { c in
			return .init(
                id: (c.generate(), c.generate()),
                meta: c.generate(),
                links: c.generate()
            )
		}
	}
}

extension ToOneRelationship where IdMetaType: Arbitrary, MetaType: Arbitrary, LinksType: Arbitrary {
	/// Create a generator of arbitrary ToOneRelationships that will all
	/// point to one of the given entities. This allows you to create
	/// arbitrary relationships that make sense in a broader context where
	/// the relationship must actually point to another entity.
	public static func arbitrary<E: ResourceObjectType>(givenEntities: [E]) -> Gen<ToOneRelationship<Identifiable, IdMetaType, MetaType, LinksType>> where E.Id == Identifiable.ID {

		return Gen.compose { c in
			let idGen = Gen.fromElements(of: givenEntities).map { $0.id }
			return .init(
                id: (c.generate(using: idGen), c.generate()),
                meta: c.generate(),
                links: c.generate()
            )
		}
	}
}

extension ToManyRelationship: Arbitrary where Relatable.ID: Arbitrary, IdMetaType: Arbitrary, MetaType: Arbitrary, LinksType: Arbitrary {
	public static var arbitrary: Gen<ToManyRelationship<Relatable, IdMetaType, MetaType, LinksType>> {
        let idWithMetaGen: Gen<ID> = Gen.compose { c in
            return .init(
                id: c.generate(),
                meta: c.generate()
            )
        }
        let idWithMetaArrayGen: Gen<[(Relatable.ID, IdMetaType)]> = idWithMetaGen
            .map { ($0.id, $0.meta) }
            .proliferate
		return Gen.compose { c in
			return .init(
                idsWithMetadata: c.generate(using: idWithMetaArrayGen),
                meta: c.generate(),
                links: c.generate()
            )
		}
	}
}

extension ToManyRelationship where IdMetaType: Arbitrary, MetaType: Arbitrary, LinksType: Arbitrary {
	/// Create a generator of arbitrary ToManyRelationships that will all
	/// point to some number of the given entities. This allows you to create
	/// arbitrary relationships that make sense in a broader context where
	/// the relationship must actually point to other existing entities.
	public static func arbitrary<E: ResourceObjectType>(givenEntities: [E]) -> Gen<ToManyRelationship<Relatable, IdMetaType, MetaType, LinksType>> where E.Id == Relatable.ID {
		return Gen.compose { c in

			let idsGen = Gen.zip(Gen.fromElements(of: givenEntities).map { $0.id }, IdMetaType.arbitrary)
                .proliferate
			return .init(
                idsWithMetadata: c.generate(using: idsGen),
                meta: c.generate(),
                links: c.generate()
            )
		}
	}
}

extension MetaRelationship: Arbitrary where MetaType: Arbitrary, LinksType: Arbitrary {
    public static var arbitrary: Gen<MetaRelationship<MetaType, LinksType>> {
        return Gen.compose { c in
            return .init(meta: c.generate(),
                         links: c.generate())
        }
    }
}
