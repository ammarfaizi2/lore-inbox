Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTLNQPj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTLNQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 11:15:39 -0500
Received: from gprs151-130.eurotel.cz ([160.218.151.130]:51074 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262111AbTLNQPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 11:15:38 -0500
Date: Sun, 14 Dec 2003 17:15:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Message-ID: <20031214161549.GA22488@elf.ucw.cz>
References: <0312030051..akdxcwbwbHdYdmdSaFbbcycyc3a~bzd25502@intel.com> <0312030051.paLaLbTdPdUbed6dXcEbXdDajbVdUd6c25502@intel.com> <20031211233031.GD23787@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211233031.GD23787@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  include/linux/fuqueue.h |  451 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/plist.h   |  197 ++++++++++++++++++++
> >  kernel/fuqueue.c        |  220 +++++++++++++++++++++++
> >  3 files changed, 868 insertions(+)
> > 
> > +++ linux/include/linux/fuqueue.h	Wed Nov 19 16:42:50 2003
> 
> I don't suppose you've run this feature name past anyone in marketting
> or PR?

Hehe, reminds me of podfuk (now called uservfs) project :-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
