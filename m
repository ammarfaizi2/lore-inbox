Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTFMIgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTFMIgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:36:35 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:23715 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S265270AbTFMIgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:36:24 -0400
Message-ID: <3EE9903E.2040101@tequila.co.jp>
Date: Fri, 13 Jun 2003 17:50:06 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030528
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: uptime wrong in 2.5.70
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
with my uptime.

gentoo root # uptime
 22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00

I think thats a bit too much ;)

Linux gentoo.tequila.intern 2.5.80 #1 Tue May 27 14:42:51 JST 2003 i686
Intel(R) Penitum(R) 4 CPU 1.60GHz GenuineIntel GNU/Linux
running on a
Gentoo System (unstable tree)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+6ZA9jBz/yQjBxz8RAgnJAJ4yZTZJuP5QJOZv3Lc9Awnr4sblpQCeOHaD
fgjlR74Svry26Jh+1oBjt6g=
=6rUw
-----END PGP SIGNATURE-----

