Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278261AbRJ1Mfb>; Sun, 28 Oct 2001 07:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278265AbRJ1MfV>; Sun, 28 Oct 2001 07:35:21 -0500
Received: from [203.134.64.99] ([203.134.64.99]:50181 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S278261AbRJ1MfL>; Sun, 28 Oct 2001 07:35:11 -0500
Message-ID: <01C16009.C6751AA0.danduke@iprimus.com.au>
From: Daniel Duke <danduke@iprimus.com.au>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.x freezes on boot
Date: Sun, 28 Oct 2001 23:39:18 +1100
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
X-OriginalArrivalTime: 28 Oct 2001 12:35:32.0494 (UTC) FILETIME=[08D062E0:01C15FAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the subject indicates, I'm having trouble running 2.4.x kernels.  I've 
tried 2.4.10 and 2.4.13, and both of them compile perfectly (no errors) but 
when I insert them into LILO and reboot I get the following:

LILO:  Linux
Loading Linux........

and the computer freezes at this point, every time.  I've tried compiling 
it for PIII/Celeron Coppermine (which is the correct one for me I think) 
and 386.  I've compiled the kernel under Debian GNU/Linux 2.2r3 (kernel 
2.2.19) with GCC 2.91.66.

My computer's basic hardware specs are:
CPU = Celeron 566
RAM = 256MB PC100 SDRAM
M/B = Gigabyte GA6VXE7+
IDE = 	hda = primary hard disk (windows and MBR here)
	hdb = cd-rw
	hdc = secondry hard disk (linux root & swap partitions live here)
	hdd = cd-rom

I've been tearing my hair out over this for about a fortnight now.  I'd 
provide more debugging info, but the computer doesn't give any because it 
freezes so early.  I am probably just forgetting to do something important, 
as this is the first time I've ever tried to compile my own kernel.  Any 
pointers or suggestions would be greatly appreciated.

>From Daniel


