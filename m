Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTJDTLf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTJDTLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:11:35 -0400
Received: from 82-68-84-59.dsl.in-addr.zen.co.uk ([82.68.84.59]:18048 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S262694AbTJDTLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:11:33 -0400
Subject: Re: patch for 2.4.23pre6aa2 thinkpad compile errors
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031004141535.GA12876@tor.trudheim.com>
References: <20031004141535.GA12876@tor.trudheim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PcbbMJ5DppZJ0q83Qge9"
Organization: Trudheim Technology Limited
Message-Id: <1065294685.11862.1.camel@tor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Sat, 04 Oct 2003 20:11:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PcbbMJ5DppZJ0q83Qge9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-10-04 at 15:15, Anders Karlsson wrote:
> Hi,
>=20
> When building the 2.4.23pre6aa2 kernel, there was some compile breaks
> in the new thinkpad support. All that was missing was an include line
> in some files, see attached patch.

Second comment to this, the thinkpad stuff can not be build into the
kernel, even if the option to do so is there. It has to be built as
modules. Perhaps a change to the *config stuff to reflect that is an
idea? (I have no idea how to do that...)

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-PcbbMJ5DppZJ0q83Qge9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/fxtdLYywqksgYBoRApQkAJ9kfHPWKHeawCiEB4QTk443L+rqpACePznL
/f5KwMppoZbI3xS2SVNisVE=
=TeAr
-----END PGP SIGNATURE-----

--=-PcbbMJ5DppZJ0q83Qge9--

