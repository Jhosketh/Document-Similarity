#include "Parser.h"

Parser::Parser() {
    //ctor
}

Parser::~Parser() {
    //dtor
}

std::vector<Book> Parser::parseData(std::string path) {
    std::vector<Book> res;
    std::string line;
    std::ifstream dataset(path.c_str());

    if (dataset.is_open()) {
        while(getline(dataset, line)) {
            std::stringstream ss(line);
            std::string item;

            while(getline(ss, item, DELIMITER)) {
                Book book;
                book.setWikiId(std::atoi(item.c_str()));

                getline(ss, item, DELIMITER);
                book.setFreebaseId(item);

                getline(ss, line, DELIMITER);
                book.setTitle(item);

                getline(ss, item, DELIMITER);
                book.setAuthor(item);

                getline(ss, item, DELIMITER);
                book.setPublicationDate(item);

                getline(ss, item, DELIMITER);
                // book genre

                getline(ss, item, DELIMITER);
                book.setSummary(item);
                book.createVectorSpace();

                res.push_back(book);
            }
        }
        dataset.close();
    }

    return res;
}
