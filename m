Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSEZE2f>; Sun, 26 May 2002 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSEZE2e>; Sun, 26 May 2002 00:28:34 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:38411 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315717AbSEZE2e>;
	Sun, 26 May 2002 00:28:34 -0400
Date: Sat, 25 May 2002 22:25:22 -0600
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525222522.A7339@hq.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.44.0205252159380.2614-100000@waste.org> <Pine.LNX.4.44.0205252116240.1028-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 09:20:32PM -0700, Linus Torvalds wrote:
> I certainly personally agree with you, but the hard-liners don't.
> Remember: it took the hard-RT community a long time to accept radical new
> things like CPU caches, and some of them _still_ like the ability to lock
> down cachelines..

I recently heard a gentleman from Boeing Civil Aviation speak on how they 
are considering what to do now that their stock of static memory, no-OO,
cacheless 68Ks are dwindling and their "tested to death tiny subset of ADA"
has no compiler vendors.

It's an interesting problem at least to some of us. 


-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

