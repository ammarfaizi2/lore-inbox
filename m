Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTDUPB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDUPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:01:28 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:22597 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261308AbTDUPB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:01:27 -0400
Date: Mon, 21 Apr 2003 11:06:52 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: [2.5.68] unregister_netdevice: waiting...
To: linux-kernel@vger.kernel.org
Message-id: <20030421150652.GB25777@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=LyciRD1jyfeSSjG0;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
Apr 21 07:06:50 density kernel: unregister_netdevice: waiting for eth0
to become free. Usage count =3D 2
Apr 21 07:07:00 density kernel: unregister_netdevice: waiting for eth0
to become free. Usage count =3D 2
Apr 21 07:07:10 density kernel: unregister_netdevice: waiting for eth0
to become free. Usage count =3D 2
---

i see this message when tryign to rmmod 3c574_cs or orinoco_cs on
shutdown.

someone mentioned it yesterday using bridge.  mine does the same
thing.  it just loops.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+pAkMCGPRljI8080RAqbdAJ4q69EdH2nDCqXlQD5U19lNtGCFfQCcDcTt
s55nWX8UEBB/Jf0NO5/Uooo=
=yJBX
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
