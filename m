Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVCHGyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVCHGyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCHGxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:53:13 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:52931 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261841AbVCHGwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:52:43 -0500
Message-ID: <422D4BA7.8050200@tequila.co.jp>
Date: Tue, 08 Mar 2005 15:52:23 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-ac1
References: <1110231261.3116.90.camel@localhost.localdomain> <B0B9168A9B666B9CF980CB7C@[192.168.12.2]> <20050308064926.GV28536@shell0.pdx.osdl.net>
In-Reply-To: <20050308064926.GV28536@shell0.pdx.osdl.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/08/2005 03:49 PM, Chris Wright wrote:
> * Clemens Schwaighofer (cs@tequila.co.jp) wrote:
> 
>>>2.6.11-ac1
>>>o	Fix jbd race in ext3				(Stephen Tweedie)
>>
>>will that patch actually appear in 2.6.11.2? At least it looks like a 
>>candidate for me ...
> 
> 
> Yes, we are intending to pick up bits from -ac (you might have missed
> that in another thread).

Probably. I am sorry :) I sort of got lost in the tons of RFD, etc
threads :)

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCLUunjBz/yQjBxz8RArh2AJ4oMATN/P+9TPtFEDrGQhu2iox+MQCfZobG
kc+hXDhfKyHhGK7UF6dKw2I=
=CVCH
-----END PGP SIGNATURE-----
