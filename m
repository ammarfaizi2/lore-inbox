Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSE0MuD>; Mon, 27 May 2002 08:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSE0MuC>; Mon, 27 May 2002 08:50:02 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:26379 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S316599AbSE0MuB>; Mon, 27 May 2002 08:50:01 -0400
Date: Mon, 27 May 2002 14:49:52 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Anton Altaparmakov <aia21@cantab.net>
cc: Clemens Schwaighofer <cs@pixelwings.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.18-dj1 with gcc 3.1 ...
In-Reply-To: <5.1.0.14.2.20020527105040.01f9f910@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0205271448500.19994-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Anton Altaparmakov wrote:

> At 10:22 27/05/02, Pawel Kot wrote:
> >On Mon, 27 May 2002, Clemens Schwaighofer wrote:
> > > I just tried to compile 2.5.18-dj1 with gcc 3.1 and it failed with NTFS as
> > > module:
>
> Yes, there is a workaround you can find it in the lkml archives.
>
> >It is a known problem and already reported to gcc people. AFAIR there is
> >the problematic change in gcc already found, but I'm not sure if the
> >problem is fixed in gcc CVS. Anton?
>
> No idea. The bug is still open. The only activity so far in the bug tracker
> has been that it has been passed around to what sounds like the right
> person now... You can follow it here:
>
> http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&database=gcc&pr=6660

OK. This should be fixed in gcc in very short time:
http://gcc.gnu.org/ml/gcc-patches/2002-05/msg02133.html

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

