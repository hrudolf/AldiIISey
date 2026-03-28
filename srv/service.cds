using { aldiiisey.db as db} from '../db/schema';

service GalaxyService {
    entity Spaceships as select from  db.Spaceships {
        *,
        null as capacity: Integer // => should be a function of ShipClass
    }
    entity Spacefarers as select from db.Spacefarers {
        *,
        null as uniformColor: String // TODO: fill up later in service, https://community.sap.com/t5/technology-blog-posts-by-sap/computed-field-example-in-cap/ba-p/13408603
    }
}