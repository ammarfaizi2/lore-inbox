Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSHaTPA>; Sat, 31 Aug 2002 15:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSHaTO7>; Sat, 31 Aug 2002 15:14:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:25539 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317872AbSHaTO7>;
	Sat, 31 Aug 2002 15:14:59 -0400
Date: Sat, 31 Aug 2002 21:19:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: bert hubert <ahu@ds9a.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: keyboard slowdown regression in 2.5.32 (right .config) Re: FIXED in 2.5.29 Re: keyboard ONLY functions in 2.5.27 with local APIC on for UP
Message-ID: <20020831211922.C67247@ucw.cz>
References: <20020720222905.GA15288@outpost.ds9a.nl> <20020728204051.A15238@ucw.cz> <20020728203211.GA20082@outpost.ds9a.nl> <20020831182645.GA8812@outpost.ds9a.nl> <20020831205337.A65739@ucw.cz> <20020831191432.GA9522@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020831191432.GA9522@outpost.ds9a.nl>; from ahu@ds9a.nl on Sat, Aug 31, 2002 at 09:14:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 09:14:32PM +0200, bert hubert wrote:
> On Sat, Aug 31, 2002 at 08:53:37PM +0200, Vojtech Pavlik wrote:
> > On Sat, Aug 31, 2002 at 08:26:45PM +0200, bert hubert wrote:
> 
> Vojtech, not only does your patch fix the problem, you supplied it in 27
> minutes. Great, I'm typing this from 2.5.32. I do have heaps and heaps of
> debugging now.
> 
> > How about I8042 support? Also enabled? If not, then the keyboard driver
> > isn't even touching the hardware.
> 
> Yes, that was enabled.
> 
> > Can you check with the attached patch? Or (better) Linus's current BK
> > tree?
> 
> When I refind Rik van Riel's bk-to-patch directory, I'll give it a shot.
> Again, thanks!

:)

-- 
Vojtech Pavlik
SuSE Labs
