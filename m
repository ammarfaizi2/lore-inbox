Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTBPQws>; Sun, 16 Feb 2003 11:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTBPQws>; Sun, 16 Feb 2003 11:52:48 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:19938 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S267218AbTBPQwr>;
	Sun, 16 Feb 2003 11:52:47 -0500
Date: Sun, 16 Feb 2003 22:32:16 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: linux 2.5.53 not compiling 
Message-ID: <Pine.LNX.4.44.0302162227200.18137-100000@topaz.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to "make bzImage" the 2.5.53 it gave me the following error

In file included from include/linux/spinlock.h:13,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:14,
                 from include/linux/proc_fs.h:5,
                 from init/main.c:15:
include/linux/kernel.h:10:20: stdarg.h: No such file or directory

I am using gcc-3.2. And I did make menuconfig with default settings.

Please CC the Reply to my mail-id rahulv@csa.iisc.ernet.in

Tahnk you 

-- 
Rahul Vaidya
Dept. of Computer Science and Automation
Indian Institute of Science
Bangalore

Room G46,
Hostel ph: 3942451

