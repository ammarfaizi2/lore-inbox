Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbTL3TUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265898AbTL3TUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:20:30 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:51661 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S265897AbTL3TU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:20:28 -0500
Subject: Re: [Fwd: Linux on Cyrix 6x86]
From: Stan Bubrouski <stan@ccs.neu.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: khorben@defora.org
In-Reply-To: <3FF1C5BC.8010902@zytor.com>
References: <3FF1C5BC.8010902@zytor.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HVWmUrQDA6uDVmAvqcYb"
Message-Id: <1072812026.1760.19.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Dec 2003 14:20:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HVWmUrQDA6uDVmAvqcYb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-30 at 13:36, H. Peter Anvin wrote:
> From: Pierre Pronchery <khorben@defora.org>
> To: hpa@zytor.com
> Subject: Linux on Cyrix 6x86
> Date: Tue, 30 Dec 2003 15:19:18 +0100
>=20
> 	Hi,
>=20
> I've just compiled Linux 2.4.23 for a Cyrix 6x86 P166+ processor, with
> the appropriate "Processor family" option "586/K5/5x86/6x86/6x86MX"
> (CONFIG_M586=3Dy). It says it's for 586-compatible processors, possibly
> lacking the TSC register, though the kernel panic'd at boot, saying it
> needed a TSC register.
>=20

I have the same processor in my old archive machine with an ancient
2.0.36 kernel.  I do recall the kernel is an i586 and I believe there
was a cyrix CPU option back then (I have to take the drives out of that
machine and put them in this one to check as the system stopped booting
a few days ago).  So looks like a bug.

> The same kernel configuration, this time set for 386, booted
> successfully.
>=20
<SNIP>
>=20
> PS: I first tried to sent this to davej@suse.de, but his address seems
> not to be valid anymore (<davej@suse.de>: user has moved to <unknown>).
>=20

I responded to this message only to possibly correct this address, I
believe you are looking for davej@redhat.com, correct?

-sb

--=-HVWmUrQDA6uDVmAvqcYb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/8c/6QHy9+2ztQiARAuUkAJ9HIFYaQqYEi3NLlvwvnger5KKZwACcDJoJ
JDLOeC1MBtYOEMXTmHeOM1A=
=d/2U
-----END PGP SIGNATURE-----

--=-HVWmUrQDA6uDVmAvqcYb--

