Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTFSL4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbTFSL4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:56:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30436 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265779AbTFSL4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:56:33 -0400
Date: Thu, 19 Jun 2003 14:10:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Robert Love <rml@tech9.net>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
Message-ID: <20030619121026.GP29247@fs.tum.de>
References: <E19Qeoz-0004CM-00@calista.inka.de> <3EE9DA08.2020707@nortelnetworks.com> <20030613160335.GO828@ip68-0-152-218.tc.ph.cox.net> <1055527639.662.364.camel@localhost> <20030613181516.GT828@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613181516.GT828@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 11:15:16AM -0700, Tom Rini wrote:
> On Fri, Jun 13, 2003 at 11:07:19AM -0700, Robert Love wrote:
> > On Fri, 2003-06-13 at 09:03, Tom Rini wrote:
> > 
> > > ... only if we say a min gcc version of 3.3 however, yes?  Otherwise the
> > > kernel gets rather bloated.  Just how wide-spread (and Good To Use) is
> > > gcc-3.3 now?
> > 
> > Good point.
> > 
> > I have been using gcc-3.3 for awhile now with success, and I can
> > recommend it at least for x86, but that really is not reason to force
> > anyone to move to it (yet).
> 
> But how much have you rebuilt, heavily tested, etc?  I know that
> currently Debian/sid is building XFree86 4.1 at -O on all arches due to

s/4.1/4.2.1/

> gcc-3.3 issues (some xdm auth problem on ppc and x86, other things
> elsewhere).
>...
> Tom Rini

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

