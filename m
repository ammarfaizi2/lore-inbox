Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbUKQSvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUKQSvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbUKQSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:51:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26252 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262479AbUKQSuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:50:12 -0500
Date: Wed, 17 Nov 2004 13:08:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041117120857.GA6952@openzaurus.ucw.cz>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116155613.GA1309@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is step 0 before adding type-safety to PCI layer... It introduces
> > constants and uses them to clean driver up. I'd like this to go in
> > now, so that I can convert drivers during 2.6.10... Please apply,
> 
> The tree is in "bugfix only" mode right now.  Changes like this need to
> wait for 2.6.10 to come out before I can send it upward.
> 
> So, care to hold on to it for a while?  Or I can add it to my "to apply
> after 2.6.10 comes out" tree, which will mean it will end up in the -mm
> releases till that happens.

I think I'd prefer visibility of "to apply after 2.6.10" tree... Thanks,
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

