Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUBCEMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUBCEMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:12:15 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:63879 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265780AbUBCEMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:12:13 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040202233243.GA1688@kroah.com>
References: <20040126215036.GA6906@kroah.com>
	 <1075401020.7680.25.camel@nosferatu.lan>  <20040202233243.GA1688@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QDvhy9ueQsU5r3ebsqhu"
Message-Id: <1075781541.6931.122.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 06:12:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QDvhy9ueQsU5r3ebsqhu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 01:32, Greg KH wrote:
> On Thu, Jan 29, 2004 at 08:30:20PM +0200, Martin Schlemmer wrote:
> > On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> >=20
> > I see latest version is very noisy, and although it is a good option
> > to have, I think it should be tweakable (and recompiling is not always
> > an option if you want some quick debugging).
> >=20
> > Attached is a simple patch to add a config option to udev.conf to toggl=
e
> > logging.
>=20
> I'm going to hold off on this patch for now for a number of reasons:
> 	- doesn't apply anymore
> 	- is buggy as your follow on message stated
> 	- I don't think it's really needed.
>=20
> But feel free to convince me otherwise :)
>=20

I'll try again with 016 =3D)

--=20
Martin Schlemmer

--=-QDvhy9ueQsU5r3ebsqhu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAHx+lqburzKaJYLYRAtCkAKCbsQQMXshahTc09WUIUaPRwaCotQCdFp2f
ZS2nGi79aGcOcwkX+Fi9vWc=
=DD4B
-----END PGP SIGNATURE-----

--=-QDvhy9ueQsU5r3ebsqhu--

