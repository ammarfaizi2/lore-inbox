Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRCARLo>; Thu, 1 Mar 2001 12:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRCARLf>; Thu, 1 Mar 2001 12:11:35 -0500
Received: from hermes.sistina.com ([208.210.145.141]:13324 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S129733AbRCARKN>;
	Thu, 1 Mar 2001 12:10:13 -0500
Date: Thu, 1 Mar 2001 11:09:53 -0600
From: AJ Lewis <lewis@sistina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: smartmedia adapter support??
Message-ID: <20010301110953.L16667@sistina.com>
In-Reply-To: <20010301100041.A22824@mediaone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010301100041.A22824@mediaone.net>; from tewalberg@mediaone.net on Thu, Mar 01, 2001 at 10:00:41AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2001 at 10:00:41AM -0600, Tim Walberg wrote:
> Just wondering whether anyone has successfully gotten
> either a PCMCIA SmartMedia Adapter (specifically the
> Viking Components one) or a FlashPath floppy SmartMedia
> adapter working under 2.4.x. I've got both, and haven't
> gotten either working under either 2.2.x or 2.4.x, but
> I haven't had the time to work real hard at it either,
> so I'm hoping someone can give me some pointers...

I have a Simple Technology PCMCIA adapter that just worked when I compiled
the PCMCIA modules for my kernel.  It just looks like an IDE hard drive to
linux and shows up as an /dev/hdxx device.

--=20
AJ Lewis
Sistina Software Inc.                  Voice:  612-379-3951
1313 5th St SE, Suite 111              Fax:    612-379-3952
Minneapolis, MN 55414                  E-Mail: lewis@sistina.com
http://www.sistina.com

Current GPG fingerprint =3D 3B5F 6011 5216 76A5 2F6B  52A0 941E 1261 0029 2=
648
Get my key at: http://www.sistina.com/~lewis/gpgkey
 (Unfortunately, the PKS-type keyservers do not work with multiple sub-keys)

-----Begin Obligatory Humorous Quote----------------------------------------
FATAL ERROR! SYSTEM HALTED! - Press any key to do nothing...
-----End Obligatory Humorous Quote------------------------------------------

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6noJhpE6/iGtdjLERAmWWAJ9g5O164bSCgriBnuskcFHdumi5RQCeJ9pJ
kYq2cXmT+dkk32VZvCMxPeI=
=gLiS
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
