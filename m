Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSE0KDW>; Mon, 27 May 2002 06:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSE0KDV>; Mon, 27 May 2002 06:03:21 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:37192 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316541AbSE0KDU>; Mon, 27 May 2002 06:03:20 -0400
Message-Id: <5.1.0.14.2.20020527105040.01f9f910@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 27 May 2002 11:03:47 +0100
To: Pawel Kot <pkot@linuxnews.pl>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.18-dj1 with gcc 3.1 ...
Cc: Clemens Schwaighofer <cs@pixelwings.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205271119550.19994-100000@urtica.linuxnews.
 pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:22 27/05/02, Pawel Kot wrote:
>On Mon, 27 May 2002, Clemens Schwaighofer wrote:
> > I just tried to compile 2.5.18-dj1 with gcc 3.1 and it failed with NTFS as
> > module:

Yes, there is a workaround you can find it in the lkml archives.

>It is a known problem and already reported to gcc people. AFAIR there is
>the problematic change in gcc already found, but I'm not sure if the
>problem is fixed in gcc CVS. Anton?

No idea. The bug is still open. The only activity so far in the bug tracker 
has been that it has been passed around to what sounds like the right 
person now... You can follow it here:

http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=gcc&pr=6660

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

