using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Cliente1}',
                Value : customer_ID,
            },
            // CAMPOS NUEVOS EN EL FORMULARIO
            {
                $Type : 'UI.DataField',
                Value : creationDate,
                Label : 'Fecha de Creación',
            },
            {
                $Type : 'UI.DataField',
                Value : resolutionDate,
                Label : 'Fecha de Resolución',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>DescripcinGeneral}',
            ID : 'i18nDescripcinGeneral',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    ID : 'GeneratedFacet1',
                    Label : '{i18n>InformacinGeneral}',
                    Target : '@UI.FieldGroup#GeneratedGroup',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Detalles}',
                    ID : 'i18nDetalles',
                    Target : '@UI.FieldGroup#i18nDetalles',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversacin}',
            ID : 'i18nConversacin',
            Target : 'conversation/@UI.LineItem#i18nConversacin',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Ttulo}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Cliente}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Estado}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgencia1}',
        },
        // CAMPOS NUEVOS EN LA TABLA
        {
            $Type : 'UI.DataField',
            Value : creationDate,
            Label : 'Fecha Creación',
        },
        {
            $Type : 'UI.DataField',
            Value : resolutionDate,
            Label : 'Fecha Resolución',
        },
    ],
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '{i18n>SapAura}',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.FieldGroup #i18nDetalles : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
            },
        ],
    },
);

annotate service.Incidents with {
    customer @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.Text : customer.name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Incidents with {
    status @(
        Common.Label : '{i18n>Status}',
        Common.ValueListWithFixedValues : true,
        Common.Text : status.descr,
    )
};

annotate service.Incidents with {
    urgency @(
        Common.Label : '{i18n>Urgencia}',
        Common.ValueListWithFixedValues : true,
        Common.Text : urgency.descr,
    )
};

annotate service.Status with {
    code @Common.Text : descr
};

annotate service.Urgency with {
    code @Common.Text : descr
};

annotate service.Incidents.conversation with @(
    UI.LineItem #i18nConversacin : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : '{i18n>Autor}',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Mensaje}',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>Fecha}',
        },
    ]
);