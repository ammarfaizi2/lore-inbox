Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270508AbTGZVW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270516AbTGZVW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:22:58 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:59885 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270508AbTGZVWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:22:54 -0400
Date: Sat, 26 Jul 2003 23:37:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp updates
Message-ID: <20030726213754.GK266@elf.ucw.cz>
References: <20030726211310.GG266@elf.ucw.cz> <Pine.LNX.4.44.0307261422080.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307261422080.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, I killed few trivial hunks, will submit them through trivial
> > patch monkey. Are you happy now, patrick?
> 
> Why do you insist on abusing the trivial patch monkey? Why can't you send 
> them directly to the maintainers? For instance, you add/remove printk()s 
> and comments that other people may or may not want in there. 
> 
> But no, this doesn't make me happy because you insist on munging multiple 
> patches together that have little to do with each other, besides the fact 
> they touch the same file. Like I said in private email, it really helps to 
> track down a problem if each patch and subsequent changeset is as small 
> and localized as possible. 
> 
> And, that's a real problem with swsusp. It's a huge mess right now. I'd 
> like to see it work well and reliably for 2.6, and have the source code be 
> in a state where people can look at it without running away screaming. 
> Convoluted updates are not going to help the situation. 

[Sorry for the mess, I guess we are on the good way to solve this in
private mails.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
