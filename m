Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVDNWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDNWZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDNWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:25:33 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:25258 "EHLO
	bgo1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S261583AbVDNWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:25:27 -0400
Date: Fri, 15 Apr 2005 00:27:41 +0200
From: Daniel Andersen <anddan@linux-user.net>
Subject: Re: 2.6.11.7 ip_conntrack: table full, dropping packet.
In-reply-to: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Message-id: <425EEE5D.2090904@linux-user.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steve@perfectpc.co.nz wrote:
> 
> Hi,
> 
> I thought this problem has been fixed but apparently not in 2.6.11.7. Is 
> there any patch for it ? Thanks
> 
> 
> 
> Steve Kieu
> PerfectPC Ltd. Technical Division.
> Web: http://www.perfectpc.co.nz/
> Ph: 04 461 7489
> Mob: 021 137 0260
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Maybe you are thinking of a problem I'm not aware of, but have you tried 
increasing /proc/sys/net/ipv4/ip_conntrack_max ?

Daniel Andersen

-- 
