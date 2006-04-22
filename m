Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDVRR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDVRR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 13:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDVRR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 13:17:59 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:25749 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750741AbWDVRR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 13:17:58 -0400
Date: Sat, 22 Apr 2006 11:09:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Thinkpad X32 went to sleep, woke up as space heater
Message-ID: <20060422090929.GA15491@atrey.karlin.mff.cuni.cz>
References: <20060420085149.GA25029@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420085149.GA25029@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I did suspend-to-ram yesterday on thinkpad x32, while docked in
> docking station.... I do  not think I've done that before, because
> docking only works for a few weeks. This morning I wake up okay,
> unfortunately that thinkpad woke up as a portable, battery-backed-up
> space heater :-(.
> 
> I can turn it on, it blinks keyboard leds and starts CPU fan, but
> that's it. Tried removing battery and AC power for a few minutes, but
> it made no difference. Tried pressing various keys during power on, no
> reaction. Not even keyboard light reacts.
> 
> That machine may stil be covered by warranty (but I'm not sure if
> that's good news, I primarily want my data back...)

With vojtech, we were able to disconnect CMOS backup battery,
reconnect it and machine recovered. But be warned that that connector
is very fragile. In fact I do not have connector there any
more... just few pieces of broken plastics.

						Pavel

-- 
Thanks, Sharp!
