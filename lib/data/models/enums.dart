enum OrderOption {
  asc("Ascending", "asc"),
  desc("Descending", "desc");

  final String displayName;
  final String value;
  const OrderOption(this.displayName, this.value);
}

enum SortOption {
  reputation("Reputation", "reputation"),
  creationDate("Creation Date", "creation"),
  name("Name", "name"),
  lastModifiedDate("Last Modified Date", "modified");

  final String displayName;
  final String value;
  const SortOption(this.displayName, this.value);
}
