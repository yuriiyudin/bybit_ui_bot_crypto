import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terminal_octopus/src/constants/theme.dart';
import 'package:terminal_octopus/src/features/dashboard/history/providers/history_provider.dart';
import 'package:terminal_octopus/src/features/dashboard/widgets/cover_widget.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HISTORY',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: CoverWidget(
          child: history.when(
              data: (history) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(0.7),
                            1: FlexColumnWidth(0.7),
                            2: FlexColumnWidth(0.6),
                            3: FlexColumnWidth(1),
                            4: FlexColumnWidth(1),
                            5: FlexColumnWidth(1),
                            6: FlexColumnWidth(1),
                            7: FlexColumnWidth(1),
                            8: FlexColumnWidth(1),
                            9: FlexColumnWidth(0.5),
                            10: FlexColumnWidth(1),
                            11: FlexColumnWidth(1),
                          },
                          border: TableBorder.all(color: Colors.white30),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              children: [
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Pair',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Side', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Coins', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Coin price', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Entry Price', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Market Price', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Earning', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('USD amount', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('Sell coins amount', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('createdTime', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('orderId', style: TextStyle(color: Colors.green)),
                                  ),
                                ),
                              ],
                            ),
                            ...List.generate(history.state.length, (index) {
                              String? procentPnl;
                              final startPrice = double.parse(history.state[index].avgEntryPrice);
                              final marketPrice = double.parse(history.state[index].avgExitPrice);

                              if (double.tryParse(history.state[index].closedPnl)! < 0) {
                                procentPnl = ((startPrice - marketPrice) / startPrice * 100).toStringAsFixed(2);
                                procentPnl = double.parse(procentPnl).abs().toStringAsFixed(2);
                              } else {
                                procentPnl = ((startPrice - marketPrice) / startPrice * 100).toStringAsFixed(2);
                              }

                              if (double.parse(history.state[index].closedPnl) > 0 && history.state[index].side == 'Sell') {
                                procentPnl = double.parse(procentPnl).abs().toStringAsFixed(2);
                              }

                              return TableRow(children: [
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].symbol,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].side == 'Buy' ? 'Short' : 'Long',
                                        style: TextStyle(
                                          color: history.state[index].side == 'Sell' ? Colors.green : Colors.orange[900],
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].qty,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].orderPrice,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].avgEntryPrice,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].avgExitPrice,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        '${history.state[index].closedPnl.toString()} (${procentPnl}%)',
                                        style: TextStyle(color: double.tryParse(history.state[index].closedPnl)! < 0 ? Colors.red : Colors.green, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].cumEntryValue,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].cumExitValue,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        DateFormat('dd MMMM yyyy HH:mm:ss')
                                            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(history.state[index].createdTime)))
                                            .toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment: TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        history.state[index].orderId,
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )),
                              ]);
                            })
                          ]),
                    ),
                  ),
              error: (e, st) {},
              loading: () => Center(child: CircularProgressIndicator()))),
    );
  }
}
