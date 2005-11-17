Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVKQVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVKQVTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVKQVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:19:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750941AbVKQVTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:19:48 -0500
Date: Thu, 17 Nov 2005 13:18:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Dave Jones <davej@redhat.com>,
       Olivier Galibert <galibert@pobox.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117211856.GS5856@shell0.pdx.osdl.net>
References: <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <20051117170202.GB10402@dspnet.fr.eu.org> <1132257432.4438.8.camel@mindpipe> <20051117201204.GA32376@dspnet.fr.eu.org> <1132258855.4438.11.camel@mindpipe> <20051117203731.GG5772@redhat.com> <1132260851.5959.15.camel@mindpipe> <20051117210643.GG7991@shell0.pdx.osdl.net> <1132262060.5959.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132262060.5959.21.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> OK I should not single out Red Hat or OSDL, it just seems like we get a
> lot more general gripes about ALSA regressions than we see good bug
> reports.  All I am saying is that maybe someone from a distro with
> access to bug reports from a huge user base has some ideas for how we
> could better deal with these regressions.  The ALSA project does not get
> many good bug reports because we are farther from the users.

Yeah, bad bug reports are indeed a pain.  One thing that may help ALSA is
more frequent merging with mainline.  Then the delta between ALSA cvs
(and hence ALSA developers) and mainline (users) is smaller.
