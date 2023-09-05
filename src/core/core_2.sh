#!/bin/sh
echo "-----------------------------\nstart core 2\n-----------------------------";
echo "-----------------------------\nstart core 2\n-----------------------------" >> ./log/log.log;
while read FILE
do

    TIME=`date +%s%N`;
    CURL_ONLINE=`curl -x "${FILE}/" -o /dev/null -w '%{http_code}\n' -s`;
    echo ${FILE};

    if [ $CURL_ONLINE = 200 ]; then
        CURL_INFO_PHP_PHP=`curl -x "${FILE}/info.php" -o /dev/null -w '%{http_code}\n' -s`;
        CURL_INFO_PHP_PHP=`curl -x "${FILE}/php.php" -o /dev/null -w '%{http_code}\n' -s`;
        CURL_PHP_INFO_PHP=`curl -x "${FILE}/infophp.php" -o /dev/null -w '%{http_code}\n' -s`;
        CURL_TEST_PHP=`curl -x "${FILE}/test.php" -o /dev/null -w '%{http_code}\n' -s`;

        if [ $CURL_INFO_PHP_PHP = 200 ] || [ $CURL_INFO_PHP_PHP = 200 ] || [ $CURL_PHP_INFO_PHP = 200 ] || [ $CURL_TEST_PHP = 200 ]; then
            mkdir "../core2_${TIME}";
            echo ${FILE}> ../core2_$TIME/about.txt;

            if [ ${CURL_INFO_PHP_PHP} = 200 ]; then
                curl -x "${FILE}/infophp.php" -o "../core2_${TIME}/phpinfo_php.html";
                echo "discover vulnerabilities.";
                echo "core2 discover vulnerabilities. ADDRESS: ${FILE}" >> ./log/log.log;
            else
                echo 'not vulnerable.';
            fi

            if [ ${CURL_INFO_PHP_PHP} = 200 ]; then
                curl -x "${FILE}/info.php" -o "../core2_${TIME}/info_php.html";
                echo "discover vulnerabilities.";
                echo "core2 discover vulnerabilities. ADDRESS: ${FILE}" >> ./log/log.log;
            else
                echo 'not vulnerable.';
            fi

            if [ ${CURL_PHP_INFO_PHP} = 200 ]; then
                curl -x "${FILE}/infophp.php" -o "../core2_${TIME}/phpinfo_php.html";
                echo "discover vulnerabilities.";
                echo "core2 discover vulnerabilities. ADDRESS: ${FILE}" >> ./log/log.log
            else
                echo 'not vulnerable.';
            fi

            if [ ${CURL_TEST_PHP} = 200 ]; then
                curl -x "${FILE}/test.php" -o "../core2_${TIME}/testphp.html";
                echo "discover vulnerabilities.";
                echo "core2 discover vulnerabilities. ADDRESS: ${FILE}" >> ./log/log.log;
            else
                echo 'not vulnerable.';
            fi

        else
            echo 'not vulnerable.';
            echo "core2 not vulnerable.           ADDRESS: ${FILE}" >> ./log/log.log;
        fi
    else
        echo 'not site.'
        echo "core2 not site.                 ADDRESS: ${FILE}" >> ./log/log.log;
    fi
done < ./tmp_textdb/x2.txt
