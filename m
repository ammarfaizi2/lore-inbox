Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUHQAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUHQAMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHQAM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:12:27 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:8119 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268036AbUHQAL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:11:56 -0400
Subject: Re: Hang after "BIOS data check successful" with DVI
From: Aaron Michael Bauman <kodieren@comcast.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200408161655.43266.sjackman@telus.net>
References: <200408161655.43266.sjackman@telus.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CJNU56WnD698YHxmcjdG"
Organization: Kodieren
Message-Id: <1092683255.9234.7.camel@Kodieren>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 19:07:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CJNU56WnD698YHxmcjdG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-16 at 23:55, Shaun Jackman wrote:
> When I have a DVI display plugged into my Matrox G550 video card the
> boot process hangs at "BIOS data check successful". I am running Linux
> kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
> boot without the DVI display plugged in, I can plug it in after the
> boot process and the display works.
>=20
> Please cc me in your reply. Thanks,
> Shaun

Shaun,
#kernel on freenode recommends that users running the 2.6.x tree to stay
at 2.6.7+, so try upgrading your kernel, stay above 2.6.7 and see what
happens.=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-CJNU56WnD698YHxmcjdG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBIQX3O0LXno0F73YRAinOAJ4xIkQ5gXUq37L5h58/lwTkKBKB5QCePN6q
+SMvEqRpYasvkrS6sp+JEMs=
=vFhQ
-----END PGP SIGNATURE-----

--=-CJNU56WnD698YHxmcjdG--

