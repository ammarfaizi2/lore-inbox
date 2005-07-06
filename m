Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVGFKJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVGFKJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVGFKGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:06:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59863 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262234AbVGFIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:22:54 -0400
Date: Wed, 6 Jul 2005 10:22:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
Message-ID: <20050706082230.GF1412@elf.ucw.cz>
References: <11206164393426@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164393426@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As requested, here are the patches that form Suspend2, for review.
> 
> I've tried to split it up into byte size chunks, but please don't expect
> that these will be patches that can mutate swsusp into Suspend2. That
> would roughly equivalent to asking for patches that patch Reiser3 into
> Reiser4 - it's a redesign.
> 
> There are a few extra patches not included here, all of which are not
> core to Suspend2. Since I'm not expecting this code to get merged as is,
> I haven't worried about including them. If that's a problem, let me know.

Is swsusp1 expected to be functional after these are applied? You
removed *some* of its hooks, but not all, so I'm confused.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
