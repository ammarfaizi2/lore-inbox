Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWJHSbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWJHSbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWJHSbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:31:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:60550 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750835AbWJHSbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:31:04 -0400
Date: Sun, 8 Oct 2006 20:29:41 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Bryce Harrington <bryce@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Status on CPU hotplug issues
Message-ID: <20061008182941.GA8308@osiris.ibm.com>
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007000031.GI22139@osdl.org> <20061007103559.GC30034@elf.ucw.cz> <20061007204220.GB24743@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007204220.GB24743@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > We've been running this testsuite fairly continuously for several
> > > months, and irregularly for about a year before that.  We find that on
> > > some platforms like PPC64 it's quite robust, and on others there are
> > > issues, but the developers tend to be quick to provide fixes as the
> > > issues are found.  I'm glad to see that the results are finally showing
> > > green for ia64.
> > 
> > Hmm, perhaps you should add ppc64 to the hotplug_report.html, so that
> > some green can be seen :-).

FWIW, s390 passes all tests as well ;)
