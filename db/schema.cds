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
    email     : String;
}

entity Spacefarers : SpaceshipOwners {
    firstName : String;
    lastName  : String;
    languages : Composition of many Languages on languages.code;
    origin    : Locations;
    rank      : Ranks;
    spaceship : Association to Spaceships;
}

entity Companies : SpaceshipOwners {
    legalName : String;
}

type Uniform {
    type  : String;
    color : String;
}

type Locations {
    type: String;
    name: String;
}

entity Spaceships : cuid, managed {
    name      : String;
    shipClass : ShipClass;
    captain   : Association to Spacefarers;
    crew      : Association to many Spacefarers on crew.spaceship = $self;
    owner     : Association to SpaceshipOwners;
    uniform   : Uniform;
}

@assert.range
type Ranks : String enum {
    Candidate;
    Junior;
    Medior;
    Senior;
    Captain;
}
