Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSK1QSf>; Thu, 28 Nov 2002 11:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSK1QSf>; Thu, 28 Nov 2002 11:18:35 -0500
Received: from bitmover.com ([192.132.92.2]:12703 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265636AbSK1QSe>;
	Thu, 28 Nov 2002 11:18:34 -0500
Date: Thu, 28 Nov 2002 08:25:50 -0800
From: Larry McVoy <lm@bitmover.com>
Message-Id: <200211281625.gASGPo804227@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: connectivity to bkbits.net?
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've been having problems getting out to certain parts of the net for the
last few days, in particular, we can't get to sgi.com which is unusual.
If you are having problems getting to bkbits.net, let me know.  We have
a couple of machines at rackspace and I can push repos over there.

traceroute to sgi.com (128.167.58.40), 30 hops max, 38 byte packets
 1  bitmover (10.3.9.3)  0.535 ms  0.103 ms  0.100 ms
 2  cisco (192.132.92.1)  1.236 ms  1.175 ms  1.228 ms
 3  s9-1-1-6-0.ar2.SFO1.gblx.net (64.214.96.229)  3.080 ms  3.205 ms  2.982 ms
 4  64.215.195.189 (64.215.195.189)  3.052 ms  3.256 ms  3.114 ms
 5  64.211.147.86 (64.211.147.86)  4.592 ms  4.623 ms  4.468 ms
 6  so6-0-0-2488M.br2.PAO2.gblx.net (207.136.163.126)  4.586 ms  4.530 ms  4.701 ms
 7  p4-0.paix-bi1.bbnplanet.net (4.0.6.81)  4.627 ms  4.467 ms  4.427 ms
 8  p6-0.snjpca1-br1.bbnplanet.net (4.24.7.61)  5.179 ms  5.678 ms  5.215 ms
 9  p1-0.sjccolo-dbe1.bbnplanet.net (4.24.6.253)  5.431 ms  5.214 ms  5.235 ms
10  vlan40.sjccolo-isw03-rc1.bbnplanet.net (128.11.200.91)  5.326 ms  5.396 ms  5.464 ms
11  128.11.16.169 (128.11.16.169)  5.581 ms  5.470 ms  5.654 ms
12  *
