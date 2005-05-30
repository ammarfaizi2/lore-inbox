Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVE3KTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVE3KTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 06:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVE3KTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 06:19:51 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:9756 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261590AbVE3KTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 06:19:33 -0400
Message-ID: <429AE8A5.5010206@poczta.fm>
Date: Mon, 30 May 2005 12:19:17 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Judy Fischbach <jfisch@cs.pdx.edu>
Subject: Re: Driver for MCS7780 USB-IrDA bridge chip
References: <42943CB5.50400@poczta.fm> <20050525235846.GA28644@kroah.com> <4298510E.8030502@poczta.fm> <Pine.GSO.4.58.0505292332530.7049@wezen.cs.pdx.edu>
In-Reply-To: <Pine.GSO.4.58.0505292332530.7049@wezen.cs.pdx.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF594125E5AD979A694CF97AF"
X-EMID: 441dc138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF594125E5AD979A694CF97AF
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Judy Fischbach napisa=B3(a):

> this chip also and we just recently got SIR working at 9600. We are in

I ve just set up ppp communication over ircomm with my Palm device :)
9600 of course but works flawlesly :-D

> the currently in the process of testing. We would like to join forces,
> share what we've done and help with efforts to add support for speed
> changes, FIR and more testing.

It's great to hear I am not on my own with those problems. If you have
read my source you know that speed changing routine is there and works,
or rather is seemed to work according to the data sheet. What I can't do
now is find a proper way to invoke it and not make the kernel panic. If
I solve this problem only error handling and performace tuning will have
to be done (if no other problems will be born by the way).

Please tell how can I help.

PS. I am simply curious how long did it take you to develope your code
and how many of you have worked on it?
--=20
By=B3o mi bardzo mi=B3o.                     Trzecia pospolita kl=EAska, =
[...]
>=A3ukasz<                      Ju=BF nie katolicka lecz z=B3odziejska.  =
(c)PP


--------------enigF594125E5AD979A694CF97AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCmuiuNdzY8sm9K9wRAsURAJ9aH0gEZyhMp9n4qr8OPwitUXXgwACeO0TR
Odz3woP4C9euJKMYDltku/U=
=VO6o
-----END PGP SIGNATURE-----

--------------enigF594125E5AD979A694CF97AF--
