#ifndef PARSER_H
#define PARSER_H

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include "Book.h"

class Parser {
public:
    /** Constructor & Destructor */
    Parser();
    virtual ~Parser();

    /** Other methods */
    static std::vector<Book> parseData(std::string path);

protected:

private:
    static const char DELIMITER = '\t';
};

#endif // PARSER_H
