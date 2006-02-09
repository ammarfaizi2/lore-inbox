Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWBIEzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWBIEzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWBIEzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:55:24 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28632 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422798AbWBIEzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:55:24 -0500
Subject: Re: sound problem on recent PowerBook5,8 MacRISC3
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yaroslav Halchenko <yoh@psychology.rutgers.edu>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1139437750.5003.19.camel@localhost.localdomain>
References: <20060208160002.GI5538@washoe.onerussian.com>
	 <1139437750.5003.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 23:55:18 -0500
Message-Id: <1139460919.30058.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 09:29 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-02-08 at 11:00 -0500, Yaroslav Halchenko wrote:
> > Dear Kernel People,
> > 
> > Sound fails to work on the PowerBook laptop
> > information on which could be found from
> > http://www.onerussian.com/Linux/bugs/bug.sound/
> > 
> > On 2.6.16-rc1 and got
> > dmasound_pmac: couldn't find a Codec we can handle
> > ....
> > snd: Unknown layout ID 0x52
> > (and ALSA failed to find any device)
> 
> The sound chipset on these new machines isn't yet supported.
> 

Please file a feature request in the ALSA bugzilla, so this won't get
lost.  Please include pointers to any Darwin code or any other docs you
think might help.

https://bugtrack.alsa-project.org/alsa-bug/login_select_proj_page.php?ref=bug_report_advanced_page.php

Lee

