Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTIJFJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTIJFJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:09:08 -0400
Received: from www.mail15.com ([194.186.131.96]:43274 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S264534AbTIJFJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:09:02 -0400
Date: Wed, 10 Sep 2003 09:09:01 +0400 (MSD)
Message-Id: <200309100509.h8A591O4087507@www.mail15.com>
From: Muthukumar <kmuthukumar@mail15.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: 
X-Proxy-IP: [203.129.254.138]
X-Originating-IP: [172.16.1.46]
Subject: Problem on linux-kernel-2.6.0-test3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all ,

I am muthukumar working in squid development ,for the developmet in 
epoll,i have tried to compile the kernel-2.6 with IA64 support on 
IA64 platform.

But in the compilation i am getting the error as 

HOSTCC  scripts/lxdialog/checklist.o
In file included from scripts/lxdialog/checklist.c:24:
scripts/lxdialog/dialog.h:29:20: curses.h: No such file or 
directory
In file included from scripts/lxdialog/checklist.c:24:
scripts/lxdialog/dialog.h:127: error: parse error before 
"use_colors"

And so many lines because there is no file as 
include CURSES_LOC
as in scripts/lxdialog/dialog.h

So please give soem instructions about this to me.

Then weather feature versions are having this problems..

So please if u know then reply to me.

Thanks
Mvthv

