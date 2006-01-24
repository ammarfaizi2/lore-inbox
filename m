Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWAXWrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWAXWrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWAXWrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:47:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10714 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750798AbWAXWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:47:16 -0500
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060124223834.GH2449@redhat.com>
References: <200601240929.37676.rjw@sisk.pl>
	 <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz>
	 <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz>
	 <20060124222044.GG2449@redhat.com> <20060124223328.GC1602@elf.ucw.cz>
	 <20060124223834.GH2449@redhat.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 17:47:10 -0500
Message-Id: <1138142831.2771.149.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 17:38 -0500, Dave Jones wrote:
>  > We'll of course try to get the interface right at the first
>  > try. OTOH... if wrong interface is in kernel for a month, I do not
>  > think it is reasonable to keep supporting that wrong interface for a
>  > year before it can be removed. One month of warning should be fair in
>  > such case...
> 
> Users want to be able to boot between different kernels.
> Tying functionality to specific versions of userspace completely
> screws them over.

Surely it's OK to experiment with different interfaces in -mm, as long
as it doesn't hit mainline?  Otherwise what's the point of an
experimental branch?

Lee

