Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUGVXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUGVXqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 19:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUGVXq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 19:46:29 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:59288 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266124AbUGVXqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 19:46:24 -0400
Message-ID: <41004A8C.1000906@sbcglobal.net>
Date: Thu, 22 Jul 2004 18:15:24 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.7) Gecko/20040720
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: USB trouble since 2.6.8-rc1...
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig586EB1B657684B3533B7B123"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig586EB1B657684B3533B7B123
Content-Type: multipart/mixed;
 boundary="------------060206050207050502030605"

This is a multi-part message in MIME format.
--------------060206050207050502030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been having trouble with USB since 2.6.8-rc1; khubd ends up 
blocking on something which makes USB hotplugging stop working (and only 
half my devices even get initialized).  I did get 2.6.8-rc1 to work once 
though it seemed to help inserting modules before calling hotplug.  
However I haven't been able to repeat that during my last 5 attempts 
with no changes besides a reboot.  I'm running 2.6.7-ck5 right now with 
no apparent problems.

I haven't done extensive testing, but things seemed to work OK until I 
plugged in my Belkin F5U231 4-port multi-tt hub.  My other hub is a 
4-port single-tt Belkin F5U224.

I've attached the usb messages from 2.6.8-rc2 booting with the hub 
attached and then the little bit I see in the log if I don't plug-in the 
F5U231 until after the rest of the USB devices have been attached.

Please let me know what further information or action on my behalf will 
help find the solution to this problem.

Thanks

Wes Janzen




--------------060206050207050502030605
Content-Type: application/x-gzip;
 name="usb.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="usb.log.gz"

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
91+Lr5jES0sAAA==
--------------060206050207050502030605--

--------------enig586EB1B657684B3533B7B123
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAEqSTH1dEI8IpaARAiXhAKCLrfGiQcfoK2av79kEdYGNNrwqXwCgkA46
nFchbhG0dBxKDY9E6/5Fg3o=
=nqm+
-----END PGP SIGNATURE-----

--------------enig586EB1B657684B3533B7B123--
