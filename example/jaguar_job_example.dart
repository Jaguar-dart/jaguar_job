// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';
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

main() async {
  /* TODO
  final manager = new JobManager();
  Job controller = manager.everyMinute(job1);
  */

  int number = 0;

  Job job = Job.everyFewSeconds(10, () {
    print("Hello $number");
    number++;
  });

  print("Starting job...");
  job.start();

  await new Future.delayed(new Duration(seconds: 30), () {
    job.cancel();
    print("Stopped job!");
  });

  await new Future.delayed(new Duration(minutes: 1), () {});

  exit(0);
}
