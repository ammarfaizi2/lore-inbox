Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUERJYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUERJYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUERJYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 05:24:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261369AbUERJYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 05:24:45 -0400
Subject: Re: 2.6.6 issues on IDE and GemTek Radio
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Eduard Roccatello <lilo@roccatello.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAl7tkcaWqPUW2mjQuSvWqZAEAKqodSdQVOEaR9VOf9kh0aQAAAAGXGwAAEAAAAFePwr1XwpRLqbyaidpgUrgBAAAAAA==@roccatello.it>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAAC4AAAAAAAAAl7tkcaWqPUW2mjQuSvWqZAEAKqodSdQVOEaR9VOf9kh0aQAAAAGXGwAAEAAAAFePwr1XwpRLqbyaidpgUrgBAAAAAA==@roccatello.it>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o2WTcRTKA5Vsq0ZO36J9"
Organization: Red Hat UK
Message-Id: <1084872281.2781.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 18 May 2004 11:24:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o2WTcRTKA5Vsq0ZO36J9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-18 at 10:58, Eduard Roccatello wrote:
> Hello people,
> I've some trouble on 2.6.6 with ide devices
>=20
> (this is from syslog)
> hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
>=20
> VP_IDE: User given PCI clock speed impossible (66000), using 33 MHz inste=
ad.
> VP_IDE: Use ide0=3Data66 if you want to assume 80-wire cable.

you pass idebus=3D66 which I suspect is really really wrong....



--=-o2WTcRTKA5Vsq0ZO36J9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAqdZYxULwo51rQBIRApMKAJ41sFAppUqyCXPPlSgLkpZxIPeFxwCgg4lc
CbAINjfCp0iRTi3zn4X5nks=
=IrsS
-----END PGP SIGNATURE-----

--=-o2WTcRTKA5Vsq0ZO36J9--

