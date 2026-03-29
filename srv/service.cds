using { aldiiisey.db as db} from '../db/schema';

service GalaxyService @(requires: 'authenticated-user') {
    entity Planets as projection on db.Planets;
    entity Ranks as projection on db.Ranks;
    entity Spaceships as projection on db.Spaceships;
    entity Spacefarers as projection on db.Spacefarers;
    entity UniformColors as projection on db.UniformColors;
}

annotate GalaxyService.Spacefarers with @(
    restrict: [
  { grant: 'READ', to: 'authenticated-user' },
  { grant: ['CREATE','UPDATE','DELETE'], to: 'Admin' },
  { grant: ['UPDATE','DELETE'], to: 'authenticated-user',
    where: 'ID = $user.spacefarer_ID' }
    ],
    odata.draft.enabled
);