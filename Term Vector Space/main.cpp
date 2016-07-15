#include <iostream>
#include <string>

#include "Book.h"
#include "Parser.h"

const std::string DS_BEFORE_PATH = "datasets/before/booksummaries.txt";
const std::string DS_AFTER_PATH = "datasets/after/";
const std::string DS_CORPUS_PATH = "../Document Similarity/corpus/";
const std::string DS_CORPUS_TEST_PATH = "../Document Similarity/corpus/test/";

const std::string FANTASY = "/m/01hmnh";
const std::string ROMANCE = "/m/01qxvh";
const std::string SCIENCE_FICTION = "/m/06n90";
const std::string CHILDREN_LITERATURE = "/m/0dwly";

void printAllInfo(std::vector<Book> books) {
    int i = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::cout << i << std::endl;

        std::string filename = DS_AFTER_PATH;
        char numstr[21];
        filename.append(itoa(i, numstr, 10));
        filename.append(".txt");

        std::ofstream newfile(filename.c_str());
        if (newfile.is_open()) {
            (*it).printToExternal(newfile);
        } else {
            std::cout << "Unable to open file";
        }
        i++;
    }
}

void printSummaryOnly(std::vector<Book> books) {
    int i = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::cout << i << std::endl;

        std::string filename = DS_CORPUS_PATH;
        char numstr[21];
        filename.append(itoa(i, numstr, 10));
        filename.append(".txt");

        std::ofstream newfile(filename.c_str());
        if (newfile.is_open()) {
            (*it).printCorpusToExternal(newfile);
        } else {
            std::cout << "Unable to open file";
        }
        i++;
    }
}

void printFantasyBooks(std::vector<Book> books) {
    int i = 1;
    int j = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::string filename = DS_CORPUS_TEST_PATH + "fantasy-";
        char numstr[21];
        filename.append(itoa(j, numstr, 10));
        filename.append(".txt");

        Book book = (*it);
        if (book.getGenres().find(FANTASY) != std::string::npos
            && book.getGenres().find(ROMANCE) == std::string::npos
            && book.getGenres().find(SCIENCE_FICTION) == std::string::npos
            && book.getGenres().find(CHILDREN_LITERATURE) == std::string::npos) {
            std::cout << i << std::endl;
            std::ofstream newfile(filename.c_str());
            if (newfile.is_open()) {
                (*it).printCorpusToExternal(newfile);
            } else {
                std::cout << "Unable to open file";
            }
            j++;
        }
        i++;
    }
}

void printRomanceBooks(std::vector<Book> books) {
    int i = 1;
    int j = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::string filename = DS_CORPUS_TEST_PATH + "romance-";
        char numstr[21];
        filename.append(itoa(j, numstr, 10));
        filename.append(".txt");

        Book book = (*it);
        if (book.getGenres().find(ROMANCE) != std::string::npos
            && book.getGenres().find(SCIENCE_FICTION) == std::string::npos
            && book.getGenres().find(CHILDREN_LITERATURE) == std::string::npos) {
            std::cout << i << std::endl;
            std::ofstream newfile(filename.c_str());
            if (newfile.is_open()) {
                (*it).printCorpusToExternal(newfile);
            } else {
                std::cout << "Unable to open file";
            }
            j++;
        }
        i++;
    }
}

void printScienceFictionBooks(std::vector<Book> books) {
    int i = 1;
    int j = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::string filename = DS_CORPUS_TEST_PATH + "scifi-";
        char numstr[21];
        filename.append(itoa(j, numstr, 10));
        filename.append(".txt");

        Book book = (*it);
        if (book.getGenres().find(SCIENCE_FICTION) != std::string::npos
            && book.getGenres().find(ROMANCE) == std::string::npos
            && book.getGenres().find(CHILDREN_LITERATURE) == std::string::npos) {
            std::cout << i << std::endl;
            std::ofstream newfile(filename.c_str());
            if (newfile.is_open()) {
                (*it).printCorpusToExternal(newfile);
            } else {
                std::cout << "Unable to open file";
            }
            j++;
        }
        i++;
    }
}

void printChildrenLiteratureBooks(std::vector<Book> books) {
    int i = 1;
    int j = 1;
    for(std::vector<Book>::iterator it = books.begin(); it != books.end(); ++it) {
        std::string filename = DS_CORPUS_TEST_PATH + "children-";
        char numstr[21];
        filename.append(itoa(j, numstr, 10));
        filename.append(".txt");

        Book book = (*it);
        if (book.getGenres().find(CHILDREN_LITERATURE) != std::string::npos) {
            std::cout << i << std::endl;
            std::ofstream newfile(filename.c_str());
            if (newfile.is_open()) {
                (*it).printCorpusToExternal(newfile);
            } else {
                std::cout << "Unable to open file";
            }
            j++;
        }
        i++;
    }
}

int main() {
    std::vector<Book> books;
    books = Parser::parseData(DS_BEFORE_PATH);
    printFantasyBooks(books);
    printRomanceBooks(books);
    printScienceFictionBooks(books);
    printChildrenLiteratureBooks(books);
    return 0;
}
