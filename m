Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAWP6d>; Tue, 23 Jan 2001 10:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAWP6X>; Tue, 23 Jan 2001 10:58:23 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:15726
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129511AbRAWP6G>; Tue, 23 Jan 2001 10:58:06 -0500
Date: Tue, 23 Jan 2001 07:58:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jonathan Earle <jearle@nortelnetworks.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] Coding Style
Message-ID: <20010123075805.A2575@work.bitmover.com>
Mail-Followup-To: Jonathan Earle <jearle@nortelnetworks.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 10:41:49AM -0500, Jonathan Earle wrote:
> I prefer descriptive variable and function names - like comments, they help
> to make code so much easier to read.
> 
> One thing I wonder though... why do people prefer 'some_function_name()'
> over 'SomeFunctionName()'?  I personally don't like the underscore character
> - it's an odd character to type when you're trying to get the name typed in,
> and the shifted character, I find, is easier to input.

I have a tendency to use class_functionName() where "class" represents a
class of related functions.  They all tend to take a point to an instance
of that "class".  So then you can read the code and see the "classes" in
the names.

And, this way, I can piss off both the anti underscore and the anti mixed case
people at the same time :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
