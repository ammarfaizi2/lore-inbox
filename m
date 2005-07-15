Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263303AbVGOOjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbVGOOjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbVGOOjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:39:48 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:60566 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263303AbVGOOh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:37:27 -0400
Date: Fri, 15 Jul 2005 08:37:21 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Andi Kleen <ak@suse.de>
cc: yhlu <yinghailu@gmail.com>, Stefan Reinauer <stepan@openbios.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
In-Reply-To: <20050715030518.GS23737@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0507150833481.7348@enigma.lanl.gov>
References: <2ea3fae10507141058c476927@mail.gmail.com>
 <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov> <20050714190929.GL23619@wotan.suse.de>
 <2ea3fae1050714194649c66d7e@mail.gmail.com> <20050715030518.GS23737@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Andi Kleen wrote:

> Only on uniprocessor machines.

Question for the AMD guys: is there a chance of getting
non-proprietary-bios ACPI tables from AMD directly? I.e. ACPI tables as
needed for power-now etc. could be released under GPL, making inclusion
into linuxbios a bit simpler.  Right now, the only ACPI table's I've seen
all bear "IF I COPY THIS PLEASE SUE ME UNDER THE DMCA" notices :-)

If such tables are available, and I'm just out of touch, I'd be very happy
to hear that; please send me a URL. 

It makes no sense at all to me that ACPI would be copyright anyone, since
they merely describe hardware, and even the OS guys might want to copy
them around from node to node in some cases. But that's the problem right
now.

ron
