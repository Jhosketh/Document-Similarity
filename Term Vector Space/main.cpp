#include <iostream>

#include "Parser.h"

int main() {
    const std::string DS_PATH = "datasets/data1.txt";

    Parser::parseData(DS_PATH);

    std::cout << "Hello world!" << std::endl;
    return 0;
}
