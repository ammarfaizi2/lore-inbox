Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWELHMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWELHMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWELHMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:12:09 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:40916
	"EHLO bifrost.lang.hm") by vger.kernel.org with ESMTP
	id S1751031AbWELHMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:12:06 -0400
Date: Fri, 12 May 2006 00:12:03 -0700 (PDT)
From: David Lang <david@lang.hm>
X-X-Sender: dlang@david.lang.hm
To: linux-kernel@vger.kernel.org, rl@hellgate.ch
cc: netdev@vger.kernel.org
Subject: Re: network freeze with nforce-A939 integrated rhine card
In-Reply-To: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
Message-ID: <Pine.LNX.4.62.0605120009590.2803@qnivq.ynat.uz>
References: <Pine.LNX.4.62.0605112235170.2802@qnivq.ynat.uz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.62.0605120009592.2803@qnivq.ynat.uz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, David Lang wrote:

> I haven't had time to go back and find where is started (my prior kernel was 
> 2.6.15-rc7), but with 2.6.17-rc1/2/3/4 I've been running into a problem where 
> when transfering large amounts of data (trying to ftp a TB or so of data off 
> of the box to my new server it will run for a while (as little as 1G, as much 
> as 45G) and then the network card will shut down.

following up with earlier kernels, this problem persists back as far as 
2.6.13.

I'll do more testing tomorrow.

David Lang
