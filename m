Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWHAGlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWHAGlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWHAGlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:41:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161184AbWHAGlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:41:20 -0400
Date: Mon, 31 Jul 2006 23:41:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.18-rc3] build fixes:  omap-rng
Message-Id: <20060731234107.f4ae0f00.akpm@osdl.org>
In-Reply-To: <200607312238.54582.mb@bu3sch.de>
References: <200607310724.44928.david-b@pacbell.net>
	<200607312238.54582.mb@bu3sch.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 22:38:54 +0200
Michael Buesch <mb@bu3sch.de> wrote:

> Andrew, please apply to -mm and think about queueing it for 2.6.18.
> Thanks.
> 

Wilco.

> 
> Seems like the omap-rng driver in the main tree predates the switch
> from <asm/hardware/clock.h> to <linux/clk.h> ... now it builds OK.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

This should have been attributed to David - I made it so.  Please indicate
this by putting a From: line at the very start of the changelog, thanks.
