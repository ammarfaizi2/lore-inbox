Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317592AbSGEW4O>; Fri, 5 Jul 2002 18:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317593AbSGEW4N>; Fri, 5 Jul 2002 18:56:13 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14346 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317592AbSGEW4N>; Fri, 5 Jul 2002 18:56:13 -0400
Date: Sat, 6 Jul 2002 00:58:43 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705225843.GA4061@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it> <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz> <20020705201155.GF28569@merlin.emma.line.org> <Pine.LNX.4.44L0.0207052216410.3293-100000@moje.ich.vabo.cz> <20020705203945.GB17912@merlin.emma.line.org> <Pine.LNX.4.44L0.0207052243190.3950-100000@moje.ich.vabo.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0207052243190.3950-100000@moje.ich.vabo.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


AGAIN: Please DO NOT CC: ME on mailing lists unless I ask for a Cc:

On Fri, 05 Jul 2002, Tomas Konir wrote:

> On Fri, 5 Jul 2002, Matthias Andree wrote:
>=20
> > Are there any strong hints that TCQ caused these?
>=20
> only hypothesis, but vith high probability, because there were no problem=
s=20
> before using TCQ. My hypothesis is that my IBM disk is oveloaded when=20
> using TCQ. (This is only HW problem. No TCQ ).

Well, DTLA break down without giving advance warnings. So TCQ need not
be related to this problem.

> > That's your liberty to choose. :-) (And I can understand the IBM part of
> > it.)
>=20
> Yes but is there any other disk which supports TCQ ?

I think all relevant SCSI drives do. Not what you intended, but I'm not
aware of any ATA disks other than IBM DPTA, DTLA, IC35L*AV*.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9JiSjFmbjPHp/pcMRAjznAJoDZIfJ80oq+P5q0C2V+ApOx85xlQCfbXJM
trOpKjUA3PNhTUYDvbO5OAE=
=hYdg
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
