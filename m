Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266223AbSKOMXr>; Fri, 15 Nov 2002 07:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbSKOMXr>; Fri, 15 Nov 2002 07:23:47 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:23244 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S266223AbSKOMXo>; Fri, 15 Nov 2002 07:23:44 -0500
Message-ID: <3DD4E8E9.9D5F77F1@wipro.com>
Date: Fri, 15 Nov 2002 18:00:33 +0530
From: Rohit Raveendran <rohit.raveendran@wipro.com>
Reply-To: rohit.raveendran@wipro.com
Organization: Wipro
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] AIM Independent Resource Benchmark results for kernel-2.5.47
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 12:30:24.0509 (UTC) FILETIME=[C573DAD0:01C28CA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AIM Independent Resource Benchmark - Suite IX v1.1, January 22, 1996
Copyright (c) 1996 - 2001 Caldera International, Inc.
All Rights Reserved

Machine's name                                    : reg
Machine's configuration                           :
Lx2.5.47-P3-497MHz-128MB
Number of seconds to run each test [2 to 1000]    : 60
Path to disk files                                : /tmp

Starting time:      Fri Nov 15 14:30:22 2002
Projected Run Time: 1:00:00
Projected finish:   Fri Nov 15 15:30:22 2002



------------------------------------------------------------------------------------------------------------
 Test        Test        Elapsed       CPU Utilization   Iteration   
Iteration          Operation
Number       Name      Time (sec)      User     System     Count   Rate
(loops/sec)    Rate (ops/sec)
------------------------------------------------------------------------------------------------------------
     1 add_double          60.06      58.00      0.00     1060      
17.64902       317682.32 Thousand Double Precision Additions/second
     2 add_float           60.03      59.00      0.00     1598      
26.62002       319440.28 Thousand Single Precision Additions/second
     3 add_long            60.02      59.00      0.00      990      
16.49450       989670.11 Thousand Long Integer Additions/second
     4 add_int             60.02      59.00      0.00      990      
16.49450       989670.11 Thousand Integer Additions/second
     5 add_short           60.01      59.00      0.00     2820      
46.99217      1127812.03 Thousand Short Integer Additions/second
     6 creat-clo           60.03       1.00     55.00     1359      
22.63868        22638.68 File Creations and Closes/second
     7 page_test           60.02       4.00     55.00     2108      
35.12163        59706.76 System Allocations & Pages/second
     8 brk_test            60.03      12.00     47.00     1417      
23.60486       401282.69 System Memory Allocations/second
     9 jmp_test            60.00      59.00      0.00   255529    
4258.81667      4258816.67 Non-local gotos/second
    10 signal_test         60.00      10.00     49.00     5134      
85.56667        85566.67 Signal Traps/second
    11 exec_test           60.02       0.00      4.00     1767      
29.44019          147.20 Program Loads/second
    12 fork_test           60.04       0.00     22.00      607      
10.10993         1010.99 Task Creations/second
    13 link_test           60.00       2.00     57.00    13948     
232.46667        14645.40 Link/Unlink Pairs/second
    14 disk_rr             60.36       2.00     53.00      271       
4.48973        22987.41 Random Disk Reads (K)/second
    15 disk_rw             60.03       2.00     53.00      233       
3.88139        19872.73 Random Disk Writes (K)/second
    16 disk_rd             60.01       4.00     54.00     2089      
34.81086       178231.63 Sequential Disk Reads (K)/second
    17 disk_wrt            60.17       1.00     55.00      334       
5.55094        28420.81 Sequential Disk Writes (K)/second
    18 disk_cp             60.17       2.00     55.00      269       
4.47067        22889.81 Disk Copies (K)/second
    19 sync_diskrw         62.56       0.00      2.00        4       
0.06394          163.68 Sync Random Disk Writes (K)/second
    20 sync_diskwrt        61.51       0.00      3.00       10       
0.16258          416.19 Sync Sequential Disk Writes (K)/second
    21 sync_diskcp         61.95       0.00      3.00       10       
0.16142          413.24 Sync Disk Copies (K)/second
    22 disk_src            60.00       7.00     51.00     9696     
161.60000        12120.00 Directory Searches/second
    23 div_double          60.04      59.00      0.00     1086      
18.08794        54263.82 Thousand Double Precision Divides/second
    24 div_float           60.04      57.00      0.00     1052      
17.52165        52564.96 Thousand Single Precision Divides/second
    25 div_long            60.05      59.00      0.00      883      
14.70441        13233.97 Thousand Long Integer Divides/second
    26 div_int             60.04      59.00      0.00      883      
14.70686        13236.18 Thousand Integer Divides/second
    27 div_short           60.03      59.00      0.00      883      
14.70931        13238.38 Thousand Short Integer Divides/second
    28 fun_cal0            60.03      59.00      0.00     2507      
41.76245     21382375.48 Function Calls (no arguments)/second
    29 fun_cal1            60.01      59.00      0.00     5731      
95.50075     48896383.94 Function Calls (1 argument)/second
    30 fun_cal2            60.01      59.00      0.00     3658      
60.95651     31209731.71 Function Calls (2 arguments)/second
    31 fun_cal_15          60.03      58.00      0.00     1272      
21.18941     10848975.51 Function Calls (15 arguments)/second
    32 sieve               60.58      59.00      1.00       59       
0.97392            4.87 Integer Sieves/second
    33 mul_double          60.03      59.00      0.00      953      
15.87540       190504.75 Thousand Double Precision Multiplies/second
    34 mul_float           60.06      59.00      0.00      951      
15.83417       190009.99 Thousand Single Precision Multiplies/second
    35 mul_long            60.00      54.00      0.00    39123     
652.05000       156492.00 Thousand Long Integer Multiplies/second
    36 mul_int             60.00      59.00      0.00    42726     
712.10000       170904.00 Thousand Integer Multiplies/second
    37 mul_short           60.01      60.00      0.00    34316     
571.83803       171551.41 Thousand Short Integer Multiplies/second
    38 num_rtns_1          60.00      59.00      0.00    18394     
306.56667        30656.67 Numeric Functions/second
    39 new_raph            60.00      59.00      0.00    60829    
1013.81667       202763.33 Zeros Found/second
    40 trig_rtns           60.03      58.00      0.00     1207      
20.10661       201066.13 Trigonometric Functions/second    41
matrix_rtns         60.00      59.00      0.00   228487    
3808.11667       380811.67 Point Transformations/second
    42 array_rtns          60.05      60.00      0.00      441       
7.34388          146.88 Linear Systems Solved/second
    43 string_rtns         60.01      59.00      0.00      483       
8.04866          804.87 String Manipulations/second
    44 mem_rtns_1          60.08      29.00     31.00      652      
10.85220       325565.91 Dynamic Memory Operations/second
    45 mem_rtns_2          60.00      59.00      0.00    72518    
1208.63333       120863.33 Block Memory Operations/second    46
sort_rtns_1         60.02      60.00      0.00     1295      
21.57614          215.76 Sort Operations/second
    47 misc_rtns_1         60.00      19.00     39.00    19574     
326.23333         3262.33 Auxiliary Loops/second
    48 dir_rtns_1          60.01      18.00     42.00     4858      
80.95317       809531.74 Directory Operations/second
    49 shell_rtns_1        60.03       0.00      1.00     2227      
37.09812           37.10 Shell Scripts/second
    50 shell_rtns_2        60.00       0.00      2.00     2232      
37.20000           37.20 Shell Scripts/second
    51 shell_rtns_3        60.03       0.00      1.00     2233      
37.19807           37.20 Shell Scripts/second
    52 series_1            60.00      59.00      0.00  1156536   
19275.60000      1927560.00 Series Evaluations/second
    53 shared_memory       60.00      22.00     38.00    80384    
1339.73333       133973.33 Shared Memory Operations/second
    54 tcp_test            60.00       3.00     56.00    15091     
251.51667        22636.50 TCP/IP Messages/second
    55 udp_test            60.00       4.00     55.00    27342     
455.70000        45570.00 UDP/IP DataGrams/second
    56 fifo_test           60.00       7.00     53.00    46579     
776.31667        77631.67 FIFO Messages/second
    57 stream_pipe         60.00       8.00     50.00    72256    
1204.26667       120426.67 Stream Pipe Messages/second
    58 dgram_pipe          60.00       8.00     50.00    71061    
1184.35000       118435.00 DataGram Pipe Messages/second
    59 pipe_cpy            60.00      11.00     45.00   107632    
1793.86667       179386.67 Pipe Messages/second
    60 ram_copy            60.00      59.00      0.00   798549   
13309.15000    332994933.00 Memory to Memory Copy/second
------------------------------------------------------------------------------------------------------------
Projected Completion time:  Fri Nov 15 15:30:22 2002
Actual Completion time:     Fri Nov 15 15:30:30 2002
Difference:                 0:00:08

AIM Independent Resource Benchmark - Suite IX
   Testing over
