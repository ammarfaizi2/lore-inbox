Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVAUMQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVAUMQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVAUMQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:16:01 -0500
Received: from gprs215-198.eurotel.cz ([160.218.215.198]:29650 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262347AbVAUMP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:15:56 -0500
Date: Fri, 21 Jan 2005 13:15:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mathias Kretschmer <posting@blx4.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asus A7N8X-E ACPI S3 resume hangs with 2.6.10 and 2.6.11-rc1
Message-ID: <20050121121521.GC11659@elf.ucw.cz>
References: <41EFDF7B.40408@blx4.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EFDF7B.40408@blx4.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I haven't tried any earlier kernel. Problem exists with 2.6.10 and 
> 2.6.11-rc1.  System seems to suspend ok. When I press the power button 
> the fans turn on again, the IDE LED seems to flash a little and then 
> stays on permanently. System hangs. Display is still off, so I don't 
> know if there are any kernel messages. All I can do is hit the Reset 
> button. S1 works fine.
> 
> Under WinXP S3 works.
> 
> Does anyone see the same problem ?

Try older kernels then. And read Documentation/power/video.txt

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
