Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUHCOKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUHCOKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHCOKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:10:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265887AbUHCOKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:10:33 -0400
Date: Tue, 3 Aug 2004 10:09:43 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Shane Shrybman <shrybman@aei.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
In-Reply-To: <1091541932.2254.3.camel@mars>
Message-ID: <Pine.LNX.4.58.0408031009040.12823@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars>  <Pine.LNX.4.58.0408030517310.21280@devserv.devel.redhat.com>
 <1091541932.2254.3.camel@mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Aug 2004, Shane Shrybman wrote:

> > > I was unable to boot -O2. It seemed to hang up when it got to the
> > > aic7xxx(29160) scsi controller.
> > 
> > does it boot with voluntary-preempt=2 on the boot command line? (or with 
> > voluntary-preempt=1)?
> > 
> 
> Nope, didn't boot with either voluntary-preempt=1 or 2 on the boot
> command line. Booting stopped at the scsi controller again.
> 
> It did boot with just acpi=off.

does the non-patched kernel boot?

	Ingo
