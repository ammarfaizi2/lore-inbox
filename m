Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVFRPY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVFRPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVFRPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 11:24:57 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:16178 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S262115AbVFRPYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 11:24:53 -0400
Message-ID: <42B43CB6.8090707@poczta.fm>
Date: Sat, 18 Jun 2005 17:24:38 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem name storage (Was: A Great Idea (tm) about reimplementing
 NLS.)
References: <f192987705061303383f77c10c@mail.gmail.com> <200506151213.44742.vda@ilport.com.ua> <200506152155.05865.pmcfarland@downeast.net> <C960854D-7EA5-4DD7-8F2B-7021092CE3EB@mac.com>
In-Reply-To: <C960854D-7EA5-4DD7-8F2B-7021092CE3EB@mac.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0679481E831D274023AF51E"
X-EMID: f8109138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0679481E831D274023AF51E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Kyle Moffett napisa=C5=82(a):

> Would the following system for filenames resolve most of the issues  pe=
ople
> are raising:
>=20
> First load charset tables into the kernel.  These would be stored in=20
> files in userspace
[...]

Just like keyboard maps?

> The following mount options would available:
>   nls_raw=3D(0|1)  [default 1]:
[...]
>   nls_disk=3D<string-charset>
[...]
>   nls_user=3D<string-charset>

It sounds quite reasonable to me :-)


--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigE0679481E831D274023AF51E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCtDy7NdzY8sm9K9wRAuqzAJ97C9Olf8m9ard9JU80W8Q518RU4ACffarE
Rb7IHnT8NFYTtOYjhyanYoM=
=rAc1
-----END PGP SIGNATURE-----

--------------enigE0679481E831D274023AF51E--
