Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbTDBHPP>; Wed, 2 Apr 2003 02:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262534AbTDBHPP>; Wed, 2 Apr 2003 02:15:15 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:4350
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262450AbTDBHPO>; Wed, 2 Apr 2003 02:15:14 -0500
Date: Wed, 2 Apr 2003 02:22:07 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jos Hulzink <josh@stack.nl>
cc: Matthew Harrell 
	<mharrell-dated-1049658915.d5a407@bittwiddlers.com>,
       Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, "" <chris@wirex.com>,
       "" <andrew.grover@intel.com>
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard
 during bootup
In-Reply-To: <200304020107.58676.josh@stack.nl>
Message-ID: <Pine.LNX.4.50.0304020221230.8773-100000@montezuma.mastecende.com>
References: <130680000.1049224849@flay> <20030401114749.A7647@figure1.int.wirex.com>
 <20030401195514.GA29214@bittwiddlers.com> <200304020107.58676.josh@stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Jos Hulzink wrote:

> The only way I can boot recent 2.5 kernels is to make sure my BIOS does 
> nothing that even smells like ACPI. The only response I got so far on the 
> lkml is "disable acpi support" and "disable apic support". The only 
> conclusion I can make is that the ACPI support in 2.5 is buggy enough to 
> prevent 2.5 to emerge into 2.6 for a long time from now, and unfortunately 
> nobody seems to care. I detected big IRQ / ACPI / APIC trouble since about  
> 2.5.44 - 2.5.53, and nothing has changed since. 
> 
> NFI, I just don't understand that a core problem that prevents me from booting 
> 2.5 kernels, is noticed by so few others that it is able to remain unfixed 
> for so long.

Can you send me a boot log and your config file? Also a bootlog from 2.4 
would be nice.

	Zwane
-- 
function.linuxpower.ca
