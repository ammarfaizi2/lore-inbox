Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278159AbRJ1Lb0>; Sun, 28 Oct 2001 06:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRJ1LbQ>; Sun, 28 Oct 2001 06:31:16 -0500
Received: from fw2.aub.dk ([195.24.1.195]:56814 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S278159AbRJ1LbK>;
	Sun, 28 Oct 2001 06:31:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: What is standing in the way of opening the 2.5 tree?
Date: Sun, 28 Oct 2001 12:28:44 +0100
X-Mailer: KMail [version 1.3]
In-Reply-To: <1004219488.11749.19.camel@stomata.megapathdsl.net> <3BDB91D7.C7975C44@mandrakesoft.com>
In-Reply-To: <3BDB91D7.C7975C44@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15xo7Q-000191-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 October 2001 06:04, Jeff Garzik wrote:
> Miles Lane wrote:
> > Dear Linus,
> >
> > It seems like there has been the expectation that the 2.5
> > tree was about to be opened for at least the last two months.
>
> Most likely we are
> (a) waiting for stuff to get merged from Alan's tree, and
> (b) waiting for new VM and blkdev stuff in Linus tree to settle down and
> prove itself stable
>
> Personally I am still fixing bugs (2.4 stuff) so I could care less :)

Basicly you could restate it like this:
2.5 will be when:
(a) Linus is satisfied with the patches from Alan's tree
(b) Alan is satisfied with the patches in Linux's tree. (Most notably VM 
stuff)

Since some of the stuff in Alan's tree is for special features/hardware, it 
might get droped when Alan gets the responsiblity for a truly stable kernel. 
So (b) is the most important condition.

The latest ac patch was getting smaller, watch for it for reach 0 :)

It might be an idea to consider a two or three tiered release model like 
debian. E.g. experimental/testing/stable.. Right now 2.2 is stable, 2.4 is 
testing closing to stable, but we lack an experimental branch, although Alan 
has taken some stable "experimental" stuff. A truly experimental 2.4 would 
nice even if the source incompatable changes was still postponed for 2.5. And 
offical post-patches for the stable releases could also be usefull, instead 
of people recomminding kernels from Redhat/Suse. Official post-patches would 
IMHO have saved 2.4.11 and 12.

Disclaimer: But releasemodels are religius questions and hard to argue or 
prove. :-)

regards
`Allan
