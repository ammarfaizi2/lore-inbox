Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTBEOPi>; Wed, 5 Feb 2003 09:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTBEOPi>; Wed, 5 Feb 2003 09:15:38 -0500
Received: from [203.199.54.8] ([203.199.54.8]:46610 "EHLO
	ltitlout.lntinfotech.com") by vger.kernel.org with ESMTP
	id <S261364AbTBEOPh>; Wed, 5 Feb 2003 09:15:37 -0500
Subject: How to read kernel routing tables?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF22A4195E.CF5ED89F-ON65256CC4.004EA46C@lntinfotech.com>
From: Mahesh.Pujara@lntinfotech.com
Date: Wed, 5 Feb 2003 19:49:44 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.9 |November 16, 2001) at
 02/05/2003 07:49:45 PM,
	Itemize by SMTP Server on LTITLOUT/LNTINFOTECH(Release 5.0.11  |July 24, 2002) at
 02/05/2003 08:13:21 PM,
	Serialize by Router on LTITLOUT/LNTINFOTECH(Release 5.0.11  |July 24, 2002) at
 02/05/2003 08:13:54 PM,
	Serialize complete at 02/05/2003 08:13:54 PM
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

