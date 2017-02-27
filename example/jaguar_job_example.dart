// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:mongo_dart/mongo_dart.dart' as mgo;
import 'package:jaguar_mongo/jaguar_mongo.dart';
import 'package:jaguar_job/jaguar_job.dart';

const String mongoUrl = '';

@WrapMongoDb(mongoUrl)
Future<Null> job1(@Input(MongoDb) mgo.Db db) async {
  print("hello");
}

main() {
  final manager = new JobManager();
  JobController controller = manager.everyMinute(job1);
}
