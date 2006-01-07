Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWAGKin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWAGKin (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 05:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWAGKin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 05:38:43 -0500
Received: from mail.gmx.de ([213.165.64.21]:63963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932711AbWAGKin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 05:38:43 -0500
X-Authenticated: #24128601
Date: Sat, 7 Jan 2006 11:39:01 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060107103901.GA17833@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <43BE24F7.6070901@triplehelix.org> <20060106232522.GA31621@section_eight.mops.rwth-aachen.de> <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everybody,

On Fr, Jan 06, 2006 at 03:30:47 -0800, Mark Knecht wrote:
> On 1/6/06, Sebastian <sebastian_ml@gmx.net> wrote:
> > Hi all!
> > On Fri, Jan 06, 2006 at 12:06:15AM -0800, Joshua Kwan wrote:
> > > Hi Sebastian,
> > >
> > > On 01/03/2006 02:20 PM, Sebastian wrote:
> > > > The second series was ripped with deprecated ide-scsi emulation and=
 yielded the
> > > > same results as EAC.
> > >
> > > What were you using? cdparanoia? cdda2wav? (Are there actually that m=
any
> > > other options on Linux?)
> > I use cdparanoia.
>=20
> Try  cdparanoia -Bvz
>=20
> This will cause the rip to be extremely careful and make sure
> everything is exactly right. It works well for me and was recommended
> by someone I trust. I hop it works for you..
>=20
> Cheers,
> Mark
>=20
I used cdparanoia -BzX -O48 for every rip.
Just to be clear, I'm not writing to this list because I have problems
with an application. :) Rather I like to know where to fix this problem, in
kernelland or userspace, like, should I start getting into cdparanoia or
reading the o'Reilly book about kernel drivers?


Thanks

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDv5pFTWouIrjrWo4RAsmkAJ92Xb6yLcmOu0gesD+X1PLdvjrHTACdHIPg
zN5f955IYLNHW1KkVXSybuM=
=Vbz5
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

