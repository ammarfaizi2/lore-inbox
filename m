Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265928AbUHZJSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUHZJSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHZJSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:18:38 -0400
Received: from web41508.mail.yahoo.com ([66.218.93.91]:50816 "HELO
	web41508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267882AbUHZJFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:05:24 -0400
Message-ID: <20040826090508.79320.qmail@web41508.mail.yahoo.com>
Date: Thu, 26 Aug 2004 10:05:08 +0100 (BST)
From: =?iso-8859-1?q?Arne=20Henrichsen?= <ahenric@yahoo.com>
Subject: Re: sys_sem* undefined
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040825091413.0c43c78d.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

thanks for the help. I am very new to Linux
programming, and I do not understand what you mean
with  'syscalls are not called by name'. 

I did find the header file syscalls.h, recompiled my
code but it still says the following:

*** Warning: "sys_semop"
[/prj/builds/host/linux/prj.ko] undefined!
*** Warning: "sys_semctl"
[/prj/builds/host/linux/prj.ko] undefined!
*** Warning: "sys_semget"
[/prj/builds/host/linux/prj.ko] undefined!

And when I load the module, then it tells me:

insmod: error inserting './prj.ko': -1 Unknown symbol
in module

So, I call sys_sem* functions from my code. What else
must I do?

Thanks again.
Arne
  


	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
