Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSEaAsq>; Thu, 30 May 2002 20:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSEaAsp>; Thu, 30 May 2002 20:48:45 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:26273
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S313181AbSEaAsp>; Thu, 30 May 2002 20:48:45 -0400
Date: Thu, 30 May 2002 20:48:19 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Kenneth Johansson <ken@canit.se>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <1022803993.2799.13.camel@tiger>
Message-ID: <Pine.LNX.4.44.0205302043540.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2002, Kenneth Johansson wrote:

> On Fri, 2002-05-31 at 01:19, Daniel Phillips wrote:
> 
> > I think that with these breakups done the thing would be sufficiently
> > digestible to satisfy Linus.  Now that I think of it, Linus's request
> > for a breakup is really an endorsement, and quite possibly Keith took
> > it the wrong way.  (Keith, by the way, how did I do on the structural
> > breakdown?  Sorry, I really couldn't spend as much time on it as it
> > deserves.)
> 
> Maybe I'm the idiot here but what dose this gain you??

1) easier review

2) Linus acceptance

While the breakups doesn't necessarily guarantee #2 it is at least a known 
prerequisite.

And of course #2 is quite important here.


Nicolas

