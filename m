Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTISAM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 20:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTISAM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 20:12:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:56301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262221AbTISAMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 20:12:52 -0400
Message-Id: <200309190012.h8J0ClU15905@mail.osdl.org>
Date: Thu, 18 Sep 2003 17:12:44 -0700 (PDT)
From: markw@osdl.org
Subject: Hackbench STP Results History for 2.5 mm/2.6 mm
To: linux-kernel@vger.kernel.org, linstab@osdl.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More history from hackbench from STP from the 2.5 and 2.6 mm kernels.
These are also separated by the number of processors from 1-, 2-, 4- and
8-processor systems.  I think there might be a few anomalies in this list...

1-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
2.5.62-mm1             18.1        N/A  http://khack.osdl.org/stp/266295/
2.5.62-mm3             14.4      -20.3  http://khack.osdl.org/stp/266948/
2.5.63-mm1             14.2       -1.4  http://khack.osdl.org/stp/267564/
2.5.63-mm2             14.1       -0.5  http://khack.osdl.org/stp/267808/
2.5.64-mm4             14.1       -0.2  http://khack.osdl.org/stp/268444/
2.5.64-mm6             14.1       -0.0  http://khack.osdl.org/stp/268552/
2.5.65-mm1             13.6       -3.8  http://khack.osdl.org/stp/268824/
2.5.65-mm2             13.6        0.1  http://khack.osdl.org/stp/268882/
2.5.65-mm3             13.2       -2.8  http://khack.osdl.org/stp/268954/
2.5.65-mm4             13.8        4.6  http://khack.osdl.org/stp/269011/
2.5.66-mm1             13.6       -1.3  http://khack.osdl.org/stp/269497/
2.5.66-mm2             14.0        2.6  http://khack.osdl.org/stp/269679/
2.5.66-mm3             13.8       -1.1  http://khack.osdl.org/stp/270049/
2.5.67-mm1             13.8       -0.2  http://khack.osdl.org/stp/270280/
2.5.67-mm2             13.8       -0.0  http://khack.osdl.org/stp/270435/
2.5.67-mm4             14.0        1.2  http://khack.osdl.org/stp/270599/
2.5.68-mm1             14.1        1.2  http://khack.osdl.org/stp/270714/
2.5.68-mm2             34.1      141.2  http://khack.osdl.org/stp/270888/
2.5.68-mm3             33.7       -1.1  http://khack.osdl.org/stp/271132/
2.5.68-mm4             33.1       -1.8  http://khack.osdl.org/stp/271286/
2.5.69-mm2             32.8       -1.1  http://khack.osdl.org/stp/271846/
2.5.69-mm3             32.9        0.6  http://khack.osdl.org/stp/271956/
2.5.69-mm5             32.5       -1.5  http://khack.osdl.org/stp/272207/
2.5.69-mm6             32.7        0.8  http://khack.osdl.org/stp/272278/
2.5.70-mm3             33.3        1.8  http://khack.osdl.org/stp/273203/
2.5.70-mm5             17.7      -47.0  http://khack.osdl.org/stp/273458/
2.5.70-mm7             17.3       -2.2  http://khack.osdl.org/stp/273645/
2.5.70-mm9             17.2       -0.7  http://khack.osdl.org/stp/273904/
2.5.72-mm1             17.2        0.4  http://khack.osdl.org/stp/274215/
2.5.73-mm1             17.5        1.5  http://khack.osdl.org/stp/274824/
2.5.73-mm2             17.6        0.5  http://khack.osdl.org/stp/275094/
2.5.74-mm2             18.4        4.4  http://khack.osdl.org/stp/275388/
2.5.74-mm3             17.4       -5.2  http://khack.osdl.org/stp/275517/
2.6.0-test1-mm1        18.1        4.2  http://khack.osdl.org/stp/276034/
2.6.0-test1-mm2        17.3       -4.7  http://khack.osdl.org/stp/276254/
2.6.0-test2-mm1        16.7       -3.6  http://khack.osdl.org/stp/276491/
2.6.0-test2-mm2        16.1       -3.5  http://khack.osdl.org/stp/276821/
2.6.0-test2-mm3        17.9       11.1  http://khack.osdl.org/stp/277017/
2.6.0-test2-mm4        17.4       -2.8  http://khack.osdl.org/stp/277086/
2.6.0-test2-mm5        16.7       -3.8  http://khack.osdl.org/stp/277282/
2.6.0-test3-mm1        16.8        0.9  http://khack.osdl.org/stp/277418/
2.6.0-test4-mm1        15.1      -10.3  http://khack.osdl.org/stp/280107/
2.6.0-test4-mm2        15.4        1.7  http://khack.osdl.org/stp/280103/
2.6.0-test4-mm4        15.8        3.0  http://khack.osdl.org/stp/280099/
2.6.0-test4-mm5        16.3        2.7  http://khack.osdl.org/stp/280095/
2.6.0-test4-mm6        15.3       -6.1  http://khack.osdl.org/stp/280091/
2.6.0-test5-mm2        15.3        0.3  http://khack.osdl.org/stp/280087/


