Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315426AbSELW4l>; Sun, 12 May 2002 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSELW4k>; Sun, 12 May 2002 18:56:40 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:57604 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315426AbSELW4j>; Sun, 12 May 2002 18:56:39 -0400
Date: Mon, 13 May 2002 00:56:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Thunder from the hill <thunder@ngforever.de>,
        Diego Calleja <DiegoCG@teleline.es>,
        Becki Minich <bminich@earthlink.net>, linux-kernel@vger.kernel.org,
        johnnyo@mindspring.com
Subject: Re: Reiserfs has killed my root FS!?!
Message-ID: <20020512225623.GG1020@louise.pinerecords.com>
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1:11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Alexander Viro <viro@math.psu.edu>, May-12 2002, Sun, 18:47 -0400]
>
> > On Sun, 12 May 2002, Diego Calleja wrote:
> >
> > > > attempt to access beyond end of device
> > > > 08:12: rw=0 want=268574776 limit=8747392
> > > 
> > > I'm not an expert, but this perhaps isn't a reiserfs problem.
> > 
> > Nope. It looks much more like the IDE problem Tomas Szepe addressed in 
> > "2.5.15 IDE possibly trying to scribble beyond end of device"
> 
> ... except that he's using 2.4

Well, judging by
<quote>
	I use reiserfs on all my filesystems.  I have noticed some minor
	corruption of files in the past when I didnt shut down Linux properly
	(lockups, etc).  I experiment alot with my computer.

	Anyway lately I was havin a problem that required frequent reboots.
</quote>

I'd assume this bloke might have booted 2.5.15, only he's not mentioning it.


T.
