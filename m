Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUGOV4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUGOV4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266391AbUGOV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:56:18 -0400
Received: from web41114.mail.yahoo.com ([66.218.93.30]:41643 "HELO
	web41114.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266381AbUGOVzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:55:43 -0400
Message-ID: <20040715215542.94441.qmail@web41114.mail.yahoo.com>
Date: Thu, 15 Jul 2004 14:55:42 -0700 (PDT)
From: Pedro Marques <pedro_m@yahoo.com>
Subject: Re: [patch] update email address of Pedro Roque Marques
To: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, pedro_m@yahoo.com
In-Reply-To: <20040715210828.GK25633@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Adrian Bunk <bunk@fs.tum.de> wrote:

btw: i wonder if the PCBIT isdn driver is still used
by anyone. I may be a good idea to just remove it from
the kernel dist. It was never a very popular adapter.

> I tried to send a Cc of a patch in a file in the
> Linux kernel that is
> credited to Pedro Roque Marques, but the email
> bounced.
> 
> The patch below (already ACK'ed by Pedro Roque
> Marques) updates his 
> email address. It applies against both 2.4 and 2.6 .
> 
> diffstat output:
>  Documentation/isdn/CREDITS      |    2 +-
>  Documentation/isdn/README.pcbit |    2 +-
>  drivers/isdn/pcbit/callbacks.c  |    2 +-
>  drivers/isdn/pcbit/callbacks.h  |    2 +-
>  drivers/isdn/pcbit/capi.c       |    2 +-
>  drivers/isdn/pcbit/capi.h       |    2 +-
>  drivers/isdn/pcbit/drv.c        |    2 +-
>  drivers/isdn/pcbit/edss1.c      |    2 +-
>  drivers/isdn/pcbit/edss1.h      |    2 +-
>  drivers/isdn/pcbit/layer2.c     |    2 +-
>  drivers/isdn/pcbit/layer2.h     |    2 +-
>  drivers/isdn/pcbit/module.c     |    2 +-
>  drivers/isdn/pcbit/pcbit.h      |    2 +-
>  include/linux/in6.h             |    2 +-
>  include/linux/ipv6_route.h      |    2 +-
>  include/net/if_inet6.h          |    2 +-
>  include/net/ip6_fib.h           |    2 +-
>  include/net/ipv6.h              |    2 +-
>  include/net/neighbour.h         |    2 +-
>  net/core/neighbour.c            |    2 +-
>  net/ipv6/addrconf.c             |    2 +-
>  net/ipv6/af_inet6.c             |    2 +-
>  net/ipv6/datagram.c             |    2 +-
>  net/ipv6/exthdrs.c              |    2 +-
>  net/ipv6/icmp.c                 |    2 +-
>  net/ipv6/ip6_fib.c              |    2 +-
>  net/ipv6/ip6_input.c            |    2 +-
>  net/ipv6/ip6_output.c           |    2 +-
>  net/ipv6/ipv6_sockglue.c        |    2 +-
>  net/ipv6/mcast.c                |    2 +-
>  net/ipv6/ndisc.c                |    2 +-
>  net/ipv6/protocol.c             |    2 +-
>  net/ipv6/raw.c                  |    2 +-
>  net/ipv6/reassembly.c           |    2 +-
>  net/ipv6/route.c                |    2 +-
>  net/ipv6/sit.c                  |    2 +-
>  net/ipv6/tcp_ipv6.c             |    2 +-
>  net/ipv6/udp.c                  |    2 +-
>  38 files changed, 38 insertions(+), 38 deletions(-)
> 
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> ---
> linux-2.6.8-rc1-full/Documentation/isdn/CREDITS.old
> 2004-06-16 07:18:58.000000000 +0200
> +++ linux-2.6.8-rc1-full/Documentation/isdn/CREDITS
> 2004-07-15 22:33:03.000000000 +0200
> @@ -37,7 +37,7 @@
>  Andreas Kool (akool@Kool.f.EUnet.de)
>    For contribution of the isdnlog/isdnrep-tool
>  
> -Pedro Roque Marques (roque@di.fc.ul.pt)
> +Pedro Roque Marques (pedro_m@yahoo.com)
>    For lot of new ideas and the pcbit driver.
>  
>  Eberhard Moenkeberg (emoenke@gwdg.de)
> ---
>
linux-2.6.8-rc1-full/Documentation/isdn/README.pcbit.old
> 2004-06-16 07:19:52.000000000 +0200
> +++
> linux-2.6.8-rc1-full/Documentation/isdn/README.pcbit
> 2004-07-15 22:33:03.000000000 +0200
> @@ -37,4 +37,4 @@
>  regards,
>    Pedro.
>  		
> -<roque@di.fc.ul.pt>
> +<pedro_m@yahoo.com>
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.c.old
> 2004-06-16 07:18:57.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/edss1.c
> 2004-07-15 22:33:03.000000000 +0200
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/pcbit.h.old
> 2004-06-16 07:18:58.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/pcbit.h
> 2004-07-15 22:33:03.000000000 +0200
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.h.old
> 2004-06-16 07:18:58.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.h
> 2004-07-15 22:33:03.000000000 +0200
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/module.c.old
> 2004-06-16 07:19:37.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/module.c
> 2004-07-15 22:33:03.000000000 +0200
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/drv.c.old
> 2004-06-16 07:19:43.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/drv.c
> 2004-07-15 22:33:03.000000000 +0200
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.c.old
> 2004-06-16 07:19:43.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/capi.c
> 2004-07-15 22:33:03.000000000 +0200
> @@ -4,7 +4,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   * 
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
>   *
>   * This software may be used and distributed
> according to the terms of 
>   * the GNU General Public License, incorporated
> herein by reference.
> ---
> linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.c.old
> 2004-06-16 07:19:43.000000000 +0200
> +++ linux-2.6.8-rc1-full/drivers/isdn/pcbit/layer2.c
> 2004-07-15 22:33:03.000000000 +0200
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (C) 1996 Universidade de Lisboa
>   *
> - * Written by Pedro Roque Marques
> (roque@di.fc.ul.pt)
> + * Written by Pedro Roque Marques
> (pedro_m@yahoo.com)
> 
=== message truncated ===



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
