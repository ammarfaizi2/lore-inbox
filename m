Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270892AbTGPO46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270898AbTGPOz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:55:29 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:8110 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S270892AbTGPOyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:54:09 -0400
Date: Wed, 16 Jul 2003 10:09:01 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Julien <soda@gunnm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : touchpad doesn't work
Message-ID: <20030716150901.GE8196@lostlogicx.com>
References: <3F146DB2.1080204@gunnm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <3F146DB2.1080204@gunnm.org>
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new touchpad code in the kernel (I have just learned, tested, and am
now using) requires the new XFree driver available at:
http://www.tuxmobile.com/touchpad_driver.html
The latest version of the drivrer can be built outside of X source, or
there are binaries available.  Included in the package are good docs on
installation and use.  Important note:  for kernel 2.5.X > 70 the driver
now uses the event interface, so make sure you configure your kernel
with event interface support either on or as a module.

You can contact me directly for more info, or just search the web for
more configuration information.

--Brandon

On Tue, 07/15/03 at 23:10:10 +0200, Julien wrote:
> 1 . The touchpad of my laptop doesn't work with the 2.6 Linux kernel,=20
> but works with the 2.5.70
>=20

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FWqMHCCPbR8BLcYRAob1AJ4ibvY5qoih2zL2O/hNdKctxYekFgCdE+dD
sZauBR79EQ7oPqF15KzXUIA=
=T8c2
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
