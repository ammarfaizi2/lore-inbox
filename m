Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275915AbTHOMOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTHOMOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:14:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:29057 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275915AbTHOMOy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:14:54 -0400
Date: Fri, 15 Aug 2003 13:10:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Charles Lepple <clepple@ghz.cc>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PIT, TSC and power management [was: Re: 2.6.0-test3 "loosing ticks"]
Message-ID: <20030815121023.GC15911@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com> <1060793667.10731.1437.camel@cog.beaverton.ibm.com> <20030814171703.GA10889@mail.jlokier.co.uk> <1060882084.10732.1588.camel@cog.beaverton.ibm.com> <3F3C272E.7060702@ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3C272E.7060702@ghz.cc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Lepple wrote:
> amd76x_pm is roughly equivalent to ACPI C2 idling, but since my BIOS 
> doesn't export any C-state functionality to the kernel ACPI code, I am 
> stuck with letting amd76x_pm frob the chipset registers.

Same here.

-- Jamie
