Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVACJqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVACJqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 04:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVACJqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 04:46:04 -0500
Received: from mailer2-5.key-systems.net ([81.3.43.243]:33673 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S261412AbVACJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 04:45:56 -0500
Message-ID: <41D9144F.8010706@mathematica.scientia.net>
Date: Mon, 03 Jan 2005 10:45:51 +0100
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with kernel bootparameters when using UDF fs support
 together with XFS quotas
References: <41D692E9.4060805@mathematica.scientia.net> <20050103080832.GA16355@suse.de>
In-Reply-To: <20050103080832.GA16355@suse.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB01069AC2FC178537A98C81B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB01069AC2FC178537A98C81B
Content-Type: multipart/mixed;
 boundary="------------010308080306080909080204"

This is a multi-part message in MIME format.
--------------010308080306080909080204
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Olaf Hering wrote:

> rootfstype=xfs should fix it.

Yes, thanks that worked :)

Greetings,
cam.

--------------010308080306080909080204
Content-Type: text/x-vcard; charset=utf-8;
 name="cam.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cam.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQpvcmc6TXVuaWNoIFVuaXZlcnNpdHkgb2YgQXBwbGllZCBTY2ll
bmNlcztEZXBhcnRtZW50IG9mIE1hdGhlbWF0aWNzIGFuZCBDb21wdXRlciBTY2llbmNlDQph
ZHI7cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOjs7TG90aHN0cmE9QzM9OUZl
IDM0O009QzM9QkNuY2hlbjtGcmVpc3RhYXQgQmF5ZXJuOzgwMzM1O0ZlZGVyYWwgUmVwdWJs
aWMgb2YgR2VybWFueQ0KZW1haWw7aW50ZXJuZXQ6Y2FtQG1hdGhlbWF0aWNhLnNjaWVudGlh
Lm5ldA0KdGVsO2hvbWU6KzQ5IDg5IDI0NDA5MzkwDQp0ZWw7Y2VsbDorNDkgMTcyIDg2MTcz
NDENCngtbW96aWxsYS1odG1sOlRSVUUNCnVybDpodHRwOi8vZmhtLmVkdS8NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------010308080306080909080204--

--------------enigB01069AC2FC178537A98C81B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2RRTmstaume4L0MRApniAKCtkECGtNMn+tou1KWGNTd0I4HFwACgicEf
8UGB0ttPzkCfnStGNsP4H4w=
=WGj1
-----END PGP SIGNATURE-----

--------------enigB01069AC2FC178537A98C81B--
