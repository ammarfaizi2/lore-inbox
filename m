Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRJWUHA>; Tue, 23 Oct 2001 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278215AbRJWUGu>; Tue, 23 Oct 2001 16:06:50 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:31408 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S278214AbRJWUGl>; Tue, 23 Oct 2001 16:06:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <DevilKin@gmx.net>
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: More memory == better?
Date: Tue, 23 Oct 2001 22:04:12 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be> <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com>
In-Reply-To: <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com>
X-Cats: All your linux' belong to us!
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011023200715.AEF66217593@tartarus.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 October 2001 21:49, bill davidsen wrote:
> In article <20011023161340.02EAC9BD76@pop3.telenet-ops.be>,
>
> DevilKin <DevilKin@gmx.net> wrote:
> | Currently I've got myself a nice setup (amd 1.4ghz, abit kg7raid etc etc)
> | with 512mb ram... (DDR). I'm wondering if increasing this to 1gb has
> | advantages (speedwise or anything), since I can get my hands on it at a
> | very low price...
> |
> | I must say that even with most of my applications loaded/running, the
> | system never even touches the swap partition.
> |
> | So, would it be wise?
>
> There are some good reasons to add memory.
>
> - disk i/o rates. vmstat will tell you some disk i/o rates, if they are
> high you *may* get better performance with more memnory for cache.
>
> - future applications. As you say it's cheap right now, if you think
> there's a good chance of larger images, more kernel compiles, whatever,
> buy now.
>
> - memory bandwidth. This is very motherboard dependent, read your specs.
> Some systems will use two or four way interleave to increase bandwidth
> to memory or reduce access time. See what your m/b spec tells you.
>
> - you have the money and want to spend it on {something}! Go ahead,
> memory is one of the best investments for any system.
>
> Just remember that to use this memory you need a large memory kernel.

Ah, thats with HIGHMEM support? I've read a lot of awful things about it 
here... how stable (aka usable) is it?

DK
-- 
devilkin@gmx.net
