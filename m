Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTH0Hrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTH0Hrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:47:33 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:13708 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S263176AbTH0Hrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:47:31 -0400
Message-ID: <3F4C6281.90501@tequila.co.jp>
Date: Wed, 27 Aug 2003 16:49:21 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test4 and Xfree 4.3 and japanese 106 keyboard
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

since in the 2.6 tree the keyboard layout changed there are several
(well known and discussed) issues with the japanese keyboard layout and
the Yen/bar(pipe) key. I can ship around that problem in the shell with
'setkeycodes 0x6a 124', but in Xfree the xmodmap doesn't take this over
of course. The whole box was compiled against a 2.4.20-ck6.

So my question is: do I have to recompiled XFree against the 2.6
sources, or is there any XFree keymap changes I can do to get the
Yen/bar key back?
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

iD8DBQE/TGKAjBz/yQjBxz8RApXqAKCThxYjT2blf09HGckW7C9/LMwICACfdudU
gvQ0dZf/GaZSuNumsoR3jdI=
=b9/G
-----END PGP SIGNATURE-----

