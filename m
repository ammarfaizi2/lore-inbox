Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVBGJ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVBGJ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVBGJ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:57:25 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:11499 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261385AbVBGJ5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:57:21 -0500
Message-ID: <42073B72.8010006@tequila.co.jp>
Date: Mon, 07 Feb 2005 18:57:06 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in 2.6.8.1
References: <420739E7.8050707@tequila.co.jp>
In-Reply-To: <420739E7.8050707@tequila.co.jp>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/07/2005 06:50 PM, Clemens Schwaighofer wrote:
> hi,
> 
> today, just 30min ago I found this in my messages file:
> 
> The box is a Debian/Testing with a self compiled 2.6.8.1

I forgot one thing:

the CPU is a Xeon with HT enabled and SMP is compiled into the kernel
(for HT).

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCBztxjBz/yQjBxz8RAuSzAKCZiKutel4PLBdRTxmls2EBw4j9yQCaAu8v
54MXuqpugC5a4u6N9tk28jI=
=zHY+
-----END PGP SIGNATURE-----
