Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbULCP6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbULCP6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbULCP6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:58:44 -0500
Received: from lug-owl.de ([195.71.106.12]:1923 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262279AbULCP6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:58:39 -0500
Date: Fri, 3 Dec 2004 16:58:38 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041203155838.GM16958@lug-owl.de>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-12-03 10:29:29 -0500, Bagalkote, Sreenivas <sreenib@lsil.com>
wrote in message <0E3FA95632D6D047BA649F95DAB60E570230CA70@exa-atlanta>:
> I agree. The sysfs method would have been the most logical way of doing i=
t.

Then this is the way to go.

> But then application becomes sysfs dependent. We really cannot do that.

You can, I'm sure :)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBsI0uHb1edYOZ4bsRAs18AJwOF84hrNT3GIaS0RudTpOBWHZ4XgCeIThS
jEPEM+aphZe5rMpa76NBqTE=
=iQsL
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
