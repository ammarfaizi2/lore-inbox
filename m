Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSLSQbR>; Thu, 19 Dec 2002 11:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSLSQbR>; Thu, 19 Dec 2002 11:31:17 -0500
Received: from zeke.inet.com ([199.171.211.198]:35200 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S265828AbSLSQbQ>;
	Thu, 19 Dec 2002 11:31:16 -0500
Message-ID: <3E01F632.1030302@inet.com>
Date: Thu, 19 Dec 2002 10:39:14 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
References: <200212190108.RAA03649@adam.yggdrasil.com> <20021219091336.A20477@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Dec 18, 2002 at 05:08:45PM -0800, Adam J. Richter wrote:
> 
>>	I don't currently use bugzilla (just due to inertia), but the
>>whole world doesn't have to switch to something overnight in order for
>>that facility to end up saving more time and resources than it has
>>cost.  Adoption can grow gradually, and it's probably easier to work
>>out bugs (in bugzilla) and improvements that way anyhow.
> 
> 
> I'm not asking the world to switch to it overnight.  Just one person
> would be nice. 8)
> 

Ok, Russell, maybe I can lend a small hand there....

You have a bug tracking mechanism of your own on www.arm.linux.org.uk, 
along with a separate patch tracker.
Do you want ARM bug reports in bugzilla instead of your site?  If so, 
can you link to it from that bug tracker page?  (I suppose you'd want to 
  direct people to bugzilla for just 2.5.* and 2.5.*-rmk*)

I submitted a 2.4 bug to your bug tracker, got an answer to the question 
when I posted to the arm mailing lists (thanks!), and submitted a patch 
to the mailing list.  But nothing has happened on the bug status.  I 
asked if you wanted patches for bugs put in the patch tracker or the bug 
tracker, but got no reply.
I understand that you're fighting the Acorn battle of 2.5.50 -> 2.5.52, 
so I'm trying not to sound like I'm complaining.  (Failing, yes, I know, 
sorry. :/ )  Some assurance that you will acknowledge bugs in bugzilla 
would be greatly encouraging to me.  (Such as a reply to this message?)

I'll try to get 2.5 bug reports for ARM into bugzilla based on your 
comments here, but a couple of suggestions:
- post an announcement to the arm lists of where you want which bugs to go,
- link to the same in a prominent place from your bug and patch trackers
- if you can, perhaps give priority in terms of replies and such to 
those who use bugzilla... I value your replies, and if I can do 
something to increase my chances of even getting an "Ack, I'll look at 
it next week", I'll try to do that.

Comments?

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

