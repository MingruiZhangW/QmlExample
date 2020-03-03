import QtQuick 2.9

Rectangle
{

    property bool commonBorder : true

    property int lBorderwidth : 1
    property int rBorderwidth : 1
    property int tBorderwidth : 1
    property int bBorderwidth : 1

    property int commonBorderWidth : 1

    // z : Sets the stacking order of sibling items. By default the stacking order is 0.
    // lower z mean stack down
    z : -1

    property string borderColor : "white"

    color: borderColor

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

        topMargin    : commonBorder ? -commonBorderWidth : -tBorderwidth
        bottomMargin : commonBorder ? -commonBorderWidth : -bBorderwidth
        leftMargin   : commonBorder ? -commonBorderWidth : -lBorderwidth
        rightMargin  : commonBorder ? -commonBorderWidth : -rBorderwidth
    }
}
