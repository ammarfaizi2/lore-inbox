Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbTDLXMm (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTDLXMm (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 19:12:42 -0400
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:14048
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S261897AbTDLXMk (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 19:12:40 -0400
Date: Sat, 12 Apr 2003 16:24:25 -0700
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bug: slab corruption in 2.5.67-mm1
Message-ID: <20030412232425.GA24920@triplehelix.org>
References: <3E988DA2.4080600@tmsusa.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <3E988DA2.4080600@tmsusa.com>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2003 at 03:05:22PM -0700, J Sloan wrote:
> I had run 2.5.67-mm1 for some days and for
> the most part it ran well in it's duties as dns,
> squid, vpn/firewall and postfix server, with
> the only oddity being the ide messages which
> I reported earlier.

You're insane running a -mm kernel on a production machine, IMHO.
They're good for desktop use but in my experience anything that needs to
stay up for more than a few days should at LEAST use one of the
stability-oriented patches like -mjb or -osdl, if not the vanilla
kernel.

2.5-mm typically goes nuts with such errors as you described after a
few days of uptime, as far as I've seen and noticed. These bugs will
probably eventually be fixed, but at this time, it's still unstable.

I wouldn't run anything above 2.4.20 on a box that does what you
describe..

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mKApT2bz5yevw+4RAuBbAJ0SmPm9Gu7twn3l1+I9cAduB3/c4wCcD96F
4qqrn2X6Z73EKJUyKwVz9dY=
=6O4o
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
