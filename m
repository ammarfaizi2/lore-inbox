Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271088AbUJUXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271088AbUJUXRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271102AbUJUXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:15:43 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:46211 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S271033AbUJUXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:02:09 -0400
Date: Fri, 22 Oct 2004 01:01:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hibernation and time and dhcp
Message-ID: <20041021230151.GA24980@elf.ucw.cz>
References: <200410202045.24388.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410202045.24388.cijoml@volny.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> with 2.6.9 hibernation to disk finally works! Thanks
> To ram it still don't work, system starts with lcd disabled - but it is 
> another story.
> 
> I have now this problem - when I hibernate and then system is started up in 
> other company, it don't update time and shows still for example 14:00 - when 
> I rehibernate for example in 20:00 - could you ask bios for current time? 
> It's better to have bad time about few seconds instead of hours.
> 
> Same problem with dhcp - it should ask for IP when rehibernate.

Known bug and I posted patch at least to acpi list few hours ago.

									Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
