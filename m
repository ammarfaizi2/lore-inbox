Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTDQH6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 03:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTDQH6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 03:58:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1408 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261223AbTDQH6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 03:58:09 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304170812.h3H8CjIr000336@81-2-122-30.bradfords.org.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
To: admin@brien.com (Brien)
Date: Thu, 17 Apr 2003 09:12:44 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org
In-Reply-To: <006a01c3045a$037f54b0$6901a8c0@athialsinp4oc1> from "Brien" at Apr 16, 2003 04:51:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK...  Do you get the same locations failing with one pair of DIMMs as
> > with another identical pair of DIMMs, or is it just randomly flakey?
> 
> never seems to be the same
> (maybe a few are, but they've never all been the same--I'd have to look
> closely to match any addresses)

OK...

> > Are you sure it's not the power supply?  If the voltages are only just
> > within spec, you could concievably get the behavior you describe.
> 
> well, I have a 450 watt power supply that's rated for more than I'm
> using--it very rarely even becomes warm after hours of use
> 
> the voltages go much higher than they need to; I've also tried adjusting
> them and had the same problem

If you've got 10% or more over-voltage, I would be suspicious.

> > I wouldn't even bothing trying to run anything on a machine until it
> > runs Memtest86 for a couple of hours successfully.
> 
> I can with single modules, but not with 2..
> 
> I don't know what to do...

I would contact Gigabyte about it, and mention that your board with
that specific memory configuration fails Memtest86.

It's not a Linux specific problem.

> thanks for all of the comments/suggestions

No problem.  Let us know what happens.

John.
