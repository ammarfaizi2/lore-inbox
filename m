Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129297AbRBBTzh>; Fri, 2 Feb 2001 14:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBBTzT>; Fri, 2 Feb 2001 14:55:19 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129297AbRBBTzA>;
	Fri, 2 Feb 2001 14:55:00 -0500
Message-ID: <20010202161250.C129@bug.ucw.cz>
Date: Fri, 2 Feb 2001 16:12:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter Samuelson <peter@cadcamlab.org>, Tom Leete <tleete@mountain.net>
Cc: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com> <3A77C6E7.606DDA67@mountain.net> <20010131042616.A32636@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010131042616.A32636@cadcamlab.org>; from Peter Samuelson on Wed, Jan 31, 2001 at 04:26:17AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It's not an incompatibility with the k7 chip, just bad code in
> > include/asm-i386/string.h.
> 
> So you're saying SMP *is* supported on Athlon?  Do motherboards exist?

Check today's slashdot ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
