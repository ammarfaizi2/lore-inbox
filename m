Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313334AbSDQS6X>; Wed, 17 Apr 2002 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313422AbSDQS6W>; Wed, 17 Apr 2002 14:58:22 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:45070 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S313334AbSDQS6U>; Wed, 17 Apr 2002 14:58:20 -0400
Date: Wed, 17 Apr 2002 12:56:28 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204171507300.23328-100000@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204171237010.21779-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Ingo Molnar wrote:

> 
> On Wed, 17 Apr 2002, James Bourne wrote:
> > So, the timer isn't being balanced still, others are (is there a
> > specific case in your patch for irq 0 (< 1)?  I couldn't see it but it
> > almost looks as though it's being missed..)
> 
> it's a separate bug, solved by a separate patch.
> 

Where would I find this separate patch?  Is there something I could do
some testing on?

Thanks and regards
James

> 	Ingo
> 

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


