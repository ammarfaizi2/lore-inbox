Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbULGPXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbULGPXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbULGPXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:23:33 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:140 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261834AbULGPXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:23:31 -0500
Date: Tue, 7 Dec 2004 08:22:28 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] IRQ resource deallocation[0/2]
In-Reply-To: <41B559DD.7040307@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.61.0412070820240.13396@montezuma.fsmlabs.com>
References: <41B559DD.7040307@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, Kenji Kaneshige wrote:

> I had posted the IRQ resource deallocation patch a couple of monthes
> ago and I had incorporated all feedbacks from the mailing list
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109688530703122&w=2).
> But it doesn't seems to be included yet, so I would like to try again.
> I hope my patch is included onto -mm tree since I want the patches
> be tested by many people.

You should remove the config option and make it unconditional.

Thanks,
	Zwane

