Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVHOQ0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVHOQ0s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVHOQ0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:26:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19343 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964821AbVHOQ0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:26:47 -0400
Date: Mon, 15 Aug 2005 18:26:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Blaisorblade <blaisorblade@yahoo.it>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Feature removal: ACPI S4bios support
Message-ID: <20050815162638.GA2379@elf.ucw.cz>
References: <200508111417.47499.blaisorblade@yahoo.it> <20050812132444.GH1826@elf.ucw.cz> <20050815160007.GA3614@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815160007.GA3614@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Remove S4BIOS support. It is pretty useless, and only ever worked for
> > _me_ once. (I do not think anyone else ever tried it). It was in
> > feature-removal for a long time, and it should have been removed before.
> >...
> 
> You've forgotten to remove the feature-removal-schedule.txt entry in 
> your patch.  ;-)

Well, that can always be done later. There are probably other small
pieces that can be removed now. But I got neither ACK nor NAK on the
patch :-(.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
