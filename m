Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293063AbSBWBJc>; Fri, 22 Feb 2002 20:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293065AbSBWBJN>; Fri, 22 Feb 2002 20:09:13 -0500
Received: from [212.16.7.66] ([212.16.7.66]:44047 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S293063AbSBWBJK>;
	Fri, 22 Feb 2002 20:09:10 -0500
Message-ID: <3C766C93.70109@namesys.com>
Date: Fri, 22 Feb 2002 19:06:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, green@thebsh.namesys.com,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020212190834.W9826@lynx.turbolabs.com> <Pine.LNX.4.33.0202131300500.16151-100000@localhost.localdomain> <20020213095502.F25535@lynx.turbolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need to move from discussing whether Linus can scale to whether the 
Linux Community can scale.

Every organization needs to have clearly defined algorithms for 
determining what work is done by who.  For the linux community, our work 
consists in part of reviewing patches.  Incoherent inconsistent 
delegation is the only reason why we are having scaling problems.  We 
have a consistent recurring problem (yes, I know, a few lucky folks like 
me don't have this problem, but it is clear to see that WE as a 
community have this problem).

It is important that there be  a consistent feeling among patch 
submitters that they know where to send their patches for 
acceptance/rejection.  There should be NO patches which go out, and not 
even a rejection comes back.  

Every organization has clearly defined procedures for allocating the 
flow of work.  It is called a management structure.  That is what we 
need, and we need a formal well defined and externally visible one.  An 
informal undefined network of friends is just not suitable for an 
organization where the flow of email is as large as it is in the Linux 
Community.

Linus, I would like you to stop saying that you cannot scale to where 
you can read every email, and start determining what it takes to make 
the Linux Community infrastructure underneath you responsive to patches. 
 Bitkeeper is a great start, but you also need to create  a management 
structure and interface that is clearly defined to the external 
community.  Saying that the maintainers list is ignored by you means 
that you need to create something that is not ignored by you.  You also 
need to create a system (bitkeeper can perhaps help, Larry?) for 
tracking who fails to respond to patches, and (after a few warnings) 
remove them as maintainers.  

Our problems are not novel.  Let us apply standard business school 
methodologies to them.

Hans


