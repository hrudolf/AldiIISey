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

entity Spacefarers : cuid, managed {
    firstName                 : String(32);
    lastName                  : String(32);
    rank                      : Association to Ranks;
    spaceship                 : Association to Spaceships;
    starDustCollection        : Integer;
    traveledDistance          : Decimal(9, 2);
    birthDay                  : Date;
    lang                      : Association to Languages;
    originPlanet              : Association to Planets;
    email                     : String(50) @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    virtual spaceSuitColor    : String(16);
    virtual fullName          : String;
    virtual shipAndRank       : String;
    virtual hideTravelAction  : Boolean;
}

entity Planets : cuid, managed {
    name        : String(16);
    description : String;
}

type UniformColor : String(16) enum {
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
    name             : String(32);
    shipClass        : ShipClass;
    captain          : Association to Spacefarers;
    crew             : Association to many Spacefarers
                           on crew.spaceship = $self;
    uniform          : Association to UniformColors;
    currentLocation  : Association to Planets;
    virtual capacity : Integer;
}

entity Ranks {
    key code : Rank;
        i18n : localized String(16);
}

entity UniformColors {
    key code : UniformColor;
        i18n : localized String(16);
}

type Rank         : String(16) enum {
    captain = 'captain';
    senior = 'senior';
    medior = 'medior';
    junior = 'junior';
    candidate = 'candidate';
}
