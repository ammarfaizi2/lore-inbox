Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVKWU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVKWU3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVKWU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:28:39 -0500
Received: from cantor.suse.de ([195.135.220.2]:23950 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932356AbVKWU2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:28:21 -0500
Date: Wed, 23 Nov 2005 21:28:19 +0100
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: Stefan Reinauer <stepan@openbios.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linuxbios@openbios.org,
       yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [LinuxBIOS] x86_64: apic id lift patch
Message-ID: <20051123202819.GO20775@brahms.suse.de>
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de> <43849FA5.4020201@lanl.gov> <2ea3fae10511230919l4d9829d8j3ce5d820b74074d1@mail.gmail.com> <20051123173636.GL20775@brahms.suse.de> <2ea3fae10511230940t1f6a1757lf885a2559be6f0dc@mail.gmail.com> <20051123181804.GC27398@openbios.org> <2ea3fae10511231022g3a690870qf4564b085c24cb20@mail.gmail.com> <2ea3fae10511231035y5466a793y829688f5532ad32e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae10511231035y5466a793y829688f5532ad32e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:35:19AM -0800, yhlu wrote:
> it doesn't work. At that case must disable the apci in kernel...(acpi=off)

Shouldn't be very hard to fix in the kernel though 
(to use only SRAT and nothing else of ACPI). I can look 
into it if nobody beats me to it

-Andi
