Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTJWO7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTJWO7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:59:31 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3457 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263588AbTJWO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:59:21 -0400
Date: Thu, 23 Oct 2003 16:01:06 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310231501.h9NF164o006515@81-2-122-30.bradfords.org.uk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310231024160.21154@montezuma.fsmlabs.com>
References: <200310230930.h9N9U0B4006046@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0310231024160.21154@montezuma.fsmlabs.com>
Subject: Re: In-kernel Gopher server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Zwane Mwaikambo <zwane@arm.linux.org.uk>:
> On Thu, 23 Oct 2003, John Bradford wrote:
> 
> > Implementing a web-based interface to such data is all very well until
> > you want to access it on a device the size of a wristwatch.
> 
> Wristwatch /proc frobnicating aside, I think your clients are paying for 
> support, perhaps getting yourself to a desk and normal computer might be 
> in their best interests.

Obviously I'm not suggesting it as a normal method of support, it's
just another option.  There might be times when a desk and a normal
computer are more than five minutes away, and having something to
think about on the way there is useful.

> And anyway if you must, what's wrong with a 
> normal pda, ssh and cat(1)?

Nothing, but if we were going to export configuration data at all, it
might as well be done using something more light weight than HTTP and
HTML.

Maybe the wristwatch example was a bit extreme, but what about a
system with very low bandwidth for connectivity?  What if you were
trying to get configuration data back from a spacecraft millions of
miles away?  At 300 BPS or less, and hours of latency, Gopher starts
to look a bit more realistic than getting a shell prompt via ssh :-).

John.
