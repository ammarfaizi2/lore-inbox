Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266300AbUAVSF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUAVSFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:05:52 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:53445 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266300AbUAVSFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:05:42 -0500
Date: Fri, 23 Jan 2004 07:08:25 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: swusp acpi
In-reply-to: <20040122102655.GC200@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074794904.12773.72.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-tf0uDABmF7eBIREhSEM5";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <200401211143.51585.tuxakka@yahoo.co.uk>
 <20040122003212.GC300@elf.ucw.cz> <1074735908.1405.85.camel@laptop-linux>
 <20040122101555.GA200@elf.ucw.cz>
 <20040122102254.A17786@flint.arm.linux.org.uk>
 <20040122102655.GC200@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tf0uDABmF7eBIREhSEM5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Michael Frank has done a patch giving 2.4 PM support for serial ports
(my serial console now works flawlessly). Perhaps it could be ported to
2.6 and the driver model...

Nigel

On Thu, 2004-01-22 at 23:26, Pavel Machek wrote:
> Hi!
>=20
> > > Not only serial console... Noone wrote serial port support.
> >=20
> > Incorrect.  I never merged the changes because it's rather too hacky.
>=20
> Who wrote them? Do you have that patch somewhere?
> 								Pavel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-tf0uDABmF7eBIREhSEM5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAEBGYVfpQGcyBBWkRArKWAJ9Y+ICgNvg5oTWB+GliXyEnQ0A+OQCfcduA
KSRKc2IChZpuCad5AJd+sFE=
=Jy9t
-----END PGP SIGNATURE-----

--=-tf0uDABmF7eBIREhSEM5--

