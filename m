Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVDOAS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVDOAS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVDOASH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:18:07 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:9868 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261674AbVDOAPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:15:36 -0400
Message-ID: <425F07A6.2010402@g-house.de>
Date: Fri, 15 Apr 2005 02:15:34 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050326)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA Oops (triggered by xmms)
References: <425EFB32.2010000@g-house.de> <Pine.LNX.4.62.0504150150240.3466@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504150150240.3466@dragon.hyggekrogen.localhost>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jesper Juhl wrote:
> 
>   ^^^^^ you should send such info inline in the email - having to go check 
> external links makes a lot of people ignore the stuff right then and 

yeah, but the oops doesn't wrap at 80 chars itsself and often oopses are
hardly readable inline.

> Btw: I believe this is fixed in 2.6.11.7 - from the Changelog : 
>
> <tiwai@suse.de>
> 	[PATCH] Fix Oops with ALSA timer event notification

oh, this sounds good. strange though, that my 2.6.11-gentoo-r5 (whatever
they've patched in there) *never* oopsed the days ago but all of a sudden
started to oops yesterday....


thank you,
Christian.
- --
BOFH excuse #131:

telnet: Unable to connect to remote host: Connection refused
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXwem+A7rjkF8z0wRAuXSAJ4tZujWF0H5Da5o2J6yfzZQJolhPACgiKUR
YknU154MUkPEB52FuYTTF50=
=5yoy
-----END PGP SIGNATURE-----
