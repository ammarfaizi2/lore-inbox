Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbTJWCkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTJWCkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:40:13 -0400
Received: from ssa8.serverconfig.com ([209.51.129.179]:54187 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S261503AbTJWCkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:40:08 -0400
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: Dave Jones <davej@redhat.com>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Date: Wed, 22 Oct 2003 21:35:22 +0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <200310221947.45996.theman@josephdwagner.info> <20031023012350.GI26476@redhat.com>
In-Reply-To: <20031023012350.GI26476@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310222135.22968.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, thanks Dave for having a far more polite and meaningful response 
to potty-mouth Tim Hockin.

>> So what?

> You can't use FP code in the kernel.

What can't be done today, might be done tommorrow.

I've long complained -- in this forum and in others -- that there's a lack 
of vision, or at least a lack of documented and published vision, when it 
comes to the future of kernel development.  If you're wondering why I don't 
do it myself, it's because I don't know enough of where the project is 
headed, and I can't find out because it's not documented.  Catch-22.  
However, this is entirely a separate discussion.

I am thinking of future development.  I know this point is kind of moot 
because 2.6 already adopts the change, but that hasn't stopped about a 
dozen backports of other features to previous versions of the kernel.

> You're reading into this far too much.

Perhaps I'm reading too much into this from your personal message, and if I 
have overreacted to your personal message I apologize.  However, this isn't 
the first time I've tried to help out, and deal with, the open source 
community.  The community isn't very welcoming to newcomers which has made 
me a bit short tempered when dealing with them.

> Your proposed change is in part already vetoed (for sound reasons)
> for 2.4, and is already included in the development branch
> (where such a far-reaching change should be tested). The other part
> of your proposal is completely bogus as far as the kernel is concerned.

I respectivly disagree with those reasons.  -march is gcc flag.  If it 
creates any instability (doubtful), it's really a gcc problem.  Throwing it 
in will light a fire under their @$$ to get their act together.

>> If you don't make the change, I will consider it conclusive proof
>> that the whole free-as-in-freedom is really just free-as-in-beer.

> No amount of 'threats' are going to change this.

That's not a threat, Dave.  That's a statement of fact.  If this change 
isn't put in, my opinion will be of x.  It's a fact that my opinion will be 
of this nature.  A threat would be if I took some sort of action that would 
be damning to the linux kernel project or open source as a whole, and my 
opinion -- for what it's worth -- doesn't carry enough weight to be damning 
to either.

Joseph D. Wagner
