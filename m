Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVBHCY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVBHCY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 21:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVBHCY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 21:24:56 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:2214 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261439AbVBHCYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 21:24:48 -0500
Message-ID: <420822E5.1070408@tequila.co.jp>
Date: Tue, 08 Feb 2005 11:24:37 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Andries Brouwer <aebr@win.tue.nl>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Pozsar Balazs <pozsy@uhulinux.hu>,
       Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
References: <200502080023.j180NDJI006174@laptop11.inf.utfsm.cl>
In-Reply-To: <200502080023.j180NDJI006174@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/08/2005 09:23 AM, Horst von Brand wrote:
> Clemens Schwaighofer <cs@tequila.co.jp> said:
> 
> [...]
>>but to be honest, most times I need vfat, and I actually haven't
>>encountered a time when I need msdos.
> 
> But writing MSDOS on a VFAT filesystem is a sure way to screw it up, and
> AFAIU vice-versa.

well it doesn't screw it up if you write MS DOS on a VFAT, you just
loose a lot of data.

I was kinda surprised when I came home and plugged in my USB stick to
see just A3.CB instead of a nice long filename :)

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCCCLljBz/yQjBxz8RAvgyAJ4zRyjszLLuBeZz5lBAyegCTbm1ygCfYf2E
UJKEEU0HJuLRTAjec3aEQ3s=
=g+L4
-----END PGP SIGNATURE-----
