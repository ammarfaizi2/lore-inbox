Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbUCZDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUCZDV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:21:28 -0500
Received: from 66-194-152-191.gen.twtelecom.net ([66.194.152.191]:30340 "EHLO
	pico.surpasshosting.com") by vger.kernel.org with ESMTP
	id S263027AbUCZDVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:21:04 -0500
Date: Thu, 25 Mar 2004 21:20:10 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, ak@suse.de, len.brown@intel.com, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326032010.GB9248@cheney.cx>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx> <20040326030809.GQ7967@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1kVeyRzorzGcO9ta"
Content-Disposition: inline
In-Reply-To: <20040326030809.GQ7967@atomide.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1kVeyRzorzGcO9ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2004 at 07:11:45PM -0800, Tony Lindgren wrote:
> * Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> >=20
> > Is this actually a "VIA" fix or a just workaround for the broken Arima
> > bios? I noticed that the Arima bios seems to be pretty buggy in some
> > other aspects as well.
>=20
> VIA fix, not a BIOS thing.

I guess I am just surprised that no one else had noticed this bug back
when K8T800 first came out (April 2003) and fixed it already. :)

Thanks,
Chris

--1kVeyRzorzGcO9ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY6Fq0QZas444SvIRApaCAJ4/BjL1y9zv5KahRMf47PbWkPzPBwCcDN/o
uxII/XNhE4A5N1sc/aY2HQo=
=UZVK
-----END PGP SIGNATURE-----

--1kVeyRzorzGcO9ta--
