Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSDULKO>; Sun, 21 Apr 2002 07:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313044AbSDULKN>; Sun, 21 Apr 2002 07:10:13 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:3892 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312638AbSDULKM>; Sun, 21 Apr 2002 07:10:12 -0400
Message-Id: <5.1.0.14.2.20020421120820.040107b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 21 Apr 2002 12:10:05 +0100
To: Jochen Friedrich <jochen@scram.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204211121010.18496-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<taken Linus out of cc: list>

At 10:22 21/04/02, Jochen Friedrich wrote:
>Hi Larry,
>
> > Huh?  BK requires no more net access than you require when submitting
> > a regular patch.  You need to be connected to move the bits.
>
>Wrong. Many corporate firewalls allow email and http (both via proxy) and
>reject any other traffic. CVS and BK are both unusable in this
>environment.

Not wrong. BK works fine over http protocol. CVS is another matter which I 
cannot comment on...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

