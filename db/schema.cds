using {
    cuid,
    managed,
    sap.common.Languages
} from '@sap/cds/common';

namespace aldiiisey.db;

@assert.range
type ShipClass : String enum {
    Transporter;
    Corvette;
    Frigate;
    Cruiser;
    Battlecruiser;
    Battleship;
    Aurora;
}

entity SpaceshipOwners : cuid, managed {
    originPlanet    : String;
    email           : String;
    ownedSpaceships : Association to many Spaceships
                          on ownedSpaceships.owner = $self;
}

entity SpacefarerLanguages : cuid {
    employee : Association to Spacefarers;
    language : Association to Languages;
    level    : String; // optional (e.g. basic, fluent)
}

entity Spacefarers : SpaceshipOwners {
    firstName          : String;
    lastName           : String;
    languages          : Association to many SpacefarerLanguages
                             on languages.employee = $self;
    rank               : Ranks;
    spaceship          : Association to Spaceships;
    starDustCollection : Integer;
}

entity SpaceCompanies : SpaceshipOwners {
    legalName : String;
}

type Uniform {
    type  : String;
    color : String;
}

entity Spaceships : cuid, managed {
    name      : String;
    shipClass : ShipClass;
    captain   : Association to Spacefarers;
    crew      : Composition of many Spacefarers
                    on crew.spaceship = $self;
    owner     : Association to SpaceshipOwners;
    uniform   : Uniform;
}

@assert.range
type Ranks     : String enum {
    Candidate;
    Junior;
    Medior;
    Senior;
    Captain;
}
