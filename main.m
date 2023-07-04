#include <Foundation/Foundation.h>

#define PROGRAM_NAME "rfa"
#define USAGE "usage: " PROGRAM_NAME " file...\n"

int main(int argc, char *argv[])
{
    NSString *sourcePath = nil;
    NSURL *sourceURL = nil, *targetURL = nil;
    NSError *error = nil;

    if (argc <= 1) {
        fprintf(stderr, USAGE);
        return 1;
    }

    while (--argc > 0) {
        sourcePath = [NSString stringWithCString:*++argv encoding:[NSString defaultCStringEncoding]];
        sourceURL = [NSURL fileURLWithPath:sourcePath];
        targetURL = [NSURL URLByResolvingAliasFileAtURL:sourceURL options:0 error:&error];
        if (error) {
            fprintf(stderr, PROGRAM_NAME ": %s\n", [error.localizedDescription cStringUsingEncoding:[NSString defaultCStringEncoding]]);
            return error.code;
        }
        printf("%s\n", [targetURL.path cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    }

    return 0;
}
