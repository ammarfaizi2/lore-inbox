Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270858AbUJVEKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270858AbUJVEKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270948AbUJVEHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:07:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56287 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270899AbUJUUbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:31:09 -0400
Date: Thu, 21 Oct 2004 22:30:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Rate of change
Message-ID: <20041021203037.GJ32465@suse.de>
References: <41758410.2020200@pobox.com> <20041019213758.GE22334@redhat.com> <20041019213932.GA7383@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041019213932.GA7383@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19 2004, Jeff Garzik wrote:
> On Tue, Oct 19, 2004 at 05:37:59PM -0400, Dave Jones wrote:
> > On Tue, Oct 19, 2004 at 05:16:00PM -0400, Jeff Garzik wrote:
> >  > 
> >  > 850 changesets and 3383 revisions since 2.6.9 was released,
> >  > a little over 24 hours ago.
> >  > 
> >  > That's pretty impressive.
> > 
> > Given a lot of these are backlogs from folks being
> > conservative whilst we were in -rc, perhaps this is an
> > indication we need shorter -rc periods ?
> 
> 
> Actually, we need longer non-rc periods :)

Agree. The rate of change is truly impressive (thank you Andrew and
BK!), but personally I'd like to see things settle down a lot more
quickly. Instead of having 2-3 weeks of continual patch flood, a week or
submitting the stuff that was already done by 2.6.9 by Andrews inclusion
criteria (which I completely agree with) results in -rc1, followed by
2-3 weeks of of truly stabilizing bug fixing. Since by virtue of this
inclusion criteria development for a particular feature/change is
already done by 2.6.9 release, this should be easy [1].

[1] Yeah right, but at least we can try.

-- 
Jens Axboe

