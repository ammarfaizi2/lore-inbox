Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTENL6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTENL6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:58:52 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:58788 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261893AbTENL6r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:58:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.69-mm5 with contest
Date: Wed, 14 May 2003 22:13:26 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305142213.27937.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Contest (http://contest.kolivas.org) benchmarks with osdl 
(http://www.osdl.org) hardware.

no_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          1	80	93.8	0.0	0.0	1.00
2.5.68-mm3          1	80	93.8	0.0	0.0	1.00
2.5.69              1	80	93.8	0.0	0.0	1.00
2.5.69-mm3          1	79	94.9	0.0	0.0	1.00
2.5.69-mm5          1	79	94.9	0.0	0.0	1.00
cacherun:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          1	76	98.7	0.0	0.0	0.95
2.5.68-mm3          1	76	98.7	0.0	0.0	0.95
2.5.69              1	76	98.7	0.0	0.0	0.95
2.5.69-mm3          1	76	98.7	0.0	0.0	0.96
2.5.69-mm5          1	76	98.7	0.0	0.0	0.96
process_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          2	177	41.8	177.5	56.5	2.21
2.5.68-mm3          2	177	42.4	181.5	55.9	2.21
2.5.69              2	181	41.4	196.5	58.0	2.26
2.5.69-mm3          2	176	42.0	183.0	56.2	2.23
2.5.69-mm5          2	176	42.6	182.5	55.7	2.23
ctar_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          3	108	73.1	1.0	5.6	1.35
2.5.68-mm3          3	120	66.7	1.0	5.0	1.50
2.5.69              3	103	75.7	0.0	0.0	1.29
2.5.69-mm3          3	126	63.5	1.0	4.8	1.59
2.5.69-mm5          3	114	70.2	1.0	5.3	1.44
xtar_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          3	107	72.0	1.0	4.7	1.34
2.5.68-mm3          3	111	69.4	1.7	4.5	1.39
2.5.69              3	106	72.6	1.0	3.7	1.32
2.5.69-mm3          3	111	69.4	1.7	4.5	1.41
2.5.69-mm5          3	102	75.5	1.0	4.9	1.29
io_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          4	131	58.8	47.0	18.9	1.64
2.5.68-mm3          4	271	28.4	89.2	17.9	3.39
2.5.69              4	343	22.7	120.5	19.8	4.29
2.5.69-mm3          4	319	24.5	105.3	18.1	4.04
2.5.69-mm5          4	137	56.9	49.6	19.0	1.73
io_other:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          2	120	65.0	49.2	22.3	1.50
2.5.68-mm3          2	127	61.4	45.1	19.5	1.59
2.5.69              2	127	61.4	55.5	24.4	1.59
2.5.69-mm3          2	133	58.6	47.1	18.7	1.68
2.5.69-mm5          2	115	67.8	46.4	20.7	1.46
read_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          2	115	67.8	9.1	6.1	1.44
2.5.68-mm3          2	117	67.5	9.2	6.0	1.46
2.5.69              2	104	75.0	6.3	4.8	1.30
2.5.69-mm3          2	113	69.9	9.1	6.1	1.43
2.5.69-mm5          2	113	69.9	9.0	6.2	1.43
list_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          2	97	79.4	0.0	7.2	1.21
2.5.68-mm3          2	96	80.2	0.0	7.3	1.20
2.5.69              2	95	81.1	0.0	5.3	1.19
2.5.69-mm3          2	95	81.1	0.0	7.4	1.20
2.5.69-mm5          2	96	80.2	0.0	7.3	1.22
mem_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          2	101	78.2	53.0	2.0	1.26
2.5.68-mm3          2	130	61.5	75.0	2.3	1.62
2.5.69              2	98	79.6	60.5	2.0	1.23
2.5.69-mm3          2	135	59.3	77.0	2.2	1.71
2.5.69-mm5          2	99	79.8	53.0	2.0	1.25
dbench_load:
Kernel         [runs]	Time	CPU%	Loads	LCPU%	Ratio
2.5.68-mm2          4	345	22.0	4.8	49.3	4.31
2.5.68-mm3          4	721	10.5	6.8	33.6	9.01
2.5.69              4	374	20.3	5.0	48.1	4.67
2.5.69-mm3          4	653	11.6	6.2	34.0	8.27
2.5.69-mm5          4	316	24.1	4.0	44.6	4.00

These results show a return to the performance of 2.5.68-mm2 with the request 
change to 128. Furthermore it seems the heavy swapping of mem_load seems to 
be helped by these changes.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wjLmF6dfvkL3i1gRAuMnAKCoQP+ZOy+C1KN221Rzt/oqz/wvlwCgrI0K
QkzA7kefWHUW8/9Mp5Frw1o=
=72L5
-----END PGP SIGNATURE-----

