Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUJKD04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUJKD04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268664AbUJKD0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:26:55 -0400
Received: from dev.tequila.jp ([128.121.50.153]:28422 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268663AbUJKD0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:26:09 -0400
Message-ID: <4169FD44.60101@tequila.co.jp>
Date: Mon, 11 Oct 2004 12:25:56 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rcX: user still can't rip cds, burn cds, etc
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

on my lapto (debian/unsable) I run a 2.6.9-rc2-mm2 kernel (because with
2.6.8.1 I have oopses on shutdown if an USB device is attached).

anyway, I still can't burn cds as a user, or rip a cd from an IEEE (==
scsi layer) device. I can rip from my internal CD-ROM (atapi).

Seriously, this is annyoing. Is this something I shall report to the
cdparanoia guys? Or is this still an issue with the new "rights" in the
kernel itself.

lg, clemens
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBaf1DjBz/yQjBxz8RAt4GAJ9D6viCr4IOyrSnRl988xPEb9epPgCeP/y2
YgsxRC7ViTEMQxPpTVVrqr0=
=TW+P
-----END PGP SIGNATURE-----
