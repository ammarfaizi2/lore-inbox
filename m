Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTFCLKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTFCLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:10:44 -0400
Received: from B53fa.pppool.de ([213.7.83.250]:62891 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S264958AbTFCLKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:10:42 -0400
Subject: Re: VIA CHIPSET KT 400 / 8235 troubleshooting
From: Daniel Egger <degger@fhm.edu>
To: Henrik Storner <henrik-kernel@hswn.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bbhli0$v5j$1@ask.hswn.dk>
References: <0060478E58FDD611A4A200508BCF7BD97BF752@pleyel.chant.com>
	 <bbhli0$v5j$1@ask.hswn.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Htc4MRzGgSXkZQ3/L3LW"
Message-Id: <1054629097.2723.7.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 03 Jun 2003 10:31:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Htc4MRzGgSXkZQ3/L3LW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2003-06-03 um 10.17 schrieb Henrik Storner:

> My KT400 motherboard (Soltek) requires me to boot with the "noapic"
> parameter, or it will hang in a similar manner. Did you try that,
> or did you just enable/disable the APIC in the BIOS ?

My ECS L7VTA will boot with APIC enabled but has interrupt problems=20
with at least the NIC and thus will stop booting (over network that is).
Alan told me yesterday in private that he thinks he knows the problem
and has a solution in his -ac series.

Haven't had a chance to try that though...

--=20
Servus,
       Daniel

--=-Htc4MRzGgSXkZQ3/L3LW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+3Fzochlzsq9KoIYRArINAKDArEKMHnQJSkSBWxhJ5Ic4zbTnqgCcDpjE
cLMU6VsDkdBmwn1DyVDG6OY=
=kcMq
-----END PGP SIGNATURE-----

--=-Htc4MRzGgSXkZQ3/L3LW--

