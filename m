Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUFYAvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUFYAvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUFYAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 20:51:24 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:14254 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S265961AbUFYAvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 20:51:09 -0400
Message-ID: <40DB76F1.9010107@tequila.co.jp>
Date: Fri, 25 Jun 2004 09:50:57 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: 2.6.7 and khelper
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

First of I have no idea what khelper actually does, but it seems to make
a problem on my box.

I have a Debian/unstable box here (the same one that has these "fast
clock problems with 2.6.7-mm1) and every night after the syslog restart
the process with the id "4", which is khelper is reported to be
respawning to fast.

Now is this a kernel issue, or more a issue of my system and some jobs
that might disrupt this?

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA23bwjBz/yQjBxz8RAlICAKDJDZWc7kFf3Kk907cUYdpUzRtoGACgpiJm
vVs8NTMKABMkufRM6NwLifM=
=yG2m
-----END PGP SIGNATURE-----
