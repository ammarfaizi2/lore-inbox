Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbRFYP5Y>; Mon, 25 Jun 2001 11:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264656AbRFYP5O>; Mon, 25 Jun 2001 11:57:14 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:60688 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264642AbRFYP5I>; Mon, 25 Jun 2001 11:57:08 -0400
Message-ID: <20010625155706.66345.qmail@web13907.mail.yahoo.com>
Date: Mon, 25 Jun 2001 08:57:06 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about linux mips ext2fs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, all,

I want port linux to our mipsel system. The kernel
can work and system stop at mount root file system.
I download root file system for mipsel from MIPS
company. Because our system have no ethernet
interface,
I have to copy root file system directly to our hard
disk. I put hard disk under intel linux, and using 
fdisk and make ex2fs on it. Then I copy root file 
system to hard disk. After finished, I place this hard
disk under our mipsel environment. I do not know if 
it can work under this environment, the kernel can
mount root file system? If someone knows, please help
me.
Thanks in advance!

Barry

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
