Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbUKRRNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUKRRNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUKRRKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:10:39 -0500
Received: from fsmlabs.com ([168.103.115.128]:6112 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262781AbUKRRJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:09:09 -0500
Date: Thu, 18 Nov 2004 10:08:50 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: kernel-stuff@comcast.net
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: X86_64: Many Lost ticks
In-Reply-To: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
Message-ID: <Pine.LNX.4.61.0411181007530.7181@musoma.fsmlabs.com>
References: <111820041702.27846.419CD5AD000313A800006CC6220588448400009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 kernel-stuff@comcast.net wrote:

> I tried all the newer kernels including -ac. All have the same problem.
> 
> Andi - On a side note, your change "NVidia ACPI timer override" present 
> in 2.6.9-ac8 breaks on my laptop - I get some NMI errors ("Do you have a 
> unusual power management setup?") and DMA timeouts - happens regularly.

Interesting, could you send your dmesg, from booting with the 'debug' 
kernel parameter. Also the output from dmidecode and lspci would be nice.

Thanks,
	Zwane

