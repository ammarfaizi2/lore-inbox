Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268601AbUHZJr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268601AbUHZJr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUHZJn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:43:29 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2540 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S268207AbUHZJlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:41:25 -0400
X-Sender-Authentication: net64
Date: Thu, 26 Aug 2004 11:41:22 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD record
Message-Id: <20040826114122.79daaa16.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.3.96.1040825174749.3199M-100000@gatekeeper.tmr.com>
References: <20040825135149.2166f4a4.skraw@ithnet.com>
	<Pine.LNX.3.96.1040825174749.3199M-100000@gatekeeper.tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004 17:54:25 -0400 (EDT)
Bill Davidsen <davidsen@tmr.com> wrote:

> On Wed, 25 Aug 2004, Stephan von Krawczynski wrote:
> >
> > Actually this is only FUD spread by Joerg. He is definitely not the only
> > man on this planet knowing how to program CD/DVD burning equipment.
> 
> Good, glad you have a supply of SCSI gurus who want to dedicate all their
> spare time to maintaining OS software. Joerg has been at this for years,
> and I think that while identifying technically competent people is
> possible, I doubt there's a big overlap with the set of people who have
> nothing better to do with their spare time. When I said "find" I certainly
> meant both qualifications.

Well, please read the docs for cdrecord again carefully. The story is not about
_free_, it is about _money_. Certain versions of cdrecord are licensed to
commercial customers for _money_. So please rethink your position.

> > Generally cdrecord has one big deficiency, which obviously was intended:
> > it does not allow medium skilled programmers from drive _vendors_ to add
> > support for their latest hardware easily. Everyone has to beg Joerg, which
> > obviously increased his ego dramatically over the years.
> > It would be a lot better to start off a new project where vendors (or
> > anybody with skill and will) can contribute more easily, i.e. something
> > that is truely_open_.
> 
> A nice idea, but in truth if a vendor wants support in cdrecord a tech ref
> and sample unit will almost certainly do it. I'd love to have support for
> HD_BURN in Linux, but Joerg can't seem to get the info needed. I doubt
> that people who won't release the info will trouble to write the driver.

Well, if I were owner of docs that are important for Joerg to make money and
had listened to him for the past 4 or 5 years and how he treated people (and
still does) it would be highly probable that I wouldn't be very cooperative,
too.
Please see the whole picture, not only what Joerg talks about.
Just take a clear look at his latest code changes and tell me if they look like
being done by an open-minded and friendly person to you.

Speaking from a potential commercial customers' point of view I decided against
using this software, not because of the money, but because of the
closed-everything-and-his-ears habit of the author. I don't see how this
project can survive its current author. Therefore I consider it an already dead
horse.

-- 
Regards,
Stephan
