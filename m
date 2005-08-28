Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVH1UpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVH1UpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVH1UpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:45:06 -0400
Received: from lucidpixels.com ([66.45.37.187]:18648 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750721AbVH1UpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:45:05 -0400
Date: Sun, 28 Aug 2005 16:45:04 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Patrick McFarland <pmcfarland@downeast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel/Box Freezes Under Kernel 2.6.12.5
In-Reply-To: <200508261751.11751.pmcfarland@downeast.net>
Message-ID: <Pine.LNX.4.63.0508281644360.27379@p34>
References: <Pine.LNX.4.63.0508261733400.363@p34> <200508261751.11751.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have two separate machines with the same controller and HDD.
As soon as I found out it fixed the bug on one of them, I changed it on 
the other, neither machine has crashed since.

On Fri, 26 Aug 2005, Patrick McFarland wrote:

> On Friday 26 August 2005 05:36 pm, Justin Piszcz wrote:
>> 2- ATA/133 Maxtor (ATA/Promise Controller)
>
> Make sure its actually the kernel and not that controller. Go find another
> identical one and test with it.
>
> -- 
> Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
> "Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd
> all be running around in darkened rooms, munching magic pills and listening to
> repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
>
