Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269354AbRHaUxe>; Fri, 31 Aug 2001 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRHaUxY>; Fri, 31 Aug 2001 16:53:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:5112
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S269354AbRHaUxK>; Fri, 31 Aug 2001 16:53:10 -0400
Date: Fri, 31 Aug 2001 13:53:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
Message-ID: <20010831135323.A22974@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15coqr-0003DR-00@the-village.bc.nu> <Pine.LNX.4.30.0108311335150.9298-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0108311335150.9298-100000@anime.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 01:37:16PM -0700, Dan Hollis wrote:
> On Fri, 31 Aug 2001, Alan Cox wrote:
> > > So what happens when someone is able to duplicate the problem on say AMD
> > > 760MP chipset with registered ECC PC2100 ram and 450W power supply?
> > > Not to say it has happened yet (I havent got my dual Tyan Tiger MP yet :-)
> > > but where would the finger start pointing then?
> > That would make it a lot more complex. There were a few cases much earlier
> > on with AMD chipset lockups but those have been cured (and were an Athlon
> > processor errata where a prefetch of an uncacheable line made a very very
> > nasty mess).
> 
> Can you define a hardware configuration that if it fails under athlon
> optimizations, you would consider a falsification of the "marginal
> hardware" theory?
> 
> I want a hardware config that will get everyones attention if it fails.
> 

>From other posts, that would be boards based on AMD chipsets, and possibly
SIS or ALI.

