Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDDRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDDRkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDDRkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:40:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32273 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750751AbWDDRkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:40:00 -0400
Date: Tue, 4 Apr 2006 00:01:29 +0000
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc1: collie -- oopsen in pccardd?
Message-ID: <20060404000129.GA2590@ucw.cz>
References: <20060404122212.GG19139@elf.ucw.cz> <20060404124350.GA16857@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404124350.GA16857@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue 04-04-06 13:43:50, Russell King wrote:
> On Tue, Apr 04, 2006 at 02:22:12PM +0200, Pavel Machek wrote:
> > I'm getting some oopses when inserting/removing pccard (on collie,
> > oopses in pccardd). It does not break boot, so it is not immediate
> > problem, but I wonder if it also happens on non-collie machines?
> 
> No idea what so ever.  Not even any clues as to what might be going wrong
> due to the lack of oops dump.  (Not that I even look after PCMCIA anymore.)

Sorry for lack of oops. I was not expecting you to debug it, I
expected some voices telling me it is broken for them, too :-).

							Pavel
-- 
Thanks, Sharp!
