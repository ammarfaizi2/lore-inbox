Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVBHJmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVBHJmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 04:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVBHJmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 04:42:43 -0500
Received: from elch.in-berlin.de ([192.109.42.5]:28870 "EHLO elch.in-berlin.de")
	by vger.kernel.org with ESMTP id S261496AbVBHJml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 04:42:41 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Feb 2005 10:35:37 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] tv-card tuner fixup
Message-ID: <20050208093536.GF32600@bytesex>
References: <20050204130102.GA24220@bytesex> <Pine.LNX.4.58.0502040756120.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502040756120.2165@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That one should go into 2.6.11.
> > - fix initialization order bug.
> 
> I applied your earlier patch already. Can you verify that I merged 
> everything correctly, and that my current BK tree matches yours?

Yep, it is fine.  Just a whitespace sneaked in somehow, otherwise
current bk is identical to my sources ;)

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
