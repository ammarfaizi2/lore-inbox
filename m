Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVCNXGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVCNXGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCNW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:58:31 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:42701 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262051AbVCNW54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:57:56 -0500
Message-ID: <423616CF.6060204@ens-lyon.org>
Date: Mon, 14 Mar 2005 23:57:19 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 - DRM/i915 broken
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org> <200503142330.42556.bero@arklinux.org>
In-Reply-To: <200503142330.42556.bero@arklinux.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer a écrit :
> On Monday 14 March 2005 22:54, Brice Goglin wrote:
> 
>>DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
>>It's the first -mm kernel I try on this box. I don't whether previous -mm
>>worked or not. Anyway, 2.6.11 works great.
> 
> 
> You may want to try compiling without CONFIG_4KSTACKS. I've run into (not 100% 
> reproducable) problems with i855 [and i865 is using a lot of the same code] 
> and 4K stacks before...

Thanks, but I still see my problem without 4K stacks.

Brice
