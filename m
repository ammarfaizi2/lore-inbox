Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTHVPpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTHVPpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:45:17 -0400
Received: from mx02.qsc.de ([213.148.130.14]:411 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S263310AbTHVPpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:45:11 -0400
Date: Fri, 22 Aug 2003 17:46:39 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18int
Message-ID: <20030822154639.GA711@gmx.de>
References: <200308222231.25059.kernel@kolivas.org> <200308222351.16691.kernel@kolivas.org> <20030822145622.GA716@gmx.de> <200308230103.19724.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <200308230103.19724.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test3-O18 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2003 at 01:03:19AM +1000, Con Kolivas wrote:
> > > There it is again; the reference to darn O10. Hrm. One question before
> > > your holiday; your O10 kernel is it the same kernel tree or a
> > > different/newere one? I'm looking to blame something else here I know=
 but
> > > I need to know; this just doesn't hold with any testing here.
> >
> > well, I run O10 on top of test2, since I didn't need any patches from
> > test3 I didn't rediff it.
>=20
> So O18 is also on test2?

Okay, I applied O18 on top of test2 now. Xmms works as a charm,
programm start is still slow while doing an tar xf linuxtest2.tar.
Already open xterm's (one with mutt) react a bit in-interactive (I spawn
vi to write this email and a :w takes 5 seconds). It is nonetheless
worse than O10, sorry to say that.

--=20
Regards,

Wiktor Wodecki

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Rjrf6SNaNRgsl4MRAp27AKCYNvbrMoggxuC+oRsICtQaNNlw/ACePsaI
MSCfdZUQ7UVy+lzgeQdqPrg=
=E3yJ
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
