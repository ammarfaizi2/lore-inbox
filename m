Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282147AbRK1OvZ>; Wed, 28 Nov 2001 09:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281864AbRK1OvQ>; Wed, 28 Nov 2001 09:51:16 -0500
Received: from pop.gmx.net ([213.165.64.20]:13554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282147AbRK1OvD> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 09:51:03 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Wed, 28 Nov 2001 15:52:41 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128150717.C23858@suse.de> <20011128153718.D23858@suse.de>
In-Reply-To: <20011128153718.D23858@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011128145113Z282147-17409+19920@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 28. November 2001 15:37 schrieben Sie:
> On Wed, Nov 28 2001, Jens Axboe wrote:
> > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Am Mittwoch, 28. November 2001 14:58 schrieben Sie:
> > > > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > > > -----BEGIN PGP SIGNED MESSAGE-----
> > > > > Hash: SHA1
> > > > >
> > > > > Hi Jens,
> > > > > your patch doesn't work for ide-scsi
> > > > > I get this oops when trying to mount a CD:
> > > >
> > > > [oops in sr_scatter_pad]
> > > >
> > > > Hmm ok, and 2.5.1-pre1 works for you right?
> > >
> > > Yes it works very well
> >
> > Ok, thanks for confirming that. Going to take a look at it now.
>
> Does this work for you? Apply on top of what you already have.

Yes it does work :)
Thank you very much

BTW my patch does work, too in addition with the sr-sg patch ;) But Jens' is 
cleaner

Bye
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BPo7vIHrJes3kVIRAqtJAJ9zDUEC3hOr/YrhD0u9ffDq+0Qu/gCgkCFO
BZ/hoLNeJn69teIN8L1msSI=
=lXPv
-----END PGP SIGNATURE-----
