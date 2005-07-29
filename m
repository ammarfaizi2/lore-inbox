Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVG2LrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVG2LrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVG2LrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:47:12 -0400
Received: from mail.isurf.ca ([66.154.97.68]:30117 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S262513AbVG2LrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:47:10 -0400
Message-ID: <42EA175A.4080008@staticwave.ca>
Date: Fri, 29 Jul 2005 07:47:38 -0400
From: Gabriel Devenyi <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.24
References: <200507291310.42203.kernel@kolivas.org> <42EA0EF8.2040202@staticwave.ca> <200507292127.25529.kernel@kolivas.org>
In-Reply-To: <200507292127.25529.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats correct, does it need it?

--
Gabriel Devenyi
ace@staticwave.ca

Con Kolivas wrote:
> On Fri, 29 Jul 2005 21:11, Gabriel Devenyi wrote:
> 
>>Hello Con,
>>
>>Attempting to run this on my 2.6.12-ck3s system results in the following
>>error:
>>
>>sawtooth interbench-0.24 # ./interbench
>>loops_per_ms unknown; benchmarking...
>>690936 loops_per_ms saved to file interbench.loops_per_ms
>>
>>Could not get memory or swap size
>>
>>Bug perhaps? My configuration hasn't changed since interbench 0.23 AFAIK.
> 
> 
> No swap?
> 
> Cheers,
> Con
> 
