import random

# Python script to generate two large CSV files for further vi manipulation.

# configuration parameters
# reference years for each file
FILE_1_YEAR = str(2015)
FILE_2_YEAR = str(2023)

# number of lines in each file
FILE_1_LC = 10377
FILE_2_LC = 32100

# names of each file
FILE_1_NM = 'profiles_' + FILE_1_YEAR + '.csv'
FILE_2_NM = 'profiles_' + FILE_2_YEAR + '.csv'

# lines with "none" content on file 1
FILE_1_NONE = [15, 101, 1007, 5002, 5003]

# lines with "none" content on file 2
FILE_2_NONE = [1500, 1501, 1502, 10111]

# loads the names stored in first_names.txt
fnames = []
with open('./script/first_names.txt') as f:
    for line in f:
        fnames.append(line.strip())

# loads the names stored in last_names.txt
lnames = []
with open('./script/last_names.txt') as f:
    for line in f:
        lnames.append(line.strip())

# loads the cities stored in cities.txt
cities = []
with open('./script/cities.txt') as f:
    for line in f:
        cities.append(line.strip())

# loads the countries stored in countries.txt
countries = []
with open('./script/countries.txt') as f:
    for line in f:
        countries.append(line.strip())

# loads the occupations stored in occupations.txt
occupations = []
with open('./script/occupations.txt') as f:
    for line in f:
        occupations.append(line.strip())


# Returns the header of the first CSV file.
def add_header_1():
    line_1 = '# Filename: ' + FILE_1_NM + '\n'
    line_2 = 'id|filepath|name|date|dob|city|country|height|weight|occupation\n'
    return line_1 + line_2


# Returns the header of the second CSV file.
def add_header_2():
    line_01 = '#    Filename: ' + FILE_2_NM + '\n'
    line_02 = '#     Purpose: list with user profiles as of ' + FILE_2_YEAR + '.\n'
    line_03 = '#      Author: comp141.\n'
    line_04 = '# Description: Column 01: Profile ID number.\n'
    line_05 = '#              Column 02: Profile image file path.\n'
    line_06 = '#              Column 03: Profile user name.\n'
    line_07 = '#              Column 04: Profile join date.\n'
    line_08 = '#              Column 05: User\'s date of birth.\n'
    line_09 = '#              Column 06: User\'s home city. \n'
    line_10 = '#              Column 07: User\'s country of origin. \n'
    line_11 = '#              Column 08: User\'s height in cm. \n'
    line_12 = '#              Column 09: User\'s weight in kg. \n'
    line_13 = '#              Column 10: User\'s occupation. \n'
    line_14 = '# Verif. Code: 10212f98b5f6a95f21b51a93529af47bcb662dda38e39132a7a12d59a276c29b\n'

    return line_01 + line_02 + line_03 + line_04 + line_05 + line_06 + line_07 + line_08 + line_09 + \
        line_10 + line_11 + line_12 + line_13 + line_14


# creates file 1
def file_1_create():
    with open(FILE_1_NM, 'w') as file_1:
        # adds the header to the file
        file_1.write(add_header_1())

        # for each line of the file
        for i in range(FILE_1_LC):
            has_none = False

            # raffles a profile image file path
            image = '/home/comp141/profile_system/pictures/' + str(random.randint(1, 999999)).zfill(6) + '.png'

            # raffles a name for the current profile
            f_name = fnames[random.randint(1, len(fnames)) - 1]
            l_name = fnames[random.randint(1, len(fnames)) - 1]
            name = f_name + ' ' + l_name
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                name = 'none'

            # raffles a date
            year = str(random.randint(2005, int(FILE_1_YEAR)))
            month = str(random.randint(1, 12))
            day = str(random.randint(1, 28))
            date = year + '/' + month + '/' + day
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                date = 'none'

            # raffles a dob
            dob_year = str(random.randint(1980, 2000))
            dob_month = str(random.randint(1, 12))
            dob_day = str(random.randint(1, 28))
            dob = dob_year + '/' + dob_month + '/' + dob_day
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                dob = 'none'

            # raffles city and country
            city = cities[random.randint(1, len(cities)) - 1]
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                city = 'none'

            country = countries[random.randint(1, len(countries)) - 1]
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                country = 'none'

            # raffles height and weight
            height = str(random.randrange(160, 195))
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                height = 'none'

            weight = str(random.randrange(58, 110))
            if i in FILE_1_NONE and random.random() > 0.5:
                has_none = True
                weight = 'none'

            # raffles an occupation
            occupation = occupations[random.randint(1, len(occupations)) - 1]
            if i in FILE_1_NONE and (random.random() > 0.5 or not has_none):
                # has_none = True
                occupation = 'none'

            line_i = str(i + 1) + '|' + image + '|' + name + '|' + date + '|' + dob + '|' + city + \
                     '|' + country + '|' + height + '|' + weight + '|' + occupation + '\n'

            file_1.write(line_i)
            print('Added line', i, 'of', str(FILE_1_LC) + '.')


# creates file 2
def file_2_create():
    with open(FILE_2_NM, 'w') as file_2:
        # adds the header to the file
        file_2.write(add_header_2())

        # for each line of the file
        for i in range(FILE_2_LC):
            has_none = False

            # raffles a profile image file path
            image = '/home/comp141/profile_system/pictures/' + str(random.randint(1, 999999)).zfill(6) + '.jpg'

            # raffles a name for the current profile
            f_name = fnames[random.randint(1, len(fnames)) - 1]
            l_name = fnames[random.randint(1, len(fnames)) - 1]
            name = f_name + ' ' + l_name
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                name = 'none'

            # raffles a date
            year = str(random.randint(int(FILE_1_YEAR), int(FILE_2_YEAR)))
            month = str(random.randint(1, 12))
            day = str(random.randint(1, 28))
            date = year + '/' + month + '/' + day
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                date = 'none'

            # raffles a dob
            dob_year = str(random.randint(1980, 2000))
            dob_month = str(random.randint(1, 12))
            dob_day = str(random.randint(1, 28))
            dob = dob_year + '/' + dob_month + '/' + dob_day
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                dob = 'none'

            # raffles city and country
            city = cities[random.randint(1, len(cities)) - 1]
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                city = 'none'

            country = countries[random.randint(1, len(countries)) - 1]
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                country = 'none'

            # raffles height and weight
            height = str(random.randrange(160, 195))
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                height = 'none'

            weight = str(random.randrange(58, 110))
            if i in FILE_2_NONE and random.random() > 0.5:
                has_none = True
                weight = 'none'

            # raffles an occupation
            occupation = occupations[random.randint(1, len(occupations)) - 1]
            if i in FILE_2_NONE and (random.random() > 0.5 or not has_none):
                # has_none = True
                occupation = 'none'

            line_i = str(i + 1 + FILE_1_LC) + ',' + image + ',' + name + ',' + date + ',' + dob + ',' + city + \
                     ',' + country + ',' + height + ',' + weight + ',' + occupation + '\n'

            file_2.write(line_i)
            print('Added line', i, 'of', str(FILE_2_LC) + '.')


# main execution
file_1_create()
file_2_create()
