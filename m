Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVAaHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVAaHce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVAaH3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:29:36 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:25503 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261689AbVAaH1c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:27:32 -0500
Message-ID: <41FDDDD3.5060103@tequila.co.jp>
Date: Mon, 31 Jan 2005 16:27:15 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <lkml@mac.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic on a 2.6.7
References: <41FD8F08.3020000@tequila.co.jp> <23fc8bba6baa220cfdbffa7d93303319@mac.com>
In-Reply-To: <23fc8bba6baa220cfdbffa7d93303319@mac.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/31/2005 04:24 PM, Felipe Alfaro Solana wrote:
> On 31 Jan 2005, at 02:51, Clemens Schwaighofer wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi,
>>
>> I have a RedHat 9.0 box with a self compiled 2.6.7 kernel.
>>
>> Today I had this error and a total lockup on the box. Before that (~6h
>> before I had another lockup, but no output to anywhere).
> 
> 
> Have you tried with a more recent kernel? 2.6.7 is a little bit ancient.

well, I had a 2.6.9, but I had a lot of lock ups, only 2.6.7 ran more
stable. But I might try 2.6.10, and see if I have ~1 month again a lock up

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB/d3TjBz/yQjBxz8RAtyDAJsEPF4GyrX23oerx/X9M7TcVEbMhQCdFdtA
tmTmgbIi0J9Yx/JisCdzKGA=
=dREk
-----END PGP SIGNATURE-----
