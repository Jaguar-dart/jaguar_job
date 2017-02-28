part of jaguar_job;

class _StreamedJob<T> implements Job {
  final String id;

  final String name;

  final Stream<T> stream;

  final _Exec exec;

  _StreamedJob(this.id, this.name, this.stream, this.exec);

  bool hasFinished() => false;

  bool isCancelled() => _cancelled;

  bool hasStarted() => _started;

  bool _started = false;

  bool _cancelled = false;

  int _executing = 0;

  int _executed = 0;

  StreamSubscription<T> _subscription;

  Future<Duration> start() {
    if (_started) throw new Exception("Job already started!");
    _started = true;

    _subscription = stream.listen((T t) async {
      _lastExecution = new DateTime.now();
      await exec.perform();
      _executing++;
      await exec.perform();
      _executing--;
      _executed++;
    });

    return null;
  }

  bool cancel() {
    if (_subscription == null) {
      _cancelled = true;
      return true;
    }

    _subscription.cancel();
    _cancelled = true;
    return _executing != 0;
  }

  DateTime _lastExecution;

  Duration nextExecutionIn() => null;

  DateTime nextExecutionAt() => null;
}