Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263947AbTCWWCf>; Sun, 23 Mar 2003 17:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263949AbTCWWCe>; Sun, 23 Mar 2003 17:02:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:5777 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263947AbTCWWCd>; Sun, 23 Mar 2003 17:02:33 -0500
Date: Sun, 23 Mar 2003 14:13:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>
cc: Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <1770000.1048457602@[10.10.2.4]>
In-Reply-To: <1048452882.1486.58.camel@phantasy.awol.org>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <1048452882.1486.58.camel@phantasy.awol.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The distros inherently have a conflict of interest getting changes merged
>> back into mainline ... it's time consuming to do, it provides them no real
>> benefit (they have to maintain their huge trees anyway), and it actively
>> damages the "value add" they provide.
> 
> I do not disagree.
> 
> Although, I think there is incentive to get work merged.  It _does_
> reduce maintenance.  I think you can see Red Hat merging stuff back.  I
> know my employer encourages everything I do to be done openly and get it
> merged.  Its a huge benefit to maintenance and QA to get stuff merged.

Yeah, I think it happens on the whole, despite the conflict of interest;
but frustratingly slowly. There's two sides to that equation though.
 
>> If that's people's attitude ("you should use a vendor"), then we need a 
>> 2.4-fixed tree to be run by somebody with an interest in providing 
>> critical bugfixes to the community with no distro ties. People may be
>> perfectly capable of finding, applying, and collecting their own patches,
>> but that's no reason to make it difficult.
> 
> No where above did I say "you should use a vendor"
> 
> In fact, what I did say is "I think users can and should compile their
> own kernel if they want.  And as kernel developers, we should facilitate
> that."

Right. I just think mainline should provide that facilitation role. 
If it doesn't, then if someone can gather the patches together, it'd
help a lot. Applying the patches less of a problem than finding out what
to apply ... following LKML isn't feasible for most people.
 
> I merely suggest that users should not expect anything if they go it
> there own.  They need to follow the lists and be informed.  Its like me
> assuming I can maintain my car without a mechanic and then freaking out
> when I did not hear about a service defect.  Actually, a better analogy
> may include me knowing nothing about cars, too :)

yeah, but it's more like "should we have someone list the service defects
together on a website where you can find them easily", or leave them in 
a darkened basment where the lights are out with "beware of the leapord"
stuck on the door ;-) Or should I have to service my car at the dealer?

Some people may chose the dealer ... I'd prefer the website to the 
basement ;-)

> Anyhow, what exactly are we arguing over?

Not a lot ;-)

M.

