Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWBQB1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWBQB1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWBQB1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:27:42 -0500
Received: from 63.15.233.220.exetel.com.au ([220.233.15.63]:44935 "EHLO
	sydlxfw01.samad.com.au") by vger.kernel.org with ESMTP
	id S1750843AbWBQB1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:27:41 -0500
Date: Fri, 17 Feb 2006 12:27:39 +1100
To: linux-kernel@vger.kernel.org
Subject: poweroff on i386
Message-ID: <20060217012739.GO26235@samad.com.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CbqR2XcyIs6OSP+I"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Alexander Samad <alex@samad.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CbqR2XcyIs6OSP+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I am interested in how the linux kernel powers off i386 machine.  I
basically followed the path from /sbin/poweroff to halt.c to the kernel
system command reboot and that into apm apm_power_off  I can't find
where the non apm machine get powered off

Alex

--CbqR2XcyIs6OSP+I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9SaLkZz88chpJ2MRAqVJAKDRw+bPiuZrQNN3ittBYZYUxJWqPACcDAXW
/3OcdrVTDlAw8hQO/a9SJ/8=
=Vhex
-----END PGP SIGNATURE-----

--CbqR2XcyIs6OSP+I--
