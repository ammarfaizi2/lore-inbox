Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDAVLQ>; Sun, 1 Apr 2001 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDAVLH>; Sun, 1 Apr 2001 17:11:07 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:8489 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132563AbRDAVKz>; Sun, 1 Apr 2001 17:10:55 -0400
Date: Sun, 1 Apr 2001 22:10:07 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
   linux-kernel@vger.kernel.org
Subject: Re: problem in drivers/block/Config.in (PATCH)
Message-ID: <20010401221007.K15175@redhat.com>
In-Reply-To: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at> <20010331160027.A26494@balu.sch.bme.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yr6OvWOSyJed8q4v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010331160027.A26494@balu.sch.bme.hu>; from pozsy@sch.bme.hu on Sat, Mar 31, 2001 at 04:00:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yr6OvWOSyJed8q4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 31, 2001 at 04:00:27PM +0200, Pozsar Balazs wrote:

> On Fri, Mar 30, 2001 at 10:17:08PM +0200, Herbert Rosmanith wrote:
> In fact, if we want to get what is said in the comment, we should write:
>=20
> if [ "$CONFIG_PARPORT" =3D "m" -a "$CONFIG_PARIDE_PARPORT" =3D "y" ] ; th=
en
>    define_bool CONFIG_PARIDE_PARPORT m
> fi

But the condition is never satisfied.

Tim.
*/

--yr6OvWOSyJed8q4v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6x5kuONXnILZ4yVIRAkf6AJ9ZFxNf4lIrKPNESNMoHvfP6GrbUwCfcNKO
53gP+nrYKcE8rbuXhTyDFM8=
=VTzG
-----END PGP SIGNATURE-----

--yr6OvWOSyJed8q4v--
