Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUAQCC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAQCC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:02:58 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:14049 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265954AbUAQCCz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:02:55 -0500
Date: Sat, 17 Jan 2004 15:07:35 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Announce: Software Suspend Core Patch 2.0 rc4.
In-reply-to: <pan.2004.01.16.21.35.02.327622@dungeon.inka.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074305254.2016.13.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-4kLSx8oVUaQ7Ozoj6Ut4";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074282072.5328.52.camel@laptop-linux>
 <pan.2004.01.16.21.35.02.327622@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4kLSx8oVUaQ7Ozoj6Ut4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2004-01-17 at 10:35, Andreas Jellinghaus wrote:
> including urls might be nice.
>=20
> also the feature comparison webpage
> does not mention bios at all.

True. Feel free to produce a column; I don't have any experience with
BIOS support for suspending, so don't know what it can/can't do and
whether this varies from computer to computer.

> Till now I used SOFTWARE_SUSPEND because
> it works fine, whereas PM_DISK somehow uses the=20
> bios, and does not work (dell latitude c600,
> I don't have that magic partition the dell bios
> expects).
>=20
> SWSUSP2 will be like SWSUSP concerning this issue?

I'm not sure that PM_DISK does use the bios. In fact, I'm pretty sure it
doesn't. Feel free to prove me wrong.

Regarding the relationship with SOFTWARE_SUSPEND, the answer is yes.
Software Suspend 2 works in a very similar way to Software Suspend.

Nigel

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-4kLSx8oVUaQ7Ozoj6Ut4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACJjmVfpQGcyBBWkRAtVfAJ9RtQMLaBoHuuY5PVGj+8+K5aH7PQCfTiz7
5dIoFgk8slWDHIiMIGqf2Yc=
=bwTv
-----END PGP SIGNATURE-----

--=-4kLSx8oVUaQ7Ozoj6Ut4--

