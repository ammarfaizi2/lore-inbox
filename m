Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRHWWwv>; Thu, 23 Aug 2001 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270688AbRHWWwl>; Thu, 23 Aug 2001 18:52:41 -0400
Received: from otter.mbay.net ([206.40.79.2]:35858 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S270646AbRHWWwg> convert rfc822-to-8bit;
	Thu, 23 Aug 2001 18:52:36 -0400
From: jalvo@mbay.net (John Alvord)
To: Disconnect <lkml@sigkill.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Date: Thu, 23 Aug 2001 22:52:35 GMT
Message-ID: <3b8788c0.11437523@mail.mbay.net>
In-Reply-To: <20010823144406.G25051@sigkill.net> <Pine.LNX.4.33L.0108231608520.31410-100000@duckman.distro.conectiva> <20010823153126.H25051@sigkill.net>
In-Reply-To: <20010823153126.H25051@sigkill.net>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 15:31:26 -0400, Disconnect <lkml@sigkill.net>
wrote:

>On Thu, 23 Aug 2001, Rik van Riel did have cause to say:
>
>> On Thu, 23 Aug 2001, Disconnect wrote:
>> 
>> > ONLY task that they will use python for.  And everyone who builds a kernel
>> > will have gcc, so thats the 'ideal' dependency.  Second and third most
>> > likely, a C++ compiler or perl (depending on what you figure the
>> > installbase of each one is).  Forth, some form of java runtime.  And after
>> > that is python.
>> 
>> Sounds like you'd just might be fanatical enough to implement
>> CML2 in C or Perl, then ;)
>> 
>> Personally, I'd welcome such a thing...
>
>You are mistaking my position I think.  Personally, I like python quite a
>bit ;) 
>
>But my point isn't that its good/bad for CML2.  My point is that I would
>be very surprised if you had to install python in order to configure and
>build a kernel under CML2, once CML2 is the official configuration
>platform.  (Right now it is necessary to have python to use cml2.  But
>CML2 is not yet in the stock kernel sources.)
>
>But until ESR either chimes in or releases the final CML2, this is a moot
>discussion.

ESR is awaiting the 2.5 branch and the makefile rewrite.

My impression is that CML2 is "less bad" than CML in terms of weird
languages and buggy interpreters.

john
