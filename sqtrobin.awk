#!/usr/bin/awk

/^S/{
scan=$2;
charge=$4;
oMass=$7;
sp=$8;
numMatch=$9;
mobility=$11;
}
/^M/{
xrank=$2;
sprank=$3;
cMass=$4;
deltCn=$5;
xcorr=$6;
sp=$7;
matchIons=$8;
expectedIons=$9;
sequence=$10;
mobility=$12;
timsscore=$13;
}
/^L/
{
  protein = $2;
  label = 1;
  if (protein~/Reverse_/) {
    label = -1;
  }
	if (xrank == "1") {
	  print 
	}
}
