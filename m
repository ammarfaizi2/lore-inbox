Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCPTUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCPTUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 14:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVCPTUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 14:20:22 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:59617 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261362AbVCPTUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 14:20:02 -0500
Date: Wed, 16 Mar 2005 12:20:29 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nathan Lynch <ntl@pobox.com>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, rusty@rustcorp.com.au
Subject: Re: CPU hotplug on i386
In-Reply-To: <20050316170945.GK21853@otto>
Message-ID: <Pine.LNX.4.61.0503161220130.19938@montezuma.fsmlabs.com>
References: <20050316132151.GA2227@elf.ucw.cz> <20050316170945.GK21853@otto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Nathan Lynch wrote:

> On Wed, Mar 16, 2005 at 02:21:52PM +0100, Pavel Machek wrote:
>
> > I tried to solve long-standing uglyness in swsusp cmp code by calling
> > cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> > available on i386. Is there way to enable CPU_HOTPLUG on i386?
> 
> i386 cpu hotplug has been in -mm for a while.  Don't know when (if
> ever) it will get merged.

Well this is a good user =)
