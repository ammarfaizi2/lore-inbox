Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270775AbTGNTxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTGNTxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:53:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270775AbTGNTvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:51:04 -0400
Subject: Re: Linux v2.6.0-test1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058213335.11859.4.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Jul 2003 13:08:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.6.0-test1
Compiler: gcc 3.2.2
Script: http://developer.osdl.org/~cherry/compile/compregress.sh

               bzImage       bzImage        modules
             (defconfig)  (allmodconfig) (allmodconfig)

2.6.0-test1  0 warnings     8 warnings   1296 warnings
             0 errors       9 errors       39 errors

2.5.75       0 warnings     8 warnings   1296 warnings
             0 errors       9 errors       39 errors



Compile statistics have been for kernel releases from 2.5.46 to
2.6.0-test1 at: http://developer.osdl.org/~cherry/compile/

Failure summary:

   drivers/block: 2 warnings, 1 errors
   drivers/char: 226 warnings, 4 errors
   drivers/isdn: 216 warnings, 5 errors
   drivers/media: 102 warnings, 5 errors
   drivers/mtd: 42 warnings, 1 errors
   drivers/net: 293 warnings, 6 errors
   drivers/net: 29 warnings, 6 errors
   drivers/scsi: 109 warnings, 10 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/video: 101 warnings, 3 errors
   sound: 5 warnings, 3 errors
   sound/oss: 55 warnings, 3 errors

Warning summary:


   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 28 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pci: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 5 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 9 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 39 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors

John



