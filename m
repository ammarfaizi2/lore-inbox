Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310894AbSCHOsy>; Fri, 8 Mar 2002 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310888AbSCHOsq>; Fri, 8 Mar 2002 09:48:46 -0500
Received: from vsmtp1.tin.it ([212.216.176.221]:38654 "EHLO smtp1a.cp.tin.it")
	by vger.kernel.org with ESMTP id <S310889AbSCHOsd> convert rfc822-to-8bit;
	Fri, 8 Mar 2002 09:48:33 -0500
Message-ID: <3C883B6200001112@ims1b.cp.tin.it>
Date: Fri, 8 Mar 2002 15:48:24 +0100
From: ciak@virgilio.it
Subject: =?iso-8859-1?Q?=5BTEST=5D=20dbench=2010=20test=20on=202=2E4=2E16=20and=202=2E4=2E17?=
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I perfomed dbench 10 on both 2.4.16 and .17 (without patch)
Here the results:

Administrator@OIVT444P /cygdrive/log
$ cat 2.4.17.dbench10.log
Throughput 25.654 MB/sec (NB=32.0676 MB/sec  256.54 MBit/sec)  10 procs
Throughput 24.024 MB/sec (NB=30.03 MB/sec  240.24 MBit/sec)  10 procs
Throughput 25.0597 MB/sec (NB=31.3246 MB/sec  250.597 MBit/sec)  10 procs
Throughput 23.082 MB/sec (NB=28.8525 MB/sec  230.82 MBit/sec)  10 procs
Throughput 25.447 MB/sec (NB=31.8088 MB/sec  254.47 MBit/sec)  10 procs
Throughput 26.6811 MB/sec (NB=33.3513 MB/sec  266.811 MBit/sec)  10 procs
Throughput 24.5282 MB/sec (NB=30.6603 MB/sec  245.282 MBit/sec)  10 procs
Throughput 21.9301 MB/sec (NB=27.4126 MB/sec  219.301 MBit/sec)  10 procs
Throughput 29.3987 MB/sec (NB=36.7484 MB/sec  293.987 MBit/sec)  10 procs
Throughput 23.4877 MB/sec (NB=29.3596 MB/sec  234.877 MBit/sec)  10 procs
Average: 24.9292 MB/sec
System info
cpu MHz         : 334.237
bogomips        : 678.29
Thu Mar 7 22:55:09 GMT 2002

Administrator@OIVT444P /cygdrive/log
$ cat 2.4.16.dbench10.log
Throughput 42.18 MB/sec (NB=52.7251 MB/sec  421.8 MBit/sec)  10 procs
Throughput 42.2764 MB/sec (NB=52.8456 MB/sec  422.764 MBit/sec)  10 procs
Throughput 42.9552 MB/sec (NB=53.694 MB/sec  429.552 MBit/sec)  10 procs
Throughput 42.8453 MB/sec (NB=53.5566 MB/sec  428.453 MBit/sec)  10 procs
Throughput 40.8713 MB/sec (NB=51.0891 MB/sec  408.713 MBit/sec)  10 procs
Throughput 44.1715 MB/sec (NB=55.2144 MB/sec  441.715 MBit/sec)  10 procs
Throughput 42.523 MB/sec (NB=53.1538 MB/sec  425.23 MBit/sec)  10 procs
Throughput 43.2136 MB/sec (NB=54.017 MB/sec  432.136 MBit/sec)  10 procs
Throughput 40.593 MB/sec (NB=50.7413 MB/sec  405.93 MBit/sec)  10 procs
Throughput 41.079 MB/sec (NB=51.3487 MB/sec  410.79 MBit/sec)  10 procs
Average: 42.2708 MB/sec
System info
cpu MHz         : 334.523
bogomips        : 678.29
Thu Mar 7 23:03:16 GMT 2002

What has been changed in 2.4.17, I have 1/2 of performance...

Please CC'me, cause I'm not a subscriber of the list!!

Thanks,
Ciak




