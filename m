Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285088AbRLLH61>; Wed, 12 Dec 2001 02:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285089AbRLLH6S>; Wed, 12 Dec 2001 02:58:18 -0500
Received: from gate.tao-group.com ([62.255.240.131]:62219 "EHLO
	mail.tao-group.com") by vger.kernel.org with ESMTP
	id <S285088AbRLLH6C>; Wed, 12 Dec 2001 02:58:02 -0500
Subject: Re: non-hackers
From: Andrew Ebling <aebling@tao-group.com>
To: michail@manegakis.freeserve.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16DyWZ-0004uW-00.2001-12-12-01-49-32@mail5.svr.pol.co.uk>
In-Reply-To: <E16DyWZ-0004uW-00.2001-12-12-01-49-32@mail5.svr.pol.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.11.09.00 (Preview Release)
Date: 12 Dec 2001 07:57:50 +0000
Message-Id: <1008143871.406.0.camel@spinel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-12 at 01:49, Michael Menegakis wrote:
> Since I'm not a kernel expert and absolutely not a kernel hacker I'd like to 
> submit my thoughts that may be proven usefull to all you maintainers. I 
> believe there is a need for a message board that everyone could submit bugs 
> of the kernel after being informed by a help file on how exactly this should 
> be done. 

There is plenty of information on this:

- in the Documentation directory in the kernel source.
- in the mailing list FAQ, the address of which appended to every post
to this list.

> I really don't feel we, the kernel users, should spend your valuable 
> time and post these here, as well as we need a help site that tells us how 
> exactly we should submit our kernel issues. And anyway, to be informed how we 
> can recognize what is actually a bug and what is a user fault from an easy to 
> read web site.

The "kernel users" should follow the instructions above, search the
archives (address is in FAQ), if the problem has not been reported,
report it, if it has been reported (and they have no more information to
add) they should not post and can rest assured that at least the hackers
know about it... a fix may even be iminent.

> I find it too difficult for us, the average kernel users, to have to read 
> books and books of documendation - and eventually become hackers - when there 
> would be a site that covers this step by step and doesn't need to much efford 
> on research. Please let me know if you do care at all anyway, or you're only 
> concerned about -your- bug discoveries (I'm not implying anything, let me 
> add).

A quick search for "kernel hacking" on google brings up

http://www.kernelhacking.org
 
which contains a kernelhacking-HOWTO (work in progress) in the docs
section.  It aims to make kernel hacking/programming/debugging
accessible to the average C programmer.

With a _little_ effort, you could have found all this information
yourself ;)

<RANT>   <--- HTML tag from HTML 4.0-ac1 ;)

If the kernel doesn't currently do what _you_ want, _you_ should invest
_your_ time to learn how to make it do what you want, then contribute
your fix and what you learned in the process by helping others.  That is
what free software is all about.

</RANT>

happy hacking,

Andy

