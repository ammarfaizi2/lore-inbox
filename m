Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755161AbWKMPvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbWKMPvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbWKMPvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:51:12 -0500
Received: from ref.nmedia.net ([66.39.177.2]:20776 "EHLO ref.nmedia.net")
	by vger.kernel.org with ESMTP id S1755161AbWKMPvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:51:11 -0500
Date: Mon, 13 Nov 2006 07:51:09 -0800 (PST)
From: Shaun Q <shaun@c-think.com>
X-X-Sender: shaun@ref.nmedia.net
To: Mark Lord <lkml@rtr.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
In-Reply-To: <455884B9.5020106@rtr.ca>
Message-ID: <Pine.BSO.4.64.0611130749530.21533@ref.nmedia.net>
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
 <455884B9.5020106@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Nov 2006, Mark Lord wrote:

> Shaun Q wrote:
>> Hi there everyone --
>> 
>> I'm trying to build a custom kernel for using both cores of my new Core2Duo 
>> E6600 processor...
>> 
>> I thought this was simply a matter of enabling the SMP support in the 
>> kernel .config and recompiling, but when the kernel comes back up, still 
>> only one core is detected.
>> 
>> With the default vanilla text-based SuSE 10.1 install, it does find both 
>> cores...
>> 
>> Anyone have any pointers for me on what I might be missing?
>
> CPU type is set to Pentium-4 or Pentium-M ?  (either works here).
>
I'm not getting the CPU Type options here, just the "Processor Family" 
which is set to Intel EM64T.  I think the CPU type options are only 
available if I create a 32-bit kernel instead of the 64-bit one I'm 
working on here.

Thanks!
Shaun
