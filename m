Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTEZL4E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTEZL4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:56:03 -0400
Received: from web8105.mail.in.yahoo.com ([203.199.70.105]:11137 "HELO
	web8105.in.yahoo.com") by vger.kernel.org with SMTP id S264354AbTEZL4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:56:03 -0400
Message-ID: <20030526120913.10514.qmail@web8105.in.yahoo.com>
Date: Mon, 26 May 2003 13:09:13 +0100 (BST)
From: =?iso-8859-1?q?maha=20rajan?= <maha_rtlin@yahoo.co.in>
Subject: Kernel compilation errors.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
  I am running a kernel 2.4.20-8 and i have the
sources of linux-2.4.4 and when i try to compile it I
get the messages below.Can you please help me with
this

gcc -D__KERNEL__ -I/usr/src2.4/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=athlon     -c -o
timer.o timer.c
timer.c:35: conflicting types for `xtime'
/usr/src2.4/linux/include/linux/sched.h:540: previous
declaration of `xtime'
make[2]: *** [timer.o] Error 1
make[2]: Leaving directory `/usr/src2.4/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src2.4/linux/kernel'
make: *** [_dir_kernel] Error 2

My system is an athlon/256MB/inboard Nvidia
video/Sound.

Thanks in advance
with regards,
Maharajan. V


________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
