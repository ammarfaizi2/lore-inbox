Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUB2Qx1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 11:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUB2Qx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 11:53:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:16590 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262079AbUB2QxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 11:53:21 -0500
From: john cherry <cherry@osdl.org>
Date: Sun, 29 Feb 2004 08:53:20 -0800
Message-Id: <200402291653.i1TGrKM10457@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.4-rc1 - 2004-02-28.17.30) - 165 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ia64/kernel/ivt.S:166: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:181: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:190: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:190: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:229: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:232: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:232: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:267: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:270: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:270: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:505: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:507: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:507: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:564: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:566: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:566: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
arch/ia64/kernel/ivt.S:612: Warning: This is the location of the conflicting usage
arch/ia64/kernel/ivt.S:614: Warning: Only the first path encountering the conflict is reported
arch/ia64/kernel/ivt.S:614: Warning: Use of 'ld8' violates RAW dependency 'DTC' (data)
{standard input}:10487: Warning: This is the location of the conflicting usage
{standard input}:10489: Warning: Only the first path encountering the conflict is reported
{standard input}:10489: Warning: This is the location of the conflicting usage
{standard input}:10489: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:10491: Warning: Only the first path encountering the conflict is reported
{standard input}:10491: Warning: This is the location of the conflicting usage
{standard input}:10491: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:10493: Warning: Only the first path encountering the conflict is reported
{standard input}:10493: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1104: Warning: This is the location of the conflicting usage
{standard input}:1106: Warning: Only the first path encountering the conflict is reported
{standard input}:1106: Warning: This is the location of the conflicting usage
{standard input}:1106: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1108: Warning: Only the first path encountering the conflict is reported
{standard input}:1108: Warning: This is the location of the conflicting usage
{standard input}:1108: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1110: Warning: Only the first path encountering the conflict is reported
{standard input}:1110: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1821: Warning: This is the location of the conflicting usage
{standard input}:1822: Warning: Only the first path encountering the conflict is reported
{standard input}:1822: Warning: This is the location of the conflicting usage
{standard input}:1822: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1823: Warning: Only the first path encountering the conflict is reported
{standard input}:1823: Warning: This is the location of the conflicting usage
{standard input}:1823: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1824: Warning: Only the first path encountering the conflict is reported
{standard input}:1824: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1862: Warning: This is the location of the conflicting usage
{standard input}:1873: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1875: Warning: Use of 'ld8.mov' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1921: Warning: This is the location of the conflicting usage
{standard input}:1922: Warning: Only the first path encountering the conflict is reported
{standard input}:1922: Warning: This is the location of the conflicting usage
{standard input}:1922: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1923: Warning: Only the first path encountering the conflict is reported
{standard input}:1923: Warning: This is the location of the conflicting usage
{standard input}:1923: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1924: Warning: Only the first path encountering the conflict is reported
{standard input}:1924: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:1931: Warning: Use of 'ld8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1942: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1944: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1949: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1957: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1960: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1965: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1967: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1972: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1974: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1978: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:1980: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2003: Warning: This is the location of the conflicting usage
{standard input}:2014: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2016: Warning: Use of 'ld8.mov' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2072: Warning: Use of 'ld8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2083: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:20840: Warning: This is the location of the conflicting usage
{standard input}:20854: Warning: Only the first path encountering the conflict is reported
{standard input}:20854: Warning: Use of 'st8' may violate RAW dependency 'DBR#' (data)
{standard input}:20856: Warning: Only the first path encountering the conflict is reported
{standard input}:20856: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:2085: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:20874: Warning: Only the first path encountering the conflict is reported
{standard input}:20874: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:20875: Warning: Only the first path encountering the conflict is reported
{standard input}:20875: Warning: Use of 'ld4' may violate RAW dependency 'DBR#' (data)
{standard input}:2090: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2098: Warning: Use of 'ld4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2101: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2106: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2108: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2113: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2115: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2119: Warning: Use of 'st4' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2121: Warning: Use of 'st8' may violate RAW dependency 'RR#' (data), specific resource number is 4
{standard input}:2292: Warning: This is the location of the conflicting usage
{standard input}:2293: Warning: Only the first path encountering the conflict is reported
{standard input}:2293: Warning: This is the location of the conflicting usage
{standard input}:2293: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2294: Warning: Only the first path encountering the conflict is reported
{standard input}:2294: Warning: This is the location of the conflicting usage
{standard input}:2294: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2295: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2486: Warning: This is the location of the conflicting usage
{standard input}:2488: Warning: Only the first path encountering the conflict is reported
{standard input}:2488: Warning: This is the location of the conflicting usage
{standard input}:2488: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2490: Warning: Only the first path encountering the conflict is reported
{standard input}:2490: Warning: This is the location of the conflicting usage
{standard input}:2490: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2492: Warning: Only the first path encountering the conflict is reported
{standard input}:2492: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2642: Warning: This is the location of the conflicting usage
{standard input}:2643: Warning: Only the first path encountering the conflict is reported
{standard input}:2643: Warning: This is the location of the conflicting usage
{standard input}:2643: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2644: Warning: Only the first path encountering the conflict is reported
{standard input}:2644: Warning: This is the location of the conflicting usage
{standard input}:2644: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2645: Warning: Only the first path encountering the conflict is reported
{standard input}:2645: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2668: Warning: This is the location of the conflicting usage
{standard input}:2669: Warning: Only the first path encountering the conflict is reported
{standard input}:2669: Warning: This is the location of the conflicting usage
{standard input}:2669: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2670: Warning: Only the first path encountering the conflict is reported
{standard input}:2670: Warning: This is the location of the conflicting usage
{standard input}:2670: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:2671: Warning: Only the first path encountering the conflict is reported
{standard input}:2671: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3566: Warning: This is the location of the conflicting usage
{standard input}:3568: Warning: Only the first path encountering the conflict is reported
{standard input}:3568: Warning: This is the location of the conflicting usage
{standard input}:3568: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3570: Warning: Only the first path encountering the conflict is reported
{standard input}:3570: Warning: This is the location of the conflicting usage
{standard input}:3570: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3572: Warning: Only the first path encountering the conflict is reported
{standard input}:3572: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3817: Warning: This is the location of the conflicting usage
{standard input}:3818: Warning: Only the first path encountering the conflict is reported
{standard input}:3818: Warning: This is the location of the conflicting usage
{standard input}:3818: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3819: Warning: Only the first path encountering the conflict is reported
{standard input}:3819: Warning: This is the location of the conflicting usage
{standard input}:3819: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:3820: Warning: Only the first path encountering the conflict is reported
{standard input}:3820: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4484: Warning: This is the location of the conflicting usage
{standard input}:4486: Warning: Only the first path encountering the conflict is reported
{standard input}:4486: Warning: This is the location of the conflicting usage
{standard input}:4486: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4488: Warning: Only the first path encountering the conflict is reported
{standard input}:4488: Warning: This is the location of the conflicting usage
{standard input}:4488: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:4490: Warning: Only the first path encountering the conflict is reported
{standard input}:4490: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5410: Warning: This is the location of the conflicting usage
{standard input}:5411: Warning: Only the first path encountering the conflict is reported
{standard input}:5411: Warning: This is the location of the conflicting usage
{standard input}:5411: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5412: Warning: Only the first path encountering the conflict is reported
{standard input}:5412: Warning: This is the location of the conflicting usage
{standard input}:5412: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
{standard input}:5413: Warning: Only the first path encountering the conflict is reported
{standard input}:5413: Warning: Use of 'mov' may violate WAW dependency 'RR#' (impliedf)
