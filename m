Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTF1FyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 01:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTF1FyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 01:54:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27329 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264606AbTF1FyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 01:54:21 -0400
Date: Fri, 27 Jun 2003 23:08:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: bcollins@debian.org, davidel@xmailserver.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <37590000.1056780491@[10.10.2.4]>
In-Reply-To: <20030627193521.25040f3e.akpm@digeo.com>
References: <20030626.224739.88478624.davem@redhat.com><21740000.1056724453@[10.10.2.4]><Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com><20030627.143738.41641928.davem@redhat.com><Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com><20030627213153.GR501@phunnypharm.org><20030627162527.714091ce.akpm@digeo.com><35240000.1056760723@[10.10.2.4]><20030627181432.61bf6f3a.akpm@digeo.com><36630000.1056766403@[10.10.2.4]> <20030627193521.25040f3e.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If some low-value stuff leaks through then ho-hum, at least it was
> on-topic.  It is not as if we are unused to low-value content...

;-)
 
> It would be good if pure administrata such as changing the status were
> filtered.

That should be easy enough.
 
> In fact, there is probably no point in sending anything bugzilla->list apart
> from the initial report.  If the bug is then pursued via bugzilla then OK. 
> If is is pursued via email then bugzilla just captures the discussion.   

OK, but I'm pretty much doing that already. I try to filter out some of
the "bugs with no content". So it sounds like the issue is more the
loop from email back in. Will see what I can get done - have to schedule
some time from the admins.

>> 2. email back in.
>> 
>> Email back in is harder, and needs more thought as to how to make it
>> easy to use, whilst avoiding logging crap (eg. ensuing flamewars that 
>> derive from the bug reports, etc).
> 
> Well hopefully people will have the sense to cut the bugzilla address off
> the Cc line if it drifts off-topic.

Fairy nuff.
 
>> My intuition is to log replies by
>> default, and hack off certain threads by hand
> 
> Nah.  Just log everything and hack off the crap by larting people.

Heh. need to get a good "remote slap protocol" implemented. Perhaps
the net guys can write us an RFC for it ;-)

M.

