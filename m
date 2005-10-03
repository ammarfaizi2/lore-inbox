Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVJCIfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVJCIfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVJCIfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:35:41 -0400
Received: from wg.technophil.ch ([213.189.149.230]:56450 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932192AbVJCIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:35:41 -0400
Date: Mon, 3 Oct 2005 10:35:37 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.13.2 - menuconfig: raid support wrong place?
Message-ID: <20051003083537.GB1746@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Is it wanted, that some hardware raids are listed below
"Block devices" and not IDE or SCSI support?

And will SATA devices in general stay below SCSI?

Both things aren't really intuitive to find and I would expect
the raid drivers below IDE or SCSI and I was searching for SATA
not below SCSI some times.

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ0DtWLOTBMvCUbrlAQKLOQ/+JNCKZir1pWIHSyBtsyKX0mCixK7x23HD
Qg3TgIXcbooO/p9TnSFm2DI8asybQMEPgIdwRkUmg+Pkxszym3XEzXaecyrmOX9k
XiECEApRP8MdjqPzONBtCoSM6excDZO4Bdm3Xjqn6Go3kPgv4P7G4ZR6JCy/eC8g
Wi5tN8FzWaa8ur0mNVx+INNGvaoNIoH0kQHeXchtIHbZ6p2UBP3l9V2FG0EPNWB7
xufYI8pN68Gn2QnI4T3D4AvzPVQqlLEJWVygxk3cctDn7QRTLWNC6CaKfetggix/
v31xzweMN1AfDCV5rMRgZ5NT11l9GzubkOFCaiKOr9XAV7pIf5w9Ms3kWeHFCGY8
3q1LCKoWyF/dbc60OsqdIdLuBtppy6CMByChdnzb48ir1NEX6H9E060fkmih2meG
QrHZAWWDl+SWGb8WO7mw6R4ZzDJvFcJrmbUu9y/evlbFMGzbCTTKrrLn5Eti9fwd
QnpPMk/sOncVZ9QaHUt6cXCtWD2HEk9StOHCLerSH/yqNIoy2jpQx5z9lCMVURX4
zjEkStS555Vq6YLpJyd6eBTGG4wSUpAOddu8hYY9YeZflN4hFKAY20LYnx062wz4
EBZLRd/TXlznlchGiBn5IazQCaty6gv3up4W40q3PADGWHTwSTvu95jNEuRZ5JkP
faynDAeTJE8=
=9BgX
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
