Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTGKTrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTGKTq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:46:27 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:25611
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265141AbTGKToh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:44:37 -0400
Date: Fri, 11 Jul 2003 12:59:20 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711195920.GD976@matchmail.com>
Mail-Followup-To: Andrew Theurer <habanero@us.ibm.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <200307111437.12648.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307111437.12648.habanero@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 02:37:12PM -0500, Andrew Theurer wrote:
> On Friday 11 July 2003 09:02, Dave Jones wrote:
> > Process scheduler improvements.
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > - Scheduler is now Hyperthreading SMP aware and will disperse processes
> >   over physically different CPUs, instead of just over logical CPUs.
> 
> I'm pretty sure this is not in 2.5 (unless it's in bk after 2.5.75)
> 

wasn't this merged back in 2.4.6x?
