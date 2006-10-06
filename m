Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWJFSPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWJFSPa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWJFSPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:15:30 -0400
Received: from thunk.org ([69.25.196.29]:34473 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422810AbWJFSP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:15:29 -0400
Date: Fri, 6 Oct 2006 14:15:03 -0400
From: Theodore Tso <tytso@mit.edu>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       "Theodore Ts'o" <theotso@us.ibm.com>
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
Message-ID: <20061006181503.GE21816@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Tim Bird <tim.bird@am.sony.com>, Darren Hart <dvhltc@us.ibm.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Theodore Ts'o <theotso@us.ibm.com>
References: <200610051404.08540.dvhltc@us.ibm.com> <452696C8.9000009@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452696C8.9000009@am.sony.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:47:52AM -0700, Tim Bird wrote:
> Our site is intended to cover more than just the kernel,
> so I didn't really approach the kernel.org owners for a sub-domain,
> but your use of a sub-domain of wiki.kernel.org is very interesting.
> I didn't know such things were available.
> 
> Do you think other sub-domains of wiki.kernel.org will be made
> available for other kernel areas?  If so, what are the terms
> of use?  We haven't chosen our domain name yet, so we
> still have some flexibility if there are other options open
> to us.  (maybe embedded.wiki.kernel.org??)

Yep, that was part of the design.  When I approached Peter Anvin and
the other kernel.org maintainers during OLS about hosting the -rt wiki
on kernel.org infrastructure, what we explicitly talked about was
making it easy to set up other wiki's for multiple kernel projects,
just like kernel.org hosts multiple mailing lists beyond just the
LKML.

If we get too many wiki's, or the wiki's get too much traffic, we may
need to hit up some corporate sponsors to update the hardware which is
driving the *.wiki.kernel.org domain, but I suspect that won't be
terribly difficult.  Both the real-time wiki and the embedded wiki
would benefit and are of interest to a large number of companies, and
I'm sure we wouldn't have too much difficulty hitting them up for
money for hardware upgrades.  :-)

> Who would I contact about this?

I'd suggest sending mail to webmaster@kernel.org.

Regards,

					- Ted
