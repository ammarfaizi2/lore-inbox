Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRBWP3A>; Fri, 23 Feb 2001 10:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRBWP2v>; Fri, 23 Feb 2001 10:28:51 -0500
Received: from [212.140.58.138] ([212.140.58.138]:52229 "EHLO
	mail.helpmagic.com") by vger.kernel.org with ESMTP
	id <S129847AbRBWP2q>; Fri, 23 Feb 2001 10:28:46 -0500
From: "Jon Evans" <evansj@helpmagic.com>
To: <linux-kernel@vger.kernel.org>
Subject: usb / hub / usb-storage problem with 2.4.2
Date: Fri, 23 Feb 2001 15:24:44 -0000
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
X-MIMETrack: Itemize by SMTP Server on helpmagic-notes/Helpmagic/UK(Release 5.0 (Intl)|30
 March 1999) at 02/23/2001 03:24:34 PM,
	Serialize by Router on helpmagic-notes/Helpmagic/UK(Release 5.0 (Intl)|30
 March 1999) at 02/23/2001 03:24:41 PM,
	Serialize complete at 02/23/2001 03:24:41 PM
Message-ID: <NEBBJPFEMKMMDGBIMIADGEOKCAAA.evansj@helpmagic.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Iomega Jaz USB drive has stopped working.  I'm not sure when, I know it
has worked since 2.4.0 but I haven't used it for a couple of weeks.

The problem is:

Feb 23 15:13:47 evansj kernel: hub.c: USB new device connect on bus1/2,
assigned device number 5
Feb 23 15:13:47 evansj kernel: usb.c: USB device not accepting new address=5
(error=-32)
Feb 23 15:13:48 evansj kernel: hub.c: USB new device connect on bus1/2,
assigned device number 6
Feb 23 15:13:48 evansj kernel: usb.c: USB device not accepting new address=6
(error=-32)

These mesages appear whenever the device is plugged in.

My USB mouse, in the other USB port, continues to work fine.

Jon.

Apologies if Outlook screws up the line wrapping...

