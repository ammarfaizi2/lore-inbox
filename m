Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265605AbSJSOAA>; Sat, 19 Oct 2002 10:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265606AbSJSOAA>; Sat, 19 Oct 2002 10:00:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5645 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265605AbSJSN77>; Sat, 19 Oct 2002 09:59:59 -0400
Date: Sat, 19 Oct 2002 15:05:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Nicholas Wourms <nwourms@netscape.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.44 - and offline for a week
Message-ID: <20021019150558.A21819@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0210182117500.12531-100000@penguin.transmeta.com> <aorjq3$3dm$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <aorjq3$3dm$1@main.gmane.org>; from nwourms@netscape.net on Sat, Oct 19, 2002 at 08:41:18AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 08:41:18AM -0400, Nicholas Wourms wrote:
> Perhaps this is good reason to delay the freeze for an additional 2 weeks or 
> so?

The same thing will happen.  You will always get people rushing to get
their projects into the kernel just before a feature freeze no matter
what date gets set.

> Again, I really don't see what the rush is all about.

It's only a rush because that's what people with their features are doing.
The deadline of October 31 was set at the kernel summit on Ottawa around
the middle of June.

The whole idea of shortening the feature development time is to (hopefully)
shorten the stabilisation time after, and hopefully get 2.6 out earlier.
This then means 2.7 can open earlier.

Although this means that there will be fewer features between each stable
version, hopefully the stable version series will stabilise earlier.

Oh, and Oct 31st is one deadline we're trying not to miss. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

