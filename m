Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269449AbUJFUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269449AbUJFUDW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUJFUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:03:20 -0400
Received: from bos-gate1.raytheon.com ([199.46.198.230]:50055 "EHLO
	bos-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S269439AbUJFUCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:02:32 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF57A902F3.999F14FA-ON86256F25.006D1FB5@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Wed, 6 Oct 2004 15:01:14 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/06/2004 03:01:23 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Meanwhile, I'm stuck with 2.6.9-rc2-mm4-S7 (SMP), but happy.
>
>Strange thing is, that on my laptop, 2.6.9-rc3-mm2-S9 (UP) is doing just
>fine. Guess that ohci_hcd now makes the difference here, against the
>former which makes uhci_hcd bad behaved atm.

I am having similar problems with -T1 and separately reported problems with
a build of rc3-mm1-S8 as well (no oops, but the USB mouse is dead).
Somewhere between those two versions (rc2-mm4-S7 and rc3-mm1-S8) is where
the problem appears to be introduced. For now I'll stay with my working -S0
kernel.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

