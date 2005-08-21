Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVHUEo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVHUEo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVHUEo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:44:57 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:12589 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750795AbVHUEo5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:44:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g2CBaopYrsAp0vUbQolS29YubaHdGlpYkTE2FAt4M0QrQcCdXUHh6bdDQm900KKzKNKXmdKKjMv74NJYUAtUh9oaBR/o2NWCYuVvwXw77iArsyqxp7IgRxWutb4fVRD1QJ+JHTBdWd99zOD3693DA5/bIxw9IFmmGf7R/c++vbw=
Message-ID: <6bffcb0e05082021446aeb8004@mail.gmail.com>
Date: Sun, 21 Aug 2005 06:44:51 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508211422.16850.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43001E18.8020707@bigpond.net.au>
	 <200508211147.39503.kernel@kolivas.org>
	 <6bffcb0e050820211645c31a7@mail.gmail.com>
	 <200508211422.16850.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/05, Con Kolivas <kernel@kolivas.org> wrote:
> Well it will survive all right, but eventually get into swap thrash territory
> and that's not a meaningful cpu scheduler benchmark.
> 
> Cheers,
> Con
> 


Ok. How about make -j? It's one of kernbench test runs, on my box load
average > 1500 ;).

BTW I have only 1 gb ram, so high values of -j are road to hell for my system...
I'm still learning, but it's fun ;). Now I'll try your latest -ck.
Thanks for "1Gb Low Memory Support".

Regards,
Michal Piotrowski
