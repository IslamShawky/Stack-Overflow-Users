class UsersResponseModel {
  List<User>? users;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  UsersResponseModel({
    this.users,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  UsersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      users = <User>[];
      json['items'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.users != null) {
      data['items'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this.hasMore;
    data['quota_max'] = this.quotaMax;
    data['quota_remaining'] = this.quotaRemaining;
    return data;
  }
}

class User {
  BadgeCounts? badgeCounts;
  int? accountId;
  bool? isEmployee;
  int? lastModifiedDate;
  int? lastAccessDate;
  int? reputationChangeYear;
  int? reputationChangeQuarter;
  int? reputationChangeMonth;
  int? reputationChangeWeek;
  int? reputationChangeDay;
  int? reputation;
  int? creationDate;
  String? userType;
  int? userId;
  int? acceptRate;
  String? location;
  String? websiteUrl;
  String? link;
  String? profileImage;
  String? displayName;

  User({
    this.badgeCounts,
    this.accountId,
    this.isEmployee,
    this.lastModifiedDate,
    this.lastAccessDate,
    this.reputationChangeYear,
    this.reputationChangeQuarter,
    this.reputationChangeMonth,
    this.reputationChangeWeek,
    this.reputationChangeDay,
    this.reputation,
    this.creationDate,
    this.userType,
    this.userId,
    this.acceptRate,
    this.location,
    this.websiteUrl,
    this.link,
    this.profileImage,
    this.displayName,
  });

  User.fromJson(Map<String, dynamic> json) {
    badgeCounts = json['badge_counts'] != null
        ? BadgeCounts.fromJson(json['badge_counts'])
        : null;
    accountId = json['account_id'];
    isEmployee = json['is_employee'];
    lastModifiedDate = json['last_modified_date'];
    lastAccessDate = json['last_access_date'];
    reputationChangeYear = json['reputation_change_year'];
    reputationChangeQuarter = json['reputation_change_quarter'];
    reputationChangeMonth = json['reputation_change_month'];
    reputationChangeWeek = json['reputation_change_week'];
    reputationChangeDay = json['reputation_change_day'];
    reputation = json['reputation'];
    creationDate = json['creation_date'];
    userType = json['user_type'];
    userId = json['user_id'];
    acceptRate = json['accept_rate'];
    location = json['location'];
    websiteUrl = json['website_url'];
    link = json['link'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.badgeCounts != null) {
      data['badge_counts'] = this.badgeCounts!.toJson();
    }
    data['account_id'] = this.accountId;
    data['is_employee'] = this.isEmployee;
    data['last_modified_date'] = this.lastModifiedDate;
    data['last_access_date'] = this.lastAccessDate;
    data['reputation_change_year'] = this.reputationChangeYear;
    data['reputation_change_quarter'] = this.reputationChangeQuarter;
    data['reputation_change_month'] = this.reputationChangeMonth;
    data['reputation_change_week'] = this.reputationChangeWeek;
    data['reputation_change_day'] = this.reputationChangeDay;
    data['reputation'] = this.reputation;
    data['creation_date'] = this.creationDate;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['accept_rate'] = this.acceptRate;
    data['location'] = this.location;
    data['website_url'] = this.websiteUrl;
    data['link'] = this.link;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    return data;
  }
}

class BadgeCounts {
  int? bronze;
  int? silver;
  int? gold;

  BadgeCounts({this.bronze, this.silver, this.gold});

  BadgeCounts.fromJson(Map<String, dynamic> json) {
    bronze = json['bronze'];
    silver = json['silver'];
    gold = json['gold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bronze'] = this.bronze;
    data['silver'] = this.silver;
    data['gold'] = this.gold;
    return data;
  }
}
