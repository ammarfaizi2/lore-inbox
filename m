Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUBYSQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUBYSOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:14:08 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:6019 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261518AbUBYSNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:13:45 -0500
Date: Wed, 25 Feb 2004 19:13:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Cc: Greg KH <greg@kroah.com>
Subject: Re: [RFC 2.6] sensor chips sysfs interface change (long)
Message-ID: <20040225181328.GE1214@elf.ucw.cz>
References: <20040218220845.361341c9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1* Change the base scheme (e.g. temp_min1 -> temp1_min). This is the
> more important change (in the sense it affects all drivers and the
> libsensors library) and correspond to the second problem listed above.

> For those interested, the original thread on the lm_sensors mailing-list
> is available here:
>   http://archives.andrew.net.au/lm-sensors/msg06206.html
> And an older one on the same topic:
>   http://archives.andrew.net.au/lm-sensors/msg05028.html
> 
> Comments welcome (or even requested, according to the subject line).

Sounds good, what you probably need is to submit patch doing step #1
to Andrew and see what happens...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
