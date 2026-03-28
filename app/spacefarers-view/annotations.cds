using GalaxyService as service from '../../srv/service';
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'firstName',
                Value : firstName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'lastName',
                Value : lastName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'rank',
                Value : rank,
            },
            {
                $Type : 'UI.DataField',
                Label : 'starDustCollection',
                Value : starDustCollection,
            },
            {
                $Type : 'UI.DataField',
                Label : 'salary',
                Value : salary,
            },
            {
                $Type : 'UI.DataField',
                Label : 'birthDay',
                Value : birthDay,
            },
            {
                $Type : 'UI.DataField',
                Label : 'originPlanet',
                Value : originPlanet,
            },
            {
                $Type : 'UI.DataField',
                Label : 'email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'spaceSuitColor',
                Value : spaceSuitColor,
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
            Label : 'firstName',
            Value : firstName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'lastName',
            Value : lastName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'rank',
            Value : rank,
        },
        {
            $Type : 'UI.DataField',
            Label : 'starDustCollection',
            Value : starDustCollection,
        },
        {
            $Type : 'UI.DataField',
            Label : 'salary',
            Value : salary,
        },
    ],
);

annotate service.Spacefarers with {
    spaceship @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Spaceships',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : spaceship_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'shipClass',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'uniform_type',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'uniform_color',
            },
        ],
    }
};

