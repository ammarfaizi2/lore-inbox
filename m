Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSGWN1v>; Tue, 23 Jul 2002 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSGWN1v>; Tue, 23 Jul 2002 09:27:51 -0400
Received: from mail.MtRoyal.AB.CA ([142.109.10.24]:61631 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S318062AbSGWN1u>; Tue, 23 Jul 2002 09:27:50 -0400
Date: Tue, 23 Jul 2002 07:30:59 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
cc: James Cleverdon <jamesclv@us.ibm.com>, Alan Cox <alan@redhat.com>
Subject: Re: Summit patch for 2.4.19-rc3-ac2
In-Reply-To: <200207222121.04788.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0207230723360.25932-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, James Cleverdon wrote:

> Here's a patch for those who have been plagued by APIC errors starting around 
> -rc1-ac6.  I've submitted it to Alan, but since it has
> been affecting a number of folks, I'm also posting it here for
> your consideration and review.
> 
> This fixes the APIC receive accept errors on the two machines we have
> that were subject to it.  Let me know if it doesn't work for you.

I does work with the dell 2400.

Same config I forwarded to the list, minus the RZ1000, PIIX, CMD640, and
pcmcia bits.

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



