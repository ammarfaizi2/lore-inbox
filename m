Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUBRTF3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUBRTF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:05:29 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:13715 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S266494AbUBRTFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:05:18 -0500
Date: Wed, 18 Feb 2004 20:05:10 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: the crux with DMA
Message-ID: <20040218190510.GA14386@diamond.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040218112052.GA8001@diamond.madduck.net> <4033B3CC.2030609@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <4033B3CC.2030609@namesys.com>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.2-diamond i686
X-Mailer: Mutt 1.5.5.1+cvs20040105i (2003-11-05)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Hans Reiser <reiser@namesys.com> [2004.02.18.1949 +0100]:
> both ext3 and reiserfs are higher performance than XFS for typical file=
=20
> sizes.  XFS does very well for streaming video though (as does reiser4).

How about large files (e.g. > 2Gb).

Do you have specs on your above statement? Not that I doubt
reiserfs, but I have been generally unhappy with its performance,
especially when huge files are involved. And I have suffered severe
corruption from a single bad block. A lot of people have suggested
using XFS. I am not a guru, so these statements are far from
educated.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
consciousness: that annoying time between naps.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAM7dmIgvIgzMMSnURAoW+AJ4x8KkLX8P+MDZDP3v6aAmL28d4EwCeNaEy
UhnpjIEaDptlQWzv1rWJetc=
=EQjg
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
