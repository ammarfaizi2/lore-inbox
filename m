Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTGKTmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbTGKTkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:40:41 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:54490
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265261AbTGKTjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:39:36 -0400
Date: Fri, 11 Jul 2003 15:54:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711195418.GA30449@gtf.org>
References: <20030711140219.GB16433@suse.de> <200307111437.12648.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307111437.12648.habanero@us.ibm.com>
User-Agent: Mutt/1.3.28i
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

Wrong, grep for sibling.

	Jeff



