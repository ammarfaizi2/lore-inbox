Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUAUEvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUAUEvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 23:51:47 -0500
Received: from smtp2.cwidc.net ([154.33.63.112]:1970 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S266072AbUAUEuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 23:50:08 -0500
Message-ID: <400E04F3.4070709@tequila.co.jp>
Date: Wed, 21 Jan 2004 13:49:55 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [keyboard] current 2.6.1-bk6 yet not merged kbd.patch
References: <200401210111.39050.murilo_pontes@yahoo.com.br>
In-Reply-To: <200401210111.39050.murilo_pontes@yahoo.com.br>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murilo Pontes wrote:
| I upgrade my 2.6.1 to 2.6.1-bk6,
|
| I found in diffview on kernel.org
|
-
------------------------------------------------------------------------------------
|  drivers/input/keyboard/atkbd.c                        10 +      28 -
      0 !
|  drivers/input/keyboard/maple_keyb.c                    1 +       0 -
      0 !
|  drivers/input/keyboard/newtonkbd.c                     2 +       0 -
      0 !
|
-
-----------------------------------------------------------------------------------
|
| But attached patch yet not merged......    without this, abnt2
keyboard not work "/" and "?".
|
| Please merge this before 2.6.2 :)

yeah please. I don't want to redfine my sekey & X key definitines in
every kernel release. And I don't want to find more missing keys ...
*sob* *rant*

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFADgTzjBz/yQjBxz8RArPfAJ9yqyAG9Ytcm8l3VDCrBNghLp144QCgqyBg
BXXFwpovXvNu9YEpdOIrX5Y=
=XS+6
-----END PGP SIGNATURE-----

