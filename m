Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSDVSUH>; Mon, 22 Apr 2002 14:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314405AbSDVSUG>; Mon, 22 Apr 2002 14:20:06 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:64894 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314403AbSDVSUF>; Mon, 22 Apr 2002 14:20:05 -0400
Message-Id: <5.1.0.14.2.20020422191715.03cf1e70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Apr 2002 19:20:01 +0100
To: spyro@armlinux.org
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Cc: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>, phillips@bonn-fries.net,
        lm@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020422191953.034f51d4.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:19 22/04/02, Ian Molton wrote:
>Petr Vandrovec Awoke this dragon, who will now respond:
>
> >
> >  Why we have kernel tarball at all, then? Just put URLs where you can
> >  download different pieces of kernel, and we are done. You finally
>
>Actually, the kernel tarball is full of crap we dont need.
>
>Sooner or later its going to get too big and be split up into
>
>core kernel
>drivers (drivers/net, drivers/video etc.)
>arch specifics
>documentation
>
>all for seperate download.

That is never going to happen, at least not as long as Linus is the kernel 
maintainer. I believe he has said so more than once before...

One of the reasons being that such an act would make changing global APIs a 
virtual impossiblity. And such changes happen often in Linux during the 
unstable kernel series. And those changes are good changes... Otherwise we 
will end up with Windows having backwards compatibility with DOS for 
virtually all eternity...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

