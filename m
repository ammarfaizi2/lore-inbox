Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUA2K6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUA2K6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:58:43 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:56708 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265844AbUA2K6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:58:38 -0500
Date: Thu, 29 Jan 2004 11:57:40 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Enver Haase <enver@convergence.de>
Cc: Ingo Molnar <mingo@redhat.com>, Rokas Masiulis <roma1390@uosis.mif.vu.lt>,
       linux-kernel@vger.kernel.org
Subject: Re: IO-APIC/VIA-RHINE problem on 2.4.x
Message-ID: <20040129105740.GA4086@k3.hellgate.ch>
Mail-Followup-To: Enver Haase <enver@convergence.de>,
	Ingo Molnar <mingo@redhat.com>,
	Rokas Masiulis <roma1390@uosis.mif.vu.lt>,
	linux-kernel@vger.kernel.org
References: <4018D74A.1000107@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4018D74A.1000107@convergence.de>
X-Operating-System: Linux 2.6.1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 10:50:02 +0100, Enver Haase wrote:
> Here's output from my machine; it's a VIA-based one.
> [...]
> This (IO-APIC configured) does not work:
> [...]
> This, however, DOES work (IO APIC NOT configured)

I've seen plenty of reports from people who complain about IO APIC
breakage on VIA. It might be fixed in 2.6, but I wouldn't know since I
don't have any IO APIC hardware. Or maybe the reporters found it easier
to turn off that option than to get somebody to fix it. If 2.6 fails
as well I suggest you try bugzilla.kernel.org so at least the report
won't go away.

Roger
