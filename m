Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSLQIlx>; Tue, 17 Dec 2002 03:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSLQIlx>; Tue, 17 Dec 2002 03:41:53 -0500
Received: from smtp.wp.pl ([212.77.101.161]:61223 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id <S261322AbSLQIlx>;
	Tue, 17 Dec 2002 03:41:53 -0500
Message-ID: <005601c2a5a9$912b8640$110011ac@home.sitech.pl>
From: "plachninka" <plachninka@wp.pl>
To: <linux-kernel@vger.kernel.org>
Subject: mkinitrd: binary operator expacted
Date: Tue, 17 Dec 2002 09:52:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Can anyone tell me what means following message:

[root@tilda plachnina]# /sbin/mkinitrd initrd-2.4.18-18.7.xsmp.img
2.4.18-18.7.xsmp

/sbin/mkinitrd: [:
/lib/modules/2.4.18-18.7.xsmp/./kernel/drivers/scsi/aic7xxx/aic7xxx.o:
binary operator expected


I  fight with aic7xxx module since 1 month...

regards

Mariusz Bozewicz


