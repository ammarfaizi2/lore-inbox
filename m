Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTI2TVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTI2TVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:21:24 -0400
Received: from dp.samba.org ([66.70.73.150]:11466 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264543AbTI2TVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:21:22 -0400
Date: Tue, 30 Sep 2003 05:19:44 +1000
From: Anton Blanchard <anton@samba.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030929191944.GC24019@krispykreme>
References: <20030928144102.5097ad81.akpm@osdl.org> <Pine.GSO.4.21.0309291155090.7432-100000@vervain.sonytel.be> <20030929110806.A5855@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929110806.A5855@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can confirm that no mail was received from the mail alias for the week
> including September 18th.  Maybe the mail about sched_clock() never made
> it to the alias in the first place?

I got it just fine:

>From akpm@osdl.org  Thu Sep 18 20:09:05 2003
Date:   Thu, 18 Sep 2003 12:45:52 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: sched_clock implementation
Message-Id: <20030918124552.7eb34d6a.akpm@osdl.org>
 
I'll be merging Ingo & Con's CPOU scheduler changes into Linus's tree
soon.
 
It does require that the architecture provides a new timing function:

...
