Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264548AbTLQVHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbTLQVHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 16:07:06 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:25226 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264548AbTLQVHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 16:07:03 -0500
Subject: Re: scsi_id segfault with udev-009
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, patmans@us.ibm.com
In-Reply-To: <200312171143.27226.dsteklof@us.ibm.com>
References: <1071682198.5067.17.camel@nosferatu.lan>
	 <200312171017.28358.dsteklof@us.ibm.com>
	 <1071690009.11705.2.camel@nosferatu.lan>
	 <200312171143.27226.dsteklof@us.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MWfo7Ju4VpYFgPgnOyrY"
Message-Id: <1071695345.11705.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 23:09:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MWfo7Ju4VpYFgPgnOyrY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-17 at 21:43, Daniel Stekloff wrote:

> > Yep, that fixes it, thanks.  Btw, any reason it wont actually display
> > anything ?
> >
> >
> > Thanks,
>=20
>=20
> Sorry, what won't display anything? Do you mean scsi_id or the fix?=20
>=20

Nevermind :D

--=20
Martin Schlemmer

--=-MWfo7Ju4VpYFgPgnOyrY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/4MXwqburzKaJYLYRAj7TAJ4tT2m8yTyNLoPr8Y95YVrhl+1gmgCeMIPi
uGmwOiEbTG8ivpr10QYIcVU=
=VGoK
-----END PGP SIGNATURE-----

--=-MWfo7Ju4VpYFgPgnOyrY--

