#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import certifi
import os
import sys
import urllib3

# from urllib3.connectionpool import connection_from_url


PULP="https://some.repo/pulp/repos/"
# Exit codes to signal user.
ERROR_DATA_NOT_FOUND = 1


class DataNotFoundException(Exception):
    """Raised if target file is not found."""
    def __init__(self, message):
        """intializes exception"""
        Exception.__init__(self, message)
        self.exit_status = ERROR_FILE_NOT_FOUND
        self.message = message


def search_pulp(http_obj, url, search_str):
    response = http_obj.request('GET', url)
    print response.status
    print response.data


def main():
    pulp_base="https://some.repo/pulp/repos/"

    parser = argparse.ArgumentParser(prog=__file__, description=__doc__)
    # parser.add_argument('-p', '--pulp_url', help='pulp url')
    parser.add_argument('-s', '--search_str', help='search string', required=True)
    args = parser.parse_args()

    # TODO: use with
    http_pool = urllib3.HTTPSConnectionPool("some.repo",
                                            cert_reqs='CERT_NONE',
                                            assert_hostname=False)
    search_pulp(http_pool, pulp_base, args.search_str)


if __name__ == '__main__':
    try:
        main()
    except (DataNotFoundException) as ex:
        print ex.message
        sys.exit(ex.exit_status)