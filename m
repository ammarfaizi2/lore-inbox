Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRC0L1m>; Tue, 27 Mar 2001 06:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRC0L1c>; Tue, 27 Mar 2001 06:27:32 -0500
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:65291 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id <S131219AbRC0L1Q>; Tue, 27 Mar 2001 06:27:16 -0500
Message-Id: <200103271127.f2RBRO513723@robert2.mpe-garching.mpg.de>
To: linux-kernel@vger.kernel.org
reply-to: robert@mpe.mpg.de
Subject: ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2
Date: Tue, 27 Mar 2001 13:27:24 +0200
From: Robert Suetterlin <sutter@robert2.mpe-garching.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2
DESCR: we have a Maxdata 4-way Xeon, with 16GByte RAM. If we compile a kernel (2.4.0 or 2.4.2 up to ac25) that uses all 16 GByte RAM the machine gets very slow. For example network Bandwidth of 100MBit Ethernet is about 1-50kByte/sec.  Access to harddrives seems to be equally slow.
	I really do not know where to start looking, but I know that lots of people seem to be using n-way Xeon with 16+GByte RAM without severe performance problem.
KEYWORDS: kernel, slow, maxdata, 16GB
KERNEL: 2.4.0 and 2.4.2 (upto ac25)

If more information --- like /proc/cpuinfo or uname -a or versions of installed software ... --- is needed to analyse the problem, please tell me, I will gladly send it.

Sincerely,

	Robert S.
