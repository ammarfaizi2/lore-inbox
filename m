Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVACVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVACVtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVACVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:49:15 -0500
Received: from smtpout.mac.com ([17.250.248.88]:50912 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261772AbVACVsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:48:03 -0500
In-Reply-To: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Mon, 3 Jan 2005 22:47:27 +0100
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2005, at 21:59, Horst von Brand wrote:

> Felipe Alfaro Solana <lkml@mac.com> said:
>
> [...]
>
>> I would like to comment in that the issue is not exclusively targeted
>> to stability, but the ability to keep up with kernel development. For
>> example, it was pretty common for older versions of VMWare and NVidia
>> driver to break up whenever a new kernel version was released.
>
> That is the price for closed-source drivers.
>
>> I think it's a PITA for developers to rework some of the closed-source
>> code to adopt the new changes in the Linux kernel.
>
> Open up the code. Most of the changes will then be done as a matter of
> course by others.

Unfortunately, you can't force the entire hardware industry to open up 
their drivers.

