Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVDFH5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVDFH5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDFH5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:57:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2196 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262140AbVDFHzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:55:43 -0400
Date: Wed, 6 Apr 2005 09:55:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Message-ID: <20050406075519.GA1352@elf.ucw.cz>
References: <20050405185620.80060.qmail@web88009.mail.re2.yahoo.com> <20050405204234.GE1380@elf.ucw.cz> <200504052249.35030.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504052249.35030.shawn.starr@rogers.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So nobody minds if I make this into a CONFIG option marked as Deprecated? :)

Actually it should probably go through

Documentation/feature-removal-schedule.txt

...and give it *long* timeout, since it is API change.
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
