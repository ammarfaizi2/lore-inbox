Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbSLSHtt>; Thu, 19 Dec 2002 02:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267564AbSLSHtt>; Thu, 19 Dec 2002 02:49:49 -0500
Received: from smtp002.mail.tpe.yahoo.com ([202.1.238.49]:51469 "HELO
	smtp002.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S267562AbSLSHts>; Thu, 19 Dec 2002 02:49:48 -0500
Message-ID: <009e01c2a734$4e045540$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: <linux-usb-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: USB 2.0 is too slow?
Date: Thu, 19 Dec 2002 15:57:39 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I've rebuilt the latest kernel 2.5.52 and test the USB 2.0 funciton with
my
   LaCie USB2.0/1394-Disk Drive 10GB and a Plextor PX-W2410TU USB2.0 CD-RW.
   It spneds about 8 minutes to copying a 300MB file. (10 times test)
   Do I miss some modules?
   Some problems I met as follows.
   (1)Sometimes it can copy completely in 30 seconds.
       Is the echi-hcd module instable or immature now?
       Or the VIA USB 2.0 host controller is bad support?
   (2) If two USB2.0 devices (HDD and CD-RW) are pluged into the same usb
hub,
       Two situations I met as follow. ( check /proc/scsi/scsi )
        A. 2 devices are found and can be attached.
        B. 2 devices are found but only one device can be attached.
   (3) What is this file, /proc/scsi/device_info, for?
   My configuration, KT333+VT8235+ IBM ATA66 10GB HDD.
   Thanks in advance.
Best Regards.
             Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
