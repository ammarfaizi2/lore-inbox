Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLFAHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTLFAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:07:52 -0500
Received: from web11506.mail.yahoo.com ([216.136.172.38]:53088 "HELO
	web11506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264290AbTLFAHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:07:47 -0500
Message-ID: <20031206000746.29459.qmail@web11506.mail.yahoo.com>
Date: Fri, 5 Dec 2003 16:07:46 -0800 (PST)
From: gary ng <garyng2000@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0312051504230.9125@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is basically the case. The only difference in the
case of linux(or may be most open source project) is
that, there is no one person or entity(there is
usually more than copyright holder) can say to for
example nvidia that 'ok, your work is not derivative
work' as there is no legal binding in saying so,
unlike a license/contract from Microsoft to them.

So as I said, may be the SCO case can make things more
'formal' rather than this 'you say, I say'.

regards,

gary

ps. As a linux user, personally I like to see it the
way you see it as that can solve a lot of those driver
issues but it(driver is derivative work) really is not
convincing for me.


--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> Ahhah! But that's how these things work. Everybody
> wants more than they
> may be entitled to, and you don't concede a thing.
> 
> Until somebody comes up with a good
> counter-argument, at which point you
> say "Yes, that is ok".
> 
> And I'd like to point out that this is exactly how
> we _do_ work. This is
> why certain binary-only modules are accepted: we're
> bitching and moaning
> about how hard those nvidia-caused problems are to
> debug, but we're not
> actually suing nvidia.
> 
> See? The basic _assumption_ is that all modules are
> derived works. But
> once you get to specifics, the answer may well be
> "oh, in your case you
> can show preexisting work on other operating
> systems, and you have a good
> case that your code isn't actually derived from the
> kernel, so as long as
> you realize that we'll never be able to support or
> care about your module,
> we won't bother you".
> 


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/
