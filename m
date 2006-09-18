Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWIRPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWIRPSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWIRPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:18:22 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:18892 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751767AbWIRPSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:18:21 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Exporting array data in sysfs
Date: Mon, 18 Sep 2006 17:18:35 +0200
User-Agent: KMail/1.9.4
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200609181359.31489.eike-kernel@sf-tec.de> <200609181622.07681.eike-kernel@sf-tec.de> <d120d5000609180759t42945f0bi496b3840818c218b@mail.gmail.com>
In-Reply-To: <d120d5000609180759t42945f0bi496b3840818c218b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1323811.OON701K3UF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609181718.35491.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1323811.OON701K3UF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dmitry Torokhov wrote:
> On 9/18/06, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>>Dmitry Torokhov wrote:

>>> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/1155.html

>> The limitation to 999 entries should go.
>
> It is not really a limitation but rather a safeguard. Do you really
> expect to have arrays with that many attributes?

At least I don't know how much they will be. If the user wants to do crazy=
=20
things... :) I'm currently hacking on a store_n implementation, perhaps I'l=
l=20
be able to show some code tomorrow.

Eike

--nextPart1323811.OON701K3UF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFDrjLXKSJPmm5/E4RAvtFAJ4z3lsWHlpzkaxRNBK00BdHAkYDagCaA8f4
nzIEwRzeYoRF4wovg8vcM4s=
=8OaZ
-----END PGP SIGNATURE-----

--nextPart1323811.OON701K3UF--
