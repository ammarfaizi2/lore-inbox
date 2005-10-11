Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVJKN6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVJKN6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJKN6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:58:10 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:16025 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S1751373AbVJKN6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:58:08 -0400
Date: Tue, 11 Oct 2005 14:57:39 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: Tony Lindgren <tony@atomide.com>
Cc: jonathan@jonmasters.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nokia 770 kernel sources?
Message-ID: <20051011135739.GA22484@apogee.jonmasters.org>
References: <35fb2e590510101708l497a44a5oe71971e9c3c925a9@mail.gmail.com> <20051011134936.GA12462@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011134936.GA12462@atomide.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 04:49:38PM +0300, Tony Lindgren wrote:

> * Jon Masters <jonmasters@gmail.com> [051011 03:09]:
> > Hi folks,
> > 
> > Anyone know if a vanilla 2.6 omap1 kernel is supposed to "just work" on the 770?
> 
> A lot of the 770 stuff already been merged, but there are
> still some more patches coming. So you should be able to use
> the linux-omap tree at some point.

I'd like to use it now as I've got a 770 that I'd like to play with.

> All the core omap stuff we merge with the mainline kernel on
> regular basis, but some omap specific drivers will probably
> never make it to the mainline tree because they are only
> used on development boards etc.

Sure. I've played with vendor omap kernels in the past.

Jon.
