Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUAEWQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUAEWQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:16:21 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:44929 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265954AbUAEWQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:16:19 -0500
Subject: Re: [ANNOUNCE] 2004-01-05 release of hotplug scripts
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
In-Reply-To: <20040105183058.GA22066@kroah.com>
References: <20040105183058.GA22066@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-msBuKp2e8ZFgVKfWI/ZP"
Message-Id: <1073341146.6075.352.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 00:19:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-msBuKp2e8ZFgVKfWI/ZP
Content-Type: multipart/mixed; boundary="=-l83vz+pr4Nq+cE38G13P"


--=-l83vz+pr4Nq+cE38G13P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-05 at 20:30, Greg KH wrote:
> I've just packaged up the latest Linux hotplug scripts into a release,
> which can be found at:
>  	http://sourceforge.net/project/showfiles.php?group_id=3D17679
> =20

Seems there is an issue with hotplug.functions .. attached correct
patch?


Thanks,

--=20
Martin Schlemmer

--=-l83vz+pr4Nq+cE38G13P
Content-Disposition: attachment; filename=hotplug-type_o.patch
Content-Type: text/x-patch; name=hotplug-type_o.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIDEvZXRjL2hvdHBsdWcvaG90cGx1Zy5mdW5jdGlvbnMJMjAwNC0wMS0wNiAwMDowNzo1My4w
ODU1ODIxNzYgKzAyMDANCisrKyAyL2V0Yy9ob3RwbHVnL2hvdHBsdWcuZnVuY3Rpb25zCTIwMDQt
MDEtMDYgMDA6MTU6MjYuMDE1NzI2MzI4ICswMjAwDQpAQCAtMTU0LDkgKzE1NCw2IEBADQogCQkj
IChpb2N0bHMgZXRjKSBub3QgaW4gc2V0dXAgc2NyaXB0cyBvciBtb2R1bGVzLmNvbmYNCiAJCUxP
QURFRD10cnVlDQogCSAgICBmaQ0KLQllbHNlDQotCSAgICAjIFRoaXMgbW9kdWxlIGlzIGFscmVh
ZHkgbG9hZGVkDQotCSAgICBMT0FERUQ9dHJ1ZQ0KIAlmaQ0KIA0KIAkjIGFsd2F5cyBydW4gc2V0
dXAgc2NyaXB0cyBhZnRlciBhbnkgbWF0Y2hpbmcga2VybmVsIGNvZGUgaGFzIGhhZA0K

--=-l83vz+pr4Nq+cE38G13P--

--=-msBuKp2e8ZFgVKfWI/ZP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+eLaqburzKaJYLYRAjvWAKCGCfcJb/XVgBE985YO/l5qE5R6GQCghRJh
K+dfs7H4kSLcDpEDGTCily4=
=6JxL
-----END PGP SIGNATURE-----

--=-msBuKp2e8ZFgVKfWI/ZP--

