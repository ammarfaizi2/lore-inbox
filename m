Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBIWIZ>; Sat, 9 Feb 2002 17:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBIWIP>; Sat, 9 Feb 2002 17:08:15 -0500
Received: from paule.demon.co.uk ([158.152.178.86]:3588 "HELO
	paule.demon.co.uk") by vger.kernel.org with SMTP id <S288012AbSBIWII>;
	Sat, 9 Feb 2002 17:08:08 -0500
Date: Sat, 9 Feb 2002 22:08:05 +0000
From: paule@ilu.vu
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Ball <chris@void.printf.net>, linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
Message-ID: <20020209220805.A383@ilu.vu>
In-Reply-To: <20020209151533.A644@ilu.vu> <877kpmvetv.fsf@lexis.house.pkl.net>, <877kpmvetv.fsf@lexis.house.pkl.net>; <20020209160407.A1222@ilu.vu> <3C6584F3.D571C1CB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6584F3.D571C1CB@zip.com.au>; from akpm@zip.com.au on Sat, Feb 09, 2002 at 12:22:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:22:11PM -0800, Andrew Morton wrote:
> paule@ilu.vu wrote:
> > 
> > root@paule:/lib/modules/2.5.3/kernel/drivers/net# insmod 3c59x
> > Using /lib/modules/2.5.3/kernel/drivers/net/3c59x.o
> > /lib/modules/2.5.3/kernel/drivers/net/3c59x.o: unresolved symbol
> > del_timer_sync
> 
> That can't happen :)
> 

reconfigured kernel, re-made, and reconfigured rc.inet1 (under 
slackware8.0) to support multiple interfaces,
and now it's all happy! *yay* :)
(yes im being sick, and using a screen-less laptop to route
 two internal networks, but hey, it's less than 1u, and cheaper
 than a router :)

Thanks for the help,

-- 
Paul Edwards
