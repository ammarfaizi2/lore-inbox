Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbTCQSgO>; Mon, 17 Mar 2003 13:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbTCQSgO>; Mon, 17 Mar 2003 13:36:14 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:26822 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S261782AbTCQSfe>; Mon, 17 Mar 2003 13:35:34 -0500
Date: Mon, 17 Mar 2003 11:46:25 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: 2.4.20 ptrace patch
Message-ID: <Pine.LNX.4.51.0303171141010.27605@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
As per a previously stated email the patch for ptrace to 2.4.20 can
be found at http://www.hardrock.org/kernel/2.4.20/linux-2.4.20-ptrace.patch

This really only fixes the failure for the sched.h patch
to apply and removes the um tree from arch.

There of course are other minor changes (offsets etc).

It does compile on i386 and does boot.  YMMV...

Regards
James Bourne
-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

