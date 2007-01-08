Return-Path: <linux-kernel-owner+w=401wt.eu-S1750713AbXAHLT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbXAHLT4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXAHLTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:19:55 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:3052 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXAHLTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:19:55 -0500
Message-ID: <45A228CC.5020004@imap.cc>
Date: Mon, 08 Jan 2007 12:19:40 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Jonas Svensson <jonass@lysator.liu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: trouble loading self compiled vanilla kernel
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
In-Reply-To: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B28E4695DE93EBF6EBBF559"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B28E4695DE93EBF6EBBF559
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonas Svensson schrieb:
> I downloaded kernel 2.6.19.1 from kernel.org and compiled it like
> make mrproper, make menuconfig, make, make modules_install, make instal=
l.
[...]
> All results in the same problem: the booting stops about when grub is
> finished and the kernel should continue. I get the
> message about loading initrd but not the line of "Uncompressing
> Linux... Ok, booting the kernel". Instead I get a blank screen with a
> flashing cursor at top left. Thats all, nothing more happens. Any
> suggestions on what could be wrong or what I should do?

Did you build a new initrd to go with your new kernel?

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig8B28E4695DE93EBF6EBBF559
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFoijMMdB4Whm86/kRApaSAJ9kmonKF+vqLHYKiBzywKTjruQ/mACffrRN
ObW9S7Vitry5u1iQYPzN59E=
=3pUD
-----END PGP SIGNATURE-----

--------------enig8B28E4695DE93EBF6EBBF559--
