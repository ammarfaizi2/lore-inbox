Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTFLCec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264690AbTFLCec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:34:32 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:63497 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264672AbTFLCeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:34:31 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Wed, 11 Jun 2003 22:48:14 -0400
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030612024814.GB4787@rivenstone.net>
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	linux-kernel@vger.kernel.org
References: <m2smqhqk4k.fsf@p4.localdomain> <20030611170246.A4187@ucw.cz> <m27k7sv5si.fsf@telia.com> <20030611203408.A6961@ucw.cz> <m2ptlkqpej.fsf@telia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <m2ptlkqpej.fsf@telia.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2003 at 11:23:48PM +0200, Peter Osterlund wrote:

> Here is a new patch that sends ABS_ events to user space. I haven't
> modified the XFree86 driver to handle this format yet, but I used
> /dev/input/event* to verify that the driver generates correct data.

    How well will GPM (for example) work with this?

--=20
Joseph Fannin
jhf@rivenstone.net

"Anyone who quotes me in their sig is an idiot." -- Rusty Russell.

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5+ntWv4KsgKfSVgRAjPGAJ4lGK0Ctrgce4gf7eEoXwlzHmKlrQCcDv4k
BfnnHWs2ECDjI3etzqGtkaY=
=sAgP
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
