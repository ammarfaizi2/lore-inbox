Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUDSTkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUDSTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:40:41 -0400
Received: from pass-d9b86743.pool.mediaWays.net ([217.184.103.67]:49792 "EHLO
	avaloon.intern") by vger.kernel.org with ESMTP id S261764AbUDSTkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:40:39 -0400
Date: Mon, 19 Apr 2004 21:38:07 +0200
From: M G Berberich <berberic@fmi.uni-passau.de>
To: linux-kernel@vger.kernel.org
Subject: usbnet 2.5/2.6.6-rc1
Message-ID: <20040419193807.GA1864@avaloon.intern>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

the usbnet module from 2.6.5 and 2.6.6-rc1 is not working with my
zaurus. 2.6.3 worked fine.

The log-messages are exactly the same in all three cases:

  usb 2-2: new full speed USB device using address 3
  usb0: register usbnet at usb-0000:00:0c.0-2, Sharp Zaurus SL-5x00

and the usb0 device is configured the same, but with kernel 2.6.3 the
connection works, with 2.6.5 and 2.6.6.-rc1 nothing happens. Trying to
ping the zaurus times out and trying to remove the usbnet module
hangs.

BTW: I'm not subscribed to this list.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  | www.fmi.uni-passau.de/~berberic

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhCqfnp4msu7jrxMRAnFVAJ4qGVdndJkKY85IrXIKSh2cIqncxwCgjTyk
GpZqEPM6enSwauigs41R5YM=
=zdcy
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
