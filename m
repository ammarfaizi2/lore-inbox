Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTBEMOT>; Wed, 5 Feb 2003 07:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267933AbTBEMOT>; Wed, 5 Feb 2003 07:14:19 -0500
Received: from [203.199.54.8] ([203.199.54.8]:33034 "EHLO
	ltitlout.lntinfotech.com") by vger.kernel.org with ESMTP
	id <S267935AbTBEMN1>; Wed, 5 Feb 2003 07:13:27 -0500
Subject: Linux kernel routing tables
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4E4F731E.60C406E3-ON65256CC4.00437E86@lntinfotech.com>
From: Mahesh.Pujara@lntinfotech.com
Date: Wed, 5 Feb 2003 17:48:05 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 02/05/2003 05:48:06 PM,
	Itemize by SMTP Server on LTITLOUT/LNTINFOTECH(Release 5.0.11  |July 24, 2002) at
 02/05/2003 06:11:40 PM,
	Serialize by Router on LTITLOUT/LNTINFOTECH(Release 5.0.11  |July 24, 2002) at
 02/05/2003 06:11:43 PM,
	Serialize complete at 02/05/2003 06:11:43 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI ,
      I am having Zebra  routing utility running on Linux kernel 2.4.20.
As zebra is Updating the kernel routing tables.
I want to read those routing tables and create the tables
in some other memory.

My questions are

1. Linux is also having the Multiple routing tables. Does
zebra updating the same routing tables of Linux?
If yes than which Linux kernel tables are updated.

2 .where the Multiple Routing tables are implemented
 in Linux Kernel for IPv4, means in which files.

3. In my program (which is some module) i want to read the
Kernel routing tables.
So how can i read those tables? Is there any standard
Linux API provided for the same.
Or what is the other way to read those table from memory ??


Waiting for  reply.
Thanking you in Advance.


Mahesh Pujara

