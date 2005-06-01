Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVFAARZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVFAARZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFAARZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:17:25 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:40549 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261215AbVFAARP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:17:15 -0400
Message-ID: <429CFE7F.20304@poczta.fm>
Date: Wed, 01 Jun 2005 02:17:03 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: jfisch@cs.pdx.edu, chris@mind.lu
Subject: Re: Driver for MCS7780 USB-IrDA bridge chip
References: <42943CB5.50400@poczta.fm>
In-Reply-To: <42943CB5.50400@poczta.fm>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2AAC33D874C3026FF0520A54"
X-EMID: e5c6a138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AAC33D874C3026FF0520A54
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Greetings Everyone.

The new, shiny 0.2alpha.3 release is ready to test it, smash it and blow
it off ;-)

The major improvement is support for other SIR speeds: 2400 through
115200 bps. Well I think they will work but frankly speaking I haven't
tested them because my Handspring always negotiates the highest rate.

I am sure there is quite a lot of bugs left so *please* test it as much
as you can. I am realy convinced that performance may be a really big
problem so I will appreciate any comments on the design.

Source tarball is available at:

http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.2alpha.3.tar.bz2
http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.2alpha.3.tar.bz2.asc (sig)

or

http://stlman.fm.interia.pl/mcs7780-0.2alpha.3.tar.bz2
http://stlman.fm.interia.pl/mcs7780-0.2alpha.3.tar.bz2.asc (sig)

To answer your question: I will make a patch but let me first be sure it
is usable and at least beta-stable. You can help ;-)

Always yours.
--=20
By=B3o mi bardzo mi=B3o.                    Trzecia pospolita kl=EAska, [=
=2E..]
>=A3ukasz<                      Ju=BF nie katolicka lecz z=B3odziejska.  =
(c)PP


--------------enig2AAC33D874C3026FF0520A54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCnP6DNdzY8sm9K9wRAoRyAJwJsyHstmFnLQ6nC7R1TUVKLuU5bQCePsGR
mfUMkSAYedr+eaNbykHX1oU=
=TLcS
-----END PGP SIGNATURE-----

--------------enig2AAC33D874C3026FF0520A54--
