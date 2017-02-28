// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_job;

import 'dart:async';
import 'dart:collection';
import 'package:jaguar/jaguar.dart';

part 'group.dart';

part 'jobs/after.dart';
part 'jobs/at.dart';
part 'jobs/periodic.dart';
part 'jobs/streamed.dart';
part 'jobs/until.dart';

const Duration _second = const Duration(seconds: 1);
const Duration _minute = const Duration(minutes: 1);
const Duration _halfHour = const Duration(minutes: 30);
const Duration _hour = const Duration(hours: 1);
const Duration _day = const Duration(days: 1);

class _Exec {
  Function _job;

  UnmodifiableListView<RouteWrapper> _wrappers;

  Future<Null> perform() async {
    _job(); //TODO implement properly
  }

  _Exec(this._job, this._wrappers);

  factory _Exec.make(Function job) {
    return new _Exec(job, new UnmodifiableListView([]));
  }
}

abstract class Job {
  String get name;

  bool hasFinished();

  bool isCancelled();

  bool hasStarted();

  Future<Duration> start();

  bool cancel();

  Duration nextExecutionIn();

  DateTime nextExecutionAt();

  static Job after(Duration duration, Function job) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller = new _AfterJob(id, name, duration, exec);

    return controller;
  }

  static Job afterAMinute(Function job) {
    return after(_minute, job);
  }

  static Job afterAnHour(Function job) {
    return after(_hour, job);
  }

  static Job afterADay(Function job) {
    return after(_day, job);
  }

  /// If no start delay is provided, execute it immediately
  static Job every(Duration duration, Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller = new _PeriodicJob(id, name, duration, exec,
        startDelay: startDelay, times: times);

    return controller;
  }

  static Job everySecond(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_second, job, startDelay: startDelay, times: times);
  }

  static Job everyFewSeconds(int seconds, Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(new Duration(seconds: seconds), job,
        startDelay: startDelay, times: times);
  }

  static Job everyMinute(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_minute, job, startDelay: startDelay, times: times);
  }

  static Job everyHalfHour(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_halfHour, job, startDelay: startDelay, times: times);
  }

  static Job everyHour(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_hour, job, startDelay: startDelay, times: times);
  }

  static Job everyDay(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_day, job, startDelay: startDelay, times: times);
  }

  static Job until(Duration duration, Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller =
        new _UntilJob(id, name, duration, exec, until, startDelay: startDelay);

    return controller;
  }

  static Job everySecondUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    return Job.until(_second, job, startDelay: startDelay, until: until);
  }

  static Job everyMinuteUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    return Job.until(_minute, job, startDelay: startDelay, until: until);
  }

  static Job everyHalfHourUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    return Job.until(_halfHour, job, startDelay: startDelay, until: until);
  }

  static Job everyHourUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    return Job.until(_hour, job, startDelay: startDelay, until: until);
  }

  static Job everyDayUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
    return Job.until(_day, job, startDelay: startDelay, until: until);
  }

  static Job at(DateTime time, Function job) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller = new _AtJob(id, name, time, exec);

    return controller;
  }

  static Job when<T>(Stream<T> stream, Function job) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller = new _StreamedJob<T>(id, name, stream, exec);

    return controller;
  }
}
