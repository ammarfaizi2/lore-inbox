Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423088AbWAMXCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423088AbWAMXCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 18:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423086AbWAMXCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 18:02:12 -0500
Received: from sipsolutions.net ([66.160.135.76]:22290 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1423074AbWAMXCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 18:02:10 -0500
Subject: Re: wireless: recap of current issues (other issues)
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137191711.2520.69.camel@localhost>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213237.GH16166@tuxdriver.com>
	 <20060113222408.GM16166@tuxdriver.com> <1137191711.2520.69.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mrChvECTFctSS+kxcvp3"
Date: Sat, 14 Jan 2006 00:02:00 +0100
Message-Id: <1137193320.2520.73.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mrChvECTFctSS+kxcvp3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-13 at 23:35 +0100, Johannes Berg wrote:
> On Fri, 2006-01-13 at 17:24 -0500, John W. Linville wrote:
>=20
> > Radiotap headers make sense for an rfmon virtual device.  I don't
> > think it makes sense for "normal" usage.  Should there be an option
> > for radiotap headers on non-rfmon links?
>=20
> Yes. For hardware debugging.

Actually, scratch that. For hardware debugging you just add a virtual
rfmon device and go with that, and just don't do anything except 2
virtual devices on the wiphy.

johannes

--=-mrChvECTFctSS+kxcvp3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8gxZaVg1VMiehFYAQLn7BAAi1NDZCBVVLyMBJgHsHgDAnTdsqD3r2lr
fyAiW0QxAQk/8Q0xvIDrfg8uENVZ4jDPhhtOJ314mbO8OuLhinn7bQbVJ+gidqwj
c8qblaJGB2bggfVO+p4hnrreRXnkySO3bhBCgWGtFUjT62Vye03k0sOqh50sbYi5
ESM98fbdu54rghlD5LwEIIgq3pPg/fSitB+aDA3u2pLIjhJrZqAezCEFE8PUcV4Z
eRCvA+E/hx/3mJ5K0UYY+tI9dCAkLr1d3ddso3Kw8JThTAQqwpB0Bk7PFLgHypPH
Fam5y+rhPXtTwxu3AvOdsKm4y4F0YZ1A56bhrxmEUQWMhJfCLQGk17i3gyCnYEba
wDbHjX7cWBHdh750hi0sQamfYrVsaCgg89/Qfb0kW6r+RW0SQ27iNMvdy9KWDcMK
orN7x10IoqfCJrY43joSlkJDOi22hHdUN5V3+jfjY3NGXIkmB6nUeJCVMnN1Oy9Q
q/d+SWDSVQN978BpzXfUSJczrBa2aLqDCy+CT7OXYBXQBxxH+dPGNJe6beAlKgbu
FgN7U4a8lqrLgwAMc6Cigxpp1ID+ImgIVOUgHgYhZ73UYjipajhufGY96bncI8qm
15xYP8z3C2MTH/i8WBnjEVtsWz5VcxsnSwrO9Q0KR/eKADSltH9Ad7qeXFtmQkaU
3oc5TgdxuMU=
=uXNj
-----END PGP SIGNATURE-----

--=-mrChvECTFctSS+kxcvp3--

