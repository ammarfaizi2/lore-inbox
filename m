Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGLXtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGLXtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUGLXtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:49:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:58257 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264261AbUGLXth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:49:37 -0400
Subject: Re: Linux 2.6.8-rc1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1089676151.3547.30.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 12 Jul 2004 16:49:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last couple 2.6 kernels and mm kernels...

Linux 2.6 Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.8-rc1      0w/0e       0w/0e    87w/ 0e   5w/0e   1w/0e     82w/0e
2.6.7          0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    102w/0e
2.6.7-rc3      0w/0e       0w/0e   108w/ 0e   5w/0e   2w/0e    104w/0e
2.6.7-rc2      0w/0e       0w/0e   110w/ 0e   5w/0e   2w/0e    106w/0e
2.6.7-rc1      0w/0e       0w/0e   111w/ 0e   6w/0e   2w/0e    107w/0e
2.6.6          0w/0e       0w/0e   123w/ 0e   7w/0e   4w/0e    121w/0e

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.7-mm7         0w/0e     0w/0e    89w/9e    5w/0e   1w/0e     84w/0e
2.6.7-mm6         0w/0e     0w/0e    85w/9e    5w/0e   1w/0e     80w/0e
2.6.7-mm5         0w/0e     0w/0e    92w/0e    5w/0e   1w/0e     87w/0e
2.6.7-mm4         0w/0e     0w/0e    94w/0e    5w/0e   1w/0e     89w/0e
2.6.7-mm3         0w/0e     0w/0e    90w/6e    5w/0e   1w/0e     86w/0e
2.6.7-mm2         0w/0e     0w/0e   109w/0e    7w/0e   1w/0e    106w/0e
2.6.7-mm1         0w/0e     5w/0e   108w/0e    5w/0e   1w/0e    104w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

John



