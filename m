Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbUKRSQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUKRSQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbUKRSON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:14:13 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:32233 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261862AbUKRSNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:13:31 -0500
Subject: Re: X86_64: Many Lost ticks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: kernel-stuff@comcast.net
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100797816.6019.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 17:10:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 17:02, kernel-stuff@comcast.net wrote:
> I tried all the newer kernels including -ac. All have the same problem.
> 
> Andi -  On a side note, your change  "NVidia ACPI timer override" present in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a unusual power management setup?") and DMA timeouts - happens regularly.

Ok ACPI timer override probably goes back into the broken bucket and out
of -ac in -ac11 then.

