Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSEaEZ2>; Fri, 31 May 2002 00:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSEaEZ1>; Fri, 31 May 2002 00:25:27 -0400
Received: from [203.199.54.8] ([203.199.54.8]:59661 "EHLO
	ltitlout.lntinfotech.com") by vger.kernel.org with ESMTP
	id <S314829AbSEaEZ0>; Fri, 31 May 2002 00:25:26 -0400
Subject: 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFBE6D9C45.358C5649-ON65256BCA.0017F7B8@lntinfotech.com>
From: Shifani.bose@lntinfotech.com
Date: Fri, 31 May 2002 09:52:30 +0530
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on BANGALORE/LNTINFOTECH(Release 5.0.8 |June 18, 2001) at
 05/31/2002 09:52:31 AM,
	Itemize by SMTP Server on LTITLOUT/LNTINFOTECH(Release 5.0.8 |June 18, 2001) at
 05/31/2002 10:11:56 AM,
	Serialize by Router on LTITLOUT/LNTINFOTECH(Release 5.0.8 |June 18, 2001) at
 05/31/2002 10:12:02 AM,
	Serialize complete at 05/31/2002 10:12:02 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i tried a example code for character device driver.
the code got compiled but while loading the driver using insmod iam getting

unresolved symbol for register_chrdev_Rfxxxxxxx

i checked the /proc/ksyms
it contains a entry by name register_chrdev_R1xxxxxxx

and /usr/src/linux-2.4/kernel/ksyms.c
contains EXPORT_SYMBOL(register_chrdev)

how can this error be avoided or where is the error it likely .

thanks and warm regards

Shifani


