Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTKLKls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTKLKls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:41:48 -0500
Received: from safe17.bezeqint.net ([212.179.95.63]:33213 "EHLO
	safe13.bezeqint.net") by vger.kernel.org with ESMTP id S261931AbTKLKlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:41:46 -0500
From: Okrain Genady <mafteah@mafteah.co.il>
Reply-To: mafteah@mafteah.co.il
Organization: Mafteah
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
Date: Wed, 12 Nov 2003 12:38:50 +0200
User-Agent: KMail/1.5.4
References: <20031112080119.GD21265@home.bofhlet.net> <200311121231.39011.mafteah@mafteah.co.il> <20031112103250.GC21141@suse.de>
In-Reply-To: <20031112103250.GC21141@suse.de>
Cc: Vid Strpic <vms@bofhlet.net>, Berke Durak <obdk65536@ouvaton.org>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_62gs/XJt4Fp+CFZ";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311121238.50406.mafteah@mafteah.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_62gs/XJt4Fp+CFZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Ok I will try without the scsi soon.


On Wednesday 12 November 2003 12:32, you wrote:
> On Wed, Nov 12 2003, Okrain Genady wrote:
> Content-Description: signed data
>
> > I didn't test w/o scsi-emu.
> > I have scsi-emu compiled in the kernel
>
> Well compile a kernel without it then, and just use ide-cd. I wont
> repeat for the Xth time why this is so, see any 2.6 'whats new' document
> or search lkml for reasons.

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

--Boundary-02=_62gs/XJt4Fp+CFZ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/sg26H3z3n0CNSu4RAo+2AJwJ30vMluGWXWWa+yVtfSah9wf1/wCeNLCV
Ffto+AeWPNVRNCAMlVYlsms=
=r7Bj
-----END PGP SIGNATURE-----

--Boundary-02=_62gs/XJt4Fp+CFZ--

