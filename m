Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbUAVBpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 20:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUAVBpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 20:45:51 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:29945 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S264300AbUAVBpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 20:45:49 -0500
Date: Thu, 22 Jan 2004 14:45:08 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: swusp acpi
In-reply-to: <20040122003212.GC300@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074735908.1405.85.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-cX/+Iz5+isAdi6Ch0tqi";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <200401211143.51585.tuxakka@yahoo.co.uk>
 <20040122003212.GC300@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cX/+Iz5+isAdi6Ch0tqi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Howdy.

It looks like PM support for serial ports is also broken; a serial
console is unusable after resuming.

Regards,

Nigel

On Thu, 2004-01-22 at 13:32, Pavel Machek wrote:
> Hi!
>=20
> > And with pressing power button everything else comes back exept
> > usb.
> > This behaviour is kind of "little light nap" and system comes back fast=
.
> > And I have also noticed that I cannot use bios passwd with
> > # echo 3 > /proc/acpi/sleep   cause even it doesn't reboot it goes
> > somehow to bios and bios passwd prompted but it doesn't accept it?
> > But after disabled bios passwd it works exept usb.
> >=20
> > Can somebody give me any wise what I'm doing wrong or point
> > me to some documentation about this matter?
>=20
> Seems like USB suspend/resume support is not yet working... Talk to
> usb maintainers and offer them some testing...
> 								Pavel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-cX/+Iz5+isAdi6Ch0tqi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQBADyskVfpQGcyBBWkRAngPAJjjYpU793aamdE/gJ2rhEm95uqiAKCNp7L8
T7mwr7uz3KDdI76HGiBvQA==
=cF8K
-----END PGP SIGNATURE-----

--=-cX/+Iz5+isAdi6Ch0tqi--

