part of jaguar_job;

/* TODO
class JobGroup {
  final Map<String, Job> _jobs = {};

  String after(Duration duration, Function job) {
    //TODO
  }

  String afterAMinute(Function job) {
    return after(_minute, job);
  }

  String afterAnHour(Function job) {
    return after(_hour, job);
  }

  String afterADay(Function job) {
    return after(_day, job);
  }

  /// If no start delay is provided, execute it immediately
  String every(Duration duration, Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    final String id = '';
    final String name = '';
    final exec = new _Exec.make(job);

    final controller = new _PeriodicJob(id, name, duration, exec,
        startDelay: startDelay, times: times);

    _jobs[id] = controller;

    return id;
  }

  String everySecond(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_second, job, startDelay: startDelay, times: times);
  }

  String everyMinute(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_minute, job, startDelay: startDelay, times: times);
  }

  String everyHalfHour(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_halfHour, job, startDelay: startDelay, times: times);
  }

  String everyHour(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_hour, job, startDelay: startDelay, times: times);
  }

  String everyDay(Function job,
      {Duration startDelay: Duration.ZERO, int times}) {
    return every(_day, job, startDelay: startDelay, times: times);
  }

  /* TODO
  String until(Duration duration, Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String everySecondUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String everyMinuteUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String everyHalfHourUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String everyHourUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String everyDayUntil(Function job,
      {Duration startDelay: Duration.ZERO, DateTime until}) {
  }

  String at(DateTime time, Function job) {
  }
  */

  String when(Stream stream, Function job) {
  }

  Future<Null> start() async {
    for (Job job in _jobs.values) {
      await job.start();
    }
  }

  Future<Null> cancelAll() async {
    for (Job job in _jobs.values) {
      await job.cancel();
    }
  }
}
*/