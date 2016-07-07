#include <iostream>
#include <string>

#include "Book.h"
#include "Parser.h"

int main() {
    const std::string DS_BEFORE_PATH = "datasets/before/booksummaries.txt";
    const std::string DS_AFTER_PATH = "datasets/after/";
    const std::string DS_CORPUS_PATH = "../Document Similarity/corpus/";
    std::vector<Book> books;

    books = Parser::parseData(DS_BEFORE_PATH);
    int i = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::cout << i << std::endl;
        // (*it).printInfo();
        // (*it).createVectorSpace();
        // (*it).printVectorSpace();
        // std::cout << std::endl << std::endl;

        //std::string filename = DS_AFTER_PATH;
        std::string filename = DS_CORPUS_PATH;
        char numstr[21];
        filename.append(itoa(i, numstr, 10));
        filename.append(".txt");

        std::ofstream newfile(filename.c_str());
        if (newfile.is_open()) {
            //(*it).printToExternal(newfile);
            (*it).printCorpusToExternal(newfile);
        } else {
            std::cout << "Unable to open file";
        }
        i++;
    }

    return 0;
}
