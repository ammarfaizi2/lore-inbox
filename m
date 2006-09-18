Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965636AbWIRKLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965636AbWIRKLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965635AbWIRKLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:11:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965637AbWIRKLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:11:21 -0400
Date: Mon, 18 Sep 2006 12:11:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 8 hours of battery life on thinkpad x60
Message-ID: <20060918101113.GM3746@elf.ucw.cz>
References: <20060917194118.GA3477@elf.ucw.cz> <Pine.LNX.4.61.0609180939270.23599@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609180939270.23599@yvahk01.tjqt.qr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-09-18 09:44:54, Jan Engelhardt wrote:
> 
> >I did a presentation about getting 8 hours of runtime out of common
> >notebooks. You can get it at
> 
> So if I use an uncommon notebook with an uncommon battery (SONY 
> PCGA-BP3U - 59070 mWh - 7 hours average) how much more am I supposed to 
> get?

I can't tell, without seeing your machine.

> present rate:            8029 mW (currently WLAN + Webradio)

Turn down wlan and you should be able to have one more hour... Go
after drivers, and find the ones that do not power their hardware down
properly and you can get another hour or so...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
