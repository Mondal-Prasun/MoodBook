import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mood_book/model/mood_model.dart';

class MoodPieChart extends StatefulWidget {
  const MoodPieChart({
    super.key,
    required this.mooddata,
  });
  final List<MoodModel> mooddata;

  @override
  State<MoodPieChart> createState() {
    return _MoodPieChartState();
  }
}

class _MoodPieChartState extends State<MoodPieChart> {
  int touchIndex = -1;
  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> moodListData() {
      int happy = 0;
      int sad = 0;
      int angry = 0;
      int fear = 0;
      int surprise = 0;
      int disgust = 0;
      int currentDays = 0;
      final todayDate = DateTime.now();

      for (int i = 0; i < widget.mooddata.length; i++) {
        if (int.parse(widget.mooddata[i].month) == todayDate.month) {
          currentDays++;
          switch (widget.mooddata[i].mood) {
            case MoodVarient.happy:
              happy++;
              break;
            case MoodVarient.sad:
              sad++;
              break;
            case MoodVarient.angry:
              angry++;
              break;
            case MoodVarient.fear:
              fear++;
              break;
            case MoodVarient.surprise:
              surprise++;
              break;
            case MoodVarient.disgust:
              disgust++;
              break;

            default:
              throw Error();
          }
        }
      }

      return List.generate(6, (index) {
        final isTouched = index == touchIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        switch (index) {
          case 0:
            return PieChartSectionData(
              color: mColor[MoodVarient.happy],
              value: ((happy / currentDays) * 100).floorToDouble(),
              title: ((happy / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: mColor[MoodVarient.sad],
              value: ((sad / currentDays) * 100).floorToDouble(),
              title: ((sad / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: mColor[MoodVarient.angry],
              value: ((angry / currentDays) * 100).floorToDouble(),
              title: ((angry / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          case 3:
            return PieChartSectionData(
              color: mColor[MoodVarient.fear],
              value: ((fear / currentDays) * 100).floorToDouble(),
              title: ((fear / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          case 4:
            return PieChartSectionData(
              color: mColor[MoodVarient.surprise],
              value: ((surprise / currentDays) * 100).floorToDouble(),
              title:
                  ((surprise / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );
          case 5:
            return PieChartSectionData(
              color: mColor[MoodVarient.disgust],
              value: ((disgust / currentDays) * 100).floorToDouble(),
              title: ((disgust / currentDays) * 100).floorToDouble().toString(),
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            );

          default:
            throw Error();
        }
      });
    }

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(
              () {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchIndex = -1;
                  return;
                }
                touchIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              },
            );
          },
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: moodListData(),
      ),
    );
  }
}
