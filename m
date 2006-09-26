Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWIZO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIZO5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWIZO5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 10:57:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3852 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S932108AbWIZO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 10:57:53 -0400
Date: Tue, 26 Sep 2006 14:57:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: George Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no status when suspending to disk
Message-ID: <20060926145742.GA4030@ucw.cz>
References: <4517DA5E.4050709@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4517DA5E.4050709@cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-09-06 09:32:14, George Nychis wrote:
> Hey guys,
> 
> Whenever I suspend to disk without quitting X first, I do not get a
> status, ie. 58%
> 
> I updated my kernel a couple weeks ago and it miraculously came up, I
> was able to get a status when using the kernel.
> 
> Then when I just recently updated my kernel again it went away.
> 
> All I get now is a blank, but lit, LCD screen with a blinking cursor at
> the very top left.
> 
> How can I get it to display the status?

console loglevel, see faq.

-- 
Thanks for all the (sleeping) penguins.
