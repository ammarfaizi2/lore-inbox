Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbUKCXTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUKCXTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUKCXRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:17:21 -0500
Received: from dev.tequila.jp ([128.121.50.153]:48135 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S261979AbUKCXHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:07:23 -0500
Message-ID: <41896498.3040802@tequila.co.jp>
Date: Thu, 04 Nov 2004 08:07:04 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp> <41896198.8080308@tmr.com>
In-Reply-To: <41896198.8080308@tmr.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/04/2004 07:54 AM, Bill Davidsen wrote:

>> <rant>
>> So why is it still impossible that users can write CDs/DVDs. I, as a
>> user, find this rather ridicolous that you have to patch the kernel to
>> get this simple thing running. Security is important, yes, but this is
>> just annoying.
> 
> 
> Security is important, there are no buts about it. See the almost
> endless thread on this earlier. You can run your burns as root, of course.

of course I can ... I can even start X as root if I set it up correct,
but thats not the point. The point of having a user, is _not_ to have to
start programs as root. I don't want that.

Sure its just my private laptop, at home, where only I work on, and its
behind a route. Still, I think that argument _does_ not count.

If its a security thing, and the client program hasn't adepted, okay,
but this ...

>> I really hope that gets fixed soon, because its just annoying to reboot
>> to a different kernel, just to write CDs ...
>> </rant>
> 
> 
> I'm not sure what you consider "fixed" in this context, but if you mean
> disabled security I don't personally expect (or want) that.

That was not my wish and I don't want that.

> Someone claimed that cdrecord could get RR scheduling with attributes
> set (did they mean capabilities?), but I haven't seen a working example
>  yet.

well I use k3b so it uses groisofs to burn dvds ... I don't care much
about cdrecord and in my deep inner world I hope they get replaced, by
someone with whom you can argue.

lg, clemens

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiWSHjBz/yQjBxz8RAtMCAKDg8YskmjEvOnPXOfkE1MSIDgpuuQCfe0Pw
4K6HkDuj6rg8LAJXfHXwhEQ=
=5+IQ
-----END PGP SIGNATURE-----
