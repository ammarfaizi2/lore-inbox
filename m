Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWBCMTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWBCMTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWBCMTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:19:09 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:7177 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1750729AbWBCMTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:19:08 -0500
Subject: WLAN drivers
From: Panagiotis Issaris <takis.issaris@uhasselt.be>
To: linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RJcW+G8/YuchqsBc0pa2"
Date: Fri, 03 Feb 2006 13:18:58 +0100
Message-Id: <1138969138.8434.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RJcW+G8/YuchqsBc0pa2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to decide which wireless card to purchase, and I find it
quite difficult to know which cards are support "out-of-the-box" with
recent Linux kernels. I've found various lists of WLAN cards on
websites, on which people report success stories, but I still think
it's rather confusing.

A year ago I bought a card (WG111), which was supposed to be supported
by an open source driver, but in the end I still had to use ndiswrapper
as there appeared to be two [*] different versions of that same product.
One used the chipset which could be used with an open source driver, the
other -ofcourse the version I bought- is not supported by any open
source driver.

So, basically, getting a product name or number doesn't seem to be
enough to be sure to buy a card which will work with a unpatched Linux
kernel.

Furthermore, it appears the cards that are supported, are often
supported by out-of-kernel drivers, which is a tad less convenient, and
gives me some concerns on whether the driver will always be available
for recent kernels.

And, finally, it seems a lot of cards that get recommendations, are
based on rather old chipsets, which are unlikely to be still sold today.



And now the reason I'm sending this to this mailing list: Which wireless
network cards are you all using and which ones would you recommend? Is
anyone using USB wireless network cards (without using ndiswrapper)?


With friendly regards,
Takis


[*] At that time, now I think there's even three different versions,
possibly using different chipsets.

--=-RJcW+G8/YuchqsBc0pa2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD40oy9kOxLuzz4CkRAsjmAJ9WQvC4KO/3MO7SzBjJEx/8JliQLQCfQDyz
7H+Oiwm47mmgB4273Zy70YA=
=ZtLV
-----END PGP SIGNATURE-----

--=-RJcW+G8/YuchqsBc0pa2--

