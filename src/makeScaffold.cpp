#include "data.h"

int main (int argc, char ** argv) {
	string reg = "", gen = "", fam ="", out="";
	for (int a = 1 ; a < argc ; a++) {
		if (strcmp(argv[a], "--gen") == 0) gen = string(argv[a+1]);
		if (strcmp(argv[a], "--fam") == 0) fam = string(argv[a+1]);
		if (strcmp(argv[a], "--reg") == 0) reg = string(argv[a+1]);
		if (strcmp(argv[a], "--out") == 0) out = string(argv[a+1]);
    if (strcmp(argv[a], "--help") == 0) {
      cout << "makeScaffold v0.1\n";
      cout << "--gen <VCF>\n";
      cout << "--fam <ped.txt>\n";
      cout << "--reg <region in bed-coordinates>\n";
      cout << "--out <output VCF>\n";
      exit(0);
    }
	}
  if (gen == ""){
    cout << "makeScaffold v0.1\n";
    cout << "--gen <VCF>\n";
    cout << "--fam <ped.txt>\n";
    cout << "--reg <region in bed-coordinates>\n";
    cout << "--out <output VCF>\n";
    exit(0);
  }
  assert(gen != ""); assert(fam != ""); assert(out != ""); assert(reg != "");

	data D;
	D.readGenotypes(gen, reg);
	D.readPedigrees(fam);
	D.solvePedigrees();
	D.writeGenotypes(out);
}
