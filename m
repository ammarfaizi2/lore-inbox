Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267962AbTAHVFO>; Wed, 8 Jan 2003 16:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267963AbTAHVFN>; Wed, 8 Jan 2003 16:05:13 -0500
Received: from mta5.algx.net ([67.92.168.234]:35862 "EHLO chimta04.algx.net")
	by vger.kernel.org with ESMTP id <S267962AbTAHVFK>;
	Wed, 8 Jan 2003 16:05:10 -0500
Date: Wed, 08 Jan 2003 13:13:21 -0800
From: Rowan Reid <rreid@studio3arc.com>
Subject: 2.5.54 and 2.5.52 keep failing on make modules_install
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <001c01c2b75a$ca687c20$6601a8c0@s3ac>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-Mailer: Microsoft Outlook, Build 10.0.2616
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I keep getting errors  simular to that listed below when I run make
modules_install. This happens for 2.5.52, and 2.5.54. 

depmod: *** Unresolved symbols in
/lib/modules/2.5.54/kernel/net/netlink/netlink_dev.ko

This problem does not exist on 2.5.50.  My only problem is when using
the 2.5.50 kernel I get the following error on boot. After some research
I understood there is a bug or something in 2.5.50. can someone give me
some direction.  My reason for trying to use the 2.5 kernel is to
incorperate the IPSEC features of that kernel.

 Kernel panic on boot. Error below.  It's a 2.5.50 kernel  reiserfs 
 using initrd SuSE8.0
 
 QM_MODULES not implimented
 UDF-fs: No partition found




 
Rowan Reid
Job Captain, 
Systems Administrator
STUDIO 3 ARCHITECTS
909  982  1717

