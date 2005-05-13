Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVEMUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVEMUrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVEMUel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:34:41 -0400
Received: from orb.pobox.com ([207.8.226.5]:1218 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262539AbVEMUXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:23:42 -0400
Date: Fri, 13 May 2005 13:23:37 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513202337.GA7396@ip68-225-251-162.oc.oc.cox.net>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net> <4284B55C.7010202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4284B55C.7010202@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 10:10:36AM -0400, Jeff Garzik wrote:
> Barry K. Nathan wrote:
> >On Fri, May 13, 2005 at 07:51:20AM +0200, Gabor MICSKO wrote:
> >
> >>Is this flaw affects the current stable Linux kernels? Workaround?
> >>Patch?
> 
> Simple.  Just boot a uniprocessor kernel, and/or disable HT in BIOS.
> 
> 
> >Some pages with relevant information:
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0403.2/0920.html
> >http://bugzilla.kernel.org/show_bug.cgi?id=2317
> 
> These pages have zero information on the "flaw."  In fact, I can see no 
> information at all proving that there is even a problem here.

I meant that those two URL's have relevant information regarding
disabling HT for those of us who can't simply boot a UP kernel or
disable HT in the BIOS, not that they had information on the flaw.

-Barry K. Nathan <barryn@pobox.com>
