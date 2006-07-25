Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWGYFMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWGYFMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 01:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWGYFMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 01:12:24 -0400
Received: from xenotime.net ([66.160.160.81]:60837 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932464AbWGYFMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 01:12:23 -0400
Date: Mon, 24 Jul 2006 22:15:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'H'-'M'
Message-Id: <20060724221505.c1e927ba.rdunlap@xenotime.net>
In-Reply-To: <20060725010315.816b40e9.kernel1@cyberdogtech.com>
References: <20060724192747.da3a9235.kernel1@cyberdogtech.com>
	<20060724204605.f239956b.rdunlap@xenotime.net>
	<20060725010315.816b40e9.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 01:03:15 -0400 Matt LaPlante wrote:

> On Mon, 24 Jul 2006 20:46:05 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > >  
> > >  If your hardware supports more than one io address, and your driver can
> > >  choose which one program the hardware to, starting from the more exotic
> >                    ^insert: to
> > 
> > >  
> > > -the core of the new scheduler are the following mechanizms:
> > > +The core of the new scheduler are the following mechanisms:
> > 
> > s/are/contains/
> > 
> > >   - *two*, priority-ordered 'priority arrays' per CPU. There is an 'active'
> > 
> > drop comma
> > 
> > >  	opinion still after having already compiled the kernel.
> > > -     Q: Why I cannot find the IBM MCA SCSI support in the config menue?
> > > +     Q: Why I cannot find the IBM MCA SCSI support in the config menu?
> > 
> >         Q: Why can I not find ...?
> > or
> >         Q: Why can't I find ...?
> > 
> > >       A: You have to activate MCA bus support, first.
> > >       Q: Where can I find the latest info about this driver?
> > >       A: See the file MAINTAINERS for the current WWW-address, which offers
> > 
> > Rest look good to me.
> > 
> 
> Edited patch below.

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.
---
~Randy
