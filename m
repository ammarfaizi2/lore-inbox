Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUBLTbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUBLTbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:31:06 -0500
Received: from a213-22-30-241.netcabo.pt ([213.22.30.241]:21397 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S266545AbUBLTa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:30:28 -0500
Message-ID: <38221.213.22.30.241.1076614226.squirrel@webmail.r3pek.homelinux.org>
In-Reply-To: <402BA5BD.9070307@reactivated.net>
References: <200402120122.06362.ross@datscreative.com.au>
    <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
    <402BA5BD.9070307@reactivated.net>
Date: Thu, 12 Feb 2004 19:30:26 -0000 (WET)
Subject: Re: [PATCH] 2.6, 2.4, Nforce2,
      Experimental idle halt workaroundinstead of apic ack delay.
From: "Carlos Silva" <r3pek@r3pek.homelinux.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you have one of those systems to hand? My betting is on that when you
> enable APIC/IOAPIC you will see crashes very frequently. This isn't
> enabled in
> the default kernel config..

well... i'm runnig an Asus A7N8X with the nForce2 chipset and APIC and
IO-APIC enabled. I don't have any problems at all, my machine is on 24/7.
i'm running kernel 2.6.2-gentoo, but none of the paches applyed to the
kernel is about APIC.
