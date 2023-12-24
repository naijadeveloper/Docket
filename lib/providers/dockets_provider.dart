import 'package:docket/state/docket_model.dart';
import 'package:docket/state/list_dockets_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final docketsProvider = NotifierProvider<ListOfDocketsNotifier, List<Docket>>(() {
  return ListOfDocketsNotifier();
});