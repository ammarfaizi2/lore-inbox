Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVCCCeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVCCCeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVCCCZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:25:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:23742 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261420AbVCCCYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:24:19 -0500
Date: Wed, 2 Mar 2005 18:24:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302182412.03522c8c.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The key thing I look at is total cycle time, from any particular point
in the cycle, to when that same point comes around again.

In 2.4 and before, the cycle time was a long time, I hear tell. 
Perhaps, at some points, things were sufficiently chaotic that it
was difficult to discern any particular cycle time (FFT of releases
resembled pink noise ;?).

In 2.6.x since June 2004, the cycle time has been two months.  Cool.

My employer (SGI) has to push new features through the main Linux
kernel, and then through the Linux distributors we work with, such as
SuSE and Red Hat, before they reach our customers.  And we tend to live
on the leading edge, so depend on these features.

The longer the new feature cycle time in Linux, then the longer on the
average (depending on just how we line up) it takes us to get a feature
to our customers.

I really like the two month cycle we have now.  It's fast.

If your 2.6.<odd>, 2.6.<even> proposal extended that cycle time to four
months (two months <odd>, two months <even>), that would hurt.  Not the
end of Planet Earth, but still an owie.

The times you give, of a month or two for the <odd>, and a week or two
for the <even>, if taken literally, add up to roughly the same two
months, give or take a few weeks.  This is good.

But I've long since learned to take initial time estimates from
engineers (and from my wife, when we're getting ready to go out) with
a few grains of salt.

How serious are you about these time estimates?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
