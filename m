Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVGFKJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVGFKJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbVGFKHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:07:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59351 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262228AbVGFIVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:21:51 -0400
Date: Wed, 6 Jul 2005 10:21:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
Message-ID: <20050706082127.GE1412@elf.ucw.cz>
References: <11206164393426@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11206164393426@foobar.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 06-07-05 12:20:39, Nigel Cunningham wrote:
> As requested, here are the patches that form Suspend2, for review.
> 
> I've tried to split it up into byte size chunks, but please don't expect
> that these will be patches that can mutate swsusp into Suspend2. That
> would roughly equivalent to asking for patches that patch Reiser3 into
> Reiser4 - it's a redesign.

It still has quite a big impact outside kernel/power :-(.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
