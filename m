Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281204AbRKZA24>; Sun, 25 Nov 2001 19:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKZA2q>; Sun, 25 Nov 2001 19:28:46 -0500
Received: from grip.panax.com ([63.163.40.2]:22797 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S281225AbRKZA2i>;
	Sun, 25 Nov 2001 19:28:38 -0500
Date: Sun, 25 Nov 2001 19:26:29 -0500
From: Patrick McFarland <unknown@panax.com>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011125192629.M238@localhost>
Mail-Followup-To: J Sloan <jjs@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0111241744250.12119-100000@freak.distro.conectiva> <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com> <20011124205632.C241@localhost> <20011124211204.D241@localhost> <3C0058CF.D97D0E2B@starband.net> <20011124214114.E241@localhost> <3C006F44.201DC73F@pobox.com> <20011125165819.G238@localhost> <3C017740.FB17CD8C@pobox.com> <20011125181146.L238@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011125181146.L238@localhost>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14 i686
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyhow, back to the original problem, it seems that everyone thinks you can devlope code and not have to maintain it at the same time. If linus doesnt maintain the 2.5 tree while he develops it, it will turn into an unweildly bloated mess. Now, from what I understand, linus doesnt wanna maintain the code, and thats why I think he should have someone to help him maintain the 2.5 tree while he develops it. As a project gets bigger, no matter if its the stable tree or development tree, it needs to be constantly trimmed and pruned like a real tree. 


On 25-Nov-2001, Patrick McFarland wrote:
> I have an eepro100 in my box, but I dont use it, I dont have a network. =)
> Im actually wondering if it works.
> 
> On 25-Nov-2001, J Sloan wrote:
> > Patrick McFarland wrote:
> > 
> > > So your saying I should actually trust my distro to build a kernel right?
> > 
> > Depends on how paranoid you are - I find the
> > red hat kernels to be a safe, if boring choice.
> > 
> > > I build my own kernels, I have since day one.
> > 
> > Sounds like you would have done better to use
> > the vendor suppplied kernel in this case -
> > 
> > > But, heres a semi-key point, what happens to vendor patches? Do they ever get folded back into the main tree?
> > 
> > Many do, some don't.
> > 
> > Actual bug fixes get folded into the main tree,
> > but things like the e100 driver, the dell perc
> > raid drivers, the tux webserver, the linux
> > vertual server etc that are all in the red hat
> > kernel may never be in mainstream.
> > 
> > I would sure like to see tux in main kernel,
> > since it's superior to the khttpd that's part
> > of the mainline tree.
> > 
> > But things like the e100 driver I could live
> > without if eepro100 gets to the point where
> > it works just as well.
> > 
> > cu
> > 
> > jjs
> > 
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
