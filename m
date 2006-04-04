Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWDDXAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWDDXAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWDDXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:00:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43476 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750925AbWDDXAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:00:44 -0400
X-Sasl-enc: x7VzMl9O07GP9ApmAtGYRXN6pohEpp1zs+OURmefdHJr 1144191633
Message-ID: <4432FABE.1000900@imap.cc>
Date: Wed, 05 Apr 2006 01:01:18 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, hjlipp@web.de, kkeil@suse.de
Subject: Re: + isdn4linux-siemens-gigaset-drivers-logging-usage.patch added
 to -mm tree
References: <200604040051.k340p0RI008205@shell0.pdx.osdl.net> <1144113590.3067.4.camel@laptopd505.fenrus.org>
In-Reply-To: <1144113590.3067.4.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A6D247CA587FAC89E4BE2B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A6D247CA587FAC89E4BE2B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04.04.2006 03:19, Arjan van de Ven wrote:

>>+	struct semaphore sem;		/* locks this structure:
[...]
>=20
> please consider turning this into a mutex=20

Your wish is our command. Consider it already done. :-)

See isdn4linux-siemens-gigaset-drivers-mutex-conversion.patch in the
same series.

Regards
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig3A6D247CA587FAC89E4BE2B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMvrOMdB4Whm86/kRAvZRAJ9glJIhmBwW2MFZRcBnRZ0++ICeaQCfQM5Z
8+Av4cHjxnGvyaiMQKqvIYE=
=XRkU
-----END PGP SIGNATURE-----

--------------enig3A6D247CA587FAC89E4BE2B5--
