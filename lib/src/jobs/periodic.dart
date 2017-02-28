part of jaguar_job;

class _PeriodicJob implements Job {
  final String id;

  final String name;

  final Duration startDelay;

  final Duration interval;

  final int times;

  final _Exec exec;

  _PeriodicJob(this.id, this.name, this.interval, this.exec,
      {this.startDelay, this.times});

  bool hasFinished() => _finished;

  bool isCancelled() => _cancelled;

  bool hasStarted() => _started;

  Timer _delayTimer;

  Timer _periodicTimer;

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
    if (_periodicTimer != null) {
      _periodicTimer.cancel();
    }
    _cancelled = true;

    return _executing != 0;
  }

  Future<Duration> start() async {
    if (_started) throw new Exception("Job already started!");
    _started = true;

    _nextExecution = new DateTime.now().add(startDelay);
    _delayTimer = new Timer(startDelay, () {
      _periodicTimer = new Timer.periodic(interval, (_) async {
        _lastExecution = new DateTime.now();
        _nextExecution = _lastExecution.add(interval);

        if (times is int && times >= (_executed+1)) {
          _periodicTimer.cancel();
          _nextExecution = null;
          _finished = true;
        }

        _executing++;
        await exec.perform();
        _executing--;
        _executed++;
      });
    });
    return startDelay;
  }

  DateTime _lastExecution;

  DateTime _nextExecution;

  Duration nextExecutionIn() => _nextExecution?.difference(new DateTime.now());

  DateTime nextExecutionAt() => _nextExecution;
}