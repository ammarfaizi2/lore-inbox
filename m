Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSEIOdo>; Thu, 9 May 2002 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSEIOdn>; Thu, 9 May 2002 10:33:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55826 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313181AbSEIOdm>; Thu, 9 May 2002 10:33:42 -0400
Message-ID: <3CDA7A03.3000202@evision-ventures.com>
Date: Thu, 09 May 2002 15:30:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] hdreg.h
In-Reply-To: <UTC200205091406.g49E6W018636.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andries.Brouwer@cwi.nl napisa³:
>     On Thu, May 09, 2002 at 03:48:32PM +0200, Andries.Brouwer@cwi.nl wrote:
>     > No, fdisk, cfdisk, sfdisk do not use HDIO_GETGEO_BIG.
>     > And indeed, the ioctl is completely meaningless.
> 
>     In many current distributions (e.g. from Red Hat, Mandrake and Caldera)
>     they do.
> 
> Yes, distributions are known to introduce buggy patches.
> 
> Moreover, distributions are known to copy each others bugs.
> Sometimes I tell one distribution that a patch is buggy,
> and they revert their patch, but some months later they
> have it again, copied from some other distribution.
> Even bad "segmentation fault" bugs are copied.
> 
> But for 2.5 this is not important. Distributions have time
> to fix stuff before 2.6.

And developement kernels are known to require updated:

util-linux,
modutils
mounts
net-utils

and so on :-).

As long as long an installed system doesn't break utterly
there is no reaons IMHO why cleanups shouldn't be done.

