Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270098AbTGPDVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 23:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270103AbTGPDVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 23:21:35 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:31620 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S270098AbTGPDVb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 23:21:31 -0400
Date: Tue, 15 Jul 2003 23:36:22 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1 USB-Storage problem
Message-ID: <20030716033622.GE2412@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



In rsyncing data from nfs mounted disk to a USB mounted Archos Jukebox
I'm getting alot of this:

usb-storage: page allocation failure. order:0, mod3:0x20
drivers/usb/host/uhci-hcd.c:uhci_alloc_urb_priv: couldn't allocate
memory for urb_priv

Box is a P4 with 1Gig of ram, the device is USB1.1 I believe.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FMg28+1vMONE2jsRAhA8AJsE1XwqKVNvLEGDw8OGDttk8Bu83ACg3JC7
nkwytod1MbFzFu3GWnoI9TQ=
=GyqS
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
