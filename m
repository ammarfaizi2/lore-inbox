Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136642AbREGTev>; Mon, 7 May 2001 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136644AbREGTec>; Mon, 7 May 2001 15:34:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136642AbREGTeY>; Mon, 7 May 2001 15:34:24 -0400
Message-ID: <3AF6F8A5.F556DF62@transmeta.com>
Date: Mon, 07 May 2001 12:33:57 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com> <3AF6F11E.3A03050E@transmeta.com> <20010507121822.V14127@work.bitmover.com> <3AF6F5B8.42F803C1@transmeta.com> <20010507122730.A19632@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> On Mon, May 07, 2001 at 12:21:28PM -0700, H. Peter Anvin wrote:
> > Larry McVoy wrote:
> > > What does BitKeeper have to do with this conversation?
> >
> > Because your original post was "yeah, Bitkeeper is a memory hog but you
> > can get really cheap non-ECC RAM so just stuff your system with crappy
> > RAM and be happy."  Doing so dedicates my system to running a small set
> > of applications, which I am utterly uninterested in.
> 
> .. BitKeeper isn't a memory hog, the kernel is bloated.  Over 100MB of
>    source last I checked.  BitKeeper is incredibly good at _NOT_ being
>    a memory hog, it uses the page cache as its memory pool.  If things
>    fit in the cache, they go fast, if they don't, they don't.  BitKeeper
>    is just like diff in that respect.  If you think BitKeeper is a memory
>    hog, then you must hate diff too.  How about netscape?  Don't run that
>    either?  Give me a break.
> 

I wasn't the one who said it, you did.  I don't have any evidence either
way.

> .. It's great that you aren't interested in running that set of small
>    applications, I'm sure the entire kernel list is happy to learn that.

I believe the same is true for most people, with the major exceptions
being the embedded systems and server farm people.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
