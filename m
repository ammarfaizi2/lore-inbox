Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbRBBBV0>; Thu, 1 Feb 2001 20:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130931AbRBBBVR>; Thu, 1 Feb 2001 20:21:17 -0500
Received: from munch-it.turbolinux.com ([38.170.88.129]:58357 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S130499AbRBBBVG>;
	Thu, 1 Feb 2001 20:21:06 -0500
Date: Thu, 1 Feb 2001 17:20:56 -0800
From: Prasanna P Subash <psubash@turbolinux.com>
To: Jagan_Pochimireddy@3com.com
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel ver 2.4.1 VFS problem
Message-ID: <20010201172056.A7259@turbolinux.com>
In-Reply-To: <882569E7.0001FE39.00@hqoutbound.ops.3com.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <882569E7.0001FE39.00@hqoutbound.ops.3com.com>; from Jagan_Pochimireddy@3com.com on Thu, Feb 01, 2001 at 04:22:03PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2001 at 04:22:03PM -0800, Jagan_Pochimireddy@3com.com wrote:
>=20
>=20
> But the driver for my Hard disk is not there in the list, mine is FUJISTU=
 disk
> .I think Generic scsi driver will work
>=20
> Thanks
> Jagan
>=20
>=20
Your scsi driver could be compiled into as a module. "mkinitrd" to boot off
a scsi root disk and update lilo info.
Another quick solution would be to compile the scsi driver into the kernel.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Can't open /usr/fortunes.  Lid stuck on
of a GNU generation   -o)  | cookie jar.=20
Kernel 2.2.16         /\\  |=20
on a i686            _\\_v |=20
                           |=20
------------------------------------------------------------------------

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6egt45UrYeFg/7bURAtoVAJ4oZpFnUCeSzduz1R5CpY+juAjCCACffU2S
R4dYCvggSYZMWux73RwkeHg=
=NcFA
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
