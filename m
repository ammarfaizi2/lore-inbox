Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268034AbRG2Ott>; Sun, 29 Jul 2001 10:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268033AbRG2Otj>; Sun, 29 Jul 2001 10:49:39 -0400
Received: from new-smtp1.ihug.com.au ([203.109.250.27]:5133 "EHLO
	new-smtp1.ihug.com.au") by vger.kernel.org with ESMTP
	id <S268017AbRG2Otb>; Sun, 29 Jul 2001 10:49:31 -0400
Date: Mon, 30 Jul 2001 00:49:16 +1000
From: Steve Kowalik <stevenk@debian.org>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Jean Charles Delepine <delepine@u-picardie.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Debian-Devel List <debian-devel@lists.debian.org>,
        Herbert Xu <herbert@debian.org>,
        Manoj Srivastava <srivasta@debian.org>
Subject: Re: make rpm
Message-ID: <20010730004916.A2359@broken.wedontsleep.org>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	Jean Charles Delepine <delepine@u-picardie.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Debian-Devel List <debian-devel@lists.debian.org>,
	Herbert Xu <herbert@debian.org>,
	Manoj Srivastava <srivasta@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20010729141959.B19103@wiggy.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux broken 2.4.7 i686
X-Subliminal-Message: Debian Rocks!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2001 at 02:19:59PM +0200, Wichert Akkerman uttered:
> Previously Jean Charles Delepine wrote:
> > Maybe Herbert Xu, the actual developper of the Debian kernel package or=
=20
> > Manoj Srivastava, for the Debian Linux kernel package build scripts can
> > do that.
>=20
> We've had that option for years, just call "make-kpkg kernel_image".
> It would be trivial to add a rule to the Makefile in the kernel tree
> that calls that if you do "make deb".
>=20
make-kpkg --revision=3D${KERNELRELEASE} kernel_image",surely?

--=20
                                                    Steve
Synthetic Transforming Entity Viable for Exploration and Nocturnal Killing

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZCJswJ0/XSswJFIRAqrLAJ4lKVHWkx/QzARnk9ErHoY+2PLE8QCgrhgr
bVz/rJUT2m3b8pa1EmfPsXo=
=eVbo
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
