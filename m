Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271522AbRHUERh>; Tue, 21 Aug 2001 00:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271526AbRHUER2>; Tue, 21 Aug 2001 00:17:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:39961 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271522AbRHUERL>; Tue, 21 Aug 2001 00:17:11 -0400
Date: Tue, 21 Aug 2001 00:17:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for bizzare oops in USB
Message-ID: <20010821001725.A9402@devserv.devel.redhat.com>
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com> <3B80FBA9.556B7B2B@scs.ch> <20010820174448.A1299@devserv.devel.redhat.com> <20010821000125.A28638@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010821000125.A28638@sventech.com>; from johannes@erdfelt.com on Tue, Aug 21, 2001 at 12:01:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 21 Aug 2001 00:01:26 -0400
> From: Johannes Erdfelt <johannes@erdfelt.com>

> I like your patch, but since we have the new completion stuff now, we
> should probably use that. I'll make the mod and send off the patch to
> Linus when I get back from this business trip.

OK, thanks. Meanwhile Alan picked my patch for 2.4.8-ac8
so I'll make a revert for him when you have the time and
Linus picks your fix.

-- Pete
