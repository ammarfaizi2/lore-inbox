Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUAVQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266050AbUAVQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:26:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:1427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265815AbUAVQ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:26:11 -0500
Subject: Re: 2.6.2-rc1-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040122013501.2251e65e.akpm@osdl.org>
References: <20040122013501.2251e65e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074788769.29125.1.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 08:26:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Error Summary (individual module builds):

   drivers/net: 0 warnings, 1 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors


Warning Summary (individual module builds):

   drivers/block: 1 warnings, 0 errors
   drivers/cdrom: 3 warnings, 0 errors
   drivers/char: 4 warnings, 0 errors
   drivers/ide: 29 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/mtd: 23 warnings, 0 errors
   drivers/net: 7 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/pcmcia: 4 warnings, 0 errors
   drivers/scsi: 33 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 5 warnings, 0 errors
   drivers/usb: 2 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors
   sound/oss: 33 warnings, 0 errors

John



