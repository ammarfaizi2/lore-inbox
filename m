Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTKQO5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 09:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTKQO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 09:57:32 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:46721 "EHLO
	catnet.kabel.utwente.nl") by vger.kernel.org with ESMTP
	id S261916AbTKQO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 09:57:30 -0500
Date: Mon, 17 Nov 2003 15:57:23 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configuration help texts for IPsec
Message-ID: <20031117145723.GB1268@gaast.net>
References: <20031115150841.GA4854@gaast.net> <Xine.LNX.4.44.0311170948100.1445-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0311170948100.1445-100000@thoron.boston.redhat.com>
X-Operating-System: Linux 2.4.22-ac4 on a i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Morris (jmorris@redhat.com) wrote:
> > IPsec-related options say "Say Y unless you know what you are doing.".
> > Looks fine for people who applied the IPsec patch to a kernel which
> > comes without it, but now that it's in stock, it's probably not very
> > useful to force all users to use IPsec.
> Nobody is being forced to use it: the advice is provided to help people=
=20
> get IPsec working properly.
>=20
Yes, very true. But now that the patch is in 2.6 by default, I think the
situation changes.

Just imagine a person who doesn't even know what IPsec is, trying to
configure a 2.6 kernel. "IP: AH tranformation.. What's that? Let's check
the help page. Oh, it says I should just say Yes. Okay, let's do that."

Shouldn't the text "If unsure, say Y." be more like "If you want to use
IPsec, you need this."? Possibly with an addition like "If you don't
know what IPsec is, you don't need it."?


Greetings,

Wilmer v/d Gaast.

--=20
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE/uOHTeYWXmuMwQFERAouAAKCk4FRwZ/pnQ8q8zWiPVDTdLWlOjgCfS2En
GbOk3JYfmqiughrKanavlbc=
=LLtq
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
