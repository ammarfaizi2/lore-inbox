Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755467AbWK0AVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbWK0AVA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbWK0AVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:21:00 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:50884 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1755467AbWK0AU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:20:59 -0500
Date: Sun, 26 Nov 2006 19:18:50 -0500
From: Thomas Tuttle <linux-kernel@ttuttle.net>
Subject: ACPI patch submission (was: [PATCH] Implementation of
 acpi_video_get_next_level)
In-reply-to: <20061124193650.GB22622@lion>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mail-followup-to: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <20061127001850.GA10381@lion>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=mYCpIKhGyMATD0i+
Content-disposition: inline
References: <20061124193347.GA22622@lion> <20061124193650.GB22622@lion>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've got a patch that fixes acpi_video_get_next_level in the ACPI video
driver.  I sent it to linux-kernel, linux-acpi, and some people at
Intel.  It's a very short and simple patch that fixes the brightness
hotkeys on my laptop, and probably others.  (The function it fixes had
/* Fix me */ written in it.)

Where or how should I send this patch so that it can be included in the
mainline kernel?

Thanks,

Thomas Tuttle

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFai7qgPpxLpYWreERAjbHAJ9CkW+oes2Febc5lcAA5nIkZpHH9ACeKQv3
vwWNJTRhz4HM6c8Pq/N/lMY=
=jvOm
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
