Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285557AbRLNW3T>; Fri, 14 Dec 2001 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285558AbRLNW3K>; Fri, 14 Dec 2001 17:29:10 -0500
Received: from mail.vasoftware.com ([198.186.202.175]:4837 "EHLO
	mail.vasoftware.com") by vger.kernel.org with ESMTP
	id <S285556AbRLNW2y>; Fri, 14 Dec 2001 17:28:54 -0500
Date: Fri, 14 Dec 2001 14:30:38 -0800 (PST)
From: Amy Abascal-Turner <amy@vasoftware.com>
To: <linux-kernel@vger.kernel.org>
cc: Josh Neal <jneal@vasoftware.com>
Subject: TLB IPI Wait Errors & APIC interrupt handling
Message-ID: <Pine.LNX.4.30.0112141420380.22243-100000@beefcake.hdqt.vasoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

VA Linux (Software) is in dire need of some kernel help.
If you know anything about TLB IPI and/or APIC interrupt
handling, we will gladly pay well for your expertise and
time.  We need the help on a very short timeline.

A brief description of the problem is below.  Please email
me or call me at 408-621-7054 (or the number below) if you
can help or would like further details.

Thanks!

Amy
--
Amy Abascal-Turner                   510-687-6741
Sr. Mgr. Product Support       amy@vasoftware.com
VA SOFTWARE CORP.       http://www.vasoftware.com
-------------------------------------------------

Brief History

A scientific computing cluster of 600 VA 1220s has been
experiencing various problems under heavy loading
conditions under production scenarios.  VA engineers have
been dedicated to identifying and solving these problems
and although the situation has vastly improved, it is
still not completely resolved.  The primary issue
remaining is random rebooting in SMP mode contributing to
instability as a cluster.

Technical Problems

Random Reboots:
"TLB IPI Wait" errors, possibly indicative of kernel
deadlock.  This will require kernel-development expertise
to resolve.

Reboots possibly indicative of APIC interrupt handling
which will require kernel development expertise to
resolve.

Internal Clock Skew:  resolved on by replacing motherboard
on most nodes experiencing problem.  Suspect that some
clock problems are side-effects of the APIC/TLB issues
noted.

Resolution

In order to resolve the Reboot / TLB/IPI issues, the
expertise of a kernel developer is required.  We are
currently identifying resources to contract with to
analyze the problem(s) and implement a solution.


