Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUJKOIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUJKOIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJKOIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:08:15 -0400
Received: from dev.tequila.jp ([128.121.50.153]:29960 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S268982AbUJKOFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:05:33 -0400
Message-ID: <416A9248.8070107@tequila.co.jp>
Date: Mon, 11 Oct 2004 23:01:44 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Houston <mikeserv@bmts.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 woes
References: <4169FCB5.8050808@tequila.co.jp> <20041011014747.128d92c5.mikeserv@bmts.com>
In-Reply-To: <20041011014747.128d92c5.mikeserv@bmts.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/2004 02:47 PM, Mike Houston wrote:

> Hello, I had something like that happen the other day because without
> paying attention,  I said 'n' to the question of "Local version -
> append to kernel release" during oldconfig instead of leaving it
> blank. It was 2.6.9-rc3n
> 
> Check to make sure you haven't done something similar (it's under
> General Setup).

OH! hehe, that comes when you make oldconfig, and just don't read new
stuff in detail. Thanks a lot, I would have never found that ...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBapJIjBz/yQjBxz8RAp/bAJ9uBjVhHOjKAWgH5ly6ZbyKOHrbDACeNoj4
lrMlo1Z3MA9aSTV8L4quvLM=
=dzId
-----END PGP SIGNATURE-----
