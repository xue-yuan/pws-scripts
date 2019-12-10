#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

int main() {
    std::string h = "0x61";
    std::istringstream s(h);
    unsigned char b;
    unsigned int c;

    s >> std:: hex >> c;
    b = c;

    std::cout << b << "\n";

    return 0;
}
