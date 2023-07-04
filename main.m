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
        exit(EXIT_FAILURE);
    }

    while (--argc > 0) {
        sourcePath = [NSString stringWithUTF8String:*++argv];
        sourceURL = [NSURL fileURLWithPath:sourcePath];
        targetURL = [NSURL URLByResolvingAliasFileAtURL:sourceURL options:0 error:&error];

        if (error) {
            fprintf(stderr, PROGRAM_NAME ": %s\n", error.localizedDescription.UTF8String);

            [sourcePath release];
            [sourceURL release];
            [error release];

            exit(error.code);
        }

        printf("%s\n", targetURL.path.UTF8String);

        [sourcePath release];
        [sourceURL release];
        [targetURL release];
    }

    return 0;
}
