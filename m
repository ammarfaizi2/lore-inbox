Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278215AbRJMAbp>; Fri, 12 Oct 2001 20:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278216AbRJMAbe>; Fri, 12 Oct 2001 20:31:34 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:17214 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S278215AbRJMAbZ>; Fri, 12 Oct 2001 20:31:25 -0400
Subject: Re: Updated preempt-kernel patches
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011012172702.A16500@mikef-linux.matchmail.com>
In-Reply-To: <1002917978.957.86.camel@phantasy>
	<1002925193.868.5.camel@phantasy> 
	<20011012172702.A16500@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.12.08.08 (Preview Release)
Date: 12 Oct 2001 20:32:00 -0400
Message-Id: <1002933123.868.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-12 at 20:27, Mike Fedyk wrote:
> On Fri, Oct 12, 2001 at 06:19:52PM -0400, Robert Love wrote:
> > On Fri, 2001-10-12 at 16:19, Robert Love wrote:
> > > - fix compile on SMP in some configurations (ac tree only)
> > 
> > Looks like I forgot to merge that one.  Fix follows below (its needed by
> > some ac-tree users who also compile SMP).
> >
> 
> Again? ;)

Yes, again :)

The 2.4.12-ac1 patch at http://tech9.net/rml/linux has been updated so
you don't need the previous patch.

> Any idea how it would work on any smp systems using the -ac tree?

It should run fine, give it a whirl.

	Robert Love

