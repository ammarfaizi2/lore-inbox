Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVLGUQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVLGUQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVLGUQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:16:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57359
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030302AbVLGUQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:16:15 -0500
Date: Wed, 7 Dec 2005 21:16:12 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051207201612.GV28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <1133857767.2858.25.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com> <Pine.LNX.4.58.0512071041420.17648@shark.he.net> <1133981708.2869.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133981708.2869.54.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 07:55:08PM +0100, Arjan van de Ven wrote:
> the biggest pitfal by having this done by a commercial entity or an
> entity with commercial funding is that there is a LOT of pressure to
> call things with binary drivers also certified/working. 
> It has to be an entity that can resist that pressure; if OSDL can,
> great. But their funding is partially from sources that will try to put
> that pressure on I suspect...
> So I would almost rather have a separate "kicked off and supported by
> OSDL" organisation with its own charter than have OSDL do it itself. I
> can imagine OSDL feeling the same as well ...

I don't like to see an entity doing this: if an organization (no matter
if for-profit or no-profit) will do it, they may ask vendors to pay to
be added to the "certified list".

Nobody should be required to pay to be added in the list. Furthermroe I
would suggest to use the kernel.org website, to leave it neutral.

A moinmoin wiki.kernel.org should work fine and it takes 10 minutes to
set it up. Let's use the community to build this list. Perhaps
wiki.kernel.org could also be used to document some kernel stuff later
on.
