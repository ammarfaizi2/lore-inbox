Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSFNRXJ>; Fri, 14 Jun 2002 13:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSFNRXI>; Fri, 14 Jun 2002 13:23:08 -0400
Received: from [195.63.194.11] ([195.63.194.11]:24591 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311885AbSFNRXI> convert rfc822-to-8bit; Fri, 14 Jun 2002 13:23:08 -0400
Message-ID: <3D0A2677.9060107@evision-ventures.com>
Date: Fri, 14 Jun 2002 19:23:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Benjamin LaHaise <bcrl@redhat.com>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de> <20020614115634.B22888@redhat.com> <20020614180451.R16772@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Dave Jones napisa³:
> On Fri, Jun 14, 2002 at 11:56:34AM -0400, Benjamin LaHaise wrote:
> 
>  > Add my voice to these concerns.  At the very least the code should have 
>  > been moved into a second tree to allow people to work with the old stable 
>  > driver as needed.
> 
> *nod*, with periodic known-good _tested_ bits getting merged to
> mainline, to avoid the need for an IDE merge flag day as has been
> the norm in the past.

And they where the best way to basically halt the whole thing.
Right now the only thing you would achieve would be to kick out
the other people with wich I work *together*.
Oh perhaps noone of them would have got involved...
I simply don't like to idea of lonely developement on a separate
small iland called a "dedicated mailing list". And I don't see any
need for it - the traffic on LKML isn't that high if one
learn how to use mozillas filtering facilities.



