Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313183AbSERQs2>; Sat, 18 May 2002 12:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSERQs1>; Sat, 18 May 2002 12:48:27 -0400
Received: from mout1.freenet.de ([194.97.50.132]:42123 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S313183AbSERQs0>;
	Sat, 18 May 2002 12:48:26 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: VIA686A - timer problems, time jumps
Date: Sat, 18 May 2002 18:50:22 +0200
Organization: Privat
Message-ID: <ac60oe$95l$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1021740622 9397 192.168.1.3 (18 May 2002 16:50:22 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


some time ago I wrote about problems with the via-timer and kernel 2.4.x.

Meanwhile I tested kernel linux-2.4.19-pre7ac2 and newly pre8ac4. I couldn't 
detect any problems with the timer (sudden time jumps). Does anybody know 
the reason why? I couldn't find any patch related to this problem in the 
Changelogs.

The problem occures in pre7 - I didn't test pre8.


Regards,
Andreas Hartmann
