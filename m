Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUCLWXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 17:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUCLWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 17:23:31 -0500
Received: from legolas.restena.lu ([158.64.1.34]:58604 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263000AbUCLWX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 17:23:27 -0500
Subject: Re: a7n8x-x & i2c
From: Craig Bradney <cbradney@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: backblue <backblue@netcabo.pt>, linux-kernel@vger.kernel.org
In-Reply-To: <20040312210552.GA1860@kroah.com>
References: <20040310185047.454779fc.backblue@netcabo.pt>
	 <20040312003135.GA26958@kroah.com>
	 <20040312200020.1d92f676.backblue@netcabo.pt>
	 <20040312210552.GA1860@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KcqZTwQjsvsebDh3RofR"
Message-Id: <1079130207.24173.3.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 23:23:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KcqZTwQjsvsebDh3RofR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-03-12 at 22:05, Greg KH wrote:
> On Fri, Mar 12, 2004 at 08:00:20PM +0000, backblue wrote:
> > No i dont have nothing of that enable! all debug options are disable,
> > should a7n8x-x work with lm_sensors?
>=20
> What is "a7n8x-x"?
>=20

An ASUS motherboard.

> > sensors-detect says that dont founds any chip's in my machine...
>=20
> Then I would believe that no sensors are present for it :)
>=20
> > but it finds nforce2 SMBus.
>=20
> Hm, did you try the 2.4 package of lmsensors on a 2.4 kernel?  It
> supports more chip drivers than 2.6 currently does.
>=20

Try using the w83781d

<M> Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F

Well.. that one works here on an A7N8X Deluxe anyway. I dont think it
worked for me builtin, but I load it as a module and its ok

Craig


--=-KcqZTwQjsvsebDh3RofR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAUjhdi+pIEYrr7mQRAmJLAKCkSgSyp5cpXykHeoOl9FTzlTPEBgCbB1hV
ZjKCGCinKy3vkAk73RZfMdQ=
=EdYU
-----END PGP SIGNATURE-----

--=-KcqZTwQjsvsebDh3RofR--

