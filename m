Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUESQWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUESQWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUESQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 12:22:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:53475 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264335AbUESQWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 12:22:49 -0400
Subject: Re: 2.6.6-mm4 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040519040421.61263a43.akpm@osdl.org>
References: <20040519040421.61263a43.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1084983767.12134.1.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 19 May 2004 09:22:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the timeliness of the compile stats over the last week 
or so.  Here are compile stats for the 2.6.6* drops for both 
Linus' kernel and Andrew's kernel patches.  The links at the 
bottom point to the full details for the compiles (defconfig,
allnoconfig, allyesconfig, allmodconfig).

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.6          0w/0e       0w/0e   123w/ 0e   7w/0e   4w/0e    121w/0e
2.6.6-rc3      0w/0e       0w/0e   124w/ 0e   7w/0e   5w/0e    121w/0e
2.6.6-rc2      0w/0e       0w/0e   122w/ 0e   7w/0e   4w/0e    121w/0e
2.6.6-rc1      0w/0e       0w/0e   125w/ 0e   7w/0e   4w/0e    123w/0e


Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.6-mm3         0w/0e     0w/0e   112w/9w    5w/0e   2w/5e    106w/1e
2.6.6-mm3         3w/9e     0w/0e   120w/26w   5w/0e   2w/0e    114w/10e
2.6.6-mm2         4w/11e    0w/0e   120w/24w   6w/0e   2w/0e    118w/9e
2.6.6-mm1         1w/0e     0w/0e   118w/25w   6w/0e   2w/0e    114w/10e
2.6.6-rc3-mm2     0w/0e     0w/0e   117w/ 0e   8w/0e   2w/0e    116w/0e
2.6.6-rc3-mm1     0w/0e     0w/0e   120w/10e   8w/0e   2w/0e    152w/2e
2.6.6-rc2-mm2     0w/0e     1w/5e   118w/ 0e   8w/0e   3w/0e    118w/0e
2.6.6-rc2-mm1     0w/0e     0w/0e   115w/ 0e   7w/0e   3w/0e    116w/0e
2.6.6-rc1-mm1     0w/0e     0w/7e   122w/ 0e   7w/0e   4w/0e    122w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/
Latest changes in Linus' bitkeeper tree:
   http://linux.bkbits.net:8080/linux-2.5

John


