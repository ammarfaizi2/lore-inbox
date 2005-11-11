Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVKKKHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVKKKHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKKKHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:07:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751257AbVKKKHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:07:03 -0500
Date: Fri, 11 Nov 2005 11:06:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/39] NLKD - an alternative early ioremap approach
Message-ID: <20051111100612.GA27805@elf.ucw.cz>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43720E72.76F0.0078.0@novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> An alternative to (on i386) boot-time ioremap approaches, which is more
> architecture independent (though arch dependent code needs adjustments
> if this is to be made use of, which with this patch only happens for
> i386 and x86_64) and doesn't require alternative boot-time interfaces.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>

> (actual patch attached)

Can you inline those patches? I do not care what email system you are
using, get gmail account if you have to. Or just ask for
suse.de/suse.cz account.

Ouch and btw the patch is wrong in first hunk, it adds #else/#endif
without #ifdef. Ouch.

								Pavel
-- 
Thanks, Sharp!
