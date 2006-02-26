Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWBZACB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWBZACB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 19:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBZACB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 19:02:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbWBZACA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 19:02:00 -0500
Date: Sat, 25 Feb 2006 16:01:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
In-Reply-To: <4400E34B.1000400@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
 <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Feb 2006, Stefan Richter wrote:

> Chris Wright wrote:
> > * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> > > sd: fix memory corruption by sd_read_cache_type
> > 
> > Looks like these still aren't upstream.  Can you please resend to -stable
> > once they've been picked up by Linus?
> 
> Yes, I will do so.

Perhaps equally importantly, let's get them into mainline if they are so 
important. Which means that I want sign-offs and acks from the appropriate 
people (scsi and original author, which is apparently Al).

		Linus
