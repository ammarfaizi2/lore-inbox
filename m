Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUFUJZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUFUJZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUFUJZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 05:25:48 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:38819 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S266173AbUFUJZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 05:25:47 -0400
Message-ID: <40D6A994.7080404@tequila.co.jp>
Date: Mon, 21 Jun 2004 18:25:40 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, norberto+linux-kernel@bensa.ath.cx,
       jgarzik@pobox.com
Subject: Re: 2.6.7-bk way too fast
References: <40D64DF7.5040601@pobox.com> <200406210018.04883.lkml@lpbproductions.com> <20040621001612.176bf8e1.akpm@osdl.org> <200406210115.46159.lkml@lpbproductions.com> <40D69A3F.8060501@tequila.co.jp>
In-Reply-To: <40D69A3F.8060501@tequila.co.jp>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Schwaighofer wrote:
| Matt H. wrote:
| | I tried from a fresh  2.6.7-mm1 tree  with your patch ( I had to fix
| up the
| | 2nd half of your patch by hand since  it wouldve rejected ).  The
results
| | were the same though.
|
| same for me. I just recomed from scratch and with ACPI debug on.
|
| I also will check the "vanilla 2.6.7" kernel (is compiling right now).
| but those ACPI changes are only in the mm tree as I can see

the vanilla 2.6.7 doesn't show this fast-clock problems.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1qmUjBz/yQjBxz8RAuIlAKDkIn/jZrHiAYdrXJNhSYTQuSxxyQCfebWo
jRoDhEplMB1SLE5BRTv/LKE=
=IHBr
-----END PGP SIGNATURE-----
