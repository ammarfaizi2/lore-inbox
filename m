Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHIRBn>; Fri, 9 Aug 2002 13:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHIRBn>; Fri, 9 Aug 2002 13:01:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3091 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315276AbSHIRBm>; Fri, 9 Aug 2002 13:01:42 -0400
Date: Fri, 9 Aug 2002 09:52:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@arcor.de>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Aug 2002, Rik van Riel wrote:
> 
> > Also, I think the jury (ie Andrew) is still out on whether rmap is worth
> > it.
> 
> One problem we're running into here is that there are absolutely
> no tools to measure some of the things rmap is supposed to fix,
> like page replacement.

Read up on positivism.

"If it can't be measured, it doesn't exist".

The point being that there are things we can measure, and until anything 
else comes around, those are the things that will have to guide us.

		Linus

