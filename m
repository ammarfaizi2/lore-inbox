Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbTI1TI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTI1TI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:08:58 -0400
Received: from gprs147-229.eurotel.cz ([160.218.147.229]:39809 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262692AbTI1TI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:08:56 -0400
Date: Sun, 28 Sep 2003 21:06:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linus Torvalds <torvalds@osdl.org>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
Message-ID: <20030928190657.GJ359@elf.ucw.cz>
References: <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org> <1064774937.18769.9.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064774937.18769.9.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Could you also give me some clear direction on where you want me to put
> my 2.4 port. Should it go in kernel/power, or somewhere else? (I'm
> assuming you don't want 3 versions of swsusp?!). I'd like to put it in
> the right place when I start populating swsusp25.bkbits.net, so you're
> not pulling changesets later that only move the code around (I know bk
> reduces the cost, but...).

I believe kernel/power is the right place. And no, 3 versions would
not be good thing.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
