Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315835AbSEMFLd>; Mon, 13 May 2002 01:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315837AbSEMFLc>; Mon, 13 May 2002 01:11:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315835AbSEMFLb>;
	Mon, 13 May 2002 01:11:31 -0400
Message-ID: <3CDF4AAE.1020605@mandrakesoft.com>
Date: Mon, 13 May 2002 01:10:06 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Changelogs on kernel.org
In-Reply-To: <20020512010709.7a973fac.spyro@armlinux.org> <abmi0f$ugh$1@penguin.transmeta.com> <873cwx2hi4.fsf@CERT.Uni-Stuttgart.DE> <abn6q9$umv$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
> 	jsimmons@heisenberg.transvirtual.com:
>		A bunch of fixes.
>		Pmac updates
>		Some more small fixes.
>	rmk@arm.linux.org.uk:
>		2.5.13: vmalloc link failure
>
>	trond.myklebust@fys.uio.no:
>		in_ntoa link failure
>
>	viro@math.psu.edu:
>		change_floppy() fix
>


Picking on your examples, the first IMO needs more context.

(speaking more to the crowd...)
Changeset comments need to be written as if they stand alone, without 
any other context -- including the author.  A reader should not need to 
know that (for examples) James Simmons hacks on fbdev stuff.

    Jeff



