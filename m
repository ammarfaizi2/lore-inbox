Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSFCOTM>; Mon, 3 Jun 2002 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSFCOTL>; Mon, 3 Jun 2002 10:19:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5895 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316789AbSFCOTK>;
	Mon, 3 Jun 2002 10:19:10 -0400
Message-ID: <3CFB6D24.2090309@evision-ventures.com>
Date: Mon, 03 Jun 2002 15:20:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: If you want kbuild 2.5, tell Linus
In-Reply-To: <3434.1023112731@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Content-Type: text/plain; charset=us-ascii
> 
> I regret having to do this but Linus has left me with no other options.


Somehow I can't resist, but this sounds like the
devfs and RaiserFS story again:

- devfs claimed "It will solve all major/minor number problems".
   Well we still struggle to get over with them. But now we have to
   account for the intricacies of devfs in addition too.

- RaiserFS "Trees rule the world".
   Well ext3 (no I don't care about inn server!) is faster
   XFS is better manegeable. The "mutable filesystem semantics" modules
   and what a not are nowehre in sight.

Both projects which got included due to "public preasure".

