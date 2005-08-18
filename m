Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVHRTFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVHRTFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 15:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVHRTFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 15:05:32 -0400
Received: from ixca-out.ixiacom.com ([67.133.120.10]:56971 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S932401AbVHRTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 15:05:31 -0400
Message-ID: <4304DBFB.5010906@rincewind.tv>
Date: Thu, 18 Aug 2005 12:05:31 -0700
X-Sybari-Trust: 2be44ef6 453feeff 4098152d 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: linux-kernel@vger.kernel.org, Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv> <4303CEC5.3010502@trash.net> <43042D94.4030303@rincewind.tv> <4304D763.4090001@rincewind.tv> <4304DA99.2080205@trash.net>
In-Reply-To: <4304DA99.2080205@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

>Checking the return value of ip_append_data seems cleaner to me.
>Patch attached.
>  
>
Works for me.

Thanks,
Ollie
