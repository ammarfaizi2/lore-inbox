Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbSLEBqt>; Wed, 4 Dec 2002 20:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbSLEBqt>; Wed, 4 Dec 2002 20:46:49 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:21771 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267180AbSLEBqs>; Wed, 4 Dec 2002 20:46:48 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1A91@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Yiyan Yang'" <edwardyang6@hotmail.com>, linux-kernel@vger.kernel.org
Subject: RE: new kernel can't boot
Date: Wed, 4 Dec 2002 17:54:02 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you enable initrd in the menuconfig? Can you send out the .config file?

-----Original Message-----
From: Yiyan Yang [mailto:edwardyang6@hotmail.com]
Sent: Wednesday, December 04, 2002 5:45 PM
To: linux-kernel@vger.kernel.org
Subject: new kernel can't boot


im using RHAS 2.1 kernel 2.4.9-e.3, to install oracle RAC on the server, we
have to change some parameter(character device - watch dog) and rebuild 
kernel.

I build the kernel according to the customization manual but the kernel 
fails
to boot, the error is:

  Kernel Panic: VFS: Unable to mount root fs on 01:00

My root is on ext3 FS and I did the mkinitrm RAM Disk.
Cause im not in the email-list, please directly reply to me.

Thanks very much.



_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
