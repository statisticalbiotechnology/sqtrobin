#!/usr/bin/awk

BEGIN {
maxCharge=5
chargeStr=""
for(i=1;i<=maxCharge;i++)
    chargeStr = chargeStr "\tcharge" i
features = "xcorr\tdeltCn\tsp\tdeltaMass\tfracIons\tdeltaMobility\ttimsscore" chargeStr
print "id\tlabel\t" features "\tsequence\tprotein"
}

/^S/{
scan=$2;
charge=$4;
oMass=$7;
sp=$8;
numMatch=$9;
obsMobility=$11;
chargeStr=""
for(i=1;i<=maxCharge;i++)
  if (i==charge)
    chargeStr = chargeStr "\t1"
  else
    chargeStr = chargeStr "\t0"
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
predMobility=$12;
timsscore=$13;
if (expectedIons<1)
  expectedIons=1
}
/^L/ {
  protein = $2;
  label = 1;
  if (protein~/Reverse_/)
    label = -1;
  id = scan "_" charge "_1"
  if (xrank == "1")
    features = xcorr "\t" deltCn "\t" sp "\t" (oMass-cMass) "\t" ((expectedIons-matchIons)/expectedIons) "\t" obsMobility-predMobility "\t" timsscore chargeStr
	if (xrank == "1")
    print id "\t" label "\t" features  "\t" sequence "\t" protein
}

# id <tab> label <tab> scannr <tab> feature1 <tab> ... <tab> featureN <tab> peptide <tab> proteinId1 <tab> .. <tab> proteinIdM

function rmcol(col,     i) {
  for (i=col; i<NF; i++) {
    $i = $(i+1)
  }
  NF--
}
