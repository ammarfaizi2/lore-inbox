Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282821AbRLBJO0>; Sun, 2 Dec 2001 04:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282818AbRLBJOR>; Sun, 2 Dec 2001 04:14:17 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:53920 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282816AbRLBJN6>; Sun, 2 Dec 2001 04:13:58 -0500
Date: 01 Dec 2001 23:52:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8E1ez$k1w-B@khms.westfalen.de>
In-Reply-To: <3C07EBB9.CF5EB85E@randomlogic.com>
Subject: Re: Coding style - a non-issue
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3C07EBB9.CF5EB85E@randomlogic.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pgallen@randomlogic.com (Paul G. Allen)  wrote on 30.11.01 in <3C07EBB9.CF5EB85E@randomlogic.com>:

> John Kodis wrote:

> > Mathematics has a rich tradition of using short variable names such as
> > "pi" rather than something like "circle-circumference-to-diameter-ratio".
> > They keep formulas from becoming unreadably long, and have a meaning
> > which is well understood in context.  While the long version may more
> > self-explainatory, it's the short form which is universally preferred.

> While 'pi', 'e', 'theta', 'phi', etc. are universally understood, things
> like 'i', 'a', and 'idx' are not.

I'd certainly call 'i' well understood in both math and computing. In  
math, 'i' is what engineers call 'j' (i*i == -1), and in computing, 'i'  
('j', 'k', ...) is a counter for loops (some variant of int) that don't  
exceed about a screenful.

> I can use these for anything I want
> and even for more than one thing,

Of course, if you use them differently from what the convention is, *then*  
you are in trouble.

> and they say nothing about what they
> are for. 'i', 'j', etc. are fine as loop counters and array indexes
> where their meaning is apparent by context, but are _not_ fine in other
> situations. You (or the person that wrote the code) may think that the
> name is perfectly fine, but someone else that thinks a bit different may
> not.

Yup.


MfG Kai
