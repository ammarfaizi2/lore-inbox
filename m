Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUJJGop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUJJGop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 02:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUJJGop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 02:44:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268139AbUJJGon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 02:44:43 -0400
Subject: Re: [RFC] [patch] drm core internal versioning..
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: Greg KH <greg@kroah.com>, Jon Smirl <jonsmirl@gmail.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0410100625220.12189@skynet>
References: <Pine.LNX.4.58.0410100050160.6083@skynet>
	 <9e47339104100917527993026d@mail.gmail.com>
	 <Pine.LNX.4.58.0410100328080.11219@skynet>
	 <20041010042958.GA28025@kroah.com>
	 <Pine.LNX.4.58.0410100625220.12189@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lSzWrIlZMRkY5tz5jQFv"
Organization: Red Hat UK
Message-Id: <1097390654.2788.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 10 Oct 2004 08:44:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lSzWrIlZMRkY5tz5jQFv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



>=20
> the main reason I can't rely on CONFIG_MODVERSIONS is in my Fedora instal=
l
> at least: CONFIG_MODVERSIONS is not set so it is of no use if it is
> optional...

The versioning we all talk about doesn't use MODVERSIONS but the
VERSIONMAGIC stuff, that is ALWAYS in use.


--=-lSzWrIlZMRkY5tz5jQFv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBaNo+pv2rCoFn+CIRAu2FAJ4iFu+ErDJYvGAIkHvphrIfAnz7gACfRT7J
ENDzVrda5l3u9g0RBHilJQE=
=iptU
-----END PGP SIGNATURE-----

--=-lSzWrIlZMRkY5tz5jQFv--

