Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWKOTmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWKOTmq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWKOTmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:42:45 -0500
Received: from tapsys.com ([72.36.178.242]:3255 "EHLO tapsys.com")
	by vger.kernel.org with ESMTP id S1161145AbWKOTmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:42:44 -0500
Message-ID: <455B6D74.2020507@madrabbit.org>
Date: Wed, 15 Nov 2006 11:41:40 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Bcm43xx-dev@lists.berlios.de,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: bcm43xx regression 2.6.19rc3 -> rc5, rtnl_lock trouble?
References: <455B63EC.8070704@madrabbit.org> <200611152015.07844.mb@bu3sch.de>
In-Reply-To: <200611152015.07844.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Wednesday 15 November 2006 20:01, Ray Lee wrote:
>> Suggestions? Requests for <shudder> even more info?
> 
> Yeah, enable bcm43xx debugging.

Sigh, didn't even think to look for that. Okay, enabled and compiling a new
kernel. This will take a few days to trigger, if the pattern holds, so in the
meantime, any *other* thoughts?
