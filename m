Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUAGRRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUAGRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:17:30 -0500
Received: from grendel.firewall.com ([66.28.58.176]:48336 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S266253AbUAGRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:17:24 -0500
Date: Wed, 7 Jan 2004 18:17:19 +0100
From: Marek Habersack <grendel@caudium.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb and highmem?
Message-ID: <20040107171719.GC1119@thanes.org>
Reply-To: grendel@caudium.net
References: <20040107153934.GB1119@thanes.org> <Pine.LNX.4.44.0401071708120.30778-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401071708120.30778-100000@phoenix.infradead.org>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2004 at 05:09:39PM +0000, James Simmons scribbled:
>=20
> This is because of the radeonfb driver ioremapping the framebuffer memeor=
y=20
> whichcan be really big. Once the driver is fully accelerated then we can=
=20
> remove the ioremap function in the driver.
I see, is there any ETA for that to happen? And, if you need some testing -
I will be glad to help

thanks,

marek

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//D8fq3909GIf5uoRAg4LAJ4k2AzFeq+828FGch0TZvk/PjCrfACfXw3M
R+pqWNY3n8UJI/OwzgaIpJM=
=wfyJ
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
