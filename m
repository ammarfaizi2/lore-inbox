Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUHCOqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUHCOqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUHCOqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:46:19 -0400
Received: from mail.aei.ca ([206.123.6.14]:12249 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266491AbUHCOqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:46:05 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408031009040.12823@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars>
	 <Pine.LNX.4.58.0408030517310.21280@devserv.devel.redhat.com>
	 <1091541932.2254.3.camel@mars>
	 <Pine.LNX.4.58.0408031009040.12823@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091544359.2318.1.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 10:45:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 10:09, Ingo Molnar wrote:
> On Tue, 3 Aug 2004, Shane Shrybman wrote:
> 
> > > > I was unable to boot -O2. It seemed to hang up when it got to the
> > > > aic7xxx(29160) scsi controller.
> > > 
> > > does it boot with voluntary-preempt=2 on the boot command line? (or with 
> > > voluntary-preempt=1)?
> > > 
> > 
> > Nope, didn't boot with either voluntary-preempt=1 or 2 on the boot
> > command line. Booting stopped at the scsi controller again.
> > 
> > It did boot with just acpi=off.
> 
> does the non-patched kernel boot?
> 

I am in vanilla 2.6.8-rc2 now and it seems to be fine.

> 	Ingo
> 

Regards,

Shane

