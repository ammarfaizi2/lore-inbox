Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHYWDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHYWDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUHYWDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:03:30 -0400
Received: from mail.tmr.com ([216.238.38.203]:24582 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S264299AbUHYWAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:00:51 -0400
Date: Wed, 25 Aug 2004 17:54:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD record
In-Reply-To: <20040825135149.2166f4a4.skraw@ithnet.com>
Message-ID: <Pine.LNX.3.96.1040825174749.3199M-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Stephan von Krawczynski wrote:

> On Mon, 23 Aug 2004 18:07:09 -0400
> Bill Davidsen <davidsen@tmr.com> wrote:
> 
> > > Hat trick on the Good Point(tm) front. Agreed!
> > > 
> > > Well then I may go and look into cd recording then...hmm...
> > 
> > I hate to say it, but why reinvent the wheel? I'm sure that if Jorg 
> > doesn't support new technology there will be a project, either on 
> > sourceforge or freestanding, to create OpenCDburn or some such. It would 
> > be very hard to find someone as technically good as Jorg in this area, 
> > [...]
> 
> Actually this is only FUD spread by Joerg. He is definitely not the only man on
> this planet knowing how to program CD/DVD burning equipment.

Good, glad you have a supply of SCSI gurus who want to dedicate all their
spare time to maintaining OS software. Joerg has been at this for years,
and I think that while identifying technically competent people is
possible, I doubt there's a big overlap with the set of people who have
nothing better to do with their spare time. When I said "find" I certainly
meant both qualifications.
> 
> Generally cdrecord has one big deficiency, which obviously was intended:
> it does not allow medium skilled programmers from drive _vendors_ to add
> support for their latest hardware easily. Everyone has to beg Joerg, which
> obviously increased his ego dramatically over the years.
> It would be a lot better to start off a new project where vendors (or anybody
> with skill and will) can contribute more easily, i.e. something that is truely
> _open_.

A nice idea, but in truth if a vendor wants support in cdrecord a tech ref
and sample unit will almost certainly do it. I'd love to have support for
HD_BURN in Linux, but Joerg can't seem to get the info needed. I doubt
that people who won't release the info will trouble to write the driver.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

