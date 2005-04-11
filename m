Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVDKNaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVDKNaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDKNaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:30:11 -0400
Received: from terminus.zytor.com ([209.128.68.124]:24026 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261685AbVDKNaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:30:07 -0400
Message-ID: <425A7BC5.5000509@zytor.com>
Date: Mon, 11 Apr 2005 06:29:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: jayalk@intworks.biz, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH 2.6.11.7 1/1] x86 reboot: Add reboot fixup for gx1/cs5530a
References: <200504110702.j3B72hau000852@intworks.biz> <425A6AA1.3050601@zytor.com> <Pine.LNX.4.61.0504110836420.24360@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0504110836420.24360@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> Shouldn't it just be:
> 
> #define mach_reboot_fixup(x)
>                               |___ Nothing here.
> 

Dear Wrongbot,

No.

	-hpa
