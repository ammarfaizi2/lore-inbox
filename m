Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135300AbRANTvm>; Sun, 14 Jan 2001 14:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135324AbRANTvX>; Sun, 14 Jan 2001 14:51:23 -0500
Received: from pop.gmx.net ([194.221.183.20]:57611 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135300AbRANTvV>;
	Sun, 14 Jan 2001 14:51:21 -0500
From: Martin Maciaszek <mmaciaszek@gmx.net>
Date: Sun, 14 Jan 2001 20:49:48 +0100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010114204948.A10017@nexus.shadowrun.not>
Mail-Followup-To: mmaciaszek@gmx.net,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since I installed Kernel 2.4.0 VMware is no longer able to
recognize my cdrom drive. VMware shows a dialog box on power up
with following content:
[...]
CDROM: '/dev/scd0' exists, but does not appear tobe a CDROM device.

Error connecting the CDROM device
[...]

At the same time my syslog records the following message:
Jan 13 21:49:57 nexus kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.

I tried 2.2.18 and VMware recognized the cdrom drive.

Any hints?

Cheers
Martin
--=20
BOFH excuse #122:

because Bill Gates is a Jehovah's witness and so nothing can work on St. Sw=
ithin's day.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6YgLctOa6aqYVgUYRAmCwAJ9jMjot+8rrpTMdsLN1JSn9VaIFcQCfTffh
tquznAdUoe3wYia1FIFW8zU=
=JLKU
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
