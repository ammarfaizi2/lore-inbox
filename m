Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSGJJIP>; Wed, 10 Jul 2002 05:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGJJIO>; Wed, 10 Jul 2002 05:08:14 -0400
Received: from host158.spe.iit.edu ([198.37.27.158]:60836 "EHLO lostlogicx.com")
	by vger.kernel.org with ESMTP id <S317590AbSGJJIN>;
	Wed, 10 Jul 2002 05:08:13 -0400
Date: Wed, 10 Jul 2002 04:10:35 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Vitaly Fertman <vitaly@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfsprogs release
Message-ID: <20020710041035.A7547@lostlogicx.com>
References: <200206251829.25799.vitaly@namesys.com> <20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com> <200207101206.48370.vitaly@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207101206.48370.vitaly@namesys.com>; from vitaly@namesys.com on Wed, Jul 10, 2002 at 12:06:48PM +0400
X-Operating-System: Linux found 2.4.17-openmosix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I may be stupid, but if the latest release is 3.6.2 why is the "LATEST IS"=
=20
link still pointing to 3.x.1b?  Is 3.6.2 the version which we (Gentoo=20
Linux) should be packaging?  Is it more or less safe than 3.x.1b?  Thanks!

--Brandon

On Wed, 07/10/02 at 12:06:48 +0400, Vitaly Fertman wrote:
>=20
> Hi all,
>=20
> the latest reiserfsprogs-3.6.2 is available on our ftp site.
>=20
> The most of changes are just bug fixes and speedups.
>     StatData got wrong values sometimes.
>     Tails were not converted back if had been converted to internal.
>     Lost+found was not accessible sometimes due to wrong flag in
>     metadata.
>     Extra checks on --check and fixes on --fix-fixable were added
>     for wrong st_nlinks, some info in internal tree.
>     Some multiple checks during overwriting and relocation were
>     eliminated.
>     Etc.
>=20
> Added different block size support - 1k, 2k and for Alpha 8k.
> Kernel support we are going to include into 2.4.20.
>=20
> Support for bad block lists was added also but disabled for now
> due to some conflicts with the current kernel, which have not been
> solved yet.
>=20
> Verson numbering scheme was changed.
>=20
> Another pre release 3.6.3-pre1 is also available. It includes some=20
> great speedups for reiserfsck.
>=20
> --=20
>=20
> Thanks,
> Vitaly Fertman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9K/oLHCCPbR8BLcYRAmyjAJ9mSv3VlIIrtyA0zne5O2wEr487fACgl1o1
uUMRj1XiU5ivCDndxXJ/HO4=
=gK12
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
