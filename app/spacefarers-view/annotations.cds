using GalaxyService as service from '../../srv/service';
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>FirstName}',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>LastName}',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Rank}',
                Value : rank.i18n,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>StarDustCollection}',
                Value : starDustCollection,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>TraveledDistance}',
                Value : traveledDistance,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Birthday}',
                Value : birthDay,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>OriginPlanet}',
                Value : originPlanet.name,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Email}',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>SpaceSuitColor}',
                Value : spaceSuitColor,
            },
            {
                $Type : 'UI.DataField',
                Value : spaceship.name,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : '{i18n>ID}',
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>LastName}',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>FirstName}',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Email}',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Value : spaceship.name,
            Label : '{i18n>Spaceship}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Rank}',
            Value : rank.i18n
        },
        {
            $Type : 'UI.DataField',
            Value : spaceSuitColor,
            Label : '{i18n>SpaceSuitColor}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>StarDustCollection}',
            Value : starDustCollection,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>TraveledDistance}',
            Value : traveledDistance,
        },
        {
            $Type : 'UI.DataField',
            Value : originPlanet.name,
            Label : '{i18n>OriginPlanet}',
        },
        {
            $Type : 'UI.DataField',
            Value : birthDay,
            Label : '{i18n>Birthday}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : modifiedBy,
        },
        {
            $Type : 'UI.DataField',
            Value : shipAndRank,
            Label : 'shipAndRank',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : fullName,
            Label : 'fullName',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : originPlanet_ID,
            Label : 'originPlanet_ID',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : rank_code,
            Label : 'rank_code',
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Value : spaceship_ID,
            Label : 'spaceship_ID',
            @UI.Hidden,
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>Spacefarer}',
        TypeNamePlural : '{i18n>Spacefarers}',
        Title : {
            $Type : 'UI.DataField',
            Value : fullName,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : shipAndRank,
        },
    },
    UI.SelectionFields : [
        spaceship.name,
        rank.i18n,
        starDustCollection,
        originPlanet.name,
    ],
);

annotate service.Spacefarers with {
    traveledDistance @Common.Label : '{i18n>TraveledDistance}';
    starDustCollection @Common.Label : '{i18n>StarDustCollection}';
    birthDay @Common.Label : '{i18n>Birthday}';
    firstName @Common.Label : '{i18n>FirstName}';
    lastName @Common.Label : '{i18n>LastName}';
    email @Common.Label : '{i18n>Email}';
    spaceSuitColor @(
        Common.Label : '{i18n>SpaceSuitColor}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'UniformColors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : spaceSuitColor,
                    ValueListProperty : 'i18n',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    );
    shipAndRank @UI.HiddenFilter;
    fullName @UI.HiddenFilter;
    rank @UI.HiddenFilter;
    spaceship @UI.HiddenFilter;
    originPlanet @UI.HiddenFilter;
}

annotate service.Spaceships with {
    name @(
        Common.Label : '{i18n>Spaceship}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Spaceships',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        )
};

annotate service.Ranks with {
    i18n @(
        Common.Label : '{i18n>Rank}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Ranks',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : i18n,
                    ValueListProperty : 'i18n',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};
annotate service.Planets with {
    name @(
        Common.Label : '{i18n>OriginPlanet}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Planets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

