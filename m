Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262517AbRFBMOt>; Sat, 2 Jun 2001 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbRFBMO3>; Sat, 2 Jun 2001 08:14:29 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:40970 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262517AbRFBMOY>;
	Sat, 2 Jun 2001 08:14:24 -0400
Date: Sat, 2 Jun 2001 14:14:12 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Haseeb Budhani <haseeb@ipinfusion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interface "type".
Message-ID: <20010602141412.A19864@se1.cogenit.fr>
In-Reply-To: <3B14AE60.9090904@ipinfusion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B14AE60.9090904@ipinfusion.com>; from haseeb@ipinfusion.com on Wed, May 30, 2001 at 01:25:04AM -0700
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haseeb Budhani <haseeb@ipinfusion.com> ecrit :
[...]
> I have a fairly quick one: Is there an ioctl flag/call which can be used
> to find out the "type" of the interface being used ?

See net/core/dev.c:dev_ifsioc + SIOCGIFHWADDR + include/linux/if_arp.h
+ google/search?q=linux+ioctl+device+hardware+type&btnG=Google+Search
+ man ioctl_list

-- 
Ueimor
