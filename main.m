#include <sys/stat.h>
#include <Foundation/Foundation.h>
#include <sys/syslimits.h>

#define PROGRAM_NAME "rfa"
#define USAGE "usage: " PROGRAM_NAME " file...\n"

int main(int argc, char *argv[])
{
    CFURLRef source = nil, target = nil;
    CFDataRef bookmark = nil;
    CFErrorRef error = nil;
    Boolean unused = false;
    struct stat sourceStat = { 0 };
    char path[PATH_MAX] = { 0 };

    if (argc <= 1) {
        fprintf(stderr, USAGE);
        return 1;
    }

    for (--argc, ++argv; argc > 0; --argc, ++argv) {
        stat(*argv, &sourceStat);
        if (S_ISDIR(sourceStat.st_mode)) {
            fprintf(stderr, PROGRAM_NAME ": %s: Is a directory\n", *argv);
            return 2;
        }
        source = CFURLCreateFromFileSystemRepresentation(NULL, (UInt8 *)*argv, strlen(*argv), false);
        bookmark = CFURLCreateBookmarkDataFromFile(NULL, source, &error);
        if (error) {
            fprintf(stderr, PROGRAM_NAME ": %s: Could not read file\n", *argv);
            CFRelease(source);
            return 3;
        }
        target = CFURLCreateByResolvingBookmarkData(NULL, bookmark, 0, NULL, NULL, &unused, &error);
        if (error) {
            fprintf(stderr, PROGRAM_NAME ": %s: Could not resolve bookmark data\n", *argv);
            CFRelease(source);
            CFRelease(bookmark);
            return 4;
        }
        CFURLGetFileSystemRepresentation(target, false, (UInt8 *)path, PATH_MAX);
        printf("%s\n", path);
        CFRelease(source);
        CFRelease(bookmark);
        CFRelease(target);
        error = nil;
    }

    return 0;
}
