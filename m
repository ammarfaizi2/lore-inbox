Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbTGHLYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265043AbTGHLX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:23:58 -0400
Received: from maild.telia.com ([194.22.190.101]:38905 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S267230AbTGHLWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:22:05 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1057663430.2449.5.camel@laurelin>
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
	 <1057647818.5489.385.camel@workshop.saharacpt.lan>
	 <20030708072604.GF15452@holomorphy.com>
	 <200307081051.41683.schlicht@uni-mannheim.de>
	 <20030708085558.GG15452@holomorphy.com>
	 <1057657046.1819.11.camel@mufasa.ds.co.ug>
	 <20030708110122.GA10756@vana.vc.cvut.cz> <1057663430.2449.5.camel@laurelin>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7nSwNEQVpO4XdQnR1fdX"
Organization: LANIL
Message-Id: <1057664149.6856.12.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 08 Jul 2003 13:35:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7nSwNEQVpO4XdQnR1fdX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 at 13:23, Flameeyes wrote:
> On Tue, 2003-07-08 at 13:01, Petr Vandrovec wrote:
> > vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
> > But it is not tested, I have enough troubles with 2.5.74 without mm pat=
ches...
> vmnet doesn't compile:
>=20
> make: Entering directory `/tmp/vmware-config1/vmnet-only'
> In file included from userif.c:51:
> pgtbl.h: In function `PgtblVa2PageLocked':
> pgtbl.h:82: warning: implicit declaration of function `pmd_offset'
> pgtbl.h:82: warning: assignment makes pointer from integer without a
> cast
> make: Leaving directory `/tmp/vmware-config1/vmnet-only'

I get exactly the same errors. BTW I got these on vanilla 2.5.74 aswell.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-7nSwNEQVpO4XdQnR1fdX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CqyTyqbmAWw8VdkRAj9nAJ9J3dLcQ9yMyFxMo3T/KgepA+57ygCgmLHi
KRQhCrG88hWPfatSaLeBJlk=
=1Ehg
-----END PGP SIGNATURE-----

--=-7nSwNEQVpO4XdQnR1fdX--

