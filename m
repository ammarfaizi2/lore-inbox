Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTBDXmF>; Tue, 4 Feb 2003 18:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTBDXmF>; Tue, 4 Feb 2003 18:42:05 -0500
Received: from zeke.inet.com ([199.171.211.198]:14479 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S267577AbTBDXmE>;
	Tue, 4 Feb 2003 18:42:04 -0500
Message-ID: <3E405207.8080207@inet.com>
Date: Tue, 04 Feb 2003 17:51:35 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
>>I'd love to see a small - and fast - C compiler, and I'd be willing to
>>make kernel changes to make it work with it.  
> 
> 
> I can't offer any immediate help with this but I want the same thing.  At
> some point, we're planning on funding some extensions into GCC or whatever
> reasonable C compiler is around:
> 
>     - associative arrays as a builtin type
[snip]
>     - regular expressions
[snip]
>     - tk bindings built in
> 
> and then we'll port BK to that compiler.  It's likely to be GCC because we
> want to support all the different architectures but if a kernel sponsered
> cc shows up we'll happily throw money at that.

Ok, dumb, (and probably flamebait) question time:  I read your list and 
thought "In C? Why not Python?"  I'm guessing speed issues?

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

