Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWBZQNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWBZQNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWBZQNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:13:35 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:27345 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751305AbWBZQNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:13:34 -0500
Subject: Re: [PATCH] Revert sky2 to 0.13a
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: woho@woho.de, Stephen Hemminger <shemminger@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1140968831.2934.32.camel@laptopd505.fenrus.org>
References: <4400FC28.1060705@gmx.net>
	 <20060225180353.5908c955@localhost.localdomain>
	 <200602260957.04305.woho@woho.de>  <1140966011.22812.2.camel@localhost>
	 <1140968831.2934.32.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Kgz8fB5gNgj59U192DYX"
Date: Sun, 26 Feb 2006 17:13:47 +0100
Message-Id: <1140970427.23375.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kgz8fB5gNgj59U192DYX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-26 at 16:47 +0100, Arjan van de Ven wrote:
> On Sun, 2006-02-26 at 16:00 +0100, Ian Kumlien wrote:
> > On Sun, 2006-02-26 at 09:57 +0100, Wolfgang Hoffmann wrote:
> > > On Sunday 26 February 2006 03:03, Stephen Hemminger wrote:
> > > > Instead of whining, try this.
> > >=20
> > > I tried and still see the hang.
> >=20
> > I'm at a record 12 hours with that patch.
>=20
> shhh don't jinx it ;)

Well it died 33 mins later... =3D)

I also saw some oddities... portage stopped working, i dunno if this can
be MSI related or so, else something is trashing memory in a very
special way =3DP

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-Kgz8fB5gNgj59U192DYX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1-ecc0.1.6 (GNU/Linux)

iD8DBQBEAdO77F3Euyc51N8RAmt1AKCNWekKSejxL+ldTaKSRp9/Oy1iRACgn3sF
n+qYBF8v6SZMdiFdBb8TOeY=
=XCFn
-----END PGP SIGNATURE-----

--=-Kgz8fB5gNgj59U192DYX--

