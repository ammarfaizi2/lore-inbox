Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267811AbTBEFp7>; Wed, 5 Feb 2003 00:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267812AbTBEFp7>; Wed, 5 Feb 2003 00:45:59 -0500
Received: from adedition.com ([216.209.85.42]:40197 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267811AbTBEFp6>;
	Wed, 5 Feb 2003 00:45:58 -0500
Date: Wed, 5 Feb 2003 01:03:46 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030205060346.GA7667@mark.mielke.cc>
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com> <20030204232101.GA9034@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204232101.GA9034@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 03:21:01PM -0800, Larry McVoy wrote:
> > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > make kernel changes to make it work with it.  
> I can't offer any immediate help with this but I want the same thing.  At
> some point, we're planning on funding some extensions into GCC or whatever
> reasonable C compiler is around:
>     - associative arrays as a builtin type
>     - regular expressions
>     - tk bindings built in

What is the problem with C++ or objective C?

I doubt that the GCC people would accept these sort of additions, even
if complete.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

