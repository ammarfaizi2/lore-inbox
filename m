Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUBURBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 12:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUBURBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 12:01:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:54474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261584AbUBURAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 12:00:31 -0500
From: john cherry <cherry@osdl.org>
Date: Sat, 21 Feb 2004 09:00:30 -0800
Message-Id: <200402211700.i1LH0UL23053@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-20.17.30) - 309 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: Overriding SUBDIRS on the command line can cause
arch/ia64/kernel/fsys.S:573: Warning: This is the location of the conflicting usage
arch/ia64/kernel/fsys.S:577: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/fsys.S:577: Warning: Use of 'mov.m' violates RAW dependency 'PSR.si' (data)
arch/ia64/kernel/ivt.S:164: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:165: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:180: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:188: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:188: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:189: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:189: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:228: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:231: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:231: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:266: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:269: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:269: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:504: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:506: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:506: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:563: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:565: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:565: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:611: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:613: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:613: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
drivers/i2c/busses/i2c-elv.c:155: warning: unsigned int format, different type arg (arg 2)
drivers/i2c/busses/i2c-velleman.c:141: warning: unsigned int format, different type arg (arg 2)
drivers/pci/hotplug/pciehp_pci.c:117: warning: implicit declaration of function `pcibios_set_irq_routing'
drivers/pci/hotplug/shpchp_pci.c:115: warning: implicit declaration of function `pcibios_set_irq_routing'
make[2]: *** Warning: File `drivers/input/touchscreen/built-in.o' has modification time in the future (2004-02-20 20:24:55 > 2004-02-20 20:24:54)
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
{standard input}:10306: Warning: This is the location of the conflicting usage
{standard input}:10315: Warning: Only the first path encountering the conflict is reported
{standard input}:10315: Warning: Use of 'cmp.ne' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:10480: Warning: This is the location of the conflicting usage
{standard input}:10482: Warning: Only the first path encountering the conflict is reported
{standard input}:10482: Warning: This is the location of the conflicting usage
{standard input}:10482: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:10484: Warning: Only the first path encountering the conflict is reported
{standard input}:10484: Warning: This is the location of the conflicting usage
{standard input}:10484: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:10486: Warning: Only the first path encountering the conflict is reported
{standard input}:10486: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1097: Warning: This is the location of the conflicting usage
{standard input}:1099: Warning: Only the first path encountering the conflict is reported
{standard input}:1099: Warning: This is the location of the conflicting usage
{standard input}:1099: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:11014: Warning: This is the location of the conflicting usage
{standard input}:11015: Warning: Only the first path encountering the conflict is reported
{standard input}:11015: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:1101: Warning: Only the first path encountering the conflict is reported
{standard input}:1101: Warning: This is the location of the conflicting usage
{standard input}:1101: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1103: Warning: Only the first path encountering the conflict is reported
{standard input}:1103: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:11637: Warning: This is the location of the conflicting usage
{standard input}:11641: Warning: Only the first path encountering the conflict is reported
{standard input}:11641: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:1234: Warning: This is the location of the conflicting usage
{standard input}:1244: Warning: Only the first path encountering the conflict is reported
{standard input}:1244: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:13349: Warning: This is the location of the conflicting usage
{standard input}:13353: Warning: Only the first path encountering the conflict is reported
{standard input}:13353: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:1574: Warning: This is the location of the conflicting usage
{standard input}:1581: Warning: Only the first path encountering the conflict is reported
{standard input}:1581: Warning: Use of 'cmp.geu' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:1583: Warning: Only the first path encountering the conflict is reported
{standard input}:1583: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:1597: Warning: This is the location of the conflicting usage
{standard input}:1599: Warning: Only the first path encountering the conflict is reported
{standard input}:1599: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 15
{standard input}:17104: Warning: This is the location of the conflicting usage
{standard input}:17105: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:17887: Warning: This is the location of the conflicting usage
{standard input}:17888: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:1818: Warning: This is the location of the conflicting usage
{standard input}:1819: Warning: Only the first path encountering the conflict is reported
{standard input}:1819: Warning: This is the location of the conflicting usage
{standard input}:1819: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1820: Warning: Only the first path encountering the conflict is reported
{standard input}:1820: Warning: This is the location of the conflicting usage
{standard input}:1820: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1821: Warning: Only the first path encountering the conflict is reported
{standard input}:1821: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:18725: Warning: This is the location of the conflicting usage
{standard input}:18739: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:1918: Warning: This is the location of the conflicting usage
{standard input}:1919: Warning: Only the first path encountering the conflict is reported
{standard input}:1919: Warning: This is the location of the conflicting usage
{standard input}:1919: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1920: Warning: Only the first path encountering the conflict is reported
{standard input}:1920: Warning: This is the location of the conflicting usage
{standard input}:1920: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1921: Warning: Only the first path encountering the conflict is reported
{standard input}:1921: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1933: Warning: This is the location of the conflicting usage
{standard input}:1934: Warning: Only the first path encountering the conflict is reported
{standard input}:1934: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 16
{standard input}:1946: Warning: This is the location of the conflicting usage
{standard input}:194: Warning: This is the location of the conflicting usage
{standard input}:1956: Warning: Use of 'cmp.ne' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:2039: Warning: This is the location of the conflicting usage
{standard input}:2050: Warning: Only the first path encountering the conflict is reported
{standard input}:2050: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:206: Warning: Only the first path encountering the conflict is reported
{standard input}:206: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:20946: Warning: This is the location of the conflicting usage
{standard input}:20960: Warning: Only the first path encountering the conflict is reported
{standard input}:20960: Warning: Use of 'st8' may violate RAW dependency 'DBR#' (data)
{standard input}:20962: Warning: Only the first path encountering the conflict is reported
{standard input}:20962: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:20980: Warning: Only the first path encountering the conflict is reported
{standard input}:20980: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:20981: Warning: Only the first path encountering the conflict is reported
{standard input}:20981: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:2284: Warning: This is the location of the conflicting usage
{standard input}:2289: Warning: This is the location of the conflicting usage
{standard input}:2290: Warning: Only the first path encountering the conflict is reported
{standard input}:2290: Warning: This is the location of the conflicting usage
{standard input}:2290: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2291: Warning: Only the first path encountering the conflict is reported
{standard input}:2291: Warning: This is the location of the conflicting usage
{standard input}:2291: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2292: Warning: Only the first path encountering the conflict is reported
{standard input}:2292: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2295: Warning: Only the first path encountering the conflict is reported
{standard input}:2295: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:2340: Warning: This is the location of the conflicting usage
{standard input}:2342: Warning: Only the first path encountering the conflict is reported
{standard input}:2342: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:24111: Warning: This is the location of the conflicting usage
{standard input}:24113: Warning: Only the first path encountering the conflict is reported
{standard input}:24113: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:2472: Warning: This is the location of the conflicting usage
{standard input}:2474: Warning: Only the first path encountering the conflict is reported
{standard input}:2474: Warning: This is the location of the conflicting usage
{standard input}:2474: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2476: Warning: Only the first path encountering the conflict is reported
{standard input}:2476: Warning: This is the location of the conflicting usage
{standard input}:2476: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2478: Warning: Only the first path encountering the conflict is reported
{standard input}:2478: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:24961: Warning: This is the location of the conflicting usage
{standard input}:24963: Warning: Only the first path encountering the conflict is reported
{standard input}:24963: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:25714: Warning: This is the location of the conflicting usage
{standard input}:25716: Warning: Only the first path encountering the conflict is reported
{standard input}:25716: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:2639: Warning: This is the location of the conflicting usage
{standard input}:2640: Warning: Only the first path encountering the conflict is reported
{standard input}:2640: Warning: This is the location of the conflicting usage
{standard input}:2640: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2641: Warning: Only the first path encountering the conflict is reported
{standard input}:2641: Warning: This is the location of the conflicting usage
{standard input}:2641: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2642: Warning: Only the first path encountering the conflict is reported
{standard input}:2642: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:26609: Warning: This is the location of the conflicting usage
{standard input}:26611: Warning: Only the first path encountering the conflict is reported
{standard input}:26611: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:2662: Warning: This is the location of the conflicting usage
{standard input}:2663: Warning: Only the first path encountering the conflict is reported
{standard input}:2663: Warning: This is the location of the conflicting usage
{standard input}:2663: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2664: Warning: Only the first path encountering the conflict is reported
{standard input}:2664: Warning: This is the location of the conflicting usage
{standard input}:2664: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2665: Warning: Only the first path encountering the conflict is reported
{standard input}:2665: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:268: Warning: This is the location of the conflicting usage
{standard input}:272: Warning: Only the first path encountering the conflict is reported
{standard input}:272: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:2825: Warning: This is the location of the conflicting usage
{standard input}:2827: Warning: Only the first path encountering the conflict is reported
{standard input}:2827: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:30688: Warning: This is the location of the conflicting usage
{standard input}:30690: Warning: Only the first path encountering the conflict is reported
{standard input}:30690: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:3178: Warning: This is the location of the conflicting usage
{standard input}:3190: Warning: Use of 'cmp4.lt' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:3201: Warning: This is the location of the conflicting usage
{standard input}:3203: Warning: Only the first path encountering the conflict is reported
{standard input}:3203: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:32390: Warning: This is the location of the conflicting usage
{standard input}:32392: Warning: Only the first path encountering the conflict is reported
{standard input}:32392: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:3247: Warning: This is the location of the conflicting usage
{standard input}:3288: Warning: Only the first path encountering the conflict is reported
{standard input}:3288: Warning: Use of 'tbit.z' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:3339: Warning: This is the location of the conflicting usage
{standard input}:3341: Warning: Only the first path encountering the conflict is reported
{standard input}:3341: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:3356: Warning: This is the location of the conflicting usage
{standard input}:3363: Warning: Only the first path encountering the conflict is reported
{standard input}:3363: Warning: Use of 'cmp4.ne' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:3506: Warning: This is the location of the conflicting usage
{standard input}:3508: Warning: Only the first path encountering the conflict is reported
{standard input}:3508: Warning: Use of 'addl' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 8
{standard input}:3544: Warning: This is the location of the conflicting usage
{standard input}:3545: Warning: Only the first path encountering the conflict is reported
{standard input}:3545: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:3559: Warning: This is the location of the conflicting usage
{standard input}:3561: Warning: Only the first path encountering the conflict is reported
{standard input}:3561: Warning: This is the location of the conflicting usage
{standard input}:3561: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3563: Warning: Only the first path encountering the conflict is reported
{standard input}:3563: Warning: This is the location of the conflicting usage
{standard input}:3563: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3565: Warning: Only the first path encountering the conflict is reported
{standard input}:3565: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3724: Warning: This is the location of the conflicting usage
{standard input}:3725: Warning: Only the first path encountering the conflict is reported
{standard input}:3725: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:3772: Warning: This is the location of the conflicting usage
{standard input}:3774: Warning: Only the first path encountering the conflict is reported
{standard input}:3774: Warning: Use of 'addl' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 8
{standard input}:3814: Warning: This is the location of the conflicting usage
{standard input}:3815: Warning: Only the first path encountering the conflict is reported
{standard input}:3815: Warning: This is the location of the conflicting usage
{standard input}:3815: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3816: Warning: Only the first path encountering the conflict is reported
{standard input}:3816: Warning: This is the location of the conflicting usage
{standard input}:3816: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3817: Warning: Only the first path encountering the conflict is reported
{standard input}:3817: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4038: Warning: This is the location of the conflicting usage
{standard input}:4050: Warning: Only the first path encountering the conflict is reported
{standard input}:4050: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:417: Warning: This is the location of the conflicting usage
{standard input}:419: Warning: Only the first path encountering the conflict is reported
{standard input}:419: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:4477: Warning: This is the location of the conflicting usage
{standard input}:4479: Warning: Only the first path encountering the conflict is reported
{standard input}:4479: Warning: This is the location of the conflicting usage
{standard input}:4479: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4481: Warning: Only the first path encountering the conflict is reported
{standard input}:4481: Warning: This is the location of the conflicting usage
{standard input}:4481: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4483: Warning: Only the first path encountering the conflict is reported
{standard input}:4483: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5272: Warning: This is the location of the conflicting usage
{standard input}:5287: Warning: Only the first path encountering the conflict is reported
{standard input}:5287: Warning: Use of 'cmp.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:5404: Warning: This is the location of the conflicting usage
{standard input}:5405: Warning: Only the first path encountering the conflict is reported
{standard input}:5405: Warning: This is the location of the conflicting usage
{standard input}:5405: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5406: Warning: Only the first path encountering the conflict is reported
{standard input}:5406: Warning: This is the location of the conflicting usage
{standard input}:5406: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5407: Warning: Only the first path encountering the conflict is reported
{standard input}:5407: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5431: Warning: This is the location of the conflicting usage
{standard input}:5436: Warning: Only the first path encountering the conflict is reported
{standard input}:5436: Warning: Use of 'mov' violates RAW dependency 'PSR.mfl' (impliedf)
{standard input}:564: Warning: This is the location of the conflicting usage
{standard input}:579: Warning: Only the first path encountering the conflict is reported
{standard input}:579: Warning: Use of 'cmp.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:586: Warning: This is the location of the conflicting usage
{standard input}:588: Warning: Only the first path encountering the conflict is reported
{standard input}:588: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:6173: Warning: This is the location of the conflicting usage
{standard input}:6188: Warning: Only the first path encountering the conflict is reported
{standard input}:6188: Warning: Use of 'mov' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:6986: Warning: This is the location of the conflicting usage
{standard input}:6996: Warning: Use of 'cmp4.ne' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:7030: Warning: This is the location of the conflicting usage
{standard input}:7041: Warning: Only the first path encountering the conflict is reported
{standard input}:7041: Warning: Use of 'ssm' violates WAW dependency 'PSR.i' (impliedf)
{standard input}:7119: Warning: This is the location of the conflicting usage
{standard input}:7130: Warning: Only the first path encountering the conflict is reported
{standard input}:7130: Warning: Use of 'ssm' violates WAW dependency 'PSR.i' (impliedf)
{standard input}:782: Warning: This is the location of the conflicting usage
{standard input}:783: Warning: Only the first path encountering the conflict is reported
{standard input}:783: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:7842: Warning: This is the location of the conflicting usage
{standard input}:7848: Warning: Use of 'cmp4.ne' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:797: Warning: This is the location of the conflicting usage
{standard input}:798: Warning: Only the first path encountering the conflict is reported
{standard input}:798: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:841: Warning: This is the location of the conflicting usage
{standard input}:842: Warning: Only the first path encountering the conflict is reported
{standard input}:842: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:8468: Warning: This is the location of the conflicting usage
{standard input}:8469: Warning: Only the first path encountering the conflict is reported
{standard input}:8469: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:8850: Warning: This is the location of the conflicting usage
{standard input}:8851: Warning: Only the first path encountering the conflict is reported
{standard input}:8851: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:9326: Warning: This is the location of the conflicting usage
{standard input}:9327: Warning: Only the first path encountering the conflict is reported
{standard input}:9327: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:934: Warning: This is the location of the conflicting usage
{standard input}:935: Warning: Only the first path encountering the conflict is reported
{standard input}:935: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
{standard input}:963: Warning: This is the location of the conflicting usage
{standard input}:9675: Warning: This is the location of the conflicting usage
{standard input}:9682: Warning: Only the first path encountering the conflict is reported
{standard input}:9682: Warning: Use of 'mov' violates RAW dependency 'PSR.mfl' (impliedf)
{standard input}:969: Warning: This is the location of the conflicting usage
{standard input}:979: Warning: Only the first path encountering the conflict is reported
{standard input}:979: Warning: Use of 'cmp.ltu' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:984: Warning: Only the first path encountering the conflict is reported
{standard input}:984: Warning: Use of 'mov' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
{standard input}:9973: Warning: This is the location of the conflicting usage
{standard input}:9974: Warning: Only the first path encountering the conflict is reported
{standard input}:9974: Warning: Use of 'mov' may violate WAW dependency 'GR%, % in 1 - 127' (impliedf), specific resource number is 14
