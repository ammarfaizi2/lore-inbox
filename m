Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTISAIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 20:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbTISAIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 20:08:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:65258 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbTISAID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 20:08:03 -0400
Message-Id: <200309190007.h8J07vU15192@mail.osdl.org>
Date: Thu, 18 Sep 2003 17:07:54 -0700 (PDT)
From: markw@osdl.org
Subject: Hackbench STP Results History for 2.5/2.6
To: linux-kernel@vger.kernel.org, linstab@osdl.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a history of results that we have for hackbench from STP over
the base 2.5 and 2.6 kernels.  I have them separated by the number of
processors from 1-, 2-, 4- and 8-processor systems.

1-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
linux-2.5.28           57.8        N/A  http://khack.osdl.org/stp/3969/
linux-2.5.30           55.0       -4.8  http://khack.osdl.org/stp/4089/
linux-2.5.31           56.0        1.7  http://khack.osdl.org/stp/4347/
linux-2.5.32           54.7       -2.4  http://khack.osdl.org/stp/4786/
linux-2.5.33           36.1      -34.0  http://khack.osdl.org/stp/4960/
linux-2.5.34           54.0       49.9  http://khack.osdl.org/stp/5127/
linux-2.5.36           17.2      -68.2  http://khack.osdl.org/stp/5418/
linux-2.5.44           34.5      100.6  http://khack.osdl.org/stp/6557/
linux-2.5.47           36.8        6.8  http://khack.osdl.org/stp/7062/
linux-2.5.48           36.8       -0.0  http://khack.osdl.org/stp/7410/
linux-2.5.49           36.8       -0.0  http://khack.osdl.org/stp/8020/
linux-2.5.50           36.5       -0.9  http://khack.osdl.org/stp/8368/
linux-2.5.51           36.9        1.0  http://khack.osdl.org/stp/7672/
linux-2.5.52           36.6       -0.7  http://khack.osdl.org/stp/8600/
linux-2.5.53           36.9        0.8  http://khack.osdl.org/stp/8824/
linux-2.5.54           17.7      -52.0  http://khack.osdl.org/stp/8836/
linux-2.5.57           17.9        0.8  http://khack.osdl.org/stp/12028/
linux-2.5.58           17.9        0.3  http://khack.osdl.org/stp/12087/
linux-2.5.59           17.9       -0.2  http://khack.osdl.org/stp/12171/
linux-2.5.60           18.1        1.2  http://khack.osdl.org/stp/265616/
linux-2.5.61           18.4        1.8  http://khack.osdl.org/stp/266133/
linux-2.5.62           18.4        0.2  http://khack.osdl.org/stp/266213/
linux-2.5.63           18.4       -0.3  http://khack.osdl.org/stp/266672/
linux-2.5.64           18.5        0.8  http://khack.osdl.org/stp/268044/
linux-2.5.65           17.1       -7.9  http://khack.osdl.org/stp/268757/
linux-2.5.66           16.7       -2.4  http://khack.osdl.org/stp/269927/
linux-2.5.67           16.8        0.8  http://khack.osdl.org/stp/270224/
linux-2.5.68           17.5        4.3  http://khack.osdl.org/stp/270660/
linux-2.5.69           16.9       -3.5  http://khack.osdl.org/stp/271601/
linux-2.5.70           17.1        0.9  http://khack.osdl.org/stp/272668/
linux-2.5.72           17.0       -0.0  http://khack.osdl.org/stp/274156/
linux-2.5.74           17.0        0.0  http://khack.osdl.org/stp/275173/
linux-2.5.75           17.0       -0.6  http://khack.osdl.org/stp/275652/
linux-2.6.0-test1      15.0      -11.3  http://khack.osdl.org/stp/280083/
linux-2.6.0-test2      16.9       12.3  http://khack.osdl.org/stp/276551/
linux-2.6.0-test3      17.1        1.5  http://khack.osdl.org/stp/277357/
linux-2.6.0-test4      15.5       -9.8  http://khack.osdl.org/stp/280143/
linux-2.6.0-test5      15.5        0.2  http://khack.osdl.org/stp/280075/


