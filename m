Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVFNWNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVFNWNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFNWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:13:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61616 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261374AbVFNWN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:13:27 -0400
Date: Tue, 14 Jun 2005 15:13:16 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: Re: [PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050614221316.GA6379@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com> <20050614034655.GA4180@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614034655.GA4180@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2005 [20:46:55 -0700], Nishanth Aravamudan wrote:
> On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
> 
> Here is an update of my soft-timer rework to John's latest patches. I
> have made some major changes in this revision. I would still greatly
> appreciate any comments.

<snip>

> Overview:
> 
> 1/4: Converts the soft-timer subsystem to use timerinterval as the units
> of addition and expiration.

Sorry for the noise, but this patchset is only 2 patches long, not 4.
That's what I get for trying to re-use text :/

Thanks,
Nish
