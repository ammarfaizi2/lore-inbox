Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbUDDRhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 13:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUDDRhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 13:37:03 -0400
Received: from mailrelay03.sunrise.ch ([194.158.229.31]:52430 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id S262518AbUDDRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 13:36:58 -0400
Date: Sun, 4 Apr 2004 19:36:46 +0200
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5, ACPI, suspend and ThinkPad R40
Message-ID: <20040404173646.GA15635@puck.ch>
Mail-Followup-To: bol, linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Olivier Bornet <Olivier.Bornet@puck.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have an IBM ThinkPad R40, with kernel 2.6.5 and ACPI enabled. The
system is a GNU/Debian testing up-to-date, with acpid debian package
1.0.3-2.

I can suspend with Fn-F4, thanks to a acpi config doing:

    echo 3 > /proc/acpi/sleep

The laptop goes to sleep as execpted: all the lights goes off, and the
light with the moon goes on. All is OK until this. :-)

The problem is that I can't resume it. I have found no way. Pressing Fn
don't work. The power button don't work. Closing and opening the display
don't work. The only way to re-start the computer is to remove the
battery. Of course, this cause a reboot.

Has anyone some suggestion for me ?

Thanks in advance.

		Olivier
--=20
Olivier Bornet                |    fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results      |    english  : http://puck.ch/e
http://puck.ch/               |    deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch        |    italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://pgp.mit.edu/

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcEeudj3R/MU9khgRAng2AKCAFf4hpFUCyo+lMslC1XjQp9XpOACeO+e/
bi6oCpVNioryKkBloVQ2Ke4=
=83mq
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
