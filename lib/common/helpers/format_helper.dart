import 'package:intl/intl.dart';

String formattedPrice({required double price}) => NumberFormat('#,###.00').format(price);
