Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSBEQHt>; Tue, 5 Feb 2002 11:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289628AbSBEQHk>; Tue, 5 Feb 2002 11:07:40 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:34217 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S289621AbSBEQH1>;
	Tue, 5 Feb 2002 11:07:27 -0500
Message-Id: <5.1.0.14.2.20020205160402.00abb980@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 05 Feb 2002 16:09:51 +0000
To: Holger Lubitz <h.lubitz@internet-factory.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C5FFB03.3F33DF7F@internet-factory.de>
In-Reply-To: <20020201153303.A1508@prester.hh59.org>
 <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:32 05/02/02, Holger Lubitz wrote:
>(Tried posting this before, but apparently it didn't get through.
>Apologies if it did.)
>
>Anton Altaparmakov proclaimed:
> > I was about to send the drive (IBM 7200rpm 41GiB) back for replacement when
> > I as last resort tried to upgrade the firmware of the drive.
>
>Just out of curiosity - where do you get firmware updates for hard
>drives? I know that most can be flashed with newer firmware, yet i never
>saw an actual update available.
>
>I have two IBM DTLA that sometimes make the "funny IBM noises",
>occasionally accompanied by ide resets. They haven't hung the bus, yet,
>but I'd like to be on the safe side.

I got mine from the company I bought the drive from. They are official IBM 
dealers (or something). The url for the firmware they offer is:

http://www.scan.co.uk/ibmhddtest.htm

They also have the DTLA firmware so you can grab it from there. Note that 
you need a computer running windows in order to create the floppy with the 
firmware. - Once you have the floppy boot the computer containing the hd 
you want to upgrade with the floppy and follow the onscreen instructions.

btw. During the upgrade the drives make strange noises and that had me 
worried the first time round but it seems to always happen during upgrades 
so is probably normal. I upgraded both DTLA and GXP drives and both work fine.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

