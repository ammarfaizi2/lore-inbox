Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278073AbRJPDPs>; Mon, 15 Oct 2001 23:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278074AbRJPDPj>; Mon, 15 Oct 2001 23:15:39 -0400
Received: from grip.panax.com ([63.163.40.2]:43278 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278073AbRJPDPa>;
	Mon, 15 Oct 2001 23:15:30 -0400
Date: Mon, 15 Oct 2001 23:15:53 -0400
From: Patrick McFarland <unknown@panax.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM
Message-ID: <20011015231552.D1314@localhost>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011015211216.A1314@localhost> <9qg46l$378$1@penguin.transmeta.com> <20011015230836.B1314@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011015230836.B1314@localhost>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also considering more stuff, 
someone said that this is more of a political issue, but seeing that I stay out of political issues, Im looking for the better code here. Thats all I care about.

On 15-Oct-2001, Patrick McFarland wrote:
> reading what lang wrote, ive been thinking
> 
> Im on the type of machine that swapping the least is most favorable. rik's vm seems that it would be able to swap less, and not swap the wrong things enough of the time. andrea's, if i try to do something major, it swaps like crazy, but I havent tested rik's because I dont trust the rest of the ac tree to mess around with it. Is there any chance of rik's vm being atleast an option to choose, and possibly see what the community wants? Maybe if rik's vm is cleaned up, that 5% of stupidity would go down to the less than 1% we all hope for. 
> 
> On 16-Oct-2001, Linus Torvalds wrote:
> > In article <20011015211216.A1314@localhost>,
> > Patrick McFarland  <unknown@panax.com> wrote:
> > >
> > >Why is the simple vm system still in place on the linus tree? I would
> > think the smart vm system in the ac tree would be better suited to .. 
> > oh..  say ..  everything.
> > 
> > "complex" != "smart".
> > 
> > The benchmarks I've seen says that the simple VM performs better - both
> > in terms of repeatability and in terms of absolute performance. Search
> > this list yourself if you don't believe me.
> > 
> > 		Linus
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> Patrick "Diablo-D3" McFarland || unknown@panax.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Patrick "Diablo-D3" McFarland || unknown@panax.com
