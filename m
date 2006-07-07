Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGGVmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGGVmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWGGVmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:42:10 -0400
Received: from dvhart.com ([64.146.134.43]:8877 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932305AbWGGVmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:42:09 -0400
Message-ID: <44AED530.8040802@mbligh.org>
Date: Fri, 07 Jul 2006 14:42:08 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<44AE268F.7080409@reub.net>	<20060707023518.f621bcf2.akpm@osdl.org>	<44AECEDD.201@reub.net> <20060707143854.4a8fd106.akpm@osdl.org>
In-Reply-To: <20060707143854.4a8fd106.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yikes!  Until we fix that there's no point in looking at anything else.
> 
> CONFIG_DEBUG_PAGEALLOC would nail this bug in a flash, but x86_64 doesn't
> implement the damn thing :(

I have an implementation, but there's some bug in it I never fixed. If
you want it, I'll update it  and send it out ... maybe you can spot the
bug ;-(

M.
