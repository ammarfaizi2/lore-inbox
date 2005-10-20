Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVJTSmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVJTSmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVJTSmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:42:09 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:23746 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750859AbVJTSmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:42:08 -0400
Message-ID: <4357E4E9.4@t-online.de>
Date: Thu, 20 Oct 2005 20:41:45 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.4: 'find' complained about sysfs
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD830E72BE324105CA89FBB08"
X-ID: Xj+6zcZOgeTusk7mKsKoEjdT3K33c2CpUnVn4hmAES1eucmHI9WIrm
X-TOI-MSGID: 0edcbe5d-699a-4bbc-bf72-ba33081bbea0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD830E72BE324105CA89FBB08
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

When I ran 'find /sys -name modalias' I got an error
message on stderr saying

find: WARNING: Hard link count is wrong for /sys/devices: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

uname -a:
Linux pluto 2.6.13.4 #1 Sun Oct 16 22:41:26 CEST 2005 x86_64 GNU/Linux


Regards

Harri

--------------enigD830E72BE324105CA89FBB08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDV+TuUTlbRTxpHjcRAk1hAJ4jV4RTYXzKaUjYC8ivFjSDSKZ+LACbBPZZ
0//SGgnrgnH/FBYekzvFEMU=
=Sslq
-----END PGP SIGNATURE-----

--------------enigD830E72BE324105CA89FBB08--
