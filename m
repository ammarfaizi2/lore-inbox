Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274892AbTHKXDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274889AbTHKXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:03:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:7871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274892AbTHKXDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:03:40 -0400
Subject: Re: Linux 2.6.0-test3 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
References: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060643227.30492.13.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Aug 2003 16:07:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.6.0-test3
Compiler: gcc 3.2.2
Script: http://developer.osdl.org/~cherry/compile/compregress.sh

               bzImage       bzImage        modules
             (defconfig)  (allmodconfig) (allmodconfig)

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
   drivers/char: 191 warnings, 4 errors
   drivers/isdn: 212 warnings, 9 errors
   drivers/media: 17 warnings, 6 errors
   drivers/mtd: 42 warnings, 1 errors
   drivers/net: 214 warnings, 5 errors
   drivers/net: 27 warnings, 5 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/scsi: 102 warnings, 10 errors
   drivers/video: 13 warnings, 3 errors
   sound/oss: 51 warnings, 2 errors
   sound: 2 warnings, 2 errors

Warning summary:

   drivers/atm: 12 warnings, 0 errors
   drivers/bluetooth: 2 warnings, 0 errors
   drivers/cdrom: 26 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 29 warnings, 0 errors
   drivers/ieee1394: 1 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 35 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors

John



