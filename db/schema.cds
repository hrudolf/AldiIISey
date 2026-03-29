using {
    cuid,
    managed,
    sap.common.Languages
} from '@sap/cds/common';

namespace aldiiisey.db;

@assert.range
type ShipClass    : String enum {
    Transporter;
    Corvette;
    Frigate;
    Cruiser;
    Battlecruiser;
    Battleship;
    Aurora;
}

entity SpacefarerLanguages : cuid {
    employee : Association to Spacefarers;
    language : Association to Languages;
    level    : String; // optional (e.g. basic, fluent)
}

entity Spacefarers : cuid, managed {
    firstName          : String;
    lastName           : String;
    languages          : Association to many SpacefarerLanguages
                             on languages.employee = $self;
    rank               : Association to Ranks;
    spaceship          : Association to Spaceships;
    starDustCollection : Integer;
    traveledDistance   : Decimal(9, 2);
    birthDay           : Date;
    originPlanet       : Association to Planets;
    email              : String(50) @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
}

entity Planets : cuid, managed {
    name        : String;
    description : String;
}

type UniformColor : String enum {
    red;
    blue;
    green;
    yellow;
    white;
    black;
    purple;
    gray;
    orange;
}

entity Spaceships : cuid, managed {
    name            : String;
    shipClass       : ShipClass;
    captain         : Association to Spacefarers;
    crew            : Association to many Spacefarers
                          on crew.spaceship = $self;
    uniform         : UniformColor;
    currentLocation : Association to Planets;
}

entity Ranks {
    key code : Rank;
        i18n : localized String;
}

type Rank         : String enum {
    captain = 'captain';
    senior = 'senior';
    medior = 'medior';
    junior = 'junior';
    candidate = 'candidate';
}
