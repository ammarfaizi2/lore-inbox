Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317560AbSGEUhO>; Fri, 5 Jul 2002 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317561AbSGEUhO>; Fri, 5 Jul 2002 16:37:14 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15879 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317560AbSGEUhN>; Fri, 5 Jul 2002 16:37:13 -0400
Date: Fri, 5 Jul 2002 22:39:45 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705203945.GB17912@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it> <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz> <20020705201155.GF28569@merlin.emma.line.org> <Pine.LNX.4.44L0.0207052216410.3293-100000@moje.ich.vabo.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0207052216410.3293-100000@moje.ich.vabo.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please do NOT Cc: list mail to me if there is a
Mail-Followup-Header/unless I ask for Cc:! Thanks.

On Fri, 05 Jul 2002, Tomas Konir wrote:

> On Fri, 5 Jul 2002, Matthias Andree wrote:
>=20
> > On Fri, 05 Jul 2002, Tomas Konir wrote:
> >=20
> > > hi i have similar problem.
> > > No dead disks, but after two days testing tcq patches (on 2.4). I=20
> > > got the two ATA errors (smartctl said).=20
> >=20
> > *shrug* FreeBSD should have eaten some of those drives as well, it has
> > been offering hw.ata.tags=3D"1" to enable DMA QUEUED for a while now.
> >=20
> > And yes, my deathstar DTLA307045 still works without a single broken
> > block, but never used TCQ beyond booting 2.5.17 once (no LVM -> not
> > useful for me).
> >=20
> > Another DTLA307045 died some days ago, it has never seen TCQ.
> >=20
>=20
> I have no broken blocks. Only two errors logged in S.M.A.R.T.

So what's the issue?

> I have no S.M.A.R.T. errors for one year ago. And after use TCQ there are=
=20
> two errors after two days. Is is normal ?

Are there any strong hints that TCQ caused these?

> Curently i not believe new IBM disks and TCQ. I'll wait for better disks=
=20
> and stable TCQ.

That's your liberty to choose. :-) (And I can understand the IBM part of
it.)

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9JgQRFmbjPHp/pcMRAoTiAJ9NpE1/pTmDDWdJ0tXOeMgsOba+MACeNAsz
H1q8DRXcSr60YwoiQxX875E=
=nFZd
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
