using { aldiiisey.db as db} from '../db/schema';

service GalaxyService @(requires: 'authenticated-user') {
    entity Spaceships as select from db.Spaceships {
        *,
        null as capacity: Integer // => should be a function of ShipClass
    }

    entity Spacefarers as select from db.Spacefarers {
        *,
        spaceship.uniform.color as spaceSuitColor: String
    }

    entity SpaceCompanies as projection on db.SpaceCompanies;
}

annotate GalaxyService.Spacefarers with @(restrict: [
  { grant: 'READ', to: 'Admin' },
  { grant: ['CREATE','UPDATE','DELETE'], to: 'Admin' },
  { grant: ['UPDATE','DELETE'], to: 'authenticated-user',
    where: 'ID = $user.id' }
]);