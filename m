Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTJ1JXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTJ1JXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:23:12 -0500
Received: from gprs197-51.eurotel.cz ([160.218.197.51]:61826 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263895AbTJ1JXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:23:12 -0500
Date: Tue, 28 Oct 2003 10:20:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: John Levon <levon@movementarian.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031028092026.GA1167@elf.ucw.cz>
References: <20031025182824.GA12117@gtf.org> <20031025202750.GC27754@wotan.suse.de> <20031025204717.GA78345@compsoc.man.ac.uk> <20031025205617.GD27754@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025205617.GD27754@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This has happened more than once in the tree.
> > 
> > When all the architectures have a minimum gcc requirement that accepts
> > mixed code and declarations by default, it can be removed ...
> 
> Would be my prefered solution. Discourage 2.95.
> 
> Sooner or later we have to do that anyways when a bug in 2.95 
> is found that breaks code (has happened with all gccs so far). 
> Sooner would be better, as supporting 2.95 seems to be already
> a significant mainteance burden.

Well.. except that 2.95 is still two times faster than gcc 3.3 :-(.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
