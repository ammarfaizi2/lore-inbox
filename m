Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTIBCQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTIBCQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:16:52 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:29146 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263418AbTIBCQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:16:51 -0400
Date: Mon, 1 Sep 2003 19:16:47 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <roland@topspin.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Matt Porter <mporter@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901191647.A8701@home.com>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829103943.A18608@home.com> <20030901060040.GH748@mail.jlokier.co.uk> <52oey4ifut.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <52oey4ifut.fsf@topspin.com>; from roland@topspin.com on Mon, Sep 01, 2003 at 10:22:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:22:02AM -0700, Roland Dreier wrote:
>     Matt> PPC440GX, non cache coherent, L1 icache is VTPI, L1 dcache
>     Matt> is PTPI
> 
>     Jamie> The cache looks very coherent to me.
> 
> Matt (like me) is probably just used to thinking of the IBM PPC 440
> chips as non-coherent because they are not cache coherent with respect
> to external bus masters (eg they don't snoop the PCI bus).  Of course,
> this is a different type of coherency from what you are measuring.

Exactly.  After reading some other subthreads I see the other version of
"cache coherency" that Jamie is interested in.

-Matt
