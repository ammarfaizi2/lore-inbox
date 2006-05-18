Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWERXQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWERXQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWERXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:16:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28837 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750973AbWERXQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:16:53 -0400
Date: Fri, 19 May 2006 01:16:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Harald Welte <laforge@gnumonks.org>
Cc: Florent Thiery <Florent.Thiery@int-evry.fr>,
       openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518231613.GA19731@elf.ucw.cz>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr> <20060518143824.GC17897@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518143824.GC17897@sunbeam.de.gnumonks.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Another one: you say you're workin on building X-e. Are you talking about kdrive?
> 
> I have no idea, just replaying the package names that OE uses ;)
> 
> I now have Xfbdev running on the A780.  Unfortunately due to some
> strange black magic, the ts driver ceases to receive interrupts as soon
> as X is started. reproducible.  The same happens with ts_test.

Just poll the touchscreen, then... I have similar problems with
battery hardware and touchscreen sharing ADCs on collie... but
hopefully Motorola did not do _that_ mistake.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