2-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
2.5.64-mm4             11.2        N/A  http://khack.osdl.org/stp/268445/
2.5.64-mm5             11.1       -1.5  http://khack.osdl.org/stp/268487/
2.5.64-mm6             11.4        3.3  http://khack.osdl.org/stp/268571/
2.5.65-mm1             11.3       -1.2  http://khack.osdl.org/stp/268843/
2.5.65-mm2             11.4        0.9  http://khack.osdl.org/stp/268901/
2.5.65-mm3             11.1       -2.5  http://khack.osdl.org/stp/268973/
2.5.66-mm1             11.3        1.3  http://khack.osdl.org/stp/269516/
2.5.66-mm3             11.4        1.5  http://khack.osdl.org/stp/270068/
2.5.67-mm1             11.1       -2.7  http://khack.osdl.org/stp/270299/
2.5.67-mm2             11.3        1.3  http://khack.osdl.org/stp/270454/
2.5.67-mm4             11.2       -0.3  http://khack.osdl.org/stp/270618/
2.5.68-mm1             11.2       -0.2  http://khack.osdl.org/stp/270733/
2.5.68-mm2             23.6      110.7  http://khack.osdl.org/stp/270907/
2.5.68-mm4             22.9       -2.8  http://khack.osdl.org/stp/271285/
2.5.69-mm3             22.4       -2.2  http://khack.osdl.org/stp/271955/
2.5.69-mm5             22.9        1.8  http://khack.osdl.org/stp/272206/
2.5.70-mm5             13.3      -41.6  http://khack.osdl.org/stp/273457/
2.5.70-mm6             12.8       -3.8  http://khack.osdl.org/stp/273548/
2.5.70-mm9             12.9        0.3  http://khack.osdl.org/stp/273903/
2.5.72-mm2             13.0        1.0  http://khack.osdl.org/stp/274359/
2.5.73-mm1             13.1        0.5  http://khack.osdl.org/stp/274823/
2.5.73-mm2             12.9       -1.3  http://khack.osdl.org/stp/275093/
2.5.74-mm2             13.4        4.0  http://khack.osdl.org/stp/275387/
2.5.74-mm3             13.2       -1.8  http://khack.osdl.org/stp/275516/
2.5.75-mm1             13.4        1.5  http://khack.osdl.org/stp/275713/
2.6.0-test1-mm1        13.4       -0.2  http://khack.osdl.org/stp/276033/
2.6.0-test1-mm2        13.6        1.6  http://khack.osdl.org/stp/276253/
2.6.0-test2-mm1        12.7       -6.3  http://khack.osdl.org/stp/276490/
2.6.0-test2-mm2        12.9        1.7  http://khack.osdl.org/stp/276820/
2.6.0-test2-mm3        13.2        2.4  http://khack.osdl.org/stp/277016/
2.6.0-test2-mm4        13.7        3.6  http://khack.osdl.org/stp/277085/
2.6.0-test2-mm5        13.7        0.1  http://khack.osdl.org/stp/277281/
2.6.0-test3-mm1        12.5       -9.0  http://khack.osdl.org/stp/277417/
2.6.0-test4-mm1        11.2      -10.4  http://khack.osdl.org/stp/280108/
2.6.0-test4-mm2        11.7        4.4  http://khack.osdl.org/stp/280104/
2.6.0-test4-mm4        11.7        0.0  http://khack.osdl.org/stp/280100/
2.6.0-test4-mm5        12.5        6.6  http://khack.osdl.org/stp/280096/
2.6.0-test4-mm6        11.8       -5.2  http://khack.osdl.org/stp/280092/
2.6.0-test5-mm2        11.8       -0.5  http://khack.osdl.org/stp/280088/


