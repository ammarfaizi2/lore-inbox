Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWECNbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWECNbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWECNbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:31:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:6806 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1030204AbWECNbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:31:03 -0400
From: Michael Helmling <supermihi@web.de>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Wed, 3 May 2006 15:28:15 +0200
User-Agent: KMail/1.9.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605030706.56908.supermihi@web.de> <200605022229.47937.david-b@pacbell.net>
In-Reply-To: <200605022229.47937.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23902187.IZIZQcOlZZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605031528.18809.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart23902187.IZIZQcOlZZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 May 2006 07:29, David Brownell wrote:
> On Tuesday 02 May 2006 10:06 pm, Michael Helmling wrote:
>=20
> They just hacked "usbnet". =A0There are huge chunks of code, and comments,
> that are clearly identical. =A0At least half of the "moschip" driver.
>=20
Then what they did really isn't right.

> "M Subrahmanya Srihdar" didn't "accidentally" copy the bulk of usbnet,=20
> remove all
> the attributions, and replace them ... not possible. =A0There were certai=
nly a=20
> few
> chip-specific additions of course, right where "usbnet" expects them, but=
=20
> the
> core driver is obviously all "usbnet" code.
So, what this Mr. Srihdar di wrong is to set his own name in the "copyright=
"=20
field instead of using yours. The process of modifying a GPLed module itsel=
f=20
is ok, am I right with this?
So it should be possible to convince him of this nuisance, and then use the=
=20
changes he made to make moschips device working.=20
Regards,
Michael

--nextPart23902187.IZIZQcOlZZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEWK/ycLJiNWFgTBIRAk+1AKDIoPdiNkFC2Z5EktouGaKGFejOlwCfZPGP
EvkSbDBnOA0Xk4YElNFxkWA=
=PyvD
-----END PGP SIGNATURE-----

--nextPart23902187.IZIZQcOlZZ--
