Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTL1CvA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTL1CvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:51:00 -0500
Received: from adsl-67-121-154-253.dsl.pltn13.pacbell.net ([67.121.154.253]:23514
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264943AbTL1Cu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:50:58 -0500
Date: Sat, 27 Dec 2003 18:50:54 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: What is MCE?
Message-ID: <20031228025054.GN12871@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <173d01c3cceb$08c0cda0$43ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Content-Disposition: inline
In-Reply-To: <173d01c3cceb$08c0cda0$43ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2003 at 11:33:24AM +0900, Norman Diamond wrote:
> Sometimes:
> MCE: The hardware reports a non fatal, correctable incident occurred on C=
PU
> 0.
> Bank 3: a200000000080a01
>=20
> Obviously this isn't a Linux error, Linux is being kind enough to report a
> hardware error to me, but I don't know how to interpret these error flags.
> I don't even know what MCE is but whoever developed it for Linux surely m=
ust
> know.  Please, how can I find out what this is?

MCE stands for Machine Check Exception.

This mailing list reply provides a pretty good explanation of it:

http://lists.debian.org/debian-user/2000/debian-user-200009/msg01677.html

--=20
Joshua Kwan

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP+5FC6OILr94RG8mAQLXFxAAxEE1kPDuoYeUaUp86kDczBCAVPxLcm31
hlob8m/BH2bQOCXwq8NUHs3cOecou3G8lA7S5SoIAUFNTynQOUYW58pmiY+QhyVB
CmeoKW9ZrYcyUuhz6RXG/EKh7gACLN/OFWHj7pz/whDebx/RFX0fvwKXp4V6B5AZ
Ov1qYI82teIP2LTXY43w6obP6uLgDhohEBwXZnpnH35UvcF+v9uJTBLicje6gZnU
i4userB6J7UujwzUaeyIBPYXFRzkVEqimfsydazccWirq10o9qN0pUtZMRT1iTq6
8qBHA/tJMfXeZGvEqiPQzkVB1wr4qKvqhhmMonJMATEF3Jrodzez55E6O+6aaSY6
cdpZgXMgMcX/MvUrilLc3A+Gy0n83oqTYDLHvF1E4d2ekTMzDwkkMvM9FA97+djY
IPEWjQcMayrgIeecBLwabvC4eFyPSHhO0V97gbjlBZ2WxiwRVQnKSC42wv/Biwxm
z3NOOF+fh/44hiJS2yiBtyNxTqP5w0+pNdR2/WXt3HtVXlGNj/jPSUEOQCez2SJ6
Ts506mooc4BcscpwPbdedz5iUB9ro7qq0voVepPGYPRADgkX8HHE3GP18KHLQ+G2
VM4I6k3gzus5g7PmBezCHBHuxmcwkucf5jWOWojkniGllfUT6iDk1eeimr3vk7fa
5egv/2XONUY=
=1OHl
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--