4-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
2.5.66-mm1              9.6        N/A  http://khack.osdl.org/stp/269532/
2.5.66-mm3              9.3       -3.3  http://khack.osdl.org/stp/270084/
2.5.67-mm1              8.9       -3.7  http://khack.osdl.org/stp/270315/
2.5.67-mm2              9.5        6.0  http://khack.osdl.org/stp/270470/
2.5.67-mm4              9.2       -2.4  http://khack.osdl.org/stp/270634/
2.5.68-mm1              9.2        0.2  http://khack.osdl.org/stp/270749/
2.5.68-mm2             17.2       86.1  http://khack.osdl.org/stp/270923/
2.5.68-mm4             17.1       -0.8  http://khack.osdl.org/stp/271284/
2.5.69-mm1             16.7       -2.0  http://khack.osdl.org/stp/271654/
2.5.69-mm3             16.7        0.1  http://khack.osdl.org/stp/271954/
2.5.69-mm5             16.7       -0.3  http://khack.osdl.org/stp/272205/
2.5.70-mm5              9.6      -42.8  http://khack.osdl.org/stp/273456/
2.5.70-mm9             10.3        7.4  http://khack.osdl.org/stp/273902/
2.5.72-mm2             10.2       -0.9  http://khack.osdl.org/stp/274358/
2.5.73-mm1             10.3        1.3  http://khack.osdl.org/stp/274822/
2.5.73-mm2             10.4        1.2  http://khack.osdl.org/stp/275092/
2.5.74-mm2             10.4        0.1  http://khack.osdl.org/stp/275386/
2.5.74-mm3             10.6        1.5  http://khack.osdl.org/stp/275515/
2.5.75-mm1             10.5       -1.0  http://khack.osdl.org/stp/275712/
2.6.0-test1-mm1        10.3       -1.9  http://khack.osdl.org/stp/276032/
2.6.0-test1-mm2        11.0        7.3  http://khack.osdl.org/stp/276252/
2.6.0-test2-mm1         9.9      -10.4  http://khack.osdl.org/stp/276489/
2.6.0-test2-mm2        10.3        4.2  http://khack.osdl.org/stp/276819/
2.6.0-test2-mm3         9.4       -9.2  http://khack.osdl.org/stp/277015/
2.6.0-test2-mm5        10.4       11.0  http://khack.osdl.org/stp/277280/
2.6.0-test3-mm1         9.4       -9.6  http://khack.osdl.org/stp/277416/
2.6.0-test3-mm3         8.7       -6.9  http://khack.osdl.org/stp/277862/
2.6.0-test4-mm1         8.1       -7.3  http://khack.osdl.org/stp/280109/
2.6.0-test4-mm2         8.3        2.7  http://khack.osdl.org/stp/280105/
2.6.0-test4-mm4         8.3       -0.8  http://khack.osdl.org/stp/280101/
2.6.0-test4-mm5         8.6        4.6  http://khack.osdl.org/stp/280097/
2.6.0-test4-mm6         8.3       -3.4  http://khack.osdl.org/stp/280093/
2.6.0-test5-mm2         8.4        0.1  http://khack.osdl.org/stp/280089/


