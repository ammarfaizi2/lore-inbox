Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312255AbSDTTou>; Sat, 20 Apr 2002 15:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313179AbSDTTos>; Sat, 20 Apr 2002 15:44:48 -0400
Received: from ns.suse.de ([213.95.15.193]:41487 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313168AbSDTToV>;
	Sat, 20 Apr 2002 15:44:21 -0400
Date: Sat, 20 Apr 2002 21:44:20 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove BK docs ... + x86-64 2.5.8 sync
Message-ID: <20020420214420.A13635@wotan.suse.de>
In-Reply-To: <p73u1q68cfu.fsf_-_@oldwotan.suse.de> <Pine.LNX.4.33.0204201230140.11732-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 12:33:26PM -0700, Linus Torvalds wrote:
> 
> > I don't want to use BitKeeper because I don't like open logging. I hope
> > I can continue to maintain the x86-64 port even without being part
> > of the inner bitkeeper circle.
> 
> Absolutely - as you noticed I accepted the patch, even though there was a 
> clash (with a released kernel) in there.

What clash was there? (just curious) I just checked and at least the 
kernel.org finger still shows 2.5.8 as the latest released kernel.

> 
> >	 It would be good if you did e.g.
> > a pre patch for every change that could require action from architecture
> > or other maintainers as sync point (i guess that could be made easy with
> > the appropiate script)
> 
> This is why I think it might be a good reason to just have a daily script: 
> not just to create the patches, but also to kind of keep a running 
> commentary on the kernel list on what I've merged..

Would be fine for me. 

-Andi
