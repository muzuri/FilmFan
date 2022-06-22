import 'package:filmfan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ExpandableText extends StatefulWidget {

  final String text;
  const ExpandableText({Key? key,required this.text}) : super(key: key);
  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  double textHeight=500;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?Text(firstHalf,textAlign: TextAlign.justify ,style: GoogleFonts.lato(fontSize: 15, color: textColor ,fontWeight: FontWeight.w300),):Column(
        children: [
          Text(hiddenText?(firstHalf+'...'):(firstHalf+secondHalf), textAlign: TextAlign.justify, style: GoogleFonts.lato(fontSize: 15, color: textColor,fontWeight: FontWeight.w300)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                Text("Read more",style: GoogleFonts.lato(color: orangeColor),),
                Icon(Icons.arrow_drop_down,color: orangeColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
