Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314059AbSDQErM>; Wed, 17 Apr 2002 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314060AbSDQErL>; Wed, 17 Apr 2002 00:47:11 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:41225 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S314059AbSDQErK>; Wed, 17 Apr 2002 00:47:10 -0400
Date: Tue, 16 Apr 2002 22:47:07 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <2634920014.1018993422@[10.10.2.3]>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Message-id: <Pine.LNX.4.44.0204162244420.9280-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Martin J. Bligh wrote:

> > Current kernel is 2.4.18 with the LSE APIC Routing patch
> > (http://sourceforge.net/projects/lse).  2.4.18 stock (well ok, -rc4) 
> > has much the same results.
> 
> I hate to ask trivial questions, but you did read the notes that
> come with the APIC routing patch, and actually enable it, right?
> IIRC, there was something about a command line parameter needed.
> 
> just checking ...

:) I knew I should have included that in the original message, but it's
also in the dmesg output.  append"idle=poll" is there.

There may be other issues, and I need to get physical access to the system
to check (tomorrow)...  

Regards
James Bourne

> 
> M.
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

