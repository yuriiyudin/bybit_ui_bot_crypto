import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terminal_octopus/src/constants/theme.dart';
import 'package:terminal_octopus/src/features/dashboard/history/providers/history_provider.dart';
import 'package:terminal_octopus/src/features/dashboard/live_board/providers/live_board_provider.dart';

class DashBoardScreen extends ConsumerWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(openOrdersProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              stops: [0.3, 0.7, 1.0],
              end: Alignment.bottomCenter,
              colors: [kDefaultbackgroundColor, Color.fromARGB(255, 22, 18, 50), Color.fromARGB(255, 12, 10, 29)],
            ),
          ),
          child: orders.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(0.5),
                      2: FlexColumnWidth(0.4),
                      3: FlexColumnWidth(0.8),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(1),
                      8: FlexColumnWidth(1),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(1),
                    },
                    border: TableBorder.all(
                      color: Colors.white30,
                    ),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.black),
                        children: [
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Pair',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'LONG/SHORT',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'Coins',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'USD',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'avgPrice',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'markPrice',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'unrealisedPnl',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.middle,
                              child: Text(
                                'Date',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )),
                        ],
                      ),
                      ...List.generate(data.state.length, (index) {
                        String? procentPnl;
                        final startPrice = double.parse(data.state[index].avgPrice);
                        final marketPrice = double.parse(data.state[index].markPrice);

                        if (double.tryParse(data.state[index].unrealisedPnl)! < 0) {
                          procentPnl = ((startPrice - marketPrice) / startPrice * 100).toStringAsFixed(2);
                        } else {
                          procentPnl = ((startPrice - marketPrice) / startPrice * 100).toStringAsFixed(2);
                        }

                        if (double.parse(data.state[index].unrealisedPnl) < 0 && data.state[index].side == 'Sell') {
                          procentPnl = double.parse(procentPnl).abs().toStringAsFixed(2);
                        }

                        return TableRow(children: [
                          TableCell(
                              child: Text(
                            data.state[index].symbol,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            textAlign: TextAlign.center,
                            data.state[index].side == 'Buy' ? 'Long' : 'Short',
                            style: TextStyle(color: data.state[index].side == 'Buy' ? Colors.green : Colors.orange[900], fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            textAlign: TextAlign.center,
                            data.state[index].size,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            textAlign: TextAlign.center,
                            double.parse(data.state[index].positionValue).toInt().toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            textAlign: TextAlign.center,
                            data.state[index].avgPrice,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            textAlign: TextAlign.center,
                            data.state[index].markPrice,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            '${data.state[index].unrealisedPnl} ${procentPnl != null ? '(${procentPnl}%)' : 'n/a'}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: double.parse(data.state[index].unrealisedPnl) < 0 ? Colors.red : Colors.green, fontSize: 20),
                          )),
                          TableCell(
                              child: Text(
                            DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(data.state[index].createdTime)!)),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                        ]);
                      })
                    ],
                  ),
                );
              },
              error: (e, st) {},
              loading: () => Center(child: const CircularProgressIndicator()))),
    );
  }
}
