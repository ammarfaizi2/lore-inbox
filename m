Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTIJEW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTIJEW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:22:26 -0400
Received: from www.mail15.com ([194.186.131.96]:55563 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S264520AbTIJEWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:22:25 -0400
Date: Wed, 10 Sep 2003 08:22:23 +0400 (MSD)
Message-Id: <200309100422.h8A4MNjU084251@www.mail15.com>
From: Muthukumar <kmuthukumar@mail15.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: 
X-Proxy-IP: [203.129.254.138]
X-Originating-IP: [172.16.1.46]
Subject: Introduction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all ,

I am working in squid developments oriented works.Then at presently 
i  want to upgrade my kernel to 2.6 for epoll support testing on 
Squid.


For that i have upgrade my gcc and i have tried to  compiled the 
kernel ,but i am getting some errors on kernel-2.6.0-test3 on IA64 
with ia64 linux patch.


The problem is as 
HOSTCC  scripts/lxdialog/checklist.o
In file included from scripts/lxdialog/checklist.c:24:
scripts/lxdialog/dialog.h:29:20: curses.h: No such file or 
directory
In file included from scripts/lxdialog/checklist.c:24:
scripts/lxdialog/dialog.h:127: error: parse error before 
"use_colors"
And so many error and warning so what is the problem in this.

I have browsed for this problem but i didn't get the answers for 
that.

SO pls inform about this/.

Thanks
Mvthv
