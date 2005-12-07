Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbVLGVaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbVLGVaa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbVLGVaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:30:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22424 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751752AbVLGVa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:30:29 -0500
To: Dave Jones <davej@redhat.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Leann Ogasawara <ogasawara@osdl.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Linux in a binary world... a doomsday scenario 
In-reply-to: Your message of Wed, 07 Dec 2005 16:02:46 EST.
             <20051207210246.GB22690@redhat.com> 
Date: Wed, 07 Dec 2005 13:30:18 -0800
Message-Id: <E1Ek6ri-0006aV-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2005 16:02:46 EST, Dave Jones wrote:
> On Wed, Dec 07, 2005 at 12:22:24PM -0800, Gerrit Huizenga wrote:
> 
>  > I'm a little less worried about OSDL advocating binary drivers.
> 
> Really ? That's a worst case scenario as far as I can see.

So, OSDL is an organization, sometimes referred to as "osdl.org"
and OSDL has members which are listed on the members page.

OSDL.org has no desire to advocate binary drivers in any way and I
don't expect that they will do anything to educate or influence their
members or the global vendor/IHV/developer communities to use binary
drivers.  Further, I expect they will do exactly the opposite, in
particular, educate members, developers, IHV's on how to deploy
open source drivers and the benefits of doing so.

There are *members* of OSDL who continue to have binary drivers as
part of their product line, in part because of IHV business choices,
and some of those *members* (e.g. IBM) are working to reduce the
number of binary drivers while at the same time not impacting revenue.
The goal is to remove all need for binary drivers as quickly as we can.
Business realities are keeping this from happening "immediately" but most
of the member companies that I know of are working in a similar direction.

OSDL.org has also offered to help by creating a mailing list for open source
drivers with a focus on educating and supporting IHV's (see
os_drivers@lists.osdl.org) and a new documentation site (brand new!!!)
http://developer.osdl.org/dev/opendrivers/documentation/ which will
evolve into a Wiki over time.  That Wiki will hopefully help out
IHV developers but ALSO will focus on program managers, product
managers, executives, etc.

Resolving the customer issues related to device drivers has been rated
as the #1 problem impeding customer adoption of Linux today.  That has
been raised by several vendors as well as by the OSDL Board of directors
as the #1 problem to solve.

There is a contingent of us working to ensure that the future solution
to this problem is aligned with the community guidelines of open source,
mainline accepted drivers over time, as well as with the distro needs
as we understand them.  There is a lot of material that we've generated
with a goal of educating the IHV's; we continue to work with them over
time at all levels within our own companies and the various IHV's.  This
is not an easy battle - MS still owns a large share of the IHV's business
and it is ultimately business reasons that are most compelling to
them over time.

But, net summary, I trust that OSDL would do the right thing in hosting
and editing a repository of information related to helping companies
move towards open source drivers over time.

gerrit
