Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279983AbRKDNUs>; Sun, 4 Nov 2001 08:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279985AbRKDNU3>; Sun, 4 Nov 2001 08:20:29 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:52147 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279983AbRKDNUH>; Sun, 4 Nov 2001 08:20:07 -0500
Message-Id: <5.1.0.14.2.20011104131312.02bd8ae8@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 04 Nov 2001 13:20:04 +0000
To: Sean Middleditch <elanthis@awesomeplay.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Via Onboard Audio - Round #2
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1004851818.457.24.camel@stargrazer>
In-Reply-To: <3BE4CC20.5FFEC4B5@mandrakesoft.com>
 <1004849558.457.15.camel@stargrazer>
 <3BE4CC20.5FFEC4B5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:30 04/11/2001, Sean Middleditch wrote:
>On Sun, 2001-11-04 at 00:03, Jeff Garzik wrote:
> > You cannot, through driver options.
> >
> > The IRQ routing conflict is definitely the problem.  You can try booting
> > with "PNP OS: No" and maybe other irq options are hidden in your BIOS
> > setup under an advanced menu.
>
>There is no option.

You mean you bios doesn't allow you to choose whether you have a PNP OS or 
not?!? That would be very unusual (unless you have a Dell...). Linux is not 
a PNP OS and hence problems like yours often get fixed by setting in the 
BIOS that you are not using a PNP OS. Windows still works fine with PNP OS 
= NO btw. - On my P4 I had to set PNP OS = NO otherwise I couldn't get my 
sound card to work...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

