Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263940AbTCWVsk>; Sun, 23 Mar 2003 16:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263941AbTCWVsj>; Sun, 23 Mar 2003 16:48:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:47591 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263940AbTCWVse>; Sun, 23 Mar 2003 16:48:34 -0500
Date: Sun, 23 Mar 2003 13:59:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       Pavel Machek <pavel@ucw.cz>, szepe@pinerecords.com, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <1210000.1048456766@[10.10.2.4]>
In-Reply-To: <3E7E2C5C.7000905@pobox.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <3E7E2C5C.7000905@pobox.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't agree that's always been true by any means. It may currently
>> be true, but that's far from a good thing. The current state of divergance
>> the distros have from mainline 2.4 is IMHO the biggest problem Linux has
>> today.
>> 
>> The distros inherently have a conflict of interest getting changes merged
>> back into mainline ... it's time consuming to do, it provides them no real
>> benefit (they have to maintain their huge trees anyway), and it actively
>> damages the "value add" they provide.
> 
> Just to underscore Arjan's point:  non-mainline patches are very actively 
> discouraged at Red Hat.  As time progresses the maintenance cost of EACH 
> non-mainline patch increases.  Non-mainline patches do not get the 
> benefits of wide community testing, review, and feedback. Further, 
> Red Hat employees in my experience typically land patches in the community 
> _first_ -- witness my netdriver work (goes me -> Marcelo -> RH), DaveM's 
> net stack work, and Alan's -ac tree.

Right ... people seem to have taken more than I meant from this, and taken
it more personally than it was intended. I do believe there is at least
some conflict of interest ... but that doesn't mean people are controlled 
by it.

After some other side conversations, perhaps it would be useful to clarify 
that the appearance of a problem is more that we don't *see* patches getting 
submitted or accepted very often. That doesn't necessarily mean they aren't
getting submitted.

But the divergance of 2.4 is still a massive issue ... whatever the 
underlying causes are.

M.
