Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUKDMOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUKDMOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKDML7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:11:59 -0500
Received: from dev.tequila.jp ([128.121.50.153]:56338 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S262182AbUKDMHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:07:13 -0500
Message-ID: <418A1B37.5060708@tequila.co.jp>
Date: Thu, 04 Nov 2004 21:06:15 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp> <20041103084330.GB10434@suse.de> <41889EB5.3060304@tequila.co.jp> <20041103090550.GG10434@suse.de> <41896816.2090204@tequila.co.jp> <20041104091909.GD14993@suse.de>
In-Reply-To: <20041104091909.GD14993@suse.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/2004 06:19 PM, Jens Axboe wrote:

> Probably talk to the firewire folks about this issue.

Yeah, just give a view up from what I tried today

2.6.9-rc2-mm2: works as user & root
2.6.9: doesn't work
2.6.9-ac3: doesn't work
2.6.9-ac6: doesn't work

I know I had first successful burned DVDs with 2.6.9-ac3, but I couldn't
get it running agin. The kernel sees the device somehow, but totaly
wrong, corrupted and not usable for burning. As root its often not seen
at all.

Should I try the thing again with the IEEE/Firewire people? This might
be the only solution to this very annoying problem.

lg, clemens

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBihs3jBz/yQjBxz8RAianAJ4yEijyoQIpt93J1hWsw50tSzfd7ACg4XnH
IYMX6mu3xlnzJ2LeT0hqBas=
=Otk+
-----END PGP SIGNATURE-----
