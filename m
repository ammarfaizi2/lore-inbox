Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbTHVHcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTHVHb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:31:26 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:31757 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263068AbTHVGxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:53:42 -0400
Message-Id: <4.3.2.7.2.20030822085247.02e0f788@pop.xs4all.nl>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 22 Aug 2003 08:53:03 +0200
To: Andi Kleen <ak@muc.de>, Chris Meadors <clubneon@hereintown.net>
From: Seth Mos <knuffie@xs4all.nl>
Subject: Re: Hang when mounting XFS root in 2.6.0 tests on x86-64
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <m3r83en2th.fsf@averell.firstfloor.org>
References: <n4o5.8ga.21@gated-at.bofh.it>
 <n4o5.8ga.21@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:00 21-8-2003 +0200, Andi Kleen wrote:
>Chris Meadors <clubneon@hereintown.net> writes:
>
>Better report it to linux-xfs@oss.sgi.com (cc'ed) too.
>
> > I'm trying to get a 2.6.0-test kernel to boot on my Opteron system.  It
> > has SuSE's 2.4.19-SMP kernel on it now, and it boots with that, mounts
> > the XFS root just fine.  But I build a vanilla 2.6.0-test3 with no
> > module support, everything included that I would need.  The last line
> > that it prints during boot is the NET4.0

Boot noapic ?

Cheers
--
Seth
It might just be your lucky day, if you only knew.

