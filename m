Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWGPOd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWGPOd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 10:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWGPOd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 10:33:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56966 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751588AbWGPOd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 10:33:58 -0400
Date: Thu, 1 Jan 1970 13:26:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [stable] Linux 2.6.16.25
Message-ID: <19700101132635.GB3561@ucw.cz>
References: <20060715025906.GA11167@kroah.com> <20060715032907.GB5944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715032907.GB5944@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We (the -stable team) are announcing the release of the 2.6.16.25 kernel.
> 
> Oops, please note that we now have some reports that this patch breaks
> some versions of HAL.  So if you're relying on HAL, you might not want
> to use this fix just yet (please evaluate the risks of doing this on
> your own.)
> 
> Note that HAL usually does not run on servers, so this should be safe
> there.  We'll try to provide a better fix soon...

So there's going to be one more 2.6.16, good.

Did you receive that fix-pdflush-after-wakeup? I believe I mailed it
to stable@kernel.org, but I got no reply...
						Pavel

-- 
Thanks for all the (sleeping) penguins.
