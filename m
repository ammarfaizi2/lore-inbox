Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTI1UtG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTI1UtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:49:05 -0400
Received: from gprs147-229.eurotel.cz ([160.218.147.229]:51073 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262755AbTI1Us4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:48:56 -0400
Date: Sun, 28 Sep 2003 22:24:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
Message-ID: <20030928202424.GA3072@elf.ucw.cz>
References: <20030928100620.5FAA63450F@smtp-out2.iol.cz> <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org> <20030928175853.GF359@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928175853.GF359@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This should not be warring patch. Pat
> > > already has variant in his tree,
> > > feel free to pull from him - but it
> > > would be nice to have working swsusp
> > > in -test6. --p
> > 
> > Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
> > add a big comment on why they are there but disabled?
> 
> Like this?

Sorry, discard this. I do not know what went wrong, but my bkcvs did
not seem to contain those changes, nor can I see them at bkbits.net,
yet -test6 contains them.

Sorry for confusion.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
