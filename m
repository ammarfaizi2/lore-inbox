Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270760AbUJUPR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbUJUPR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270748AbUJUPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:17:08 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:41606 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S270760AbUJUPQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:16:09 -0400
Date: Thu, 21 Oct 2004 17:47:47 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
In-Reply-To: <20041018151053.GA23069@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0410211745150.6913@musoma.fsmlabs.com>
References: <20041001204533.GA18684@elte.hu> <20041001204642.GA18750@elte.hu>
 <20041001143332.7e3a5aba.akpm@osdl.org> <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
 <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com> <20041018151053.GA23069@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Pavel Machek wrote:

> Having real implementation of this one would be very welcome for
> suspend-to-{RAM,disk} on smp machines....

I actually started working on that already but progress got hindered by 
non technical related issues, i hope to get back to it very soon. This is 
indeed handy for P4 HT type laptops.
 
> Are there really no i386 machines whose hardware supports hotplug?

There are i386 systems which do support hardware hotplug, mostly addition 
of processors. I haven't personally worked with any but have been in 
contact with people who are interested in the code for that specific 
reason.

Regards,
	Zwane

