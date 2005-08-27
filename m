Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVH0LTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVH0LTH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 07:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbVH0LTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 07:19:07 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:1483 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S1030345AbVH0LTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 07:19:06 -0400
Date: Sat, 27 Aug 2005 15:19:05 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Danial Thom <danial_thom@yahoo.com>
Cc: Ben Greear <greearb@candelatech.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Message-ID: <20050827111904.GA6484@tentacle.sectorb.msk.ru>
References: <430D4E6D.1090200@candelatech.com> <20050825060843.15874.qmail@web33311.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20050825060843.15874.qmail@web33311.mail.mud.yahoo.com>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.11-ac7
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:08:43PM -0700, Danial Thom wrote:
> If your test is still set up, try compiling
> something large while doing the test. The drops
> go through the roof in my tests.
> 
Couldn't this happen because ksoftirqd by default 
has a nice value of 19?

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

