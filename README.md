# dockerfile

A library for manipulating [Dockerfile](https://docs.docker.com/reference/builder/)

## Usage

A simple usage example:

    import 'package:dockerfile/dockerfile.dart';

    main() {
      var dockerfile = new Dockerfile();
  
      dockerfile.from('google/dart', tag: dartVersion);
      dockerfile.run('pub', args: ['build']);
      dockerfile.add(somePath, otherPath);
      await dockerfile.save(saveDirectory);
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Andersmholmgren/dockerfile/issues
