Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTEEUxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTEEUxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:53:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbTEEUxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:53:23 -0400
Subject: Re: Linux 2.5.69
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052168752.27203.175.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 14:05:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.69
Compiler: gcc 3.2.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh


                               2.5.68               2.5.69
                       --------------------    -----------------
bzImage (defconfig)          7 warnings           7 warnings
                             0 errors             0 errors

bzImage (allmodconfig)      11 warnings          11 warnings
                             6 errors             0 errors

modules (allmodconfig)    1975 warnings        1567 warnings
                            60 errors            57 errors

Compile statistics have been for kernel releases from 2.5.46 to 2.5.69
at: www.osdl.org/archive/cherry/stability

Failure summary:

   drivers/block: 6 warnings, 1 errors
   drivers/bluetooth: 0 warnings, 1 errors
   drivers/char: 319 warnings, 6 errors
   drivers/hotplug: 16 warnings, 2 errors
   drivers/isdn: 246 warnings, 6 errors
   drivers/media: 128 warnings, 6 errors
   drivers/mtd: 31 warnings, 1 errors
   drivers/net: 363 warnings, 6 errors
   drivers/video: 82 warnings, 13 errors
   drivers/video/matrox: 3 warnings, 10 errors
   sound: 5 warnings, 3 errors
   sound/oss: 49 warnings, 3 errors



Warning summary:

   drivers/atm: 39 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 33 warnings, 0 errors
   drivers/md: 3 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 10 warnings, 0 errors
   drivers/usb: 17 warnings, 0 errors
   drivers/video/aty: 4 warnings, 0 errors
   drivers/video/riva: 3 warnings, 0 errors
   drivers/video/sis: 3 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfs: 1 warnings, 0 errors
   fs/nfsd: 4 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 56 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/pci: 1 warnings, 0 errors


Other stability-related links:
   OSDL Stability page:
       http://osdl.org/projects/26lnxstblztn/results/
   Nightly linux-2.5 bk build:
       www.osdl.org/archive/cherry/stability/linus-tree/running.txt
   2.5 porting items:
       www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt
   2.5 porting items history:
       www.osdl.org/archive/cherry/stability/linus-tree/port_history.txt

John




