import 'package:flutter/material.dart';

// Emplyoee Details Card

class EmplyeeTile extends StatelessWidget {
  final String ename;
  final String ejob;
  final String eYear;
  final bool isGreen;
  const EmplyeeTile(
      {Key? key,
      required this.ename,
      required this.ejob,
      required this.eYear,
      required this.isGreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isGreen ? Colors.green : Colors.grey[200],
          border: Border.all(width: 0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/dp.jpeg'),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  ename,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.purple[100],
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  ejob,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Text(
                'Since: $eYear',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ],
      ),
    );
  }
}
