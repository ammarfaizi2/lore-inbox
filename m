Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUJFNfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUJFNfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUJFNft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:35:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:11392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269176AbUJFNf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:35:28 -0400
Date: Wed, 6 Oct 2004 09:34:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 'C' calling convention change.
In-Reply-To: <1097068610.2812.19.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.61.0410060932200.13111@chaos.analogic.com>
References: <Pine.LNX.4.61.0410060816430.3420@chaos.analogic.com>
 <1097068610.2812.19.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I'm trying to port some drivers. I thought those were
kernel thingies. Also, the kernel is so connected  with gcc-isms
that it's kinda important.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5570.56 BogoMips).
             Note 96.31% of all statistics are fiction.


On Wed, 6 Oct 2004, Arjan van de Ven wrote:

> On Wed, 2004-10-06 at 14:20, Richard B. Johnson wrote:
>> The new Red Hat Fedora release uses the following gcc version:
>>
>>  	gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)
>>
>> I have many assembly-language routines that need to interface with
>> 'C' code. The new 'C' compiler is doing something different than
>> gcc 3.2, previously used.
>
> I assume you're talking about userspace code here. Why are you bringing
> that up on the kernel list?
> The gcc list or even a fedora(-devel) list would be far more
> appropriate.
>



