#include <iostream>

template <int i> void a() { a<i + 1>(); }

int main(int argc, char *argv[]) {
  std::cout << "Hello world";
  char a[10];
  a[10] = 2;

  return 0;
}
