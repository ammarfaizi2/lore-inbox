Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUI0UWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUI0UWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:22:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56477 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267338AbUI0UTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:19:38 -0400
Date: Sun, 26 Sep 2004 15:22:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926132200.GH826@openzaurus.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <4155E40D.2020709@suse.de> <200409261202.34138.rjw@sisk.pl> <200409261345.10565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409261345.10565.rjw@sisk.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I'll try, but sysrq didn't work for me at all on 2.6.9-rc2-mm1, so I'm 
> > not sure if I really can.
> 
> As I suspected, the damn sysrq doesn't work (/proc/sysrq-trigger does, so it 
> _is_ compiled in, sigh).

Map sysrq to some other key; sysrq is hard to press on notebooks.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

