Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSJPVbY>; Wed, 16 Oct 2002 17:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSJPVbX>; Wed, 16 Oct 2002 17:31:23 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:51420 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261433AbSJPVbW>; Wed, 16 Oct 2002 17:31:22 -0400
Date: Wed, 16 Oct 2002 16:35:15 -0500
From: Shawn <core@enodev.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
Message-ID: <20021016163515.C2874@q.mn.rr.com>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <Pine.LNX.3.96.1021016170140.12145C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1021016170140.12145C-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Wed, Oct 16, 2002 at 05:05:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16, Bill Davidsen said something like:
> On Tue, 15 Oct 2002, Linus Torvalds wrote:
> > A huge merging frenzy for the feature freeze, although I also spent a few
> > days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> > CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> > those off to the maintainer).
> 
> I hope you haven't broken running WITH ide-scsi, because most people still
> run 2.4 kernels in real life and only test 2.5 because someone has to do
> it. Reconfiguring the system to use ide-scsi or not is just one more PITA
> thing which needs to be done, or more likely forgotten, with every new
> kernel.

Honestly, I think it's ok to bust the old stuff if needed. This is
simply my opinion from a user standpoint.

It's really just one kernel argument or /etc/modules.conf modification
to fix the old setup, asnd likely, if you set it up in the first place,
you can un-set it up.

--
Shawn Leas
core@enodev.com

There's a pizza place near where I live that sells only slices...
in the back you can see a guy tossing a triangle in the air...
						-- Stephen Wright
