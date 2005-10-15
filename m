Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVJOMVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVJOMVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 08:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJOMVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 08:21:45 -0400
Received: from wg.technophil.ch ([213.189.149.230]:42719 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751136AbVJOMVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 08:21:45 -0400
Date: Sat, 15 Oct 2005 14:21:31 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kernel-obri@chaostreff.ch
Subject: Some problems with 2.6.13.4
Message-ID: <20051015122131.GG8609@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>, kernel-obri@chaostreff.ch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

With 2.6.13.4 I've problems on several machines:

- IBM Thinkpad 600: Hangs (no panic, simply dead) after HDC (cdrom)
  is initialized [Works with 2.6.13.5]
- Dell Latitude C400: Keyboard does not work
- new HP-Servers (ML-350): Hangup when syslog is started

What information do you want to have from those machines?
lspci, dmesg, cpuinfo, .config when running with older kernels?

The kernel configurations are used from the versions before, with running
make oldconfig before.

Greetings,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1D0SrOTBMvCUbrlAQInwA//YEx/91ti0Kuhr6hkNfAHqeVlM2Ugu6Fp
CwImqGQHyRRIOLSMqeBPNyGmgwE8ReOwzc+/YblovIZoJrf6jTaBkfiJJDIvl+wq
LQ8I5onxT2KEa3cq5pZMHEFoeCFlZFcVb0oedG8G32d7Zd14YlotqNw7eF49A0km
Mu2Iyg809/qj3PKspfIdtg1nu8OohPO4yXEABOc+u41B7xJxDIn9qNwb6FiqlDkB
CyXxyuRToV59N21LjKZawj7QynWb3iS0Owd/6eWYUSVnH/c7edZJzzcEjDJqoTxf
ufvGiRLrrWkkLM650sG0e2NKhk1M5QhhzdjewBDX+1FBErD9mOv44UOC8FYnyOUU
Gal2L6YEaNdwUOBRdJ1KpwK6asAzeBRCP0Zld7LJrSyJCpeOw4wHD/a9gLEQPy8x
LhgS6/vDRe/AwRbBnpYS+V+UBVCriKTMf7+h/vpA7dO6o4wOvPyNkbGq0CzDH96C
IEbOiqRDypAyWNeiVvo+7P/iteJ4PUNJfCDPXuba0/BynrYrwoRfyXgpeR2z/KkR
UUygwTDq2e3I8N7F30CbB4iyXn2z3p9zRlselDN1IhRZbJlH4NeNNlu1KM9CY1aN
9p811mQFdpmwK0SuO+QEaGx7963zEofAdQSPxSg25HodXY9R0tWV/KemwSYLsM3b
410dCaS2Fhw=
=LLI+
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
