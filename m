Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbTCQSNG>; Mon, 17 Mar 2003 13:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261832AbTCQSNG>; Mon, 17 Mar 2003 13:13:06 -0500
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:21943 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S261831AbTCQSNF>; Mon, 17 Mar 2003 13:13:05 -0500
Date: Mon, 17 Mar 2003 11:23:54 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: re: Ptrace hole / Linux 2.2.25
In-Reply-To: <20030317182040.GA2145@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.51.0303171122220.27605@skuld.mtroyal.ab.ca>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>
 <1047923841.1600.3.camel@laptop.fenrus.com> <20030317182040.GA2145@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003, Tomas Szepe wrote:

> > [arjanv@redhat.com]
> > 
> > I've attached a patch against 2.4.21pre5.
> 
> So what happens now?
> 
> Is this critical enough for 2.4.21 to go out?  Or can it wait like
> some other fairly serious stuff such as the ext3 fixes?  What about
> the current state of IDE?
> 
> Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> or 2.4.20.1 with only the critical stuff applied?

FYI, I am currently testing Alans patch (cleaned up, the original does not
patch cleanly) against 2.4.20 proper.

I can make this available if requested once I know it compiles and boots...

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

