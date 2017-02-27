// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'package:jaguar/jaguar.dart';

class _Exec {
  UnmodifiableListView<RouteWrapper> _wrappers;

  Function _job;

  Future<Null> perform() {

  }
}

class _PeriodicJob implements JobController {
  String get id;

  String get name;

  final Duration startDelay;

  final Duration interval;

  final int times;

  final DateTime until;

  _Exec exec;

  Future<bool> hasFinished() {}

  Future<bool> isCancelled() {}

  Future<bool> cancel() {}

  Future<Duration> start() async {
    new Timer.periodic(interval, (_) async {
      //TODO
      await exec.perform();
    });
  }
}

abstract class JobController {
  Future<bool> hasFinished();

  Future<bool> isCancelled();

  Future<bool> cancel();

  Duration nextExecutionIn();

  DateTime nextExecutionAt();
}

class JobManager {
  FutureOr<JobController> after(Duration duration, Function job) {}

  FutureOr<JobController> afterAMinute(Function job) {}

  FutureOr<JobController> afterAnHour(Function job) {}

  FutureOr<JobController> afterADay(Function job) {}

  FutureOr<JobController> every(Duration duration, Function job,
      {Duration startDelay, int times, DateTime until}) {
    //TODO
  }

  FutureOr<JobController> everySecond(Function job,
      {Duration startDelay, int times, DateTime until}) {}

  FutureOr<JobController> everyMinute(Function job,
      {Duration startDelay, int times, DateTime until}) {}

  FutureOr<JobController> everyHalfHour(Function job,
      {Duration startDelay, int times, DateTime until}) {}

  FutureOr<JobController> everyHour(Function job,
      {Duration startDelay, int times, DateTime until}) {}

  FutureOr<JobController> everyDay(Function job,
      {Duration startDelay, int times, DateTime until}) {}

  FutureOr<JobController> at(DateTime time, Function job) {}

  FutureOr<JobController> when(Stream stream, Function job) {}

  void start() {

  }

  void stop() {

  }
}
