Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162267AbWKPCvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162267AbWKPCvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162258AbWKPCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:51:32 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:23718 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1162256AbWKPCvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:51:19 -0500
Message-ID: <455BD219.8080104@lwfinger.net>
Date: Wed, 15 Nov 2006 20:51:05 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Ray Lee <ray-lk@madrabbit.org>
CC: Michael Buesch <mb@bu3sch.de>, Bcm43xx-dev@lists.berlios.de,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <200611152015.07844.mb@bu3sch.de> <455B6D74.2020507@madrabbit.org>
In-Reply-To: <455B6D74.2020507@madrabbit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee wrote:
> Michael Buesch wrote:
>> On Wednesday 15 November 2006 20:01, Ray Lee wrote:
>>> Suggestions? Requests for <shudder> even more info?
>> Yeah, enable bcm43xx debugging.
> 
> Sigh, didn't even think to look for that. Okay, enabled and compiling a new
> kernel. This will take a few days to trigger, if the pattern holds, so in the
> meantime, any *other* thoughts?
> 

Which chip and revision do you have? Send me your equivalent of the line "bcm43xx: Chip ID 0x4306, 
rev 0x2".

Thanks,

Larry


