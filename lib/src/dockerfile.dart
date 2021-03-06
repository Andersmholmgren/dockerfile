// Copyright (c) 2015, Anders Holmgren. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library dockerfile.spec;

import 'dart:async';
import 'dart:io';

import 'package:dockerfile/src/docker_command.dart';
import 'package:path/path.dart' as p;

const String _standardFileName = 'Dockerfile';

/// Represents a [Dockerfile](https://docs.docker.com/reference/builder/)
/// Currently supports creating and saving Dockerfiles
class Dockerfile {
  final List<DockerCommand> _commands = [];

//  static Future<Dockerfile> load(Directory projectDirectory) async =>
//      new Dockerfile.parse(
//          await new File(p.join(projectDirectory.path, _standardFileName))
//              .readAsString());

  void from(String image, {String tag, String digest}) {
    _commands.add(new FromCommand(image, tag, digest));
  }

  void add(String from, String to, {bool execForm: true}) {
    _commands.add(new AddCommand(from, to, execForm));
  }

  void addDir(String from, String to, {bool execForm: true}) {
    final toDir = to.endsWith('/') ? to : to + '/';
    add(from, toDir, execForm: execForm);
  }

  void workDir(String dir) {
    _commands.add(new WorkDirCommand(dir));
  }

  void run(String command,
      {Iterable<String> args: const [], bool execForm: false}) {
    _commands.add(new RunCommand(command, args, execForm));
  }

  void cmd(Iterable<String> commandArgs, {bool execForm: true}) {
    _commands.add(new CmdCommand(commandArgs, execForm));
  }

  void entryPoint(String command,
      {Iterable<String> args: const [], bool execForm: true}) {
    _commands.add(new EntryPointCommand(command, args, execForm));
  }

  void expose(Iterable<int> ports) {
    _commands.add(new ExposeCommand(ports));
  }

  void env(String key, value) {
    _commands.add(new EnvCommand(key, value));
  }

  void envs(Map<String, dynamic> values) {
    values.forEach((key, value) {
      env(key, value);
    });
  }

  void write(IOSink sink) {
    _commands.forEach((c) {
      c.write(sink);
    });
  }

  Future save(Directory parentDir) {
    final ioSink =
        new File(p.join(parentDir.path, _standardFileName)).openWrite();
    try {
      write(ioSink);
    } finally {
      return ioSink.close();
    }
  }
}
