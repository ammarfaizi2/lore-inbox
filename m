Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVA0Xzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVA0Xzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVA0XyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:54:02 -0500
Received: from imap.gmx.net ([213.165.64.20]:11429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261319AbVA0Xwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:52:42 -0500
X-Authenticated: #641082
Subject: Re: patches to 2.6.9 and 2.6.10 - make menuconfig shows "v2.6.8.1"
From: Viktor Horvath <ViktorHorvath@gmx.net>
To: Timo Kamph <timo@kamph.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41F9610E.1000406@kamph.org>
References: <1106851254.720.4.camel@Charon>  <41F9610E.1000406@kamph.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-saoY8Tr6rwlFxRkObRrM"
Date: Fri, 28 Jan 2005 00:52:04 +0100
Message-Id: <1106869924.720.17.camel@Charon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-saoY8Tr6rwlFxRkObRrM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-27 at 22:45 +0100, Timo Kamph wrote:
> I guess you did somthing like this:
>=20
> 2.6.7 -patch-> 2.6.8 -patch-> 2.6.8.1 -patch-> 2.6.9 -patch-> 2.6.10.
>=20
> And you didn't noticed that the 2.6.9 patch failed, because it is diffed=20
> against 2.6.8 and not 2.6.8.1!

You're perfectly right. I thought "patch" would stop and ask me
something, but the error was silently buried under lots of "patching
file" lines.

> If you do the patching without the 2.6.8.1 patch everything should be fin=
e.

It is! Thanks a lot!

Viktor.

--=-saoY8Tr6rwlFxRkObRrM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB+X6kO3SWVYLvaJQRAhqSAJ98k6xkv3T9rcii/rMrHu68awF5JACfV9PL
LO4TO8fVNZPX93vWi/1PyXU=
=I52Z
-----END PGP SIGNATURE-----

--=-saoY8Tr6rwlFxRkObRrM--

