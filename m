Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUDWQC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUDWQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUDWQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:02:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264781AbUDWQC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:02:27 -0400
Date: Fri, 23 Apr 2004 11:02:04 -0500
From: AJ Lewis <alewis@redhat.com>
To: Daniel.Kirsten@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: xconfig font problems
Message-ID: <20040423160204.GB32058@null.msp.redhat.com>
References: <16404.1082735053@www66.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <16404.1082735053@www66.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2004 at 05:44:13PM +0200, Daniel.Kirsten@gmx.net wrote:
> since somewhen in the 2.6.5-rc series, I have some font problems=20
> in make xconfig. I just see rectangles instead of letters...=20
> However, numbers are displayed correctly.  (I use Fedora.)
>=20
> Does anyone know a solution.

Someone I know who had the same problem removed the .fonts.cache-1 file and
the .qt directory from their home directory, and it fixed it.  I'm guessing
it was just the font cache file that needed to go though...

Regards,
--=20
AJ Lewis                                   Voice:  612-638-0500
Red Hat Inc.                               E-Mail: alewis@redhat.com
720 Washington Ave. SE, Suite 200
Minneapolis, MN 55414

Current GPG fingerprint =3D FE77 4B43 6A9B F982 A731  02FA 2BF5 7574 294A A=
A5A
Grab the key at: http://people.redhat.com/alewis/gpg.html or one of the
many keyservers out there...
-----Begin Obligatory Humorous Quote----------------------------------------
"Facts are useless!  You can use facts to prove almost anything that's even
remotely true.  Facts schmacts."  --Homer Simpson
-----End Obligatory Humorous Quote------------------------------------------

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAiT379QxUqFeMhxURAjJ4AKCgqaZtQnQxZRFyt0FNizSwSHmMwACgjCGm
FMzQKojAtno2H3LhqYbaQXY=
=qPgB
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
