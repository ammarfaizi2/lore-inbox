Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVBNVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVBNVqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVBNVqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:46:37 -0500
Received: from gprs214-75.eurotel.cz ([160.218.214.75]:11937 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261565AbVBNVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:46:33 -0500
Date: Mon, 14 Feb 2005 22:46:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Bernard Blackham <bernard@blackham.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-ID: <20050214214620.GG12235@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is a conglomeration of about 5 patches that complete (I
> think!) the work of switching over to pm_message_t. Most of this work
> was done by Bernard Blackham, some by me, some by Pavel I think (I was
> out of action for part of the development). I believe it needs to go in
> before 2.6.11 in order to avoid compilation warnings and errors. The
> code has been in use by Suspend2 users for around three weeks. Please
> apply.

I have most of it in my tree already, modulo some usb stuff I done
wrong. Applied.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
