Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVDMC2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVDMC2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVDMC1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:27:42 -0400
Received: from zlynx.org ([199.45.143.209]:30731 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S262539AbVDMCXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:23:51 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Zan Lynx <zlynx@acm.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org
In-Reply-To: <20050412184545.GB18557@pegasos>
References: <1113235942.11475.547.camel@frodo.esi>
	 <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi>
	 <20050411210754.GA11759@pegasos>
	 <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
	 <20050412054002.GB22393@pegasos>
	 <Pine.LNX.4.61.0504121458010.31686@Megathlon.ESI>
	 <20050412184545.GB18557@pegasos>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oneYOW2Vce/oCBIz5SAk"
Date: Tue, 12 Apr 2005 20:23:41 -0600
Message-Id: <1113359021.13407.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oneYOW2Vce/oCBIz5SAk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-12 at 20:45 +0200, Sven Luther wrote:
[snip]
> > A did put a GPL notice on it. He can't change his mind later.
> Then he should give us the source.
[snip]
> The fact remains that those firmware blob have no licence, and thus defac=
to
> fall under the GPL.
>=20
> > Moreover, the firmare in not in binary form, but is part of a C source
> > file.
>=20
> It is in binary form. Disguised binary form maybe but still binary form.
[snip]
> And where did those hexstrings come from ?=20

It seems to me, that to be consistent with the argument you seem to be
presenting concerning binary data in GPLd code, that you also need to be
demanding the "source" hardware design for binary register values.

Why not consider the binary firmware in the same category as binary
register programming information?  You poke these magic bytes into these
memory locations and it works.

Where do you draw the lines between "write this byte to set the input
gate here and the output gate to there" and "write this byte sequence to
send the input byte through this loop, into this buffer, add it to the
last byte entered, and output it over there"?
--=20
Zan Lynx <zlynx@acm.org>

--=-oneYOW2Vce/oCBIz5SAk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXIKtG8fHaOLTWwgRAlXEAJ4gvvxEKKbAtMxlAykPmx3p+mjzcgCgoEDT
2LcJIDTl5BAQ5BtWX2rl0Vw=
=oXE/
-----END PGP SIGNATURE-----

--=-oneYOW2Vce/oCBIz5SAk--

