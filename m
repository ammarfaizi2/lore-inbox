Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273052AbTHFBrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273068AbTHFBrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:47:08 -0400
Received: from mail59-s.fg.online.no ([148.122.161.59]:48838 "EHLO
	mail59.fg.online.no") by vger.kernel.org with ESMTP id S273052AbTHFBrG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:47:06 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Alex Goddard <agoddard@purdue.edu>, svein@brage.info
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
Date: Wed, 6 Aug 2003 03:46:41 +0200
User-Agent: KMail/1.5.2
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
References: <871xw1kyu2.fsf@lapper.ihatent.com> <20030806013125.GB5962@brage.info> <Pine.LNX.4.56.0308052041560.3753@dust>
In-Reply-To: <Pine.LNX.4.56.0308052041560.3753@dust>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308060346.45771.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

onsdag 6. august 2003, 03:43, skrev Alex Goddard:
> On Wed, 6 Aug 2003 svein@brage.info wrote:
> > > [Snip]
> > >
> > > Tried burning without ide-scsi?  As long as you have a recent enough
> > > version of cdrtools, ide-scsi is no longer necessary in 2.5/2.6.  I
> > > haven't used ide-scsi in months, and CD burning works just fine.
> >
> > Well, then, what about cdrdao?
> > I sometimes need to make more exact copies of a CD than cdrtools allows,
> > and cdrdao doesn't seem top support IDE devices yet.
>
> I'm pretty much positive that cdrecord has a disk at once version that
> doesn't make anything explode.

The only one I'm aware of is the '-dao' option, but that's no good when what I 
really want to do is burn a CUE sheet and files, or copy another CD. It still 
expects an ISO file(or WAV, whatever) as input.

Actualy, the only use for that option that I'm aware of is to help a few 
troubled CD-readers.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/MF4B9OlFkai3rMARAmO0AKCU/KURqWB13moIM/voB0QdVLgcEACgoNqG
ZFYF/sa/VxLYXbJtianvTyA=
=FuR3
-----END PGP SIGNATURE-----

