Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbTFKPQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTFKPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:16:50 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:53261 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262493AbTFKPQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:16:47 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Wed, 11 Jun 2003 11:30:30 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030611153030.GA4787@rivenstone.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m2u1axk0kp.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <m2u1axk0kp.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2003 at 12:52:06AM +0200, Joseph Fannin wrote:

Please note that I did not write this driver -- Peter Osterlund
<petero2@telia.com> did.  I meant only to forward this here, since the
original sender seems to have problems getting through to the list.


> Hi!
>=20
> Here is a driver for the Synaptics TouchPad for 2.5.70. It is largely
> based on the XFree86 driver. This driver operates the touchpad in
> absolute mode and emulates a three button mouse with two scroll
> wheels. Features include:
>=20
> * Multi finger tapping.
> * Vertical and horizontal scrolling.
> * Edge scrolling during drag operations.
> * Palm detection.
> * Corner tapping.
>=20
> The only major missing feature is runtime configuration of driver
> parameters. What is the best way to implement that? I was thinking of
> sending EV_MSC events to the driver using the /dev/input/event*
> interface and define my own codes for the different driver parameters.
>=20
> Comments?

--=20
Joseph Fannin
jhf@rivenstone.net

Rothchild's Rule -- "For every phenomenon, however complex, someone will
eventually come up with a simple and elegant theory. This theory will
be wrong."

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+50sWWv4KsgKfSVgRAp4rAKCOxUFcawiUiTvPXr3SAQD+BxiVBACfZnQU
WiRT3lEV+Kn06ea3pnBeHY4=
=46pB
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
