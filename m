Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313569AbSDURFH>; Sun, 21 Apr 2002 13:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDURFG>; Sun, 21 Apr 2002 13:05:06 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:31803 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313569AbSDURFE>; Sun, 21 Apr 2002 13:05:04 -0400
Message-Id: <5.1.0.14.2.20020421175855.00aed8d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 21 Apr 2002 18:05:43 +0100
To: Jochen Friedrich <jochen@scram.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204211844260.18496-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 17:46 21/04/02, Jochen Friedrich wrote:
> > >Wrong. Many corporate firewalls allow email and http (both via proxy) and
> > >reject any other traffic. CVS and BK are both unusable in this
> > >environment.
> >
> > Not wrong. BK works fine over http protocol. CVS is another matter which I
> > cannot comment on...
>
>Ok, but there are other scenarios where only email is available (often via
>mail gateways like softswitch on os/390)...

Then use BK over email then (to submit a patch of your last change set for 
example you would do "bk export -tpatch -r+", and the receiving end does a 
simple "cat emailmessagetext | bk receive" and that's it done.

Obviously you haven't looked at bitkeeper... (-;

Anton

ps. You better be prepared to accept very large emails if you want to send 
a whole linux kernel repository by email though! Never mind if you are 
using bitkeeper or just a tar ball!


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

