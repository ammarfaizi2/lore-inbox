Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUGRUI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUGRUI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGRUI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:08:29 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:20352 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261239AbUGRUI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:08:27 -0400
Subject: Re: [PATCH] inotify 0.5
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org
In-Reply-To: <1090180960.5399.0.camel@vertex>
References: <1090180167.5079.21.camel@vertex>
	 <1090180432.5281.37.camel@nosferatu.lan>  <1090180960.5399.0.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4jqxf0R10mhvorqEFX1i"
Message-Id: <1090181465.5281.41.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 22:11:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4jqxf0R10mhvorqEFX1i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-18 at 22:02, John McCutchan wrote:
> On Sun, 2004-07-18 at 15:53, Martin Schlemmer wrote:
> > On Sun, 2004-07-18 at 21:49, John McCutchan wrote:
> >=20
> > > I plan on adding an inotify backend to gamin soon.
> > >=20
> >=20
> > What about support for fam?
>=20
> I have been getting the impression that fam is going to be replaced by
> gamin.
>=20

Right, but kde also works with fam, and I assume the gamin support
will only be in 2.[78] gnome-vfs?  Also, it would be nice to test
currently with fam enabled stuff, as I want to remember inotify
do not have issues with locking mounts like dnotify have?  Or is
it rather a fam-related issue ?


Thanks,

--=20
Martin Schlemmer

--=-4jqxf0R10mhvorqEFX1i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA+tlZqburzKaJYLYRApddAJ4qjHwmg9DvbyIfAzf4gjElCy9IXACghYRA
TPCFun/TFyu5BEI3IdF0qoo=
=Uvl2
-----END PGP SIGNATURE-----

--=-4jqxf0R10mhvorqEFX1i--

