Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCYI5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCYI5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCYI5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:57:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13276 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261548AbVCYI5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:57:08 -0500
Date: Fri, 25 Mar 2005 09:53:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Airlie <airlied@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.6.12-rc1-mm2: crash in drm_agp_init
Message-ID: <20050325085306.GA1366@elf.ucw.cz>
References: <20050325083035.GA1335@elf.ucw.cz> <21d7e99705032500434957cd97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705032500434957cd97@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ..with -rc1-mm2 I get crash during bootup, in some function called
> > from drm_agp_init. I'm turned off CONFIG_AGP for now, and machine now
> > boots as expected.
> 
> try -mm3 we had a bit of a patch clash between myself, Davej and
> Adrian, I think -mm3 has all the fixes in it ..

Thanks for the info and sorry for the noise. (Why does -mm2 kernel have
tendency to appear within hour from me downloading -mm1? It happened
two times now...)
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
