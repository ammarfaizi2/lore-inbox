Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWATRNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWATRNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWATRNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:13:20 -0500
Received: from [80.251.174.142] ([80.251.174.142]:39082 "EHLO FAP-MSP.emfa.pt")
	by vger.kernel.org with ESMTP id S1751101AbWATRNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:13:19 -0500
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
From: Carlos Silva <r3pek@r3pek.homelinux.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Harald Welte <laforge@netfilter.org>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	 <20060120162317.5F70722B383@anxur.fi.muni.cz>
	 <20060120163619.GK4603@sunbeam.de.gnumonks.org>
	 <40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
	 <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W+IrRiaASK2/CQMwf1r0"
Date: Fri, 20 Jan 2006 17:11:28 +0000
Message-Id: <1137777088.24723.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-FAP-MailScanner-Information: Please contact the ISP for more information
X-FAP-MailScanner: Found to be clean
X-FAP-MailScanner-MCPCheck: MCP-Clean, MCP-Checker (score=0, required 4)
X-FAP-MailScanner-SpamCheck: not spam, SpamAssassin (score=0, required 4,
	autolearn=not spam)
X-FAP-MailScanner-From: r3pek@r3pek.homelinux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W+IrRiaASK2/CQMwf1r0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-20 at 11:49 -0500, Linus Torvalds wrote:
>=20
> On Fri, 20 Jan 2006, Benoit Boissinot wrote:
> >=20
> > On x86 (32bits), i have the same i think:
>=20
> Interestingly, __alignof__(unsigned long long) is 8 these days, even=20
> though I think historically on x86 it was 4. Is this perhaps different in=
=20
> gcc-3 and gcc-4?
>=20
> Or do I just remember wrong?
>=20

I don't know what __alignof__ does but afaik, unsigned long long has
been 8 bytes at least since gcc 3.3.X. I don't know the size of it in
4.X.X.

--=-W+IrRiaASK2/CQMwf1r0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQBD0RnAttk+BQds59QRAjWVAKCJYO8R+h7j5QHwMfHBgJj9v2t+bgCfVHhu
mB/e9doHitoX7v+cn0o08TY=
=Wqir
-----END PGP SIGNATURE-----

--=-W+IrRiaASK2/CQMwf1r0--

