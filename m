Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318848AbSHREkc>; Sun, 18 Aug 2002 00:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318849AbSHREkc>; Sun, 18 Aug 2002 00:40:32 -0400
Received: from waste.org ([209.173.204.2]:61153 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318848AbSHREkb>;
	Sun, 18 Aug 2002 00:40:31 -0400
Date: Sat, 17 Aug 2002 23:44:27 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Robert Love <rml@tech9.net>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818044427.GJ21643@waste.org>
References: <1029642713.863.2.camel@phantasy> <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:06:08PM -0700, dean gaudet wrote:
> On 17 Aug 2002, Robert Love wrote:
> 
> > [1] this is why I wrote my netdev-random patches.  some machines just
> >     have to take the entropy from the network card... there is nothing
> >     else.
> 
> many southbridges come with audio these days ... isn't it possible to get
> randomness off the adc even without anything connected to it?

Many southbridges (like Intel 8x0) come with a real RNG. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
