import 'package:flutter/material.dart';

class ListAnime{
  final String name;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const ListAnime({
    @required this.name,
    @required this.cover,
    @required this.detail,
  });

  ListAnime copyWith({
    String name,
    String cover,
    String detail,
  }) {
    if ((name == null || identical(name, this.name)) &&
        (cover == null || identical(cover, this.cover)) &&
        (detail == null || identical(detail, this.detail))) {
      return this;
    }

    return new ListAnime(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      detail: detail ?? this.detail,
    );
  }

  @override
  String toString() {
    return 'listAnime{name: $name, cover: $cover, detail: $detail}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListAnime &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          cover == other.cover &&
          detail == other.detail);

  @override
  int get hashCode => name.hashCode ^ cover.hashCode ^ detail.hashCode;

  factory ListAnime.fromMap(Map<String, dynamic> map) {
    return new ListAnime(
      name: map['name'] as String,
      cover: map['cover'] as String,
      detail: map['detail'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'cover': this.cover,
      'detail': this.detail,
    } as Map<String, dynamic>;
  }

  //</editor-fold>

  final String cover;
  final String detail;
}