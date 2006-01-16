Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWAPAIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWAPAIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAPAIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:08:51 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:48140 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S932132AbWAPAIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:08:50 -0500
Date: Mon, 16 Jan 2006 11:09:23 +1100
From: CaT <cat@zip.com.au>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.15.1
Message-ID: <20060116000923.GL2035@zip.com.au>
References: <20060115070440.GH3335@sorel.sous-sol.org> <20060115080803.GJ2035@zip.com.au> <20060115235125.GN3335@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115235125.GN3335@sorel.sous-sol.org>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 03:51:25PM -0800, Chris Wright wrote:
> * CaT (cat@zip.com.au) wrote:
> > Was there a fix for the 2.6.16 cfq issues? It's a bad idea for me to use
> > AS on servers as it does weird things on the hardware we have (as I've
> > previously reported).
> 
> There's one relevant fix queued up for next -stable from
> this thread:

Cool.

> http://marc.theaimsgroup.com/?t=113657885100003&r=1&w=2
> 
> Is that what you're referring to?

Yup, thanks. That's the bug I was referring to.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
