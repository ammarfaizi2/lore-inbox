Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVAIOPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVAIOPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 09:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVAIOPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 09:15:48 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:27297 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261425AbVAIOPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 09:15:44 -0500
Message-ID: <41E13C87.3050306@ens-lyon.fr>
Date: Sun, 09 Jan 2005 15:15:35 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Benoit Boissinot <bboissin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mike Werner <werner@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org>	 <40f323d005010701395a2f8d00@mail.gmail.com>	 <21d7e99705010718435695f837@mail.gmail.com>	 <40f323d00501080427f881c68@mail.gmail.com>	 <21d7e99705010805487322533e@mail.gmail.com>	 <40f323d0050108074112ae4ac7@mail.gmail.com>	 <21d7e99705010817386f55e836@mail.gmail.com> <40f323d005010906093ba08ba4@mail.gmail.com>
In-Reply-To: <40f323d005010906093ba08ba4@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>If you could apply the patch I've attached (just adds some debug...)
>>it'll narrow it down a small bit where it is failing for me...
>>
> 
> A dmesg from a boot with the patch applied is attached.
> 
> just in case it matters, i use the following boot command line options :
> video=vesa:mtrr vga=0x317

I'm seeing "agp_backend_acquire failed on atomic read" too.
No command line options here.

Regards
Brice
