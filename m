Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267628AbUH0UcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267628AbUH0UcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUH0UcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:32:09 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:64548 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267603AbUH0Uas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:30:48 -0400
Message-ID: <4ef5fec604082713307d1b312@mail.gmail.com>
Date: Fri, 27 Aug 2004 13:30:45 -0700
From: Martin Peck <coderman@gmail.com>
Reply-To: Martin Peck <coderman@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: faster via/centaur hw rng throughput patch for 2.6.8.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412F87D8.6020009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4ef5fec604082711523b3935f9@mail.gmail.com> <412F87D8.6020009@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 15:13:28 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Honestly I would rather just remove the VIA support from the kernel
> completely:  it belongs in the userspace rngd

this sounds like a better solution to me as well.  is there anything
that uses /dev/hwrandom which might be affected?


> I've been meaning to do this for a while, wanna volunteer?  ;-)

i can poke at it; be careful what you wish for!
