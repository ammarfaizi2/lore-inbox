Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUFIWXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUFIWXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 18:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUFIWXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 18:23:01 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:61364 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S266011AbUFIWW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 18:22:58 -0400
Message-ID: <40C78DC0.6080405@g-house.de>
Date: Thu, 10 Jun 2004 00:22:56 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix minor typo in Documentation/as-iosched.txt
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020401090200010206010902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020401090200010206010902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

/sys/block/*/iosched/ seems to be /sys/block/*/queue/iosched/ in recent
2.6 kernels.

signed-off by: evil@g-house.de
(do we need this too for Documentation/ "patches"?)

Thanks,
Christian.
- --
BOFH excuse #400:

We are Microsoft.  What you are experiencing is not a problem; it is an
undocumented feature.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAx43A+A7rjkF8z0wRAsJFAKCuq2SVJd++wQv3YgMEqcnLQvJJawCdFSkx
eVDpqBZGtoZKsRIgPVa7KJs=
=YAxK
-----END PGP SIGNATURE-----

--------------020401090200010206010902
Content-Type: text/plain;
 name="as-iosched.txt.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="as-iosched.txt.diff"

LS0tIGxpbnV4LTIuNi9Eb2N1bWVudGF0aW9uL2FzLWlvc2NoZWQudHh0Lm9yaWcJMjAwNC0w
Ni0wOSAyMjo1OTowMy4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi9Eb2N1bWVudGF0
aW9uL2FzLWlvc2NoZWQudHh0CTIwMDQtMDYtMDkgMjM6MDA6MDcuMDAwMDAwMDAwICswMjAw
CkBAIC0xMzIsNyArMTMyLDcgQEAKIFR1bmluZyB0aGUgYW50aWNpcGF0b3J5IElPIHNjaGVk
dWxlcgogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBXaGVuIHVzaW5n
ICdhcycsIHRoZSBhbnRpY2lwYXRvcnkgSU8gc2NoZWR1bGVyIHRoZXJlIGFyZSA1IHBhcmFt
ZXRlcnMgdW5kZXIKLS9zeXMvYmxvY2svKi9pb3NjaGVkLy4gQWxsIGFyZSB1bml0cyBvZiBt
aWxsaXNlY29uZHMuCisvc3lzL2Jsb2NrLyovcXVldWUvaW9zY2hlZC8uIEFsbCBhcmUgdW5p
dHMgb2YgbWlsbGlzZWNvbmRzLgogCiBUaGUgcGFyYW1ldGVycyBhcmU6CiAqIHJlYWRfZXhw
aXJlCg==
--------------020401090200010206010902--
