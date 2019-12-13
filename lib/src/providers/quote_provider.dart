import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_acciona/src/models/quote_list.dart';
import 'package:quote_acciona/src/utils/utils.dart' as utils;

class QuoteProvider {
  Future<List<QuoteList>> loadQuotes() async {
    final url = 'http://10.19.98.54:4000/api-v2/cotizaciones?attributes=cotizacionid,v_est_cot:state,f_creacion:created_at,v_referencia:reference,expiry_date,expiry_date:expiry&filters[comercialid]=7682&filters[companyid]=2&sort=cotizacionid:desc&with[detalle][attributes]=detalleid, cotizacionid&with[detalle][with][dato][attributes]=datosid, detalleid,v_cliente:client,v_puertoorigen:origin,v_puertodestino:destiny,v_producto:product,comercial,all_observations,alias_port_origin,alias_port_destiny';
    final resp = await http.get(url);

    final List<dynamic> decodeData = json.decode(resp.body);
    final List<QuoteList> data = new List();

    decodeData.forEach((item) {
      final dataTemp = new QuoteList();
      dataTemp.reference = item['reference'] != null ? item['reference'] : 'SIN REFERENCIA'; 
      dataTemp.expiryDateToString = item['expiry_date_to_string']; 
      dataTemp.expiryDate = item['expiry'];
      dataTemp.state = num.parse(item['state']); 
      dataTemp.client = item['detalle']['dato']['client'];
      dataTemp.origin = item['detalle']['dato']['origin'];
      dataTemp.destiny = item['detalle']['dato']['destiny'];
      dataTemp.product = item['detalle']['dato']['product'];
      dataTemp.expiryInDays = dataTemp.expiryDate != null ? utils.differenceDates(dataTemp.expiryDate) : 0;
      //dataTemp.allObservations = AllObservations.fromJson(item['detalle']['dato']['all_observations']);
      data.add(dataTemp);
    });

    print(data);

    return data;
  }
}