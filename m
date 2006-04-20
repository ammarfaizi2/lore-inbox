Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWDTJEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDTJEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDTJEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:04:44 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:58800 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750769AbWDTJEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:04:43 -0400
Date: Thu, 20 Apr 2006 11:04:42 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Thinkpad X32 went to sleep, woke up as space heater
Message-ID: <20060420090442.GA26435@rhlx01.fht-esslingen.de>
References: <20060420085149.GA25029@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420085149.GA25029@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 20, 2006 at 10:51:49AM +0200, Pavel Machek wrote:
> Hi!
> 
> I did suspend-to-ram yesterday on thinkpad x32, while docked in
> docking station.... I do  not think I've done that before, because
> docking only works for a few weeks. This morning I wake up okay,
> unfortunately that thinkpad woke up as a portable, battery-backed-up
> space heater :-(.

Ouch, that's gotta hurt plenty.

> I can turn it on, it blinks keyboard leds and starts CPU fan, but
> that's it. Tried removing battery and AC power for a few minutes, but
> it made no difference. Tried pressing various keys during power on, no
> reaction. Not even keyboard light reacts.

Did you try pressing Insert(?) on bootup? AFAIR this is supposed to setup
factory defaults on some BIOSes. Maybe there are some other special keys
for certain BIOS versions... (do an internet search, especially for Phoenix
BIOS since many notebooks are Phoenix-based).
But of course the machine may easily be as screwed as not even executing
a single BIOS instruction any more...

> That machine may stil be covered by warranty (but I'm not sure if
> that's good news, I primarily want my data back...)

Is opening the drive box and connecting to a 2.5" adapter on a desktop
within safe warranty ranges? Perhaps not, but if it is then I'd do it.

Andreas Mohr
