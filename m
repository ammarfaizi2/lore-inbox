Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTKKK5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 05:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTKKK5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 05:57:44 -0500
Received: from intra.cyclades.com ([64.186.161.6]:4825 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263244AbTKKK5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 05:57:43 -0500
Date: Tue, 11 Nov 2003 08:46:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Shane Wegner <shane-dated-1071003928.b2036e@cm.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
In-Reply-To: <20031109210527.GA1936@cm.nu>
Message-ID: <Pine.LNX.4.44.0311110846100.14144-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Nov 2003, Shane Wegner wrote:

> Hi,
> 
> I posted some weeks ago regarding a crash I was
> experiencing with 2.4.23-pre4.  I am just writing to
> confirm that 2.4.23-pre9 is still unable to run relyably on
> this machine.  In my earlier post, I thought acpi might be
> the culprit as I had it enabled due to a bios bug.  Intel
> since fixed that so I was able to boot 2.4.23-pre9 with
> acpi totally disabled in make config.
> 
> The problem is that after some time, usually between 30
> seconds and 15 minutes in, the system locks up.  Nothing
> gets printed into the kernel logs or onto the console. 
> After 60 seconds, the IPMI watchdog kicks in and reboots
> the system.  I run Linux 2.4.22 over here with no problems
> with and without acpi.
> 
> It's an Intel server board model SDS2 with a dual Pentium
> III tualatin 1.13ghz.  I am attaching the dmesg output from
> the kernel in case it is helpful but as there is no panics
> or oops being printed, I am not sure how best I can help
> track this down.  If there is anything further I can do or
> any other information needed, let me know.

Shane, 

Can you please find out in which -pre these strange lockups started happening?

Thank you

