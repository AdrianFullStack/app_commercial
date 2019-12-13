import 'dart:convert';

QuoteList quoteListFromJson(String str) => QuoteList.fromJson(json.decode(str));

String quoteListToJson(QuoteList data) => json.encode(data.toJson());

class QuoteList {
    String reference;
    String client;
    int state;
    String createdAt;
    String expiryDate;
    String expiryDateToString;
    String origin;
    String destiny;
    String aliasPortOrigin;
    String aliasPortDestiny;
    String product;
    int expiryInDays;
    AllObservations allObservations;

    QuoteList({
        this.reference,
        this.client,
        this.state,
        this.createdAt,
        this.expiryDate,
        this.expiryDateToString,
        this.origin,
        this.destiny,
        this.aliasPortOrigin,
        this.aliasPortDestiny,
        this.product,
        this.allObservations,
        this.expiryInDays
    });

    factory QuoteList.fromJson(Map<String, dynamic> json) => QuoteList(
        reference: json["reference"],
        client: json["client"],
        state: json["state"],
        createdAt: json["created_at"],
        expiryDate: json["expiry_date"],
        expiryDateToString: json["expiry_date_to_string"],
        origin: json["origin"],
        destiny: json["destiny"],
        aliasPortOrigin: json["alias_port_origin"],
        aliasPortDestiny: json["alias_port_destiny"],
        product: json["product"],
        allObservations: AllObservations.fromJson(json["all_observations"]),
        expiryInDays: 0
    );

    Map<String, dynamic> toJson() => {
        "reference": reference,
        "client": client,
        "state": state,
        "created_at": createdAt,
        "expiry_date": expiryDate,
        "expiry_date_to_string": expiryDateToString,
        "origin": origin,
        "destiny": destiny,
        "alias_port_origin": aliasPortOrigin,
        "alias_port_destiny": aliasPortDestiny,
        "product": product,
        "all_observations": allObservations.toJson(),
        "expiry_in_days": expiryInDays
    };
}

class AllObservations {
    String observation;
    Language internationalTransport;
    Language expensesOrigin;
    Language expensesDestination;
    Language additionalServices;
    Language tax;

    AllObservations({
        this.observation,
        this.internationalTransport,
        this.expensesOrigin,
        this.expensesDestination,
        this.additionalServices,
        this.tax,
    });

    factory AllObservations.fromJson(Map<String, dynamic> json) => AllObservations(
        observation: json["observation"],
        internationalTransport: Language.fromJson(json["international_transport"]),
        expensesOrigin: Language.fromJson(json["expenses_origin"]),
        expensesDestination: Language.fromJson(json["expenses_destination"]),
        additionalServices: Language.fromJson(json["additional_services"]),
        tax: Language.fromJson(json["tax"]),
    );

    Map<String, dynamic> toJson() => {
        "observation": observation,
        "international_transport": internationalTransport.toJson(),
        "expenses_origin": expensesOrigin.toJson(),
        "expenses_destination": expensesDestination.toJson(),
        "additional_services": additionalServices.toJson(),
        "tax": tax.toJson(),
    };
}

class Language {
    String es;
    String en;

    Language({
        this.es,
        this.en,
    });

    factory Language.fromJson(Map<String, dynamic> json) => Language(
        es: json["es"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "es": es,
        "en": en,
    };
}
