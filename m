Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUF0KYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUF0KYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 06:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUF0KYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 06:24:53 -0400
Received: from imap.nuit.ca ([66.11.160.83]:10892 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S261610AbUF0KYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 06:24:43 -0400
Date: Sun, 27 Jun 2004 10:24:39 +0000
From: simon@nuit.ca
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot access '/dev/pts/292': Value too large for defined data type
Message-ID: <20040627102439.GA32767@nuit.ca>
References: <20040626151108.GA8778@nuit.ca> <20040626135948.7b4396e9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20040626135948.7b4396e9.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux
X-GPG-Key-Server: x-hkp://subkeys.pgp.net
User-Agent: Mutt/1.5.6+20040523i
X-Scan-Signature: smtp.nuit.ca 1BeWq0-0001ic-0R 9bdd22b723ee078d5c68bbf8b2893f9f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ce jour Sat, 26 Jun 2004, Andrew Morton a dit:

> simon@nuit.ca wrote:
>=20
> 2.6.7 plus
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.7-bk9.gz
> would be suitable.

In file included from include/linux/list.h:8,
                 from include/linux/signal.h:4,
                 from arch/ppc/kernel/asm-offsets.c:12:
include/asm/system.h:85: error: parse error before '{' token
include/asm/system.h:85: error: parse error before '<' token
make[2]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6'
make: *** [stamp-kernel-configure] Error 2

typos somewhere =3D)


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQGVAwUBQN6gZmqIeuJxHfCXAQI9JQwAmo41A5C4DjOqUhs5zpu0OcCebQIx6+6A
PsKYjSSj0iTOkTq9lpE3X1SgDKlZL2A+QUptKRNA+E2KX5pkVMkT96M1xxpYhDHJ
qHBquDn1pElcqVf0f7XU+Q4eK7AWWYrf+aiZMiwTc6iuFayNOeHaZs7M5L9MGXII
fjjnN5lyx/fFkuJjRSjK6w/XpTYZO3dWiAJIDbIyycqVtfAsywAfuC3Yr0rPOAGk
lQo8PTsH08AOB2FhdI+/8bOBu4oDXN8iLTiI7+hhw3y2HO6/P5ErB4qKp9rmvR8y
BNLe0F+F3wMeubTZAXW5Ao8ON0b8fsm4DWdBM7jeUWleaIh0icA+QyIxDzB96J5r
cqKjXYrlm2jyAXCBkKhq9j+yEVoFReHMRHk7CZHogvfsc1v4UVnLx4sIqA/Ieqoh
kLnU7UGNq4TOuZ+2mGNamPRL0zx1PRZ9sKtHQGO+pJD8CcS6GltXeno4TVed+bV5
LugVx/NMkUp4Y1XTPjc8btpbO2fuV7IW
=6I3X
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
