Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRF1Sfq>; Thu, 28 Jun 2001 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbRF1Sfg>; Thu, 28 Jun 2001 14:35:36 -0400
Received: from [142.176.139.106] ([142.176.139.106]:7172 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S261173AbRF1Sf2>;
	Thu, 28 Jun 2001 14:35:28 -0400
Date: Thu, 28 Jun 2001 15:35:25 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.5 Ooops
Message-ID: <Pine.LNX.4.21.0106281533140.1222-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting an Oops/kernel panic with kernel 2.4.5.
Here is what the panic notice says in part:

The panic notice said:

Unable to handle kernel paging request at virtual address 846ea4e6
*pde = 0
Oops: 0 0 0 0
cpu: 0
EIP: 0010:[<c024724c>]
EFLAGS: 00010286
Process ax25ipd (pid:270,stackpage=c54a700)
call trace:
CODE: 8a 40 40 25 ff 00 00 00 83 c0 02 8d 14 c5 00 00 00 00 29 c2
Kernel panic: Aiee, Killing interrupt handler!
In interrupt handler - not syncing..


Not sure what to do now other than to go back to a previous release.
Is anyone else having this problem?  Is there a solution?  Or 
maybe I haven't provided enough info..

The above is all that the Oops notice reported other than some numbers for
call trace, etc.. Its all there otherwise..

---
It's never too late to have a happy childhood.
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


