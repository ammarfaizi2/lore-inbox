Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUI3He1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUI3He1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUI3Hd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:33:59 -0400
Received: from nabe.tequila.jp ([211.14.136.221]:43734 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S268662AbUI3HdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:33:23 -0400
Message-ID: <415BB6B5.1010104@tequila.co.jp>
Date: Thu, 30 Sep 2004 16:33:09 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       "Markus T." <markus@trippelsdorf.net>
Subject: Re: Linux 2.6.9-rc3
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <pan.2004.09.30.04.53.05.120184@trippelsdorf.net> <200409300102.07373.gene.heskett@verizon.net> <415BA7D0.7070704@tequila.co.jp> <415BB625.9000403@andrew.cmu.edu>
In-Reply-To: <415BB625.9000403@andrew.cmu.edu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/30/2004 04:30 PM, James Bruce wrote:
| Clemens Schwaighofer wrote:
|
|> | And thats one of the reasons I never dl the bz2 version.
|>
|> what has bz2 to do with that?
|
|
| Some people believe bz2 to be buggy or otherwise less tolerant of
| corruption.  For most people these things don't seem to come up; I've
| never had problems with either despite frequent work with large
| compressed datasets.

interesting, I always use bz2 where time is not so important, and I
never had problems with it.

| Linus decided that patches will always be off the previous
| non-extraversion tarball.  Note that -rc3 is not relative to -rc2, so in
| that way its consistent.  The reason Linus gave is that such
| trivial-but-important bugfixes may come *after* the next version has
| releases or release cantidates, so this is the only sane way.  For
| example, if another tiny code bug motivated making a 2.6.8.2, the
| release cantidates shouldn't have to be rediffed.  Hopefully it makes
| sense now :)

Yes, that makes it absolutly clear. Thank you.

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

iD8DBQFBW7a1jBz/yQjBxz8RAgn2AKCkh6vzqX3yQ/MGdPz7ciNTJDR72gCfam0/
QMWESPoyEOaCUxo0+6GSDVA=
=lieG
-----END PGP SIGNATURE-----
