Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268225AbRGWNaY>; Mon, 23 Jul 2001 09:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268227AbRGWNaO>; Mon, 23 Jul 2001 09:30:14 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:60432
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S268225AbRGWNaG>; Mon, 23 Jul 2001 09:30:06 -0400
Date: Mon, 23 Jul 2001 07:30:08 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: gjerdelist@icebox.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec 2100S and 2.4.7-pre8(and 2.4.6-ac5)  i2o driver
Message-ID: <20010723073008.A1443@zed.dlitz.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0107230612420.11081-100000@snowman.icebox.org>
User-Agent: Mutt/1.3.18i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=20
> I had both compiled into the kernel at the time, but i2o_block seems to
> initialize first(i2o_block help claims they can both be used at same
> time, I sure don't know :).
>=20
> However, today I tried with only i2o_block compiled in, and now it just
> complains about not being able to mount root filesystem.  Same kernel and
> same config, except DPT patch(from http://aurore.net/source/, for 2.4.5
> but patches without any fuzz) and remove i2o support and add Adaptec i2o
> support, works fine.

Hmm... :-/   Well, thanks for the link!

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtcJuAACgkQ+Zi22OJyw8Oq2gCeJzmsFMOw7XYNOsWPLlmxk6oT
VMoAoNgjOHvmGh6zBpUn15hMMms5fUIq
=RPWu
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
