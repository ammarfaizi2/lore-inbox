Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTHYW4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTHYW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:56:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:57063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262373AbTHYW4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:56:50 -0400
Subject: Re: Linux 2.6.0-test4 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1061852209.32079.22.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 25 Aug 2003 15:56:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.6.0-test4
Compiler: gcc 3.2.2
Script: http://developer.osdl.org/~cherry/compile/compregress.sh

               bzImage       bzImage        modules
             (defconfig)  (allmodconfig) (allmodconfig)

2.6.0-test4  0 warnings     3 warnings   1016 warnings
             0 errors       0 errors       34 errors

2.6.0-test3  0 warnings     7 warnings    984 warnings
             0 errors       9 errors       42 errors

2.6.0-test2  0 warnings     7 warnings   1201 warnings
             0 errors       9 errors       43 errors

2.6.0-test1  0 warnings     8 warnings   1319 warnings
             0 errors       9 errors       38 errors



Compile statistics for 2.5 kernels and 2.6 kernels are at:
http://developer.osdl.org/~cherry/compile/


Failure summary:

   drivers/block: 2 warnings, 1 errors
   drivers/isdn: 257 warnings, 6 errors
   drivers/media: 5 warnings, 5 errors
   drivers/mtd: 25 warnings, 1 errors
   drivers/net: 208 warnings, 8 errors
   drivers/net: 36 warnings, 8 errors
   drivers/scsi/aic7xxx: 0 warnings, 3 errors
   drivers/scsi: 97 warnings, 7 errors
   drivers/video: 8 warnings, 3 errors
   sound/oss: 49 warnings, 1 errors
   sound/pcmcia: 0 warnings, 2 errors
   sound: 0 warnings, 3 errors

Warning summary:

   drivers/atm: 12 warnings, 0 errors
   drivers/cdrom: 26 warnings, 0 errors
   drivers/char: 244 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 2 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/usb: 5 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   fs/afs: 2 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 13 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors


John


