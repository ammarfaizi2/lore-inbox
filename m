Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274533AbRITO54>; Thu, 20 Sep 2001 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274532AbRITO5q>; Thu, 20 Sep 2001 10:57:46 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:4709 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S274531AbRITO5i>; Thu, 20 Sep 2001 10:57:38 -0400
Date: Thu, 20 Sep 2001 17:57:54 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: [PATCH] fix page aging (2.4.9-ac12)
Message-ID: <20010920175754.F22640@niksula.cs.hut.fi>
In-Reply-To: <20010920154806.75d7da23.skraw@ithnet.com> <20010920170349.E22640@niksula.cs.hut.fi> <20010920162054.5f430fd4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010920162054.5f430fd4.skraw@ithnet.com>; from skraw@ithnet.com on Thu, Sep 20, 2001 at 04:20:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 04:20:54PM +0200, you [Stephan von Krawczynski] claimed:
> On Thu, 20 Sep 2001 17:03:49 +0300 Ville Herva <vherva@niksula.hut.fi> wrote:
> 
> > vherva@linux:/home/vherva>./a.out
> > 4294967295
> > -1
> > -1
> 
> Aha, you name it, and how do you find these goodies when moving the kernel over
> to some new hardware platform? 

Tracing an oops for a couple of hours, I assume...

To be clear, I'm not advocating the (int)(a - b) variant, in fact I don't
think I'm qualified to advocate anything. (But I think Rik's variant was the
nicest.)


-- v --

v@iki.fi
