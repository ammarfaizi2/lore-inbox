Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268660AbUJKDXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268660AbUJKDXs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUJKDXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:23:47 -0400
Received: from dev.tequila.jp ([128.121.50.153]:16901 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268660AbUJKDXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:23:44 -0400
Message-ID: <4169FCB5.8050808@tequila.co.jp>
Date: Mon, 11 Oct 2004 12:23:33 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc3-mm3 woes
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

System: debian/unstable

I just tried 2.6.9-rc3-mm3 and I have two problems:

- - he calls himself 2.6.9-rc-mm31, yeah 31. I don't know where this comes
from, because in the Makefile itself it is mm3. Whatever makes him do
that, I don't know, but he install himselfs like this, perhaps the
problems come from that

- - cdrecord segfaults. Again I don't know if this is cdrecords fault or
not, but cdrecord works fine with 2.6.9-rc2-mm1

If needed I provide the kernel config.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBafy1jBz/yQjBxz8RAlrEAKCh1iS4T96fsVlQaq5cr1PNIHQzMQCgsf3r
Wt97FUJOzgxjRVSRfP8NCJ0=
=UnNu
-----END PGP SIGNATURE-----