8-way:
Kernel               Metric Change (%)  URL
-------------------- ------ ----------  ----------------------------------------
2.5.64-mm6              7.5        N/A  http://khack.osdl.org/stp/268597/
2.5.65-mm1              7.5        0.6  http://khack.osdl.org/stp/268869/
2.5.65-mm2              7.7        1.4  http://khack.osdl.org/stp/268927/
2.5.65-mm3              7.7        0.0  http://khack.osdl.org/stp/268999/
2.5.65-mm4              7.6       -0.6  http://khack.osdl.org/stp/269056/
2.5.66-mm1              7.6       -0.1  http://khack.osdl.org/stp/269542/
2.5.66-mm3              7.5       -0.8  http://khack.osdl.org/stp/270094/
2.5.67-mm1              7.4       -1.4  http://khack.osdl.org/stp/270325/
2.5.67-mm4              6.8       -9.0  http://khack.osdl.org/stp/270643/
2.5.68-mm1              6.7       -0.7  http://khack.osdl.org/stp/270758/
2.5.68-mm2             11.8       75.1  http://khack.osdl.org/stp/270932/
2.5.68-mm4             11.4       -2.8  http://khack.osdl.org/stp/271283/
2.5.69-mm1             11.3       -0.9  http://khack.osdl.org/stp/271653/
2.5.69-mm2             11.3        0.2  http://khack.osdl.org/stp/271843/
2.5.69-mm3             11.3       -0.5  http://khack.osdl.org/stp/271953/
2.5.69-mm5             11.3        0.4  http://khack.osdl.org/stp/272204/
2.5.69-mm6             11.2       -1.1  http://khack.osdl.org/stp/272275/
2.5.69-mm7             11.6        3.9  http://khack.osdl.org/stp/272333/
2.5.69-mm9             12.6        7.9  http://khack.osdl.org/stp/272543/
2.5.70-mm1             11.7       -7.3  http://khack.osdl.org/stp/272726/
2.5.70-mm5              7.4      -36.9  http://khack.osdl.org/stp/273455/
2.5.70-mm9              7.9        6.8  http://khack.osdl.org/stp/273901/
2.5.72-mm1              7.9        0.3  http://khack.osdl.org/stp/274212/
2.5.72-mm2              7.8       -1.4  http://khack.osdl.org/stp/274357/
2.5.73-mm1              8.0        2.5  http://khack.osdl.org/stp/274821/
2.5.73-mm2              7.9       -0.9  http://khack.osdl.org/stp/275091/
2.5.74-mm2             15.8      100.6  http://khack.osdl.org/stp/275385/
2.5.74-mm3              8.0      -49.6  http://khack.osdl.org/stp/275514/
2.5.75-mm1             26.3      229.9  http://khack.osdl.org/stp/275711/
2.6.0-test1-mm1         7.8      -70.5  http://khack.osdl.org/stp/276031/
2.6.0-test1-mm2         8.2        5.2  http://khack.osdl.org/stp/276251/
2.6.0-test2-mm1         7.9       -3.9  http://khack.osdl.org/stp/276488/
2.6.0-test2-mm2         8.0        2.2  http://khack.osdl.org/stp/276818/
2.6.0-test2-mm5         7.9       -1.2  http://khack.osdl.org/stp/277279/
2.6.0-test3-mm1         7.3       -8.5  http://khack.osdl.org/stp/277415/
2.6.0-test3-mm3         7.1       -2.7  http://khack.osdl.org/stp/277882/
2.6.0-test4-mm1         6.6       -7.2  http://khack.osdl.org/stp/280110/
2.6.0-test4-mm2         6.8        3.2  http://khack.osdl.org/stp/280106/
2.6.0-test4-mm4         6.7       -0.2  http://khack.osdl.org/stp/280102/
2.6.0-test4-mm6         6.8        1.3  http://khack.osdl.org/stp/280094/
2.6.0-test5-mm2         6.8        0.2  http://khack.osdl.org/stp/280163/

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
