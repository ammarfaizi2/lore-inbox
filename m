Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279992AbRKDNyb>; Sun, 4 Nov 2001 08:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279993AbRKDNyV>; Sun, 4 Nov 2001 08:54:21 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:6072 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279992AbRKDNyN>; Sun, 4 Nov 2001 08:54:13 -0500
Message-Id: <5.1.0.14.2.20011104134957.00bb5b60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 04 Nov 2001 13:54:11 +0000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Via Onboard Audio - Round #2
Cc: Sean Middleditch <elanthis@awesomeplay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BE54643.B0761F5@mandrakesoft.com>
In-Reply-To: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
 <1004849558.457.15.camel@stargrazer>
 <3BE4CC20.5FFEC4B5@mandrakesoft.com>
 <5.1.0.14.2.20011104131312.02bd8ae8@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:44 04/11/2001, Jeff Garzik wrote:
>Anton Altaparmakov wrote:
> > Linux is not
> > a PNP OS and hence problems like yours often get fixed by setting in the
> > BIOS that you are not using a PNP OS.
>
>Incorrect.  PCI IRQ routing (net effect of "PNP OS: Yes") works fine for
>everybody except those with Sean's type of PCI IRQ routing table.

Well, if I reboot set it to YES and boot into Linux my SB Live stops 
working. As does my wintv pci (or my network card, can't remember)... If I 
reboot, set it to NO and boot again then all is fine. Fully reproducible.

In Windows everything works with either setting, in Linux it doesn't.

And that's a fact with my Asus P4B mobo + P4 1.7GHz CPU, SB Live!, 3c9xyz, 
wintv pci, advansys scsi, and loads of peripherals (usb, etc).

Sorry, but I am correct at least for my hardware.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

