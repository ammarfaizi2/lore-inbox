Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVAERup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVAERup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVAERuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:50:44 -0500
Received: from grendel.firewall.com ([66.28.58.176]:53133 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S262517AbVAERuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:50:05 -0500
Date: Wed, 5 Jan 2005 18:49:58 +0100
From: Marek Habersack <grendel@caudium.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050105174958.GA5295@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20050104195636.GA23034@beowulf.thanes.org> <20050105094236.GG10036@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20050105094236.GG10036@logos.cnet>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 05, 2005 at 07:42:36AM -0200, Marcelo Tosatti scribbled:
[snip]
> > Has anyone had similar problems with 2.4.28 in an environment resemblin=
g the
> > above? Could it be a problem with highmem i/o?
>=20
> Nothing that I'm aware of should cause such increase in loadavg.
>=20
> Marek, can you please try 2.4.28-pre1 ?
I should be able to schedule that on Friday. Currently, we're running 2.4.28
on one of the machines (the non-virtual) but with mem=3D800M to exclude
highmem. So far - no problems... We'll see how it goes on

best regards,

marek

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB3CjGq3909GIf5uoRAlw7AJ954nY8PULz76+lzqDQE8Axc5BsagCfQ8Og
dOIi3oJrk2aztoIRo0tXm6g=
=/Yrg
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
