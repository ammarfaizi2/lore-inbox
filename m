Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319642AbSH3Sjb>; Fri, 30 Aug 2002 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319643AbSH3Sjb>; Fri, 30 Aug 2002 14:39:31 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:11481 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S319642AbSH3Sja>; Fri, 30 Aug 2002 14:39:30 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A25@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: 
Date: Fri, 30 Aug 2002 14:43:52 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an embedded system runing a 2.4.18-3 Kernel. It runs from a 256MB
compact flash disk (emulates an IDE interface). I am using an EXT2
filesystem. During some power-off/power-on testing, the disk check failed.
It dropped me to a shell and I had to run e2fsck -cfv to correct this
problem. This is all good and well in a lab environment, but in reality,
there is nobody there to perform the repair (running system is not equipped
with keyboard and monitor). Is there any way to invoke e2fsck automatically
or inhibit the failure detection mechanism? Please CC me directly on any
responses.


Thanks in advance....

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com

