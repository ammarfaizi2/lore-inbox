Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUI3G3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUI3G3z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUI3G3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:29:54 -0400
Received: from nabe.tequila.jp ([211.14.136.221]:16831 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S268995AbUI3G3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:29:49 -0400
Message-ID: <415BA7D0.7070704@tequila.co.jp>
Date: Thu, 30 Sep 2004 15:29:36 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, "Markus T." <markus@trippelsdorf.net>
Subject: Re: Linux 2.6.9-rc3
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <pan.2004.09.30.04.53.05.120184@trippelsdorf.net> <200409300102.07373.gene.heskett@verizon.net>
In-Reply-To: <200409300102.07373.gene.heskett@verizon.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/30/2004 02:02 PM, Gene Heskett wrote:
| On Thursday 30 September 2004 00:53, Markus T. wrote:
|
|># bzcat patch-2.6.9-rc3.bz2 | patch -p1
|>...
|>patching file fs/nfs/file.c
|>Hunk #2 FAILED at 74.
|>Hunk #3 FAILED at 91.
|>2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej
|>...
|>
|>___
|>Markus
|>
|
| And thats one of the reasons I never dl the bz2 version.

what has bz2 to do with that?

| You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
| I just checked my scrollback and there is no such error here.

well its a bit confusing. 2.6.8.1 is the latest stable right, normaly
patches are applied against the latest stable. Let's just hope this NFS
fix is on the rc series if you have to apply against 2.6.8

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBW6fQjBz/yQjBxz8RAgomAKC6ExKaV0NtwOkx0lcLJ9PR0WaOVQCgqCGZ
y7wOsDSIyxFoiitQkF0Is+A=
=o3Uy
-----END PGP SIGNATURE-----
