Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUC3QFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbUC3QFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:05:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:31135 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S262175AbUC3QFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:05:14 -0500
Subject: Re: Linux 2.6.5-rc3 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1080662648.6319.1.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 08:04:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the compile stats for the last week or so of releases.
The 2.6.5-rc3.mm1 release is almost done.  Stay tuned.

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.5-rc3      0w/0e       0w/0e   135w/ 0e   8w/0e   4w/0e    132w/0e
2.6.5-rc2      0w/0e       0w/0e   135w/ 0e   8w/0e   3w/0e    132w/0e
2.6.5-rc1      0w/0e       0w/0e   138w/ 0e   8w/0e   3w/0e    135w/0e
2.6.4          1w/0e       0w/0e   145w/ 0e   7w/0e   3w/0e    142w/0e

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.5-rc2-mm5     0w/0e     5w/0e   130w/ 0e   8w/0e   4w/0e    129w/0e
2.6.5-rc2-mm4     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm3     0w/0e     5w/0e   134w/ 0e   8w/0e   3w/0e    133w/0e
2.6.5-rc2-mm2     0w/0e     5w/0e   137w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc2-mm1     0w/0e     5w/0e   136w/ 0e   8w/0e   3w/0e    134w/0e
2.6.5-rc1-mm2     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e
2.6.5-rc1-mm1     0w/0e     5w/0e   135w/ 5e   8w/0e   3w/0e    133w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/
Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Daily compiles (ia64): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running64.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

John


