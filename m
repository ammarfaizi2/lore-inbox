Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbTBXEvf>; Sun, 23 Feb 2003 23:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267989AbTBXEvf>; Sun, 23 Feb 2003 23:51:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26117 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267988AbTBXEvd>; Sun, 23 Feb 2003 23:51:33 -0500
Date: Sun, 23 Feb 2003 20:58:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <46950000.1046061746@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302232041130.4453-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Martin J. Bligh wrote:
>
> > The fact is, the "crap" doesn't matter that much. As proven by the fact
> > that the "crap" processor family ends up being the one that eats pretty
> > much everybody else for lunch on performance issues.
> 
> But is that because it's a better design? Or because it has more money
> thrown at it? I suspect it's merely it's mass-market dominance generating
> huge amounts of cash to improve it ... and it got there through history,
> not technical prowess.

Sure. It's to a large degree "more money and resources", no question about 
that.

But what is "better design"? Would it have been possible to put as much 
effort as Intel (and others) put into the x86 architecture into something 
else, and make it even better? 

MY standpoint is that the above question is _meaningless_ and stupid. 
People did try. Very hard. Claiming anything else is clearly misguided. 
But compatibility and price matter equally much - and often more - than 
raw performance. Which means that even _if_ another architecture performed 
better (and it certainly happened, in the hay-day of the alpha), it 
wouldn't much matter. People still stayed away from it in droves.

And in the end, that's why I don't like IA-64. I'll take back every single
bad thing I've ever said about IA-64 if Intel were to just to sell those
things to the mass market instead of P4's. But clearly the IA-64 can't 
make it in that market, and thus it is made irrelevant. The same way alpha 
was made irrelevant, _despite_ having had much better performance - an 
advantage that ia-64 clearly doesn't have.

(Admittedly, alpha didn't have hugely better performance for very long. 
Intel came out with the PPro, and took a _lot_ of people by surprise).

AMD's x86-64 approach is a lot more interesting not so much because of any 
technical issues, but because AMD _can_ try to avoid the "irrelevant" 
part. By having a part that _can_ potentially compete in the market 
against a P4, AMD has something that is worth hoping for. Something that 
can make a difference.

IBM with Power5 and apple could be the same thing (yeah yeah, I personally
suspect it goes enough against IBMs normal approach that it will cause
some friction). A CPU that actually competes in a market that is relevant.

Because server CPU's simply aren't very interesting from a technical
standpoint. I don't know of a _single_ CPU that ever grew down. But we've
seen a _lot_ of CPU's grow _up_. In other words: the small machines tend
to eat into the large ones, not the other way around.

And if you start from the large ones, you aren't going to make it in the 
long run.

Put yet another way: if I was on Intels IA-32 team, I'd be a lot more
worried about those XScale people finally getting their act together than
I would be about IA-64. 

			Linus

