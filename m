Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUABWeM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUABWeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:34:12 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:35509 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265667AbUABWeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:34:06 -0500
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Paolo Ornati <ornati@lycos.it>, Ed Sweetman <ed.sweetman@wmich.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040102213228.GH1882@matchmail.com>
References: <200401021658.41384.ornati@lycos.it>
	 <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it>
	 <20040102213228.GH1882@matchmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-omKw/uTNRg3ysf0VU9o6"
Message-Id: <1073082842.824.5.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 23:34:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-omKw/uTNRg3ysf0VU9o6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-02 at 22:32, Mike Fedyk wrote:

> Have there been any ide updates in 2.6.1-rc1?

I see that a readahead patch was applied just before -rc1 was released.

found it in bk-commits-head

Subject: [PATCH] readahead: multiple performance fixes
Message-Id:  <200312310120.hBV1KLZN012971@hera.kernel.org>

Maybe Paolo can try backing it out.

--=20
/Martin

--=-omKw/uTNRg3ysf0VU9o6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/9fHaWm2vlfa207ERArwbAJ9C2ghHDf2z8RRAPreH/D7kOStz8wCgjQCk
4Ntf2od71rOZVjgUe6UTtYw=
=pvpl
-----END PGP SIGNATURE-----

--=-omKw/uTNRg3ysf0VU9o6--
