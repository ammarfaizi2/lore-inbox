Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293630AbSCATFd>; Fri, 1 Mar 2002 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSCATFL>; Fri, 1 Mar 2002 14:05:11 -0500
Received: from 12-249-51-60.client.attbi.com ([12.249.51.60]:36793 "EHLO noir")
	by vger.kernel.org with ESMTP id <S293630AbSCATER>;
	Fri, 1 Mar 2002 14:04:17 -0500
Date: Fri, 1 Mar 2002 13:04:17 -0600
From: Kain <kain@kain.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: Multipath routing 2.4.17
Message-ID: <20020301190417.GA30370@kain.org>
In-Reply-To: <20020301173414.GA30037@kain.org.suse.lists.linux.kernel> <p731yf4kvib.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <p731yf4kvib.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2002 at 07:12:12PM +0100, Andi Kleen wrote:
> Kain <kain@kain.org> writes:
>=20
> > I am running a mailserver on linux 2.4.17 with equal-cost multi-path
> > routing to 2 local routers, and I am able to OOPS the machine under
> > moderate load with the multipath route installed. Attached is a decoded
> > OOPS log as well as my .config.
> >=20
> > These are my log messages immediately before the OOPS:
> >=20
> > impossible 888
> > divide error: 0000
>=20
> They should be after, not before the oops.=20
>=20
> What compiler are you using?=20

I am compiling with debian sid gcc:
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)

--=20
Assassins do it from behind.
**
Professional
Bryon Roche, Kain <kain@imperativesolutions.com>
<kain@kain.org>

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjx/0LEACgkQBK2G/mh4q9XHIQCfVxPAWZbH1JmZo8xZ88EN/X9Y
JKQAn2ekJpm/WXvP6XbpHicLaiRo0ScS
=vHTO
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
