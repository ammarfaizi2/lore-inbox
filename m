Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUAUQ2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUAUQ2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:28:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:48286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265956AbUAUQ1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:27:55 -0500
Subject: Re: Linux 2.6.2-rc1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
References: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
Content-Type: text/plain
Message-Id: <1074702474.10746.2.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 08:27:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.2-rc1      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.1          0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc3      0w/0e       0w/0e   158w/ 0e  12w/0e   3w/0e    197w/0e
2.6.1-rc2      0w/0e       0w/0e   166w/ 0e  12w/0e   3w/0e    205w/0e
2.6.1-rc1      0w/0e       0w/0e   167w/ 0e  12w/0e   3w/0e    206w/0e
2.6.0          0w/0e       0w/0e   170w/ 0e  12w/0e   3w/0e    209w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/
Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Daily compiles (ia64): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running64.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

John



