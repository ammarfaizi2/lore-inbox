Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbWATBfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbWATBfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWATBfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:35:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030466AbWATBfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:35:37 -0500
Date: Thu, 19 Jan 2006 20:34:02 -0500
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120013402.GF3798@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Krzysztof Halasa <khc@pm.waw.pl>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, perex@suse.cz
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137703413.32195.23.camel@mindpipe> <1137709135.8471.73.camel@localhost.localdomain> <20060119224222.GW21663@redhat.com> <1137711088.3241.9.camel@mindpipe> <1137719627.8471.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137719627.8471.89.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 01:13:47AM +0000, Alan Cox wrote:
 > On Iau, 2006-01-19 at 17:51 -0500, Lee Revell wrote:
 > > The status is we need someone who has the hardware who can add printk's
 > > to the driver to identify what triggers the hang.  It should not be
 > > hard, the OSS driver reportedly works.
 > > 
 > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328
 > > 
 > > The bug has been in FEEDBACK state for a long time.
 > 
 > 99.9% of users don't ever look in ALSA bugzilla. 
 > 
 > A dig shows
 > 
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157371
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171221

Lee, if you can point me at a patch with debugging printk's I'm
happy to throw that into the next Fedora test update for the
users in the latter bug to test. (The first one seemed to go AWOL)

		Dave

