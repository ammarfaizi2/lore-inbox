Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTKLK3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTKLK3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:29:12 -0500
Received: from safe16.bezeqint.net ([212.179.95.62]:25240 "EHLO
	safe16.bezeqint.net") by vger.kernel.org with ESMTP id S261873AbTKLK3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:29:10 -0500
From: Okrain Genady <mafteah@mafteah.co.il>
Reply-To: mafteah@mafteah.co.il
Organization: Mafteah
To: Vid Strpic <vms@bofhlet.net>, Berke Durak <obdk65536@ouvaton.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
Date: Wed, 12 Nov 2003 12:31:38 +0200
User-Agent: KMail/1.5.4
References: <20031112080119.GD21265@home.bofhlet.net> <200311121206.55323.mafteah@mafteah.co.il> <20031112101910.GB21141@suse.de>
In-Reply-To: <20031112101910.GB21141@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Lwgs/k618rqNqRA";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311121231.39011.mafteah@mafteah.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Lwgs/k618rqNqRA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

I didn't test w/o scsi-emu.
I have scsi-emu compiled in the kernel

btw:
when I use readcd my computer dies.

On Wednesday 12 November 2003 12:19, Jens Axboe wrote:
> On Wed, Nov 12 2003, Okrain Genady wrote:
> Content-Description: signed data
>
> > Yep, I have that problem too.
>
> does burning without ide-scsi not work?

=2D-=20
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Okr=
ain Genady
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
=A0E-Mail=A0=A0=A0=A0=A0=A0=A0=A0=A0: mafteah@mafteah.co.il
=A0ICQ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0: 73163402
=A0Home Page=A0=A0=A0=A0=A0=A0: http://www.mafteah.co.il/
=A0GnuGP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0: 0x4F892EE6 At http://pgp.mit.edu/
=A0Fingerprint=A0=A0=A0=A0: 5853 E821 5EF2 69BC A9AE 3F24 1F7C F79F 408D 4A=
EE
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|

--Boundary-02=_Lwgs/k618rqNqRA
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sgwKH3z3n0CNSu4RAjVVAJ96JRvU754qSCfkhhN6las51p8cawCfYG/f
5mF423epYI+RoRejdcX1MaI=
=OgxK
-----END PGP SIGNATURE-----

--Boundary-02=_Lwgs/k618rqNqRA--

