Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbTFXApL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbTFXApL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:45:11 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:38348 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265546AbTFXApI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:45:08 -0400
Date: Mon, 23 Jun 2003 20:59:12 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: Problems with PCMCIA/Orinoco
In-reply-to: <20030623103815.E23411@flint.arm.linux.org.uk>
To: bvermeul@blackstar.nl, linux-kernel@vger.kernel.org
Message-id: <20030624005912.GA23266@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=SUOF0GtieIMvvwua;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <Pine.LNX.4.44.0306171123540.1854-100000@blackstar.nl>
 <20030623103815.E23411@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2003 at 10:38:15AM +0100, Russell King wrote:
> > unregister_netdevice: waiting for eth1 to become free. Usage count=20
=3D 1
> Is this still an outstanding problem in 2.5.73?

i still see it with both my 3c574_cs and my orinoco_cs in 2.5.73.
this one is elusive, isn't it?  if i were smarter, i'd try to track it
down.  maybe i'll look at it again, not that i know anything.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+96JgCGPRljI8080RAkOLAJ984r0j9NcSF47z4TYxkImJNz2FugCcDrWh
01PZOleccJ/neYdK57ZUUmA=
=yhgJ
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
