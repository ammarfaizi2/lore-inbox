Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUJLXwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUJLXwl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUJLXwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:52:41 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:52742 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268111AbUJLXwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:52:30 -0400
Date: Tue, 12 Oct 2004 16:52:00 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>, Doug Niehaus <niehaus@ittc.ku.edu>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012235200.GA31233@nietzsche.lynx.com>
References: <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com> <1097618415.19549.190.camel@thomas> <20041012223642.GB30966@nietzsche.lynx.com> <1097622634.19549.235.camel@thomas> <20041012233308.GA31150@nietzsche.lynx.com> <1097624226.19549.252.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097624226.19549.252.camel@thomas>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 01:37:06AM +0200, Thomas Gleixner wrote:
> Hey, what are you talking about ?
> 
> Everybody should shut up, until some people have decided that others can
> participate in the development ?

No, just wait and your (everybody's) concern should be address. It takes
time to work through all of the slop. I'm all for syncing to a single
solution, but there's a ton of problems that still need to be addressed.

> I proposed this to stop this stupid race for the better solution, which
> is ugly and horrid, as you accept yourself.

Yes, the efforts are distant from each other and it's going to take time
to resolve it. I'm probably going to use Ingo's stuff in 2.6.9+, but my
stuff in 2.6.7 is useful as a specialized kind of test harness. I'll
have to think about what's the best way of resolving this. I agree on
these points.

bill

