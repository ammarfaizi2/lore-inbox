Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVFUAty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVFUAty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVFUAsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:48:47 -0400
Received: from astro.systems.pipex.net ([62.241.163.6]:14210 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261782AbVFUAPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 20:15:53 -0400
Date: Tue, 21 Jun 2005 01:15:47 +0100
From: Paul Walker <paul@black-sun.demon.co.uk>
To: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.0d file/swap crypto package
Message-ID: <20050621001547.GT23091@black-sun.demon.co.uk>
References: <42B42E3B.DDEFE309@users.sourceforge.net> <20050620214951.35798.qmail@web32106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20050620214951.35798.qmail@web32106.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2005 at 02:49:51PM -0700, Vinay Venkataraghavan wrote:

> what is the best crypto API that I can use. I think just for this purpose
> Openssl is overkill don't you think. What kind of crypto API's can I

No, this is the kind of thing that openssl is designed for. Someone's
already done the hard wofk for you, just use it. :-)

If you really want alternatives, you could investigate Peter Gutmann's
cryptlib. If you're distributing this, though, bear in mind that almost
every machine will already have openssl, while not many will have cryptlib
installed.

--=20
Paul

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCt1wzP9fOqdxRstoRApY7AJ41Zhm3zpbZn9vR8JyWL9cHt0lgigCdE+Nf
x9ygMxnPk78ieGpMeOGAZPU=
=8kP+
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
