class ProductsModel {
  String? status;
  Meta? meta;
  List<Data>? data;

  ProductsModel({this.status, this.meta, this.data});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

    if (json['data'] != null) {
      data = (json['data'] as List).map((v) => Data.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};

    result['status'] = status;

    if (meta != null) {
      result['meta'] = meta!.toJson();
    }

    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }

    return result;
  }
}

class Meta {
  String? title;
  String? description;
  String? copyright;
  String? generated;
  int? count;

  Meta({
    this.title,
    this.description,
    this.copyright,
    this.generated,
    this.count,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    copyright = json['copyright'];
    generated = json['generated'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'copyright': copyright,
      'generated': generated,
      'count': count,
    };
  }
}

class Data {
  int? id;
  String? name;
  String? tagline;
  String? description;
  String? price;
  String? currency;
  String? image;
  Specs? specs;

  Data({
    this.id,
    this.name,
    this.tagline,
    this.description,
    this.price,
    this.currency,
    this.image,
    this.specs,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    description = json['description'];
    price = json['price'];
    currency = json['currency'];
    image = json['image'];

    specs = json['specs'] != null ? Specs.fromJson(json['specs']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs?.toJson(),
    };
  }
}

class Specs {
  String? chip;
  String? material;
  String? camera;
  String? display;
  String? battery;
  String? id;
  String? ports;
  String? weight;
  String? design;
  String? colors;
  String? screen;
  String? pencil;
  String? connectivity;
  String? phoneCase;
  String? brightness;
  String? gps;
  String? feature;
  String? carbon;
  String? os;
  String? control;
  String? audio;
  String? driver;
  String? cancellation;
  String? materials;
  String? home;
  String? sensing;
  String? size;

  Specs({
    this.chip,
    this.material,
    this.camera,
    this.display,
    this.battery,
    this.id,
    this.ports,
    this.weight,
    this.design,
    this.colors,
    this.screen,
    this.pencil,
    this.connectivity,
    this.phoneCase,
    this.brightness,
    this.gps,
    this.feature,
    this.carbon,
    this.os,
    this.control,
    this.audio,
    this.driver,
    this.cancellation,
    this.materials,
    this.home,
    this.sensing,
    this.size,
  });

  Specs.fromJson(Map<String, dynamic> json) {
    chip = json['chip'];
    material = json['material'];
    camera = json['camera'];
    display = json['display'];
    battery = json['battery'];
    id = json['id'];
    ports = json['ports'];
    weight = json['weight'];
    design = json['design'];
    colors = json['colors'];
    screen = json['screen'];
    pencil = json['pencil'];
    connectivity = json['connectivity'];
    phoneCase = json['case'];
    brightness = json['brightness'];
    gps = json['gps'];
    feature = json['feature'];
    carbon = json['carbon'];
    os = json['os'];
    control = json['control'];
    audio = json['audio'];
    driver = json['driver'];
    cancellation = json['cancellation'];
    materials = json['materials'];
    home = json['home'];
    sensing = json['sensing'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    return {
      'chip': chip,
      'material': material,
      'camera': camera,
      'display': display,
      'battery': battery,
      'id': id,
      'ports': ports,
      'weight': weight,
      'design': design,
      'colors': colors,
      'screen': screen,
      'pencil': pencil,
      'connectivity': connectivity,
      'case': phoneCase,
      'brightness': brightness,
      'gps': gps,
      'feature': feature,
      'carbon': carbon,
      'os': os,
      'control': control,
      'audio': audio,
      'driver': driver,
      'cancellation': cancellation,
      'materials': materials,
      'home': home,
      'sensing': sensing,
      'size': size,
    };
  }
}
