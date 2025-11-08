class Assets {
  static const _icons = _Icons();
  static const _Images _images = _Images();

  // ignore: library_private_types_in_public_api
  static _Icons get icons => _icons;

  // ignore: library_private_types_in_public_api
  static _Images get images => _images;
}

class _Icons {
  const _Icons();
  final String fav = "assets/icons/fav.svg";
  final String more = "assets/icons/more.svg";
  final String search = "assets/icons/search.svg";
  final String updates = "assets/icons/updates.svg";
  final String sort = "assets/icons/sort.svg";
  final String filter = "assets/icons/filter.svg";
  final String call = "assets/icons/call.svg";
  final String whatsapp = "assets/icons/whatsapp.svg";
  final String zoom = "assets/icons/zoom.svg";
  final String bed = "assets/icons/bed.svg";
  final String bath = "assets/icons/bath.svg";
  final String area = "assets/icons/area.svg";
}

class _Images {
  const _Images();

  final String advertising = "assets/images/advertising.png";
  final String background = "assets/images/background.png";
}
