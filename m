Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDNWcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDNWcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVDNWcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:32:11 -0400
Received: from grunt16.ihug.co.nz ([203.109.254.56]:42144 "EHLO
	grunt16.ihug.co.nz") by vger.kernel.org with ESMTP id S261601AbVDNWbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:31:20 -0400
Date: Fri, 15 Apr 2005 10:31:15 +1200 (NZST)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost.localdomain
Reply-To: steve@perfectpc.co.nz
To: Daniel Andersen <anddan@linux-user.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 ip_conntrack: table full, dropping packet.
In-Reply-To: <425EEE05.1040703@linux-user.net>
Message-ID: <Pine.LNX.4.62.0504151026520.1199@localhost.localdomain>
References: <Pine.LNX.4.62.0504150946020.752@localhost.localdomain>
 <425EEE05.1040703@linux-user.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>
> Maybe you are thinking of a problem I'm not aware of, but have you tried 
> increasing /proc/sys/net/ipv4/ip_conntrack_max ?

Ah, just check and discover, in 2.6.8 system the number is 8184 and in the 
2.6.11.7 it is only 4088.

Will try to increase it now and see if the internet slugish disappear. 
Thanks for the tip.

>
> Daniel Andersen
>
> -- 
>
> !DSPAM:425eed864196639116776!
>