2-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
linux-2.5.30           25.9        N/A  http://khack.osdl.org/stp/4090/
linux-2.5.31           26.3        1.6  http://khack.osdl.org/stp/4348/
linux-2.5.32           25.5       -3.1  http://khack.osdl.org/stp/4787/
linux-2.5.33           25.2       -1.0  http://khack.osdl.org/stp/4961/
linux-2.5.34           25.4        0.7  http://khack.osdl.org/stp/5128/
linux-2.5.35           15.4      -39.5  http://khack.osdl.org/stp/5360/
linux-2.5.36           15.5        0.7  http://khack.osdl.org/stp/5419/
linux-2.5.37           15.4       -0.7  http://khack.osdl.org/stp/5478/
linux-2.5.38           15.3       -0.4  http://khack.osdl.org/stp/5537/
linux-2.5.49           27.7       81.0  http://khack.osdl.org/stp/8038/
linux-2.5.50           27.3       -1.7  http://khack.osdl.org/stp/8386/
linux-2.5.51           27.5        0.7  http://khack.osdl.org/stp/7690/
linux-2.5.52           27.5        0.1  http://khack.osdl.org/stp/8618/
linux-2.5.53           27.3       -0.6  http://khack.osdl.org/stp/8713/
linux-2.5.57           14.3      -47.7  http://khack.osdl.org/stp/12046/
linux-2.5.58           14.4        1.0  http://khack.osdl.org/stp/12105/
linux-2.5.59           14.5        0.5  http://khack.osdl.org/stp/12189/
linux-2.5.60           14.6        0.3  http://khack.osdl.org/stp/265638/
linux-2.5.61           14.7        0.9  http://khack.osdl.org/stp/266155/
linux-2.5.62           14.9        1.5  http://khack.osdl.org/stp/266235/
linux-2.5.63           14.6       -2.3  http://khack.osdl.org/stp/266694/
linux-2.5.64           14.6        0.2  http://khack.osdl.org/stp/268218/
linux-2.5.65           13.6       -6.7  http://khack.osdl.org/stp/268776/
linux-2.5.66           13.3       -2.4  http://khack.osdl.org/stp/269946/
linux-2.5.67           13.3       -0.1  http://khack.osdl.org/stp/270243/
linux-2.5.68           13.0       -2.0  http://khack.osdl.org/stp/270679/
linux-2.5.69           13.1        1.0  http://khack.osdl.org/stp/272109/
linux-2.5.71           12.8       -2.3  http://khack.osdl.org/stp/274023/
linux-2.5.72           12.7       -1.1  http://khack.osdl.org/stp/274155/
linux-2.5.73           13.0        2.4  http://khack.osdl.org/stp/274702/
linux-2.5.74           12.7       -2.8  http://khack.osdl.org/stp/275172/
linux-2.5.75           12.9        2.2  http://khack.osdl.org/stp/275651/
linux-2.6.0-test1      12.6       -2.7  http://khack.osdl.org/stp/275843/
linux-2.6.0-test2      11.6       -7.4  http://khack.osdl.org/stp/277481/
linux-2.6.0-test3      12.8        9.9  http://khack.osdl.org/stp/277356/
linux-2.6.0-test4      11.8       -8.1  http://khack.osdl.org/stp/278013/
linux-2.6.0-test5      11.9        0.9  http://khack.osdl.org/stp/280076/


