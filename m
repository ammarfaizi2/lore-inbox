Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTIAVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTIAVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:12:57 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:31875 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263288AbTIAVMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:12:34 -0400
Date: Mon, 1 Sep 2003 23:12:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901211220.GD342@elf.ucw.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Patrick fucked up power managment in 2.6.0-test4 [...]
> 
> Ok, guys, how about just talking to each other without the personal 
> attacks. Pavel in particular - this is more personal friction than 
> anything else, since others do not seem to have the same visceral dislike 
> of the patches, and there _has_ been discussion about them. 

Unfortunately, that was not personal attack, that was a fact. Even
Patrick had to agree that his -test4 changes were bad idea, and I even
have "official apology" from him (on irc).

He just thinks he can fix his code, and I want that code to be
reverted, reviewed, tested, and than merged back. There's no way
current mess can be fixed in reasonable time.

I've seen no discussion about that code, and certainly have not seen
that code before it was merged, which is strange since I'm listed as
software suspend maintainer.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
