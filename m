Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVDMWo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVDMWo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 18:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDMWo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 18:44:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19449 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261203AbVDMWoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 18:44:21 -0400
Message-ID: <425DA053.8020607@mvista.com>
Date: Wed, 13 Apr 2005 15:42:27 -0700
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
       schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] Maintainers list update: linux-net -> netdev
References: <20050412062027.GA1614@verge.net.au> <425C1E30.5060405@mvista.com> <20050413021400.GA1835@verge.net.au>
In-Reply-To: <20050413021400.GA1835@verge.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:
> On Tue, Apr 12, 2005 at 12:14:56PM -0700, George Anzinger wrote:
> 
>>Horms wrote:
>>
>>>Use netdev as the mailing list contact instead of the mostly dead
>>>linux-net list.
>>>
>>
>>~
>>
>>>PHRAM MTD DRIVER
>>>@@ -1795,7 +1795,7 @@
>>>POSIX CLOCKS and TIMERS
>>>P:	George Anzinger
>>>M:	george@mvista.com
>>>-L:	linux-net@vger.kernel.org
>>>+L:	netdev@oss.sgi.com
>>>S:	Supported
>>>
>>
>>I don't really know about the rest of them, but I think this should be:
>>L: linux-kernel@vger.kernel.org
>>
>>Least wise that is where I look...
> 
> 
> Yes, I was wondering about that one. Here is a patch that
> adds to my previous patch. Trivial to say the least. 
> I can re-diff the whole thing if that is more convenient.

Looks good to me.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
