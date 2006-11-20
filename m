Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934280AbWKTXJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934280AbWKTXJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934281AbWKTXJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:09:44 -0500
Received: from mx0.towertech.it ([213.215.222.73]:34012 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S934280AbWKTXJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:09:44 -0500
Date: Tue, 21 Nov 2006 00:09:36 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.19-rc6 6/6] rtc-omap driver
Message-ID: <20061121000936.6df60c2b@inspiron>
In-Reply-To: <200611201028.48701.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201028.48701.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 10:28:48 -0800
David Brownell <david-b@pacbell.net> wrote:

> This creates a new RTC-framework driver for the RTC/calendar module found
> in various OMAP1 chips.  (OMAP2 and OMAP3 use external RTCs, like those in
> TI's multifunction PM companion chips.)  It's been in the Linux-OMAP tree
> for several months now, and other trees before that, so it's quite stable.
> The most notable issue is that the OMAP IRQ code doesn't yet support the
> RTC IRQ as a wakeup event.  Once that's fixed, a patch will be needed.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Thanks David!

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

