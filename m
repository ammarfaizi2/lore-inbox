Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBGMYJ>; Wed, 7 Feb 2001 07:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129331AbRBGMX6>; Wed, 7 Feb 2001 07:23:58 -0500
Received: from [194.213.32.137] ([194.213.32.137]:516 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129072AbRBGMXu>;
	Wed, 7 Feb 2001 07:23:50 -0500
Message-ID: <20010207115738.A218@bug.ucw.cz>
Date: Wed, 7 Feb 2001 11:57:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Enabling ACPI and APM at same time?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is it possible to have _both_ ACPI and APM enabled?

I really need APM on my notebook (so that machine suspends when it
runs out of batteries, not powers off), but having /proc/power/*
information would be *very* handy.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
