Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUI2Nta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUI2Nta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUI2NtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:49:11 -0400
Received: from acsn03.bu.edu ([128.197.159.63]:14787 "EHLO acsn03.bu.edu")
	by vger.kernel.org with ESMTP id S268372AbUI2NkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:40:08 -0400
From: Geoff Mishkin <gmishkin@bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Subject: Re: Data corruption on IDE disk via USB.
Date: Wed, 29 Sep 2004 09:37:10 -0400
User-Agent: KMail/1.7
Cc: jrxr@softhome.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9626632.vmZlGvOOSv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409290937.17500.gmishkin@acs.bu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9626632.vmZlGvOOSv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have a similar problem with a hard disk enclosure.  However, instead of=20
getting corruption, the device just stops responding and the activity light=
=20
on the enclosure stays pinned.  Then, even after power-cycling the disk, I'=
m=20
not able to remount it; I have to reboot.  Removing all of the USB modules=
=20
and re-loading them doesn't seem to help either.

I'll post usb-storage verbose debugging output when I have some.

   --Geoff Mishkin <gmishkin@bu.edu>

--nextPart9626632.vmZlGvOOSv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBWrqNCByDbUAKi3URAjavAKCA448F2CtH4ZxDVmInV5XeIgQSiwCfbLbq
2qxIaUpVcORhQfll8+pajOs=
=O8HT
-----END PGP SIGNATURE-----

--nextPart9626632.vmZlGvOOSv--
