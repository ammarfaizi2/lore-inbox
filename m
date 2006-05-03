Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWECSNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWECSNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWECSNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:13:17 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:6528 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1751347AbWECSNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:13:17 -0400
From: Michael Helmling <supermihi@web.de>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Date: Wed, 3 May 2006 20:14:28 +0200
User-Agent: KMail/1.9.1
Cc: Andrey Panin <pazke@donpac.ru>, David Hollis <dhollis@davehollis.com>,
       David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <1146667488.2348.28.camel@dhollis-lnx.sunera.com> <20060503153128.GA31133@pazke.donpac.ru>
In-Reply-To: <20060503153128.GA31133@pazke.donpac.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1287465.cnW79Gp0IK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605032014.28734.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1287465.cnW79Gp0IK
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 03 May 2006 17:31, Andrey Panin wrote:
> > What he
> > should do would be to create a moschip.c that uses usbnet as a support
> > module - just like asix.c does.  In this file, he can have his sole
> > Copyright attribution and not have to worry about following
> > changes/updates to usbnet.  Of course, if he communicated his
> > development efforts with the community, he would have received all of
> > this information long ago and we'd likely help shake out bugs in the
> > code to make it a more robust driver.
>=20
> IMHO we should do it now. If there is no volunteers, I can try to do it,
> but it will be my first USB driver, so don't expect results soon.
>=20

That would be great, I could give you feedback if / how it works.
But I think someone versed in the GPL should contact moschip to clear thing=
s a=20
bit.

--nextPart1287465.cnW79Gp0IK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEWPMEcLJiNWFgTBIRAgWyAJ0U/59RIB3Hw1mCWMtH6sx5RJBbUACbBZGc
lBMExKVuRKXKNPJG5E6fT1s=
=l0gl
-----END PGP SIGNATURE-----

--nextPart1287465.cnW79Gp0IK--
