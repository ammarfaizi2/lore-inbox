Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUGIFPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUGIFPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUGIFPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:15:43 -0400
Received: from gprs214-56.eurotel.cz ([160.218.214.56]:10369 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264297AbUGIFPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:15:41 -0400
Date: Fri, 9 Jul 2004 07:15:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, Erik Rigtorp <erik@rigtorp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709051528.GB23152@elf.ucw.cz>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz> <20040708225501.GA20143@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708225501.GA20143@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have not seen SuSE version of bootsplash... I do not want to
> > see. But this way, SuSE has its own crappy bootsplash, RedHat probably
> > too, Mandrake probably too, etc.
> 
> Red Hat gets it right and uses a program that's using fbdev.  They also
> have no swsusp support, which makes quite a lot of sense given how much
> in flux the code still is.

Okay, if redhat is actually doing it right, there's no reason for
encouraging the wrong thing.

But I guess swsusp is going to make this more "interesting" as
progressbar is nice to have there, and userland can not help at that
point.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
