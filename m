Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbTGKUTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266266AbTGKUSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:18:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59792 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266215AbTGKUQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:16:35 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: 2.5 'what to expect'
Date: Fri, 11 Jul 2003 15:30:55 -0500
User-Agent: KMail/1.5
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <200307111437.12648.habanero@us.ibm.com> <20030711195920.GD976@matchmail.com>
In-Reply-To: <20030711195920.GD976@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111530.55363.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 14:59, Mike Fedyk wrote:
> On Fri, Jul 11, 2003 at 02:37:12PM -0500, Andrew Theurer wrote:
> > On Friday 11 July 2003 09:02, Dave Jones wrote:
> > > Process scheduler improvements.
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > - Scheduler is now Hyperthreading SMP aware and will disperse processes
> > >   over physically different CPUs, instead of just over logical CPUs.
> >
> > I'm pretty sure this is not in 2.5 (unless it's in bk after 2.5.75)
>
> wasn't this merged back in 2.4.6x?

I believe that was support of, not enhancement for HT.  Actually there may 
have been some enhancements in other areas, but not scheduler.

-Andrew Theurer
