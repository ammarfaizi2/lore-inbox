Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbSJWHJi>; Wed, 23 Oct 2002 03:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262892AbSJWHJh>; Wed, 23 Oct 2002 03:09:37 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:28604 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262889AbSJWHJc>; Wed, 23 Oct 2002 03:09:32 -0400
Message-ID: <00c001c27a63$eaf1c7a0$7609720a@M3104487>
Reply-To: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Date: Wed, 23 Oct 2002 12:45:07 +0530
Organization: wipro
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-523e0bf8-6629-4c1d-a98c-a8efdc11e8ca"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-OriginalArrivalTime: 23 Oct 2002 07:15:25.0040 (UTC) FILETIME=[F4FD7F00:01C27A63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-523e0bf8-6629-4c1d-a98c-a8efdc11e8ca
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc.
All Rights Reserved

Machine's name                                    : benchtest
Machine's configuration                           : 128MB,10GB,800Mhz
Number of seconds to run each test [2 to 1000]    : 3
Path to disk files                                : /root/bench/s9110


Starting time:      Wed Oct 23 12:32:36 2002
Projected Run Time: 0:03:00
Projected finish:   Wed Oct 23 12:35:36 2002



----------------------------------------------------------------------------
--------------------------------
 Test        Test        Elapsed  Iteration    Iteration          Operation
Number       Name      Time (sec)   Count   Rate (loops/sec)    Rate
(ops/sec)
----------------------------------------------------------------------------
--------------------------------
     1 add_double           3.00         84   28.00000       504000.00
Thousand Double Precision Additions/second
     2 add_float            3.02        129   42.71523       512582.78
Thousand Single Precision Additions/second
     3 add_long             3.04         80   26.31579      1578947.37
Thousand Long Integer Additions/second
     4 add_int              3.03         80   26.40264      1584158.42
Thousand Integer Additions/second
     5 add_short            3.01        198   65.78073      1578737.54
Thousand Short Integer Additions/second
     6 creat-clo            3.05         58   19.01639        19016.39 File
Creations and Closes/second
     7 page_test            3.00        300  100.00000       170000.00
System Allocations & Pages/second
     8 brk_test             3.01        101   33.55482       570431.89
System Memory Allocations/second
     9 jmp_test             3.00      14391 4797.00000      4797000.00
Non-local gotos/second
    10 signal_test          3.00        412  137.33333       137333.33
Signal Traps/second
    11 exec_test            3.03         83   27.39274          136.96
Program Loads/second
    12 fork_test            3.05         33   10.81967         1081.97 Task
Creations/second
    13 link_test            3.00        296   98.66667         6216.00
Link/Unlink Pairs/second
    14 disk_rr              3.06         12    3.92157        20078.43
Random Disk Reads (K)/second
    15 disk_rw              3.25         11    3.38462        17329.23
Random Disk Writes (K)/second
    16 disk_rd              3.02        120   39.73510       203443.71
Sequential Disk Reads (K)/second
    17 disk_wrt             3.20         14    4.37500        22400.00
Sequential Disk Writes (K)/second
    18 disk_cp              3.01         11    3.65449        18710.96 Disk
Copies (K)/second
    19 sync_disk_rw         9.61          1    0.10406          266.39 Sync
Random Disk Writes (K)/second
    20 sync_disk_wrt        5.05          2    0.39604         1013.86 Sync
Sequential Disk Writes (K)/second
    21 sync_disk_cp         4.50          2    0.44444         1137.78 Sync
Disk Copies (K)/second
    22 disk_src             3.02        405  134.10596        10057.95
Directory Searches/second
    23 div_double           3.00         86   28.66667        86000.00
Thousand Double Precision Divides/second
    24 div_float            3.01         86   28.57143        85714.29
Thousand Single Precision Divides/second
    25 div_long             3.03         71   23.43234        21089.11
Thousand Long Integer Divides/second
    26 div_int              3.03         71   23.43234        21089.11
