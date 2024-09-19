// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library DateTimeLib {
    uint256 constant SECONDS_PER_DAY = 24 * 60 * 60;
    uint256 constant SECONDS_PER_HOUR = 60 * 60;
    uint256 constant SECONDS_PER_MINUTE = 60;
    uint256 constant DAYS_PER_YEAR = 365;
    uint256 constant DAYS_PER_LEAP_YEAR = 366;
    uint256 constant ORIGIN_YEAR = 1970;

    struct DateTime {
        uint256 year;
        uint256 month;
        uint256 day;
    }

    function isLeapYear(uint256 year) internal pure returns (bool) {
        if (year % 4 != 0) {
            return false;
        } else if (year % 100 != 0) {
            return true;
        } else if (year % 400 != 0) {
            return false;
        } else {
            return true;
        }
    }

    function leapYearsBefore(uint256 year) internal pure returns (uint256) {
        year -= 1;
        return year / 4 - year / 100 + year / 400;
    }

    function getDaysInMonth(uint256 month, uint256 year) internal pure returns (uint256) {
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            return 31;
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            return 30;
        } else if (isLeapYear(year)) {
            return 29;
        } else {
            return 28;
        }
    }

    function timestampToDate(uint256 timestamp) internal pure returns (uint256, uint256, uint256) {
        uint256 secondsAccountedFor = 0;
        uint256 buf;
        uint256 i;

        // Year
        uint256 year = ORIGIN_YEAR;
        buf = leapYearsBefore(year) - leapYearsBefore(ORIGIN_YEAR);

        while (true) {
            uint256 secondsInYear = (isLeapYear(year) ? DAYS_PER_LEAP_YEAR : DAYS_PER_YEAR) * SECONDS_PER_DAY;
            if (secondsAccountedFor + secondsInYear > timestamp) {
                break;
            }
            year += 1;
            secondsAccountedFor += secondsInYear;
        }

        // Month
        uint256 month = 1;
        for (i = 1; i <= 12; i++) {
            uint256 secondsInMonth = getDaysInMonth(i, year) * SECONDS_PER_DAY;
            if (secondsAccountedFor + secondsInMonth > timestamp) {
                month = i;
                break;
            }
            secondsAccountedFor += secondsInMonth;
        }

        // Day
        uint256 day = (timestamp - secondsAccountedFor) / SECONDS_PER_DAY + 1;

        return (year, month, day);
    }
}

library StringConverter {
    // uint256을 string으로 변환하는 함수
    function uintToString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "00";
        } else if (_i == 1) {
            return "01";
        } else if (_i == 2) {
            return "02";
        } else if (_i == 3) {
            return "03";
        } else if (_i == 4) {
            return "04";
        } else if (_i == 5) {
            return "05";
        } else if (_i == 6) {
            return "06";
        } else if (_i == 7) {
            return "07";
        } else if (_i == 8) {
            return "08";
        } else if (_i == 9) {
            return "09";
        }
        uint256 temp = _i;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (_i != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(_i % 10)));
            _i /= 10;
        }
        return string(buffer);
    }
}

library StringUtils {
    function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
        return string(abi.encodePacked(_a, _b, _c));
    }
}