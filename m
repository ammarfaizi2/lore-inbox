Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWASOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWASOGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWASOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:06:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161212AbWASOGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:06:00 -0500
Date: Thu, 19 Jan 2006 14:38:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Brown, Len" <len.brown@intel.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: remove function tracing macros
Message-ID: <20060119133824.GB1558@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005B8388F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005B8388F@hdsmsx401.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >I appreciate that but per-function tracing is overkill.
> 
> I agree that 100% function coverage is overkill.
> However, 100% is preferable to 0%.
> The most desirable middle-ground will take some work
> on the part of the folks that actually use the tracing.

Yes, unfortunately those folks seems to have 100% coverage, and it is
enough for them, so they just will have more important project all the
time, and it never gets fixed...
								Pavel
-- 
Thanks, Sharp!
