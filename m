Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281909AbRKUQSz>; Wed, 21 Nov 2001 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281905AbRKUQSp>; Wed, 21 Nov 2001 11:18:45 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:18128 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S281395AbRKUQSk>; Wed, 21 Nov 2001 11:18:40 -0500
Message-Id: <200111211618.fALGIXE06714@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Mixing 32- and 64-bit cards
Date: Wed, 21 Nov 2001 11:18:21 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111210600.fAL60kE11763@demai05.mw.mediaone.net> <3BFB625B.3000709@stesmi.com>
In-Reply-To: <3BFB625B.3000709@stesmi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was not aware of the causes, but that's actually kind of the problem.

Our main supplier says the 7000 series will be in 'soon' but the 6000 
series is available now.  We're at 95+% on the current setup, so now is 
better than soon :)

If worst comes to worst, we'll replace the 6800 when we add a second card. 
 I'm hoping Linux can handle it a little more gradefully than that, though.

	-- Brian

On Wednesday 21 November 2001 03:14 am, Stefan Smietanowski wrote:
> > At the moment, we plan to get a 6800 (32-bit PCI).  If we add 7800's
> > (64-bit PCI) or some other 3ware card later, will the driver correctly
> > configure them all?  IOW, if I have
>
> Sorry, I'm not answering your question but I do have a comment.
>
> A month or so back 3ware discontinued _ALL_ their 3ware Escalades, the
> 6xxx and the 7xxx, they have since then recieved so many mails that
> they've restarted development, support and production of them.
>
> With one 'minor' issue, they're discontinuing their 6xxx (32bit) series
> of cards. So I would recommend getting the 64bit 7xxx series directly
> instead.
