Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUACCI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 21:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUACCI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 21:08:26 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:24535 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S265878AbUACCIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 21:08:24 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.1-rc1 compile error
Date: Sat, 3 Jan 2004 13:09:10 +1100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <18PmG-40b-9@gated-at.bofh.it> <m3znd7ib1b.fsf@averell.firstfloor.org>
In-Reply-To: <m3znd7ib1b.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031309.10816.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi,

On Friday 02 January 2004 09:01, Andi Kleen wrote:
> Srihari Vijayaraghavan <harisri@bigpond.com> writes:
> > While "make bzImage", it showed these error messages:
> >   CC      arch/x86_64/kernel/io_apic.o
>
> I already submitted a patch to fix that and Linus merged it.
> Use current -bk*

Unfortunately the current -bk* would not apply cleanly. For eg, 
patch-2.6.1-rc1-bk3 does not apply to 2.6.1-rc1. Maybe when 2.6.1-rc2 is out 
I shall try it out at that time.

(BTW I have tried 2.6.1-rc1-x8664-1, and all is fine with that.)
 
> The MSI code is unfortunately quite broken and will need more
> work to really work on anything except IA32.
>
> -Andi

Thanks
Hari
harisri@bigpond.com

