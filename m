Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUAOFdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 00:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUAOFdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 00:33:20 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:30469 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S264329AbUAOFcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 00:32:51 -0500
Date: Wed, 14 Jan 2004 23:32:49 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: some UMSDOS issues
Message-ID: <20040115053249.GA12711@dbz.icequake.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

Is anyone using UMSDOS recently enough to verify that it still works? :)

I'm trying to upgrade a 386 with ZipSlack 8.0 to ZipSlack 9.1.
Using the Slackware lowmem kernel, as well as my own 2.4.24 kernel; both
will load init okay, but anything init tries to run (such as
/etc/rc.d/rcS, /sbin/agetty, etc) just fails repeatedly:

INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"
INIT: cannot execute "/sbin/agetty"

Seems strange that init can be executed but nothing thereafter.  Does
anyone have any ideas what can be done to narrow down what is going on
here?

--=20
Ryan Underwood, <nemesis@icequake.net>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABiYBIonHnh+67jkRAreKAKCfLfgd2XkOLtqHmHZAdsJbr+rwfACfeI8x
mLarXpdPTisEvYzx9KsWtlM=
=xoXw
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
