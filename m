Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTJHX5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJHX5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:57:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:16826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261845AbTJHX5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:57:53 -0400
Subject: Re: Linux 2.6.0-test7 - stability freeze (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065657470.5691.76.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Oct 2003 16:57:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImate  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- ---------
2.6.0-test7    0w/0e       0w/0e   173w/ 1e   8w/0e   3w/0e    226w/0e
2.6.0-test6    0w/0e       1w/0e   188w/ 1e  12w/0e   3w/0e    260w/2e
2.6.0-test5    0w/0e       2w/0e   205w/ 9e  15w/1e   0w/0e    305w/5e
2.6.0-test4    0w/0e       2w/0e   797w/55e  68w/1e   3w/0e   1016w/34e
2.6.0-test3    0w/0e       2w/0e   755w/66e  62w/1e   7w/9e    984w/42e
2.6.0-test2    0w/0e       1w/0e   952w/65e  63w/2e   7w/9e   1201w/43e
2.6.0-test1    0w/0e       1w/0e  1016w/60e  75w/1e   8w/9e   1319w/38e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/
Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Daily compiles (ia64): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running64.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

Warning Summary

   drivers/atm: 1 warnings, 0 errors
   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 2 warnings, 0 errors
   drivers/ide: 30 warnings, 0 errors
   drivers/media: 5 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 25 warnings, 0 errors
   drivers/net: 23 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi: 43 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   net: 9 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 47 warnings, 0 errors

Error Summary

   drivers/net: 0 warnings, 1 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors

John




