Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBXCV5>; Fri, 23 Feb 2001 21:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBXCVr>; Fri, 23 Feb 2001 21:21:47 -0500
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:3589
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S129159AbRBXCVf>; Fri, 23 Feb 2001 21:21:35 -0500
Date: Fri, 23 Feb 2001 20:21:30 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Kevin Turner <acapnotic@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <20010223202130.A4178@zed.dlitz.net>
In-Reply-To: <20010220021609.B11523@troglodyte.menefee> <20010223173557.A2744@zed.dlitz.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010223173557.A2744@zed.dlitz.net>; from dlitz@dlitz.net on Fri, Feb 23, 2001 at 05:35:57PM -0600
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID-Sign: 0xE272C3C3
X-PGP-Fingerprint-Sign: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.2-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I think Alan fixed it.

I've been running 2.4.2-ac3 under heavy load for about a half-hour now under
heavy disk usage (apt-get + 2 kernel builds + Netscape/X11), and it hasn't
locked up yet.

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

- Please always Cc to me when replying to me on the lists.
- See the mail headers for GPG/advertising/homepage information.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqXGqoACgkQ+Zi22OJyw8NKvwCgl82vjEaB/anBB6sIBP1XViS3
H7wAn2xM3V3DKyIuIN1cLTJ7SXG6M82K
=CtTd
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
