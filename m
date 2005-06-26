Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFZLvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFZLvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 07:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFZLvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 07:51:43 -0400
Received: from mxout04.versatel.de ([212.7.152.118]:35280 "EHLO
	mxout04.versatel.de") by vger.kernel.org with ESMTP id S261164AbVFZLvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 07:51:40 -0400
Message-ID: <42BE9725.5070101@web.de>
Date: Sun, 26 Jun 2005 13:53:09 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?UG96c8OhciBCYWzDoXpz?= <pozsy@uhulinux.hu>
CC: Andrew Morton <akpm@osdl.org>, "Darryl L. Miles" <darryl@netbauds.net>,
       linux-kernel@vger.kernel.org,
       Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <20050626092604.GA26658@ojjektum.uhulinux.hu>
In-Reply-To: <20050626092604.GA26658@ojjektum.uhulinux.hu>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A3FA6DB3C821DF5D69805A7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A3FA6DB3C821DF5D69805A7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Pozs=C3=A1r Bal=C3=A1zs schrieb:
> See http://lkml.org/lkml/2005/1/17/132
The patch was against 2.6.11-rc1, has it not been adapted into mainline? =

As far as I can see, most of the hunks were already applied, and some=20
parts of the code have evolved further since. BTW, I never had this=20
problem with any 2.6.11 until .12 so far.
Thanks for your pointer!


--------------enig7A3FA6DB3C821DF5D69805A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr6XJV2m8MprmeOlAQI3Jg//dnvAv6qZIEF1T7x+DESYrePiz6S66UcG
0MnRcVogxmMzt3LsUjadW5JX50aXHhNGGi0h5lKctlUUh0ZeM1rJnw+XSeaHujfl
HdW4LjC77773mvUkXdKGlzT9UzkURPWXuHi5PdGpxJaf5Z+zYxAnVlXI9oiYDMub
Z9M2NplvKu2iaUW3Ixk4BYAFLfXZCjgG/HQUrJQtjq4bfzndGnSoqWqS9QRRAmjy
zvkWlQtTsc0+v+Dmb46+oOErDJiFSvMjKc5AyH38EpWcPqir13/y0PVNN73OVc6z
Y2Gj4XoBv7MX7dZQkC2VaaYS18aV/7J9QVJT5iw+QxBxk1xlrwOkf8ia1l062nwD
j+i8QeYDH8hM74ES4dklyaQv7qEBTiGpTwrw4/ZtHamboAlXCxlXf0ye+K/Vp1N/
ToIb0fjgqcC/qDpcGeAI8HmPWb4zuOlb+P//vcgzFSHZ5mvzVFDDsCdH+FEdvbjL
HidPnWZiePiP1pEEPcEuqiPjs4wBSqFE6RLcZzt9VKDeOuAF/VW+gX5R0HM7DJd4
ZYcRXXV0g245P39MfgzrS5Z+NoMFEH/HjiM4LNNojxsePEWZ7hAPM8/s/zLZ8Lcn
3hlLHQPf2kq/JRZFP4Y/DAbyUG3o8bsILCNd7V88szL706B56+rVquXY1xQn3QKp
upoDDzDyUng=
=WO4d
-----END PGP SIGNATURE-----

--------------enig7A3FA6DB3C821DF5D69805A7--
