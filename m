Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWIYQud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWIYQud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWIYQud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:50:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbWIYQuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:50:32 -0400
Date: Mon, 25 Sep 2006 09:50:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <451798FA.8000004@rebelhomicide.demon.nl>
Message-ID: <Pine.LNX.4.64.0609250926030.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <451798FA.8000004@rebelhomicide.demon.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Sep 2006, Michiel de Boer wrote:
> 
> I support the current draft of the GPL version 3 and am very dissapointed
> it will not be adopted as is. IMHO, Linux has the power and influence
> to move mountains in the software industry, and shouldn't shy away from
> the opportunity to take moral responsibility when it arises.

Well, you do have to realize that Linux has never been an FSF project, and 
in fact has never even been a "Free Software" project.

The whole "Open Source" renaming was done largely _exactly_ because people 
wanted to distance themselves from the FSF. The fact that the FSF and it's 
followers refused to accept the name "Open Source", and continued to call 
Linux "Free Software" is not _our_ fault.

Similarly, the fact that rms and the FSF has tried to paint Linux as a GNU 
project (going as far as trying to rename it "GNU/Linux" at every 
opportunity they get) is their confusion, not ours.

I personally have always been very clear about this: Linux is "Open 
Source". It was never a FSF project, and it was always about giving source 
code back and keeping it open, not about anything else. The very first 
license used for the kernel was _not_ the GPL at all, but read the release 
notes for Linux 0.01, and you will see:

		2. Copyrights etc

  This kernel is (C) 1991 Linus Torvalds, but all or part of it may be
  redistributed provided you do the following:

	- Full source must be available (and free), if not with the
	  distribution then at least on asking for it.

	- Copyright notices must be intact. (In fact, if you distribute
	  only parts of it you may have to add copyrights, as there aren't
	  (C)'s in all files.) Small partial excerpts may be copied
	  without bothering with copyrights.

	- You may not distibute this for a fee, not even "handling"
	  costs.

notice? Linux from the very beginning was not about the FSF ideals, but 
about "Full source must be available". It also talked about "Free", but 
that very much was "Free as in beer, not as in freedom", and I decided to 
drop that later on.

How much clearer can I be? I've actively tried to promote "Open Source" as 
an alternative to "Free Software", so the FSF only has itself to blame 
over the confusion. 

Thinking that Linux has followed FSF goals is incorrect. IT NEVER DID!

I think the GPLv2 is an absolutely great license. I obviously relicensed 
everything just a few months after releasing the first version of Linux. 
But people who claim that that means that I (or anybody else) should care 
what the FSF thinks on other issues are just being totally silly.

> What is the stance of the developer team / kernel maintainers on DRM,
> Trusted Computing and software patents?

I'm very much on record as not liking them. That changes nothing. I'm also 
very much on record as saying that DRM, TPC etc have nothing at all to do 
with the kernel license.

If you want to fight DRM, do so by joining the Creative Commons movement. 
The problem with Disney is not that they use DRM, it's that they control 
the content in the first place - and they do that because content tends to 
be too monopolized. 

The whole "content" discussion has _nothing_ to do with an operating 
system. Trying to add that tie-in is a bad idea. It tries to link things 
that aren't relevant. 

So go fight the problem at the _source_ of the problem, not in my project 
that has got nothing to do it.

And please, when you join that fight, use your _own_ copyrights. Not 
somebody elses. I absolutely hate how the FSF has tried to use my code as 
a weapon, just because I decided that their license was good.

> How about a public poll?

Here's a poll for you:
 - go write your own kernel
 - poll which one is more popular

It really is that simple. The kernel was released with a few rules. The 
same way you can't just make your own version of it and then not release 
sources, you _also_ cannot just make it GPLv3. 

It's not a democracy. Copyright is a _right_. Authors matter.

			Linus
