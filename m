Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277550AbRJVFk7>; Mon, 22 Oct 2001 01:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJVFkt>; Mon, 22 Oct 2001 01:40:49 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:14481
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S277550AbRJVFkh>; Mon, 22 Oct 2001 01:40:37 -0400
Date: Sun, 21 Oct 2001 23:41:10 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac5
Message-ID: <20011021234110.A4193@zed.dlitz.net>
In-Reply-To: <20011022004549.A32210@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20011022004549.A32210@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.12-ac5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan, is this normal?

zed:~# cat /proc/sys/kernel/tainted
1
zed:~# echo "0" >/proc/sys/kernel/tainted
zed:~# cat /proc/sys/kernel/tainted
0
zed:~#

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvTsXUACgkQ+Zi22OJyw8P3GACbBJwhN9ItosKJw6MDSqRqlhM2
fHIAoJEwtiTEnkPNIql394Tb8ws75yVb
=SBQ0
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
