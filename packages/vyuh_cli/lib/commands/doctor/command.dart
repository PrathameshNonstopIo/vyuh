
import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:process_run/process_run.dart';

class DoctorCommand extends Command<int> {

  DoctorCommand({
    required Logger logger,
  }): _logger = logger {
    argParser.addFlag(
      'verbose',
       abbr: 'v',
       help: 'Display additional information about the checks.',
       negatable: false);
  } 

  final Logger _logger;
  
  @override
  String get invocation => 'vyuh doctor';

  @override
  String get description => 'Check the health of the CLI.';

  static const String commandName = 'vyuh doctor';

  @override
  String get name => commandName;

  @override
  Future<int> run() async {
  //   final result = await Process.run('vyuh', ['doctor']);
   print('\nRunning Vyuh Doctor...\n');

  //  if(result.exitCode != 0) {
  //     _logger.err('Vyuh Doctor failed.');
  //     return 1;
  //  }
    try {
      
      await _checkNodeVersion();
      await _checkDartVersion();
      await _checkMelosVersion();
      await _checkPnpmVersion();
      await _checkSanity();
    } catch (error) {
      _logger.err(error.toString());
      return ExitCode.software.code;
    }
     _logger.info('\nVyuh Doctor Summary:\n');
    return ExitCode.success.code;   
  }


 Future<void> _checkNodeVersion() async {
    try {
      final shell = Shell();
      final result = await shell.run('node -v');
       if (result.first.exitCode == 0) {
      _logger.info('✅ Node.js is installed (version: ${result.outText.trim()})');
    } else {
      _logger.info('❌ Node.js not found. Please install Node.js to continue.');
    }
  } catch (e) {
    _logger.info('❌ Error occurred while checking for Node.js: ${e.toString()}');
  }
  }


 Future<void> _checkDartVersion() async {
    try {
      final shell = Shell();
      final result = await shell.run('dart --version');
      if (result.first.exitCode == 0) {
      _logger.info('✅ Dart is installed (version: ${result.outText.trim()})');
    } else {
      _logger.info('❌ Dart not found. Please install Dart to continue.');
    }
  } catch (e) {
    _logger.info('❌ Error occurred while checking for Dart: ${e.toString()}');
  }
 }

   Future<void> _checkMelosVersion() async {
    try {
      final shell = Shell();
      final result = await shell.run('melos --version');
      if (result.first.exitCode == 0) {
      _logger.info('✅ Melos is installed (version: ${result.outText.trim()})');
    } else {
      _logger.info('❌ Melos not found. Please install Melos to continue.');
    }
  } catch (e) {
    _logger.info('❌ Error occurred while checking for Melos: ${e.toString()}');
  }
  }

   Future<void> _checkPnpmVersion() async {
    try {
      final shell = Shell();
      final result = await shell.run('pnpm --version');
      if (result.first.exitCode == 0) {
      _logger.info('✅ Pnpm is installed (version: ${result.outText.trim()})');
    } else {
      _logger.info('❌ Pnpm not found. Please install Pnpm to continue.');
    }
  } catch (e) {
    _logger.info('❌ Error occurred while checking for Pnpm: ${e.toString()}');
  }
  }

  Future<void> _checkSanity() async {
  try {
    final shell = Shell();

    // Run the command to check if Sanity CLI is installed
    final result = await shell.run('sanity --version');

    if (result.first.exitCode == 0) {
      _logger.info('✅ Sanity is installed (version: ${result.outText.trim()})');
    } else {
      _logger.info('❌ Sanity not found.');
    }
  } catch (e) {
    _logger.info('❌ Error occurred while checking for Sanity: ${e.toString()}');
  }
}
}