Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261343AbSIXTZq>; Tue, 24 Sep 2002 15:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbSIXTZq>; Tue, 24 Sep 2002 15:25:46 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:39399 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261343AbSIXTZp>; Tue, 24 Sep 2002 15:25:45 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0A5389D3@orsmsx108.jf.intel.com>
From: "Rhoads, Rob" <rob.rhoads@intel.com>
To: "'Greg KH'" <greg@kroah.com>, "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net,
       cgl_discussion@lists.osdl.org
Subject: RE: [ANNOUNCE] Linux Hardened Device Drivers Project
Date: Tue, 24 Sep 2002 12:30:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mon, Sep 23, 2002 at 03:38:32PM -0700, Rhoads, Rob wrote:
> > I appreciate all the feedback. Based on the wide variety 
> > of ideas/comments, it looks like I need to go back and 
> > incorporate these ideas into the document, potentially 
> > changing areas in major ways where appropriate.    
> 
> Not to be a pest, but I, and a lot of other people, posted some very
> specific questions in response to both your original posting, and in
> response to the published specification and published code.  
> It would be
> considered proper etiquette if you would at least try to respond to
> _some_ of these questions, as you did ask for them, rather 
> than stating
> that you are going to go mull over everything and come back with a
> modified document.

I've been overwhelmed with the hailstorm of posts hitting 
my mailbox, since I made the project announcement.

> 
> If you don't, any expectations of people reviewing future specs, or
> proposals from this project should be kept quite low.
> 

The responses I have received have fallen into several buckets:

1. INTEL???? wtf?  You're evil.  Go away.
2. Good goal; bad approach.
3. Good goal, bad approach in places, here are areas for improvement.
4. Good goal, here are my thoughts and questions on X.

Keep in mind the original post was the announcement of a new project.
Sure, there was a big document with lots of information--but the 
project is STARTING.  Not ending; personally I didn't think that 
there would be huge following on LKML.  I thought those interested
in the topic would read the spec we have, see where they like it 
and where they don't and then hopefully give me feedback to make 
the spec and the results better.  This isn't something that 
can be solved overnight.

What I'm seeing from the messages is that a lot of people have 
been thinking about this topic, and a lot of people have ideas 
on how they think the problems best solved.

Areas of common desire to be looked at:

1. validate kernel interfaces (i.e.: kernel janitor)
2. common logging mechanisms (i.e.: not POSIX logging)
3. validation/testing tools capabilities
4. driver-howto; best known methods by kernel driver 
   developers for writing stable maintainable drivers

I am trying to understand what people are looking for so that I 
can provide meaningful posts.

That said, I will go back and address the specific questions that
you and others have asked.

> thanks,
> 
> greg k-h
> 

-RobR
