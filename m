Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEBE4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 00:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTEBE4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 00:56:49 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:23989 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S261754AbTEBE4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 00:56:48 -0400
Message-ID: <3EB1FDE2.1060502@tequila.co.jp>
Date: Fri, 02 May 2003 14:10:58 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problem with japanese Keyboard key \ (yen key) on 2.5.68
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

With 2.5.68 (vanilla) I have a problem with using the '\' key.
In 2.4.20-gentoo-r3 this key has the keycode 124 in 2.5.68 it has
keycode 55. I have compiled in the exactly the same native languages and
I don't know any special settings for keyboards actually (default
language is in both kernels UTF8).

Is there anything known about this? If needed I attach all detailed
information, but at the moment I am not sure if needed.

The Base is a Gentoo Linux 1.4rc2 with ~x86 and all latest updates.

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

iD8DBQE+sf3ijBz/yQjBxz8RAg+mAJ0VFNkb9VbK+knJyPz9HrOlUgFeugCg3PH/
mYiuLWMg/JRoVkvR1ldis9o=
=IwZT
-----END PGP SIGNATURE-----

