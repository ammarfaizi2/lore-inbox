Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUJLJCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUJLJCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUJLI7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:59:00 -0400
Received: from gprs213-46.eurotel.cz ([160.218.213.46]:13184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269547AbUJLIzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:55:38 -0400
Date: Tue, 12 Oct 2004 10:55:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       Pavel Machek <pavel@suse.cz>, ncunningham@linuxmail.org,
       pascal.schmidt@email.de
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20041012085510.GC2292@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <20041011145911.GB2672@elf.ucw.cz> <416AC081.7050504@suse.de> <200410112158.49203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410112158.49203.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok... And I guess it is nearly impossible to trigger this on demand,
> > > right?
> 
> I think it is possible.  Seemingly, on my box it's only a question of the 
> number of apps started.  I think I can work out a method to trigger it 90% of 
> the time or so.  Please let me know if it's worthy of doing.

Yes, it would certainly help with testing...
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
