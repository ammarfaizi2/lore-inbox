Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSHIVWq>; Fri, 9 Aug 2002 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSHIVWq>; Fri, 9 Aug 2002 17:22:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16134 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315988AbSHIVWp>; Fri, 9 Aug 2002 17:22:45 -0400
Message-ID: <3D5431ED.4020209@evision.ag>
Date: Fri, 09 Aug 2002 23:19:41 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.1) Gecko/20020724
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Rik van Riel <riel@conectiva.com.br>, Daniel Phillips <phillips@arcor.de>,
       frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
References: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com> <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com> <20020809114050.A23656@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
>>On Fri, 9 Aug 2002, Rik van Riel wrote:
>>One problem we're running into here is that there are absolutely
>>no tools to measure some of the things rmap is supposed to fix,
>>like page replacement.
> 
> 
> But page replacement is a means to an end. One thing tht would be
> very interesting to know is how well the basic VM assumptions about
> locality work in a Linux server, desktop, and embedded environment.
> 
> You have a LRU approximation that is supposed to approximate working
> sets that were originally understood and measured on < 1Meg machines
> with static libraries, tiny cache,  no GUI and no mmap.
> 
> L.T. writes:
> 
> 
>>Read up on positivism.
> 
> 
> It's been discredited as recursively unsound reasoning.

Well not taking the "axiom of choice" for granted is really
really narrowing what can be reasoned about in a really really not
funny way. It makes it for example very "difficult" to invent real 
numbers. Well apparently recently some guy published a book which is
basically proposing that the world is just a FSA, so we can see again
that this inconvenience appears to be still very compelling to people
who never had to deal with complicated stuff like for example fluid
dynamics and the associated differential equations :-).

But if talking about actual computers, and since those are in esp.
finite, it may very well be possible to get around without it. ;-)

