Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBQXn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBQXn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBQXld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:41:33 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:10636 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261218AbVBQXlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:41:16 -0500
Date: Thu, 17 Feb 2005 15:40:54 -0800
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, ncunningham@cyclades.com,
       bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix u32 vs. pm_message_t in USB [was Re: PATCH: Address lots of pending pm_message_t changes]
Message-ID: <20050217234054.GD22369@suse.de>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <20050215003935.GB5415@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215003935.GB5415@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 01:39:35AM +0100, Pavel Machek wrote:
> Hi!
> 
> This fixes (part of) u32 vs. pm_message_t confusion in USB. It should
> cause no code changes. Please apply,

Large portions of this patch are already in my tree (and hence the -mm
tree.)  Care to rediff against the latest -mm and resend the patch?

thanks,

greg k-h
