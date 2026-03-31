using { aldiiisey.db as db} from '../db/schema';

service GalaxyService @(requires: 'authenticated-user') {
    entity Planets as projection on db.Planets;
    entity Ranks as projection on db.Ranks;
    entity Spaceships as projection on db.Spaceships;
    entity Spacefarers as projection on db.Spacefarers actions {
        @(Common.SideEffects: {TargetProperties: ['starDustCollection', 'traveledDistance']})
        @(requires: ['rank-captain', 'Admin', 'admin']) action travel();
    };
    entity UniformColors as projection on db.UniformColors;
}

annotate GalaxyService.Spacefarers with @(
    restrict: [
        { grant: 'READ', to: 'authenticated-user' },
        { grant: ['CREATE','UPDATE','DELETE'], to: 'Admin' },
        { grant: ['UPDATE','DELETE'], to: 'authenticated-user',
            where: 'ID = $user.spacefarer_ID' },
        // Captain can update their own spacefarers
        { grant: ['UPDATE'], to: 'rank-captain' },
        { grant: ['UPDATE','DELETE'], to: 'authenticated-user',
            where: 'ID = $user.spacefarer_ID' },
        { grant: ['travel'], to: 'Admin' },
        { grant: ['travel'], to: 'rank-captain' },
    ],
    odata.draft.enabled
);