Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270608AbTGZWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270609AbTGZWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:17:57 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:41867 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270608AbTGZWRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:17:55 -0400
Date: Sun, 27 Jul 2003 00:32:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: "linux-power" tree [was Re: swsusp updates]
Message-ID: <20030726223258.GO266@elf.ucw.cz>
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

> And, that's a real problem with swsusp. It's a huge mess right now. I'd 
> like to see it work well and reliably for 2.6, and have the source code be 
> in a state where people can look at it without running away screaming. 
> Convoluted updates are not going to help the situation. 

Okay, so the debate is not over. It looks like his internet connection
only works as long as you keep flaming him -- perhaps he has frozen
ethernet cable? :-)

Anyway, patrick seems to have his own "linux-power" tree, and thinks
that his "linux-power" tree will help powermanagment in Linux. I don't
think that is the case, but I'll provide split patches *once*. Then
I'm going to post each new patch (I guess I'll cc: patrick), but
cumulate them for submission to Linus. Patches will be marked [PM]
(read it as Pavel Machek or Power Managment).

I hope that works for everybody.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
