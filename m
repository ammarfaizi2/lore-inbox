Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbUKDA5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUKDA5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKDA44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:56:56 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:15013 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S262033AbUKDAv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:51:57 -0500
Message-ID: <41897D22.1070404@tequila.co.jp>
Date: Thu, 04 Nov 2004 09:51:46 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp> <cma6j6$kbk$1@sea.gmane.org>
In-Reply-To: <cma6j6$kbk$1@sea.gmane.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/2004 05:59 PM, Alexander E. Patrakov wrote:
| Clemens Schwaighofer wrote:
|
|
|>I use 2.6.9-ac3 on my Laptop and I just wanted to burn a DVD-Video with
|>my external Pioneer DVD writer which is connected via fire-wire to the
|>Laptop.
|
|
| Make sure that cdrecord (or the analogous DVD burning utility) is NOT
setuid
| root and that you (as a user) have the write permission for the writer
| device node.

thanks I will check that out. But what I am more worried, is that I
don't even see the device ...

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiX0hjBz/yQjBxz8RAhwKAKCipyXUsXiCLls3KSQaqQxsv2y31QCeLIY2
A6M58jAH4knQw69hSLJsWd4=
=fyoi
-----END PGP SIGNATURE-----
