Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbVKDFPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbVKDFPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVKDFPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:15:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161066AbVKDFPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:15:18 -0500
Date: Thu, 3 Nov 2005 21:14:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: mbligh@mbligh.org, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104010021.4180A184531@thermo.lanl.gov>
Message-ID: <Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
References: <20051104010021.4180A184531@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2005, Andy Nelson wrote:
> 
> I have done high performance computing in astrophysics for nearly two
> decades now. It gives me a perspective that kernel developers usually
> don't have, but sometimes need. For my part, I promise that I specifically
> do *not* have the perspective of a kernel developer. I don't even speak C.

Hey, cool. You're a physicist, and you'd like to get closer to 100% 
efficiency out of your computer.

And that's really nice, because maybe we can strike a deal.

Because I also have a problem with my computer, and a physicist might just 
help _me_ get closer to 100% efficiency out of _my_ computer.

Let me explain.

I've got a laptop that takes about 45W, maybe 60W under load.

And it has a battery that weighs about 350 grams.

Now, I know that if I were to get 100% energy efficiency out of that 
battery, a trivial physics calculations tells me that e=mc^2, and that my 
battery _should_ have a hell of a lot of energy in it. In fact, according 
to my simplistic calculations, it turns out that my laptop _should_ have a 
battery life that is only a few times the lifetime of the universe.

It turns out that isn't really the case in practice, but I'm hoping you 
can help me out. I obviously don't need it to be really 100% efficient, 
but on the other hand, I'd also like the battery to be slightly lighter, 
so if you could just make sure that it's at least _slightly_ closer to the 
theoretical values I should be getting out of it, maybe I wouldn't need to 
find one of those nasty electrical outlets every few hours.

Do we have a deal? After all, you only need to improve my battery 
efficiency by a really _tiny_ amount, and I'll never need to recharge it 
again. And I'll improve your problem.

Or are you maybe willing to make a few compromises in the name of being 
realistic, and living with something less than the theoretical peak 
performance of what you're doing?

I'm willing on compromising to using only the chemical energy of the 
processes involved, and not even a hundred percent efficiency at that. 
Maybe you'd be willing on compromising by using a few kernel boot-time 
command line options for your not-very-common load.

Ok?

			Linus
