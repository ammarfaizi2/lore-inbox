Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUILSnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUILSnt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268779AbUILSnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:43:49 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:4836 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S268778AbUILSnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:43:33 -0400
Date: Sun, 12 Sep 2004 20:43:24 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: usb: device not accepting address
Message-ID: <20040912184324.GA17498@cirrus.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040912180242.GA15109@cirrus.madduck.net> <414495CE.9000703@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <414495CE.9000703@comcast.net>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-1-k7 i686
X-Mailer: Mutt 1.5.6+20040818i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach John Wendel <jwendel10@comcast.net> [2004.09.12.2030 +0200]:
> I had this problem also. I  built a new kernel with ACPI turned
> off and the problem went away. My computer has a VIA chipset, and
> I see VIA in your module list. Perhaps the VIA USB driver has some
> problems.

I need ACPI. That said, USB works fine for all other devices. I am
using a Bluetooth dongle, a smart media reader, a Palm cradle, and
my mouse is also USB...

When I unplug the device, everything works fine. Plus, I did get the
device to work previously and have not changed anything since then
other than a reboot.

The device is, btw, an internal Maxxtro smart media reader,
connected to the motherboard directly by with four pins, i.e. not
a USB jack.

And yes, VIA sucks.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
fitter, healthier, more productive
like a pig, in a cage, on antibiotics
                                                          -- radiohead

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBRJjMIgvIgzMMSnURAie7AJ0UIPb76v/OPr3FPvU11qY3whwIPACfVdlm
u5NHLmVDcNKcGjUuLiaJOrI=
=aUZY
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
