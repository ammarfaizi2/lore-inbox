Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTJRAtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTJRAtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:49:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:53737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbTJRAtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:49:40 -0400
Subject: Re: Linux 2.6.0-test8 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310171530001.1988-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066438176.3653.7.camel@lapcherry>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Oct 2003 17:49:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6 Compile Statistics (gcc 3.2.2)

The build is in progress, so the links on the web site won't be active
until about 7PM (PDT).

Warnings/Errors Summary

Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
             (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
-----------  -----------  -------- -------- -------- -------- ---------
2.6.0-test8    0w/0e       0w/0e   178w/ 0e  12w/0e   3w/0e    216w/0e
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



John




