Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbRHAPxr>; Wed, 1 Aug 2001 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266579AbRHAPx1>; Wed, 1 Aug 2001 11:53:27 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:36247 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266400AbRHAPxS>;
	Wed, 1 Aug 2001 11:53:18 -0400
Message-ID: <3B682593.AB3D143C@candelatech.com>
Date: Wed, 01 Aug 2001 08:51:47 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Thomas Zehetbauer <thomasz@hostmaster.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tulip driver still broken
In-Reply-To: <20010731001907.A21982@hostmaster.org> <3B66B13B.28BD0324@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> Thomas Zehetbauer wrote:
> >
> > My genuine digital network interface card ceased to work with the tulip
> > driver contained in kernel revisions >= 2.4.4 and the development driver from
> > sourceforge.net.
> 
> How is the sourceforge driver different than the one at www.scyld.com?
> 

Becker (Scyld) has only recently gotten his drivers to even compile
on 2.4 kernel, and they are still beta quality for 2.4, evidently.

There seem to be attempts to keep the drivers in sync, functionally,
but the architectures have diverged quite a lot...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
