Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVIIPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVIIPjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVIIPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:39:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15035 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964954AbVIIPjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:39:07 -0400
Date: Fri, 9 Sep 2005 08:37:55 -0700
From: Paul Jackson <pj@sgi.com>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-Id: <20050909083755.5ff302c3.pj@sgi.com>
In-Reply-To: <43219FDF0200007800024975@emea1-mh.id2.novell.com>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
	<20050908151624.GA11067@infradead.org>
	<432073610200007800024489@emea1-mh.id2.novell.com>
	<20050908184659.6aa5a136.akpm@osdl.org>
	<43219FDF0200007800024975@emea1-mh.id2.novell.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan wrote:
> Hence I wouldn't consider it reasonable to
> break up the debugger patch entirely and submit all the pieces at once,
> because that could easily mean that if one intermediate piece doesn't
> get accepted all the dependent pieces have been separated out
> pointlessly.

This statement sounds selfish.  I read it as saying that there is
no point in doing something if it didn't result in getting your
patch accepted.

No.  There is another point.  At least one.  Contributing to the well
being of the Linux community and kernel.  That benefits us all.

A properly split and presented patch set contributes to its being
understood by others.  The clearer each patch is, the more rapidly
others can understand that patch, and the faster the kernel can adapt
while remaining healthy.

If there is some good reason that some or all of your patch should not
be accepted (a reason you missed, despite your honest best efforts),
and your presentation of the patch makes it easier for someone else
to understand what you're doing and expose this reason, then be happy
- you've done your job well - assisting someone else to shoot down
your patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
