Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTHZW6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTHZW6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:58:42 -0400
Received: from vlan303.hsrp.wa.iinet.net.au ([203.59.3.46]:8101 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262905AbTHZW6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:58:41 -0400
Subject: Re: Problems with PCMCIA (Texas Instruments PCI1410)
From: Sven Dowideit <svenud@ozemail.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Tom Marshall <tommy@home.tig-grr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030826152022.A28810@flint.arm.linux.org.uk>
References: <20030813205037.GA11977@home.tig-grr.com>
	 <20030813221254.H20676@flint.arm.linux.org.uk>
	 <20030813212610.GA12315@home.tig-grr.com>
	 <20030826140541.GA691@home.tig-grr.com>
	 <20030826152022.A28810@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1061974394.551.4.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 18:53:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 00:20, Russell King wrote:
> I'm waiting for more people to send me problem reports.  Currently, it
> looks like PCI1410 and OZ6912 cardbus controllers, and one VG469 ISA
> PCMCIA controller are affected.
> 
> If there's anyone who has found this problem and hasn't reported it, it
> would be most useful if they could put together a report (containing the
> requested information.) so we get more datapoints.
> 
> Someone else mentioned that the problem occurred (iirc) sometime between
> 2.5.70 and 2.5.75, which is when the bulk of the major pcmcia changes
> went in... so it isn't that useful.
yep, thats me :) thought i have a PCI1450 (as i think the other reports
from Thinkpad t21 are..)
> 
> Also note that I'm unable to reproduce the problem on either my ARM
> system containing a CL6833 Cardbus controller nor my IBM Thinkpad
> with a TI PCI1250, so I'm completely dependent on getting reports from
> the community to solve this issue.
Other than these reports, what else can we do to help? If this is
something that can ease me into some kernel debugging, where should i
look first?

cheers
Sven

