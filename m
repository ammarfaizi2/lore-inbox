Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270036AbUJHPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270036AbUJHPnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270033AbUJHPnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:43:46 -0400
Received: from dev.tequila.jp ([128.121.50.153]:28434 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S270036AbUJHPj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:39:59 -0400
Message-ID: <4166B4C0.7030203@tequila.co.jp>
Date: Sat, 09 Oct 2004 00:39:44 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Dickson <SteveD@redhat.com>
CC: Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS using CacheFS
References: <4161B664.70109@RedHat.com> <41661950.5070508@tequila.co.jp> <41667865.2000804@RedHat.com>
In-Reply-To: <41667865.2000804@RedHat.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/08/2004 08:22 PM, Steve Dickson wrote:
> Clemens Schwaighofer wrote:
> 
>> brr :) why is it posix, this is so out of the context for me (as a
>> user). Is it possible to have a cachefs flag. Would make it more logical.
> 
> 
> Because it was the easiest way to get things started (i.e. no userlevel
> changes needed at all).... The 'fscache' flag will be coming along with
> the nfs4 support, since nfs4 mounting code does not have an open
> (unused) mounting flag....

okay, thank you for the information. Anyway inbetween I will try that
out with NFS3 ...

lg, clemens

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBZrTAjBz/yQjBxz8RAoddAJwIVyxuMFy0tD9H8z8D/UKjXmvAtgCg4mcY
2NZyYRCsdR6CzbTKKcJiybw=
=sKPN
-----END PGP SIGNATURE-----
