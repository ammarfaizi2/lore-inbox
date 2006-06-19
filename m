Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWFSRVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWFSRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWFSRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:21:16 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:64141 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S964818AbWFSRVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:21:15 -0400
Message-ID: <4496DCFA.7090106@att.net.mx>
Date: Mon, 19 Jun 2006 12:20:58 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.17-ck1
References: <200606181736.38768.kernel@kolivas.org>
In-Reply-To: <200606181736.38768.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> These are patches designed to improve system responsiveness and interactivity. 
> It is configurable to any workload but the default ck patch is aimed at the 
> desktop and cks is available with more emphasis on serverspace.
>
> Apply to 2.6.17
> http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.17/2.6.17-ck1/patch-2.6.17-ck1.bz2
>
> or server version
> http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.17-cks1.bz2
>
> web:
> http://kernel.kolivas.org
>
> all patches:
> http://www.kernel.org/pub/linux/kernel/people/ck/patches/
>
> Split patches available.
>
> Full patchlist:
>
>   
<snip>

Thanks Con.
Good news: 2.6.17 has support for the Winbond W83687thf sensor chip. One 
patch less for me.
Bad news: now nvidia  7167 no longer compiles:
*Unknown symbol pm_unregister

Regards,

Hugo

*


