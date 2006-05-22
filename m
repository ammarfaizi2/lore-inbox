Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWEVTk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWEVTk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWEVTk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:40:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:36833 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751099AbWEVTk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:40:57 -0400
X-Authenticated: #2308221
Date: Mon, 22 May 2006 21:40:40 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Knutar <jk-lkml@sci.fi>,
       Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Message-ID: <20060522194040.GC5995@hermes.uziel.local>
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain> <20060522154830.GA5344@hermes.uziel.local> <4471E39C.1070003@citd.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <4471E39C.1070003@citd.de>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2006 at 06:15:24PM +0200, Matthias Schniedermeyer wrote:
> You just described the working-principle of a "line-interarctive" UPS.
> AFAICT this is the most used UPS-type, at least for every "small" UPSes=
=20
> i've seen in the last few years.

Exactly, and since I cannot afford to buy one I'd have to build it
myself using mainly car batteries. The most complex part would be to
charge the batteries in a way that won't kill them over time. Building
such stuff into the PSU after the secondary coil and AC/DC converter
would save the double-conversion loss, therefore making this ideal for a
single machine. But I'm still brainstorming, lacking both money and
time.

Kind regards,
Chris

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRHITt12m8MprmeOlAQKyEBAAsPb1aPRHdYTLDPKOu3nsSS9+Z2N/W7Ed
GAcVkY0Lm63T2vl6pBRusAXrr1veYkm/UMEiZot9X5MgBW9LtAeze3nYYr+aSlrk
dDtZjvluD0CccSEydhkFKiq5edydIibXe14TnVeTb3od5Ps4/5Udtcf2nMa5889d
vmHDs9PrSgEmeb5fAaXgM653uceujRoYVMC1oOunw9L9prbyStHwP5YFpfXyN/mG
+nJubN9MOoP3iDdaUgQsziiTLBYvw4IPLxu10/iWblWil3AUIyRwA1LUfWZa/6fP
g0SaqZPZGPM90uoXz1f+R9FrgXFiQlDzsyHwzCLe5RoQTQ3uzgREiyWw+gsOXyzR
p9URO+Cj4TQiG7+mMHtZHNrOU70hlLwxJ8Bv9wO01U2IeoWOt9HKGG/a0N3ALRgX
y5PNFLGtx2haGeyxJIXKVXd0JuuIoeJilEjmejRjjJF0FjpYEoCu0fO7Aeedp0JS
B92aWE+p1kI1lzgRgDUUe1pNbTPid/xA/PmLqMIFP4gLKSFOSFo+zYfyNT5qJu2D
eIpX5lEfFhcphC4AfmztRRQtiC3/USuspAxnk0rgWoIrwYhim84HNsOQ1gfrwv53
ESxbK9Fo43jsFZwNETtuX+5t+Y6z9t6mXJ4XPwtOhvIkCCwfDWJEXapETUcsADhT
4bgSUZaPB8o=
=Hal0
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--

