Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316852AbSFFHzq>; Thu, 6 Jun 2002 03:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSFFHzp>; Thu, 6 Jun 2002 03:55:45 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:44119 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316852AbSFFHzo>; Thu, 6 Jun 2002 03:55:44 -0400
Message-Id: <5.1.0.14.2.20020606085533.00aede30@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 06 Jun 2002 08:56:22 +0100
To: Mike Fedyk <mfedyk@matchmail.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [ANNOUNCE] atapci 0.51
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Thomas Zimmerman <thomas@zimres.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020606025502.GE448@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:55 06/06/02, Mike Fedyk wrote:
>On Wed, Jun 05, 2002 at 06:21:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > On Fri, 31 May 2002, Thomas Zimmerman wrote:
> >
> > > On 31-May 02:35, Bartlomiej Zolnierkiewicz wrote:
> > > [snip]
> > > > So 0.51 version is here:
> > > > http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-0.51.tar.bz2
> > > >
> > > > changelog:
> > > > - make it kernel version independent
> > > > - add '-s' strip flag to CFLAGS
> > > > - minor cosmetics by Roberto Nibali
> > > >
> > > > --
> > > > bkz
> > >
> > > Just a nit, but wouldn't the name "lsata" fit in better with "lspci" and
> > > "lsisa"?
> > >
> > > Thomas
> > >
> >
> > No, it is only for PCI chipsets.
>
>I think he meant to follow the naming convention set by lspci and lsisa.
>What do you think now?

Well the comment that it only applies to pci chipsets still applies. A 
compromise would be lsatapci I guess...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

