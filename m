Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283056AbRK1ODK>; Wed, 28 Nov 2001 09:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282145AbRK1ODB>; Wed, 28 Nov 2001 09:03:01 -0500
Received: from pop.gmx.de ([213.165.64.20]:8210 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283052AbRK1OCw> convert rfc822-to-8bit;
	Wed, 28 Nov 2001 09:02:52 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Reply-To: sebastian.droege@gmx.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Date: Wed, 28 Nov 2001 15:04:26 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128145858.A23858@suse.de>
In-Reply-To: <20011128145858.A23858@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011128140257Z283052-17408+22958@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 28. November 2001 14:58 schrieben Sie:
> On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hi Jens,
> > your patch doesn't work for ide-scsi
> > I get this oops when trying to mount a CD:
>
> [oops in sr_scatter_pad]
>
> Hmm ok, and 2.5.1-pre1 works for you right?

Yes it works very well
Bye
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BO7uvIHrJes3kVIRAs+IAJwMg9ru+joRHR9ei6Sqd6GzKMQ6ogCgmZ7X
1J8gTk2dC84QXU4g5Abp12M=
=dPWQ
-----END PGP SIGNATURE-----
