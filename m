Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTENJCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTENJCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:02:01 -0400
Received: from main.gmane.org ([80.91.224.249]:2726 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261405AbTENJCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:02:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: Re: [dri] x startup hangs again... ~2.5.69-bk5
Date: Wed, 14 May 2003 11:14:34 +0200
Message-ID: <slrnbc427q.377.andreashappe@flatline.ath.cx>
References: <slrnbc25b6.e5.andreashappe@flatline.ath.cx> <20030513165647.GA1056@suse.de> <slrnbc2d9s.cv.andreashappe@flatline.ath.cx>
Reply-To: Andreas Happe <andreashappe@gmx.net>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <slrnbc2d9s.cv.andreashappe@flatline.ath.cx>, Andreas Happe wrote:
> I will try bk-5 after some working with bk2.

ok, running with 2.5.69-bk8 since 11.5h. I'v just enabled agpmode = 2 in
XF86Config-4, everythink is on standard value. The system is stable till
now.

I've changed the settings around 2.5.69 because i've tried to get the
linux neverwinter nights client running smoother and have forgotten to
remove it from the config file. I must have been lucky until 2.5.69-bk5
which started to crash my system (so there isn't a regression, just a
"normal" instability (of which i have been warned...).

Andreas

