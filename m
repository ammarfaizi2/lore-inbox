Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUAIFiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 00:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUAIFiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 00:38:23 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:65215 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S266232AbUAIFiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 00:38:21 -0500
Date: Fri, 09 Jan 2004 18:35:43 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Is this too ugly to merge?
In-reply-to: <3FFE31B6.1030205@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073626462.10391.7.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-Vh2pwqi0v8jAvvskyLsN";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073609923.2003.10.camel@laptop-linux> <3FFE31B6.1030205@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Vh2pwqi0v8jAvvskyLsN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Oh, I did forget - there is a bit of debugging code in there that can be
taken out.

Regards,

Nigel

On Fri, 2004-01-09 at 17:44, Stephen Hemminger wrote:
> Nigel Cunningham wrote:
>=20
> > Hi all.
> >=20
> > I'm wanting to the opinion, if I may, of more experienced people
> > regarding changes I have implemented in my version of Software Suspend,
> > which I want to merge with Patrick and Pavel. Since I'm don't expect
> > that you're all familiar with how my version works, I'll give a fair bi=
t
> > of background before I come to the question.
>=20
> Do they all have to be big ugly macros?
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-Vh2pwqi0v8jAvvskyLsN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//j1eVfpQGcyBBWkRAg6+AJwK8yMKiFNneaYJlWzoJaKslqvMyACeOm0l
rmqG2hRhD7zk1yyDbEHQwUM=
=Qgtr
-----END PGP SIGNATURE-----

--=-Vh2pwqi0v8jAvvskyLsN--

