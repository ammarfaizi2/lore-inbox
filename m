Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266018AbSKBSgE>; Sat, 2 Nov 2002 13:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266017AbSKBSf5>; Sat, 2 Nov 2002 13:35:57 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:40121 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266016AbSKBSf4>;
	Sat, 2 Nov 2002 13:35:56 -0500
Date: Sat, 2 Nov 2002 18:42:25 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [half-joke] Help - someone turned my machine into xt emulating 386 using bochs...
Message-ID: <20021102184225.GA4788@bjl1.asuk.net>
References: <20021101224514.GA126@elf.ucw.cz> <20021102160433.GD4402@bjl1.asuk.net> <20021102161948.GA5546@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102161948.GA5546@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Hey, that's faster than the time I connected an ethernet traffic
> > generator to a PII :-)  What fun it was to see "l".."o".."g".."i".."n"..":"!
> 
> That was over gigabit ethernet or how did you manage to overload it so
> badly? [Do small packets over 100mbit cause this, too?]

No, it was 100mbit.  I've not tried, but I think that gigabit doesn't
cause this because the cards and drivers have interrupt deferral to
reduce livelock.

-- Jamie