4-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
linux-2.5.30           16.1        N/A  http://khack.osdl.org/stp/4091/
linux-2.5.31           16.0       -0.2  http://khack.osdl.org/stp/4349/
linux-2.5.32           15.6       -2.4  http://khack.osdl.org/stp/4788/
linux-2.5.33           15.6       -0.5  http://khack.osdl.org/stp/4962/
linux-2.5.34           15.4       -1.2  http://khack.osdl.org/stp/5129/
linux-2.5.35           10.9      -29.1  http://khack.osdl.org/stp/5361/
linux-2.5.36           10.9        0.4  http://khack.osdl.org/stp/5420/
linux-2.5.37           11.0        0.9  http://khack.osdl.org/stp/5479/
linux-2.5.38           11.1        0.4  http://khack.osdl.org/stp/5538/
linux-2.5.39           36.1      225.9  http://khack.osdl.org/stp/5976/
linux-2.5.49           20.7      -42.7  http://khack.osdl.org/stp/8053/
linux-2.5.50           20.6       -0.4  http://khack.osdl.org/stp/8401/
linux-2.5.51           20.6       -0.1  http://khack.osdl.org/stp/7705/
linux-2.5.52           20.7        0.4  http://khack.osdl.org/stp/8748/
linux-2.5.53           20.6       -0.4  http://khack.osdl.org/stp/8728/
linux-2.5.57           11.0      -46.4  http://khack.osdl.org/stp/12061/
linux-2.5.58           11.1        0.5  http://khack.osdl.org/stp/12120/
linux-2.5.59           11.0       -1.0  http://khack.osdl.org/stp/12204/
linux-2.5.60           11.3        2.5  http://khack.osdl.org/stp/265651/
linux-2.5.63           11.2       -0.9  http://khack.osdl.org/stp/266707/
linux-2.5.64           11.3        0.8  http://khack.osdl.org/stp/268219/
linux-2.5.66           10.4       -7.1  http://khack.osdl.org/stp/269962/
linux-2.5.67           10.0       -4.4  http://khack.osdl.org/stp/270259/
linux-2.5.68            9.9       -1.1  http://khack.osdl.org/stp/270695/
linux-2.5.69            9.9        0.0  http://khack.osdl.org/stp/272384/
linux-2.5.71           10.1        2.5  http://khack.osdl.org/stp/274022/
linux-2.5.72           10.1       -0.3  http://khack.osdl.org/stp/274154/
linux-2.5.73           10.2        0.6  http://khack.osdl.org/stp/274701/
linux-2.5.74           10.2        0.2  http://khack.osdl.org/stp/275171/
linux-2.5.75           10.1       -1.1  http://khack.osdl.org/stp/275650/
linux-2.6.0-test1       9.2       -8.4  http://khack.osdl.org/stp/280085/
linux-2.6.0-test2      10.2       10.5  http://khack.osdl.org/stp/276549/
linux-2.6.0-test3       9.4       -8.2  http://khack.osdl.org/stp/280081/
linux-2.6.0-test4       9.2       -2.1  http://khack.osdl.org/stp/280145/
linux-2.6.0-test5       9.4        2.1  http://khack.osdl.org/stp/280077/


8-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
linux-2.5.30           11.2        N/A  http://khack.osdl.org/stp/4092/
linux-2.5.31           11.1       -0.5  http://khack.osdl.org/stp/4350/
linux-2.5.32           10.8       -2.7  http://khack.osdl.org/stp/4789/
linux-2.5.33           11.0        1.6  http://khack.osdl.org/stp/4963/
linux-2.5.34           10.9       -1.0  http://khack.osdl.org/stp/5130/
linux-2.5.35            8.1      -25.4  http://khack.osdl.org/stp/5362/
linux-2.5.36            8.1       -0.6  http://khack.osdl.org/stp/5421/
linux-2.5.64            8.5        4.8  http://khack.osdl.org/stp/268029/
linux-2.5.65            8.3       -1.5  http://khack.osdl.org/stp/268802/
linux-2.5.66            8.4        1.3  http://khack.osdl.org/stp/269972/
linux-2.5.67            8.1       -4.1  http://khack.osdl.org/stp/270269/
linux-2.5.68            8.1       -0.3  http://khack.osdl.org/stp/270704/
linux-2.5.69            8.2        1.3  http://khack.osdl.org/stp/272385/
linux-2.5.70            7.9       -2.8  http://khack.osdl.org/stp/272665/
linux-2.5.72            7.7       -2.8  http://khack.osdl.org/stp/274153/
linux-2.5.73            7.6       -1.8  http://khack.osdl.org/stp/274700/
linux-2.5.74            7.3       -3.9  http://khack.osdl.org/stp/280037/
linux-2.5.75            7.3       -0.0  http://khack.osdl.org/stp/280036/
linux-2.6.0-test1       7.3       -0.2  http://khack.osdl.org/stp/280169/
linux-2.6.0-test2       7.2       -0.5  http://khack.osdl.org/stp/277479/
linux-2.6.0-test3       7.8        7.3  http://khack.osdl.org/stp/277354/
linux-2.6.0-test4       7.5       -2.8  http://khack.osdl.org/stp/280146/
linux-2.6.0-test5       7.5       -1.1  http://khack.osdl.org/stp/280078/

Kernels not listed either do not have results or the kernel was not
able to be used on STP.
The 'Metric' is the average time in seconds to do something with 100
processes.
Smaller numbers are better as well as a (-) change.
'Change' refers to a percentage change in the metric from the last
completed test with results.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
