Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317857AbSFNJCN>; Fri, 14 Jun 2002 05:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317867AbSFNJCM>; Fri, 14 Jun 2002 05:02:12 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17414
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317857AbSFNJCL>; Fri, 14 Jun 2002 05:02:11 -0400
Date: Fri, 14 Jun 2002 01:59:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <20020614105553.A444@ucw.cz>
Message-ID: <Pine.LNX.4.10.10206140155041.21513-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Vojtech Pavlik wrote:

> > How about you rewriting the driver an take my name out of it too.
> 
> Not such a bad idea after all. But the Promise hardware has way too many
> quirks only the Promise people know for my tastes, even more than VIA.
> And, after all, as far as I know Bartek is rewriting it right now.  ;)
> 
> > Then you can have all the credit be yours.
> 
> And all blame and responsibility - which, I think should make you quite
> happy. Also note that you're still credited in the rewritten drivers. 

I would rather not be associated with your careless and thoughtless
rework.  Funny how you got put on notice for over driving hardware.
It is clear you do not understand it so I would prefer to be disassociated
from your disasters.

IIRC, gee it must to 133 even though the docs says it does not.

Nice, with any luck pATA will be dead before 2.6 is released so people
will not have to suffer data losses from overclocked drivers and main
loops issuing "low-level format" command codes to the hardware at boot.

Have a good day,

Andre Hedrick
LAD Storage Consulting Group

