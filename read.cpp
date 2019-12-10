#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

int main() {
    std::ifstream file("/home/labuser/Desktop/API/bytes_code");
    std::string line = "";
    // unsigned char* message= new unsigned int 

    unsigned char message[84] = {0};
    int count = 0;
    std::fill_n(message, 84, 'a');
    // unsigned int aa = 0x1;
    // unsigned char aaa = aa;    
    // std::string aaaa = "0xA8";

    if (file.is_open()) {
        while (!file.eof()) {
            getline(file, line);

            std::istringstream s(line);
            unsigned char b;
            unsigned int c;
            s >> std:: hex >> c;
            b = c;

            message[count++] = b;
        }

    } else {
        std::cout << "ERROR\n";
    }

    message[83] = count - 1;

    for (int i=0; i<84; ++i) {
        // std::cout << message[i] << "\n";
        printf("%02X\n", message[i]);
    }

    return 0;
}