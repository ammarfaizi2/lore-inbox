Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVAXTbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVAXTbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVAXT2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:28:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:10649 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbVAXT14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:27:56 -0500
Subject: Re: Linux 2.6.11-rc2 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 11:28:05 -0800
Message-Id: <1106594885.19587.32.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.4.1)

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.11-rc2    18w/0e       0w/0e   365w/0e    6w/0e  22w/0e    440w/0e
2.6.11-rc1    20w/0e       0w/0e   497w/0e    6w/0e  22w/0e    577w/0e
2.6.10        13w/0e       0w/0e   778w/0e    6w/0e  15w/0e    861w/0e


Linux 2.6 (mm tree) Compile Statistics (gcc 3.4.1)

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.11-rc2-mm1   15w/0e     0w/0e   306w/14e   6w/0e  18w/0e    294w/0e
2.6.11-rc1-mm2   21w/0e     0w/0e   316w/9e    6w/0e  22w/0e    294w/0e
2.6.11-rc1-mm1   21w/0e     0w/0e   319w/0e    6w/0e  23w/0e    298w/0e
2.6.10-mm3       21w/0e     0w/0e   320w/0e    6w/0e  23w/0e    299w/0e
2.6.10-mm2       21w/0e     0w/0e   440w/0e    6w/0e  23w/0e    420w/0e
2.6.10-mm1       12w/0e     0w/0e   414w/0e    6w/0e  17w/0e    399w/0e

Daily compiles (ia32): 
   http://developer.osdl.org/cherry/compile/2.6/linus-tree/running.txt
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

John



