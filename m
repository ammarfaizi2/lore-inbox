Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCOIxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCOIxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCOIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:53:23 -0500
Received: from ns.suse.de ([195.135.220.2]:11951 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261666AbVCOIxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:53:14 -0500
Subject: RE: [ACPI] [PATCH] Panasonic ACPI driver
From: Timo Hoenig <thoenig@suse.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       akpm@osdl.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84076B92BA@pdsmsx403>
References: <3ACA40606221794F80A5670F0AF15F84076B92BA@pdsmsx403>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c7ZXca7htcClJMXA7nTz"
Date: Tue, 15 Mar 2005 09:53:12 +0100
Message-Id: <1110876792.5260.2.camel@nouse.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c7ZXca7htcClJMXA7nTz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2005-03-15 at 14:03 +0800, Yu, Luming wrote:
>Basically, this driver just call some specific AML method for hotkey funct=
ion, that can be=20
>achieved through generic hotkey driver filed at http://bugzilla.kernel.org=
/show_bug.cgi?id=3D3887.
>So I don't think this driver is needed.

OK. I will give it a try to merge the driver it into your generic hotkey
driver.

See you,

   -- Timo

..............................................................
Timo H=F6nig <thoenig at suse dot de>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-c7ZXca7htcClJMXA7nTz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCNqJ34D8IS7MFQGYRAjraAJ97txIYqf27ByWciaY6tc31rSwZbACgmH+n
UQwhHts3SHv2AoxVV+dlCX4=
=e5m7
-----END PGP SIGNATURE-----

--=-c7ZXca7htcClJMXA7nTz--

