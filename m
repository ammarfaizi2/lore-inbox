Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVJaLDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVJaLDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJaLDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:03:49 -0500
Received: from wg.technophil.ch ([213.189.149.230]:28909 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750752AbVJaLDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:03:49 -0500
Date: Mon, 31 Oct 2005 12:03:44 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Rescan SCSI Bus without /proc/scsi?
Message-ID: <20051031110344.GA16691@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

As noticed in 2.6 kernels, on should not use /proc/scsi anymore.

This breaks the popular rescan-scsi-bus.sh from Kurt Garloff.
Is there a possibility to do that through /sys somehow or do I have
to reanable /proc/scsi?

Greetings,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ2X6D7OTBMvCUbrlAQILuQ/8Cbc7au80P+N8qzVsOTAxyWE9XHR0OwyM
hVUVP3Ft0Nc5BMz6OAG0mHMvm0a9fZ5vMelgrLWWU5mLuxi91p6x4LAvmHi/ip8b
I40xzjooBa6vgLRDEAYLEfm2zQvk5uuRYfnwDrrELkCNsLUbuTgIEALgUDIF4B7p
JZZ2YJpG1zZ5Ac9/mwagwo3l6tsT55vqnJEtp4PKn8WIuWLd0kyAOORzUPFOou9C
9BdKQcoYoCITPluSbehv0VkSo2gCQMnGl/lXNbCVdRaUoee0vfHwBGJbVtym99SP
HwviCwOI30toqarJcd8mXdI/RfypAfm1yBGKLyxwueiDVW4uofQfPJdf9ylSY1N2
Ph7ZxqeAtJ9vRQy9XAxIZvESilQa8oP1mcC7q8GiGIRgA2vEa9gx3P8d3ojQ4fnw
ikmRhBSxogllJIrnwW5QNyr1Jeb3hiUktSs91go0KxLfv9KGTTDlg2KN4XXV0dvq
SuyyeS8EVUKP4ZoFDyxGQRD/Ry/qaeMFQtzaDyK1HNyAlL+QgW9RKC5G5v5ekWeB
FK0qw+8pfVh+bMKgVr8YusMUImdjNUNd4AXAtuaW+LLre6uL9I5eyblrQfHDIm+T
gUNgy+ii44jnyT9OjZ2d01D6bUNxdXhntMUL41HAtlZ9SeLYGDTGebeMSiJFUaMx
mfs+kOxl/fU=
=ceSm
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
