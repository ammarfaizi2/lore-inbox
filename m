Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSFYXBX>; Tue, 25 Jun 2002 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSFYXBX>; Tue, 25 Jun 2002 19:01:23 -0400
Received: from ip68-3-14-32.ph.ph.cox.net ([68.3.14.32]:4737 "EHLO grok.yi.org")
	by vger.kernel.org with ESMTP id <S315988AbSFYXBW>;
	Tue, 25 Jun 2002 19:01:22 -0400
Message-ID: <3D18F640.1030800@candelatech.com>
Date: Tue, 25 Jun 2002 16:01:20 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Anyone get Linux on a Shuttle SpaceWalker SS40?
References: <3D13BE09.40608@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried with a new stick of crucial 256MB DDR today, and the problem
was exactly identical, so it's probably not the memory.

I would try the latest pre-patch kernel, but I am not sure how go do about
doing that since I can't get a distro to load...

Ben


Ben Greear wrote:
> I got a cute (and very quiet) SS40 bare-bones system.  I put an
> Athlon 1.8 and 256MB DDR (Generic, Samsung chips), and a cheap Maxtor 
> 20GB HD.
> 
> RH 7.3 crashes (signal 11) in the /sbin/loader.
> 
> RH 7.2 Locks hard while transferring the image to the HD, but at least
>   it gets a little way into the install.
> 
> Mandrake 8.2  crashes (similar to RH 7.3, it appears) in the second
> stage loader.
> 
> So, I'm curious if anyone has managed to get Linux on one of these guys?
> 
> Here are the hardware specs:
> http://www.shuttle.com/english/mcs_detail_info.asp?number=174
> 
> 
> Thanks,
> Ben
> 



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


