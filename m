Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSIZWMw>; Thu, 26 Sep 2002 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSIZWMw>; Thu, 26 Sep 2002 18:12:52 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:59034 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S261514AbSIZWMw>; Thu, 26 Sep 2002 18:12:52 -0400
Date: Thu, 26 Sep 2002 15:41:54 -0700
From: Matt Porter <porter@cox.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mike Anderson <andmike@us.ibm.com>,
       Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patman@us.ibm.com,
       mbellon@mvista.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926154154.A16484@home.com>
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com> <20020926174148.GB1843@beaverton.ibm.com> <3D934BE7.8010907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D934BE7.8010907@pobox.com>; from jgarzik@pobox.com on Thu, Sep 26, 2002 at 02:03:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 02:03:19PM -0400, Jeff Garzik wrote:
> Mike Anderson wrote:
> > We have had good results using the Qlogic's driver. We are currently
> > running the v6.x version with Failover tunred off on 23xx cards. We have
> > run a lot on > 4GB systems also.
> 
> 
> Has anybody put work into cleaning this driver up?
> 
> The word from kernel hackers that work on it is, they would rather write 
> a new driver than spend weeks cleaning it up :/

I added Mark Bellon to this since he has spent a lot of time working
with QLogic to get this cleaned up for the OSDL tree.  He can probably
address some specific questions.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
