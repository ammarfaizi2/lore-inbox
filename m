Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUC3Guc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbUC3Guc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:50:32 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:45573 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S263274AbUC3Gua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:50:30 -0500
Subject: Re: Linux 2.6.5-rc3 [ACPI error message]
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HD1asDKhkosYjuTag9UO"
Organization: iNES Group
Message-Id: <1080629426.3059.3.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 30 Mar 2004 09:50:26 +0300
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HD1asDKhkosYjuTag9UO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-29 at 21:35 -0800, Linus Torvalds wrote:
> And agp, acpi, ISDN and watchdog.
>=20
> Nothing earth-shattering, in other words.


My laptop's acpi shaked a bit...

ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-1133: *** Error: Method execution failed
[\_SB_.PCI0.PCIB.MPC0._PRW] (Node c1521780), AE_NOT_EXIST
    ACPI-0154: *** Error: Method execution failed
[\_SB_.PCI0.PCIB.MPC0._PRW] (Node c1521780), AE_NOT_EXIST
ACPI: Interpreter enabled


In -rc2 the error did not exist.


--=20
Cioby



--=-HD1asDKhkosYjuTag9UO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAaRixQisRnSkd59cRAhpeAKCQx6dVOpSpJtMERTzxmmqn4E+7nQCeIGPg
0kiLr1e8RNfjTCCQB/UJplM=
=MFd3
-----END PGP SIGNATURE-----

--=-HD1asDKhkosYjuTag9UO--

