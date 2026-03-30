using GalaxyService as service from '../../srv/service';
using from '@sap/cds/common';

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
                Value : rank_code,
                Label : '{i18n>Rank}',
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
                Value : originPlanet_ID,
                Label : '{i18n>OriginPlanet}',
            },
            {
                $Type : 'UI.DataField',
                Value : spaceship_ID,
                Label : '{i18n>Spaceship}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'GalaxyService.travel',
                Label : '{i18n>Travel}',
                @UI.Hidden : {$edmJson:{$If: [{$Ne: [{$Path: 'rank_code'}, 'captain']}, true, false]}}
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>SystemFields}',
            ID : 'AutoFields',
            Target : '@UI.FieldGroup#AutoFields',
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
            Value : lang_code,
            Label : '{i18n>Language}',
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
        TypeImageUrl: {$edmJson:{$If: [{$Eq: [{$Path: 'rank_code'}, 'captain']}, 'sap-icon://badge', 'sap-icon://employee']}}
    },
    UI.SelectionFields : [
        spaceship.name,
        rank.i18n,
        originPlanet_ID,
        starDustCollection,
    ],
    UI.FieldGroup #AutoFields : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
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
        ],
    },
);

annotate service.Spacefarers with {
    traveledDistance @(
        Common.Label : '{i18n>TraveledDistance}',
        Common.FieldControl : #ReadOnly,
    );
    starDustCollection @(
        Common.Label : '{i18n>StarDustCollection}',
        Common.FieldControl : #ReadOnly,
    );
    birthDay @(
        Common.Label : '{i18n>Birthday}',
        Common.FieldControl : #Optional,
    );
    firstName @(
        Common.Label : '{i18n>FirstName}',
        Common.FieldControl : #Mandatory,
    );
    lastName @(
        Common.Label : '{i18n>LastName}',
        Common.FieldControl : #Mandatory,
    );
    email @(
        Common.Label : '{i18n>Email}',
        Common.FieldControl : #Mandatory,
    );
    spaceSuitColor @(
        UI.HiddenFilter,
        Common.Label : '{i18n>SpaceSuitColor}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'UniformColors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : spaceSuitColor,
                    ValueListProperty : spaceship.i18n,
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #ReadOnly,
        Common.Text : spaceship.uniform_code,
        Common.Text.@UI.TextArrangement : #TextOnly,
    );
    shipAndRank @UI.HiddenFilter;
    fullName @UI.HiddenFilter;
    rank @(
        UI.HiddenFilter,
        Common.Text : rank.i18n,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Ranks',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : rank_code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
    );
    spaceship @(
        UI.HiddenFilter,
        Common.Text : spaceship.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Spaceships',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : spaceship_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.FieldControl : #Mandatory,
    );
    originPlanet @(
        Common.Text : originPlanet.name,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Planets',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : originPlanet_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.FieldControl : #Mandatory,
        Common.Label : '{i18n>OriginPlanet}',
    );
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
        Common.FieldControl : #Mandatory,
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

annotate service.Planets with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
    )
};

annotate service.Spaceships with {
    ID @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};

annotate service.Ranks with {
    code @(
        Common.Text : i18n,
        Common.Text.@UI.TextArrangement : #TextOnly,
)};
annotate service.Spaceships with {
    uniform @(
        Common.Label : '{i18n>SpaceSuitColor}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'UniformColors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : uniform_code,
                    ValueListProperty : 'i18n',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.ExternalID : uniform.code,
    )
};

annotate service.Spacefarers with {
    lang @(
        Common.Text : lang.name,
        )
};