Thousand Integer Divides/second
    27 div_short            3.04         71   23.35526        21019.74
Thousand Short Integer Divides/second
    28 fun_cal              3.01        211   70.09967     35891029.90
Function Calls (no arguments)/second
    29 fun_cal1             3.00        456  152.00000     77824000.00
Function Calls (1 argument)/second
    30 fun_cal2             3.00        356  118.66667     60757333.33
Function Calls (2 arguments)/second
    31 fun_cal15            3.00        118   39.33333     20138666.67
Function Calls (15 arguments)/second
    32 sieve                3.97          3    0.75567            3.78
Integer Sieves/second
    33 mul_double           3.01         77   25.58140       306976.74
Thousand Double Precision Multiplies/second
    34 mul_float            3.01         77   25.58140       306976.74
Thousand Single Precision Multiplies/second
    35 mul_long             3.00       3377 1125.66667       270160.00
Thousand Long Integer Multiplies/second
    36 mul_int              3.00       3393 1131.00000       271440.00
Thousand Integer Multiplies/second
    37 mul_short            3.00       2706  902.00000       270600.00
Thousand Short Integer Multiplies/second
    38 num_rtns_1           3.00       1450  483.33333        48333.33
Numeric Functions/second
    39 new_raph       Unable to solve equation in 100 tries. P = 1.5708, P0
= 1.5708, delta = 6.12574e-17
new_raph: Success
 *** Failed to execute new_raph  ***
 Skipping to next test.
    40 trig_rtns            3.01         99   32.89037       328903.65
Trigonometric Functions/second
    41 matrix_rtns          3.00      18036 6012.00000       601200.00 Point
Transformations/second
    42 array_rtns           3.01         43   14.28571          285.71
Linear Systems Solved/second
    43 string_rtns          3.01         38   12.62458         1262.46
String Manipulations/second
    44 mem_rtns_1           3.01         70   23.25581       697674.42
Dynamic Memory Operations/second
    45 mem_rtns_2           3.00       5847 1949.00000       194900.00 Block
Memory Operations/second
    46 sort_rtns_1          3.01         91   30.23256          302.33 Sort
Operations/second
    47 misc_rtns_1          3.00       1253  417.66667         4176.67
Auxiliary Loops/second
    48 dir_rtns_1           3.00        459  153.00000      1530000.00
Directory Operations/second
    49 shell_rtns_1         3.01        102   33.88704           33.89 Shell
Scripts/second
    50 shell_rtns_2         3.03        109   35.97360           35.97 Shell
Scripts/second
    51 shell_rtns_3         3.00        108   36.00000           36.00 Shell
Scripts/second
    52 series_1             3.00     104677 34892.33333      3489233.33
Series Evaluations/second
    53 shared_memory        3.00       6890 2296.66667       229666.67
Shared Memory Operations/second
    54 tcp_test             3.01        445  147.84053        13305.65
TCP/IP Messages/second
    55 udp_test             3.00       1634  544.66667        54466.67
UDP/IP DataGrams/second
    56 fifo_test            3.00       2691  897.00000        89700.00 FIFO
Messages/second
    57 stream_pipe          3.00       2499  833.00000        83300.00
Stream Pipe Messages/second
    58 dgram_pipe           3.00       2515  838.33333        83833.33
DataGram Pipe Messages/second
    59 pipe_cpy             3.00       8458 2819.33333       281933.33 Pipe
Messages/second
    60 ram_copy             3.00      67376 22458.66667    561915840.00
Memory to Memory Copy/second
----------------------------------------------------------------------------
--------------------------------
Projected Completion time:  Wed Oct 23 12:35:36 2002
Actual Completion time:     Wed Oct 23 12:35:45 2002
Difference:                 0:00:09

AIM Independent Resource Benchmark - Suite IX
   Testing over


Rgds
Siva


------=_NextPartTM-000-523e0bf8-6629-4c1d-a98c-a8efdc11e8ca
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-523e0bf8-6629-4c1d-a98c-a8efdc11e8ca--
