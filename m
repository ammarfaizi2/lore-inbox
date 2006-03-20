Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWCTTpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWCTTpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWCTTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:45:38 -0500
Received: from wg.technophil.ch ([213.189.149.230]:32134 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S964934AbWCTTph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:45:37 -0500
Date: Mon, 20 Mar 2006 20:45:25 +0100
From: Nico Schottelius <nico-kernel-20060320@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nico Schottelius <nico-kernel-20060319@schottelius.org>
Subject: Re: [pcmcia/wlan/2.6.15.4] Freeze of the system
Message-ID: <20060320194525.GC16943@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel-20060320@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Nico Schottelius <nico-kernel-20060319@schottelius.org>
References: <20060319105029.GA7994@schottelius.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20060319105029.GA7994@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.15.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Nico Schottelius [Sun, Mar 19, 2006 at 11:50:29AM +0100]:
> [...]=20
> When I insert the compaq wl100 (802.11b) pcmcia card, my system
> freezes completly (it's an orinoco chip inside).
> [...]

I verified it with 2.6.15.6, it still freezes. Perhaps I'll
try with 2.6.16 tomorrow, but I do not think this will change
anything.

Perhaps someone can give me a hint on how to debug that?

Nico

--=20
Latest release: ccollect-0.3.3 (http://linux.schottelius.org/ccollect/)
Open Source nutures open minds and free, creative developers.

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRB8GVLOTBMvCUbrlAQINrhAAokxumHYWDRkx1WloZdZDbYyvi6h6APiY
ooMlq4aOw3xNbP72qogOxfcY77R8Mn/FYqryqpOv7eWU4MeFZxx6iFWbojtnNX5z
AjThgIWZGLLUJ2GM1mEhzv6PxXxMUzicBeFF20sqfNauyb2HJvFJY4q18BXeiC3x
tklqhE2nt9nEG/UplMkrfDwhxlBWu3s/QN4f2l4OoYWIUR2pogCCYbFqDo3Vykjs
e/zdRZyp40BkJNiJBVOcqeVrIG1ssVojhOtfDpWGBnjm+wWm7VZTAfFqHwOhXEjf
OZwcc7F9n9p+ijhplVJ2yLwXmyQj9B6h5r6SxrV4fWb+mx3EslLDnJX8n5Z33Gph
Av8Qw3q5eYl51N282+fn8LdYVCo36Ju2Nw6XT24cnNsWM+PSUE2NMLFz0m8yJv+S
aZF4zLPI5/XDZDCAUUccNlTme+EU9rGIU35HllGX/qr6xL0swZOuRuEFlLddX1Qv
Ztd6EwahE7dSb+SyUt8bMSXnkorwzaV+Ivkn9TYCcgWiWdgYmDd4fJlObWWhYtWv
8chZ1LRHOAJ35BQmrInsRCQ0rnwYM83lQn9Uu4BMWdHa/7R96Z9/tonLyW2ZY1/R
5t40Q2gTUwdDwB0zqg0rudZ3h18pRuX8zaDMQ0TaipYQz5Ii5Z/SjxWPyWn643Qt
7dciE3J/uCI=
=6Fq3
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
