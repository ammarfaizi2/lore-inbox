Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280554AbRKXXqC>; Sat, 24 Nov 2001 18:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280537AbRKXXpw>; Sat, 24 Nov 2001 18:45:52 -0500
Received: from femail31.sdc1.sfba.home.com ([24.254.60.21]:7860 "EHLO
	femail31.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280531AbRKXXph>; Sat, 24 Nov 2001 18:45:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Devlinks. Code. (Dcache abuse?)
Date: Sat, 24 Nov 2001 15:44:30 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15352.57742.799052.405674@notabene.cse.unsw.edu.au> <E165mO5-0006En-00@the-village.bc.nu> <15352.60223.1832.897635@notabene.cse.unsw.edu.au>
In-Reply-To: <15352.60223.1832.897635@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Message-Id: <01112415443000.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 06:21, Neil Brown wrote:
> On Monday November 19, alan@lxorguk.ukuu.org.uk wrote:
> > > I think you missed part of my point.
> > > There are lots of different name spaces in the kernel.
> > > Filesystem names.  Driver names.  Module names.
> > >
> > > But the namespace that is the current issue, the namespace of
> > > currently available devices, is not a namespace where I would expect
> > > trademarks to ever come up.  It is name space of interfaces and
> > > instances.
> >
> > You mean like adaptec/aic7xxx/0 for the first aic7xxx controller when you
> > want to refer to an adaptec card ? And yes - you do need the ability to
> > do that kind of thing, not just talk generically about "disks".
> >
> > So I still seek an answer. "Shrug, probably wont happen" isnt a good
> > one
>
> I was thinking:
>
>    devid/9005/00cf/0
>
> Now maybe the numbers can be trade marks too (I always liked "S3"'s id:
> 5333). However this number is extracted from the device in question. 

The reason Intel came up with the name "Pentium" is that a judge ruled 
they couldn't trademark a number like "386" or "486" to stop AMD from using 
it.  Just a data point.  What the law REALLY says these days is anybody's 
guess, and you can be sure somebody's lobbying to make it worse...

The law is a lot like poker: bluffing and wagering more than your opponent 
can afford is often more important than what your cards say.  The MS 
antitrust trial shows how when you stonewall it can take years for any 
enforcement action to work its way through the bureaucracy, by which point 
the issue is moot.  And the RIAA shows how somebody without a leg to stand on 
can get a really biased and/or ignorant judge to decide that PI should 
henceforth be 3 in all government documents.  But if you live your life in 
fear of being sued, you can't even go out and buy groceries...

So a vendor THREATENING to sue is normal.  Making threats is really cheap.  
Actually following through requires spending money and taking a potential 
public relations hit that can make it onto yahoo's business report where 
investors read it and drive the stock price down, which they'd generally 
rather like to avoid.  Doesn't mean they won't, but it doesn't mean a form 
letter on company letterhead justifies digging a bomb shelter...

Rob
