part of jaguar_job;

class _AfterJob implements Job {
  final String id;

  final String name;

  final Duration after;

  final _Exec exec;

  _AfterJob(this.id, this.name, this.after, this.exec);

  bool hasFinished() => _finished;

  bool isCancelled() => _cancelled;

  bool hasStarted() => _started;

  Timer _delayTimer;

  bool _started = false;

  bool _cancelled = false;

  int _executing = 0;

  int _executed = 0;

  bool _finished = false;

  bool cancel() {
    if (_delayTimer == null) {
      _cancelled = true;
      return true;
    }

    _delayTimer.cancel();
    _cancelled = true;

    return _executing != 0;
  }

  Future<Duration> start() async {
    if (_started) throw new Exception("Job already started!");
    _started = true;

    _nextExecution = new DateTime.now().add(after);
    _delayTimer = new Timer(after, () async {
      _lastExecution = new DateTime.now();
      _nextExecution = null;
      _executing++;
      await exec.perform();
      _executing--;
      _executed++;
      _finished = true;
    });

    return after;
  }

  DateTime _lastExecution;

  DateTime _nextExecution;

  Duration nextExecutionIn() => _nextExecution?.difference(new DateTime.now());

  DateTime nextExecutionAt() => _nextExecution;
}
