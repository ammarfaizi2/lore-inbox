Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUDEHDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDEHDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:03:34 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:63093 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262136AbUDEHDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:03:32 -0400
Date: Mon, 05 Apr 2004 03:03:18 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: 2.6.5-aa1
In-reply-to: <4070F11B.6020602@web.de>
To: Marcus Hartig <m.f.h@web.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Message-id: <200404050303.30657.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.1
References: <40707888.80006@web.de> <20040405002028.GB21069@dualathlon.random>
 <4070F11B.6020602@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 April 2004 01:39, Marcus Hartig wrote:
<snip>
> echo "et.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
> echo "et.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss

I used only the first one of the two commands, and had to use artsdsp to get 
sound. With both of those commands, I just got et running without arts and it 
didn't sigsegv. 

> The related part (i hope) of strace:
<snip>
>
> Thanks, i will test it later with prempt off and an other driver.

Jeff.

- -- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcQS8wFP0+seVj/4RAhL6AJ90rSQMKtx9pSAvmDtmkgBtJgwXVwCglLbz
SepNHo5CLDfhFZV3Ic3YF3A=
=1NYt
-----END PGP SIGNATURE-----
