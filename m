Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317539AbSGEOX5>; Fri, 5 Jul 2002 10:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSGEOX5>; Fri, 5 Jul 2002 10:23:57 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:41338 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317539AbSGEOX4>; Fri, 5 Jul 2002 10:23:56 -0400
Message-Id: <5.1.0.14.2.20020705152010.00aa2af0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Jul 2002 15:29:33 +0100
To: Thunder from the hill <thunder@ngforever.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IBM Desktar disk problem?
Cc: Daniel Egger <degger@fhm.edu>, venom@sns.it,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207050801190.10105-100000@hawkeye.luckynet.
 adm>
References: <1025873421.16768.20.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:03 05/07/02, Thunder from the hill wrote:
>On 5 Jul 2002, Daniel Egger wrote:
> > <advise>
> > Buy decent drives, then get DriveFitnessTest (DFT) from their website
> > and check the harddrives, note the TRC number, request an RMA on their
> > website and ship the drives as soon as possible to IBM. Wait for the
> > replacement drives and sell them ASAP on Ebay to some freaks who don't
> > give a dime about data security.
> > </advise>
>
>...and tell all the people who got a DTLA (because it's not as expensive
>as others in some countries, mind France, USA, Germany) to drop their
>disks if they want to use Linux, because we're too lazy to find a
>solution. That might be cool to you, but we want HARDWARE SUPPORT for
>Linux! That's why we're here.
>
>There _is_ a solution, we just have to find it.

Um, the solution is already known. Upgrade the firmware on the drive, low 
level format if the drive thinks there are bad sectors, and be happy. At 
least it worked for me...

The very first question when making a support call for my broken deathstar 
was "Have you installed the firmware update?" "No." "Download it here and 
install, come back if it still doesn't work."

I never thought it would work but it did! It seems there is something wrong 
in the firmware the drives are shipped with and some suppliers obviously 
know this considering my experience... When I was running the DFT test 
utility it was telling me my drive is broken and needs to be returned. 
After the firmware update the same test utility passed all tests repeatedly!

With 5 deathstars (one DTLA and four IC ones), all with firmware updates 
now, I have no problems and the oldest of the drives is now over 3 years 
old IIRC and some are pretty much in constant spun-up state since purchase...

The only problem I can see is that IBM is not pushing people to apply the 
firmware updates. I have never been even able to find where to download 
them on the IBM website. - I downloaded them from the website of my supplier...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

