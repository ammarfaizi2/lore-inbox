Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUHCQbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUHCQbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUHCQbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:31:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63642 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266705AbUHCQal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:30:41 -0400
Date: Tue, 3 Aug 2004 12:29:54 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Shane Shrybman <shrybman@aei.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
In-Reply-To: <1091544359.2318.1.camel@mars>
Message-ID: <Pine.LNX.4.58.0408031229210.7783@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars>  <Pine.LNX.4.58.0408030517310.21280@devserv.devel.redhat.com>
  <1091541932.2254.3.camel@mars>  <Pine.LNX.4.58.0408031009040.12823@devserv.devel.redhat.com>
 <1091544359.2318.1.camel@mars>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Aug 2004, Shane Shrybman wrote:

> > > Nope, didn't boot with either voluntary-preempt=1 or 2 on the boot
> > > command line. Booting stopped at the scsi controller again.
> > > 
> > > It did boot with just acpi=off.
> > 
> > does the non-patched kernel boot?
> > 
> 
> I am in vanilla 2.6.8-rc2 now and it seems to be fine.

does it boot fine with the patch applied but the APIC turned off in the 
.config?

	Ingo
