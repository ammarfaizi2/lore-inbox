Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVDLUlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVDLUlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVDLUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:40:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58867 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262112AbVDLTSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:18:47 -0400
Message-ID: <425C1E30.5060405@mvista.com>
Date: Tue, 12 Apr 2005 12:14:56 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horms <horms@verge.net.au>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, netdev@oss.sgi.com,
       Mike Phillips <mikep@linuxtr.net>, Philip Blundell <philb@gnu.org>,
       David Dillow <dave@thedillows.org>,
       Paul Gortmaker <p_gortmaker@yahoo.com>,
       Mike McLagan <mike.mclagan@linux.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jan-Pascal van Best <jvbest@qv3pluto.leidenuniv.nl>,
       Andreas Mohr <100.30936@germany.net>,
       p2@ace.ulyssis.student.kuleuven.ac.be,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Daniele Venzano <venza@brownhat.org>, Jay Schulist <jschlst@samba.org>
Subject: Re: [PATCH] Maintainers list update: linux-net -> netdev
References: <20050412062027.GA1614@verge.net.au>
In-Reply-To: <20050412062027.GA1614@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:
> On Sat, Apr 09, 2005 at 03:52:05PM +0200, Jörn Engel wrote:
> 
>>On Fri, 8 April 2005 22:16:07 +0200, Pavel Machek wrote:
>>
>>>More importantly, it is still listed as "the list" for network
>>>drivers...
>>>
>>>NETWORK DEVICE DRIVERS
>>>P:      Andrew Morton
>>>M:      akpm@osdl.org
>>>P:      Jeff Garzik
>>>M:      jgarzik@pobox.com
>>>L:      linux-net@vger.kernel.org
>>>S:      Maintained
>>
>>Maybe one of the two maintainers might want to change that? ;)
> 
> 
> Use netdev as the mailing list contact instead of the mostly dead
> linux-net list.
> 
~
>  PHRAM MTD DRIVER
> @@ -1795,7 +1795,7 @@
>  POSIX CLOCKS and TIMERS
>  P:	George Anzinger
>  M:	george@mvista.com
> -L:	linux-net@vger.kernel.org
> +L:	netdev@oss.sgi.com
>  S:	Supported
>  
I don't really know about the rest of them, but I think this should be:
L: linux-kernel@vger.kernel.org

Least wise that is where I look...
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
