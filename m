Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314754AbSDVU5p>; Mon, 22 Apr 2002 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314757AbSDVU5o>; Mon, 22 Apr 2002 16:57:44 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:58633 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314754AbSDVU5W>; Mon, 22 Apr 2002 16:57:22 -0400
Message-Id: <5.1.0.14.2.20020422215312.00ab9370@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Apr 2002 21:57:33 +0100
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Cc: Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16zOAa-0001Lt-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:42 21/04/02, Daniel Phillips wrote:
>On Monday 22 April 2002 22:18, Jeff Garzik wrote:
> > On Sun, Apr 21, 2002 at 08:05:25PM +0200, Daniel Phillips wrote:
> > > On Monday 22 April 2002 19:52, Jeff Garzik wrote:
> > > > Should we remove all advertisements from the kernel?  A Big Penguin
> > > > would probably object to the removal of this printk advertisement
> > > > for Swansea:
> > > >
> > > >   Linux NET4.0 for Linux 2.4
> > > >   Based upon Swansea University Computer Society NET3.039
> > > >
> > > > If the answer is no, then you are targetting BitKeeper specifically...
> > >
> > > Excellent point.  If the BitKeeper advertising in the kernel source were
> > > held to that level, I would be satisfied.
> >
> > <chuckle> -- and if that occurred, _I_ would fight to remove it as a
> > pointless advertisement.
>
>You'd want to get rid of the url that points at your docs?

I think you misunderstood Jeff. I would also not be happy if I suddenly saw 
a bitkeeper advertisement during kernel bootup, which is what is quoted above.

It is not a piece of the kernel so it shouldn't be advertised as such. It 
is a tool that is used in combination with the kernel and the docs for such 
tool are rightfully in the kernel. docs != advertising. How many people 
will read the docs? Not many. And certainly not many who would be 
purchasing bitkeeper. How many people will see the above show copyright 
messages on boot? A LOT. Anyone booting Linux in fact...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

