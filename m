Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbUCPQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbUCPQUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:20:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:25491 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S263983AbUCPQTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:19:35 -0500
Subject: Re: Linux 2.6.5-rc1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1079453971.2635.1.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 08:19:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.5-rc1      0w/0e       0w/0e   138w/ 0e   8w/0e   3w/0e    135w/0e
2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e
2.6.4-rc2      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.4-rc1      1w/0e       0w/0e   148w/ 0e   7w/0e   3w/0e    145w/0e
2.6.3          1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc4      1w/0e       0w/0e   142w/ 0e   9w/0e   3w/0e    142w/0e
2.6.3-rc3      1w/0e       0w/0e   145w/ 7e   9w/0e   3w/0e    148w/0e
2.6.3-rc2      1w/0e       0w/0e   141w/ 0e   9w/0e   3w/0e    144w/0e
2.6.3-rc1      1w/0e       0w/0e   145w/ 0e   9w/0e   3w/0e    177w/0e
2.6.2          1w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc3      0w/0e       0w/0e   152w/ 0e  12w/0e   3w/0e    187w/0e
2.6.2-rc2      0w/0e       0w/0e   153w/ 8e  12w/0e   3w/0e    188w/0e
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



