Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbUDGNoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUDGNoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:44:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6624 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263509AbUDGNn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:43:59 -0400
Date: Tue, 6 Apr 2004 22:46:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Quazgaa Scwhaa <quazgaa@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disappearing cursor with vesafb
Message-ID: <20040406204653.GH3084@openzaurus.ucw.cz>
References: <Law10-F82X7oG3AvUzk00032908@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F82X7oG3AvUzk00032908@hotmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> allthewhile my red block cursors are unaffected. The following things 
> instigate the disappearance of my cursor:  Switching to X and back to 
> console, and any other kind of switching to a graphical sort of mode, 
> be it framebuffer apps like graphical links, mplayer, etc.  Also the 
> console screen blanking after 10 or however many minutes screensaver 
> type of deal.  The thing is that it is somewhat random where I can 
> switch to X and back a few times and all is well and then the next 
> time the cursor disappears.  Or maybe the first time I switch to X 
> and back the cursor will disappear, etc.  On some rarer occasions i 
> think it happens even if i do nothing more than switch from a vterm 
> with a blinking underscore cursor to one with a red block and then 
> back.
> 

I see it, too, and it was in 2.6.[0..4] at least.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

