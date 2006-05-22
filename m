Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWEVX2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWEVX2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWEVX2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:28:36 -0400
Received: from quark.didntduck.org ([69.55.226.66]:50386 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751297AbWEVX2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:28:36 -0400
Message-ID: <447249C5.6060706@didntduck.org>
Date: Mon, 22 May 2006 19:31:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [stable][patch] x86_64: fix number of ia32 syscalls
References: <200605221701_MC3-1-C081-B4B3@compuserve.com> <200605230111.18121.ak@suse.de>
In-Reply-To: <200605230111.18121.ak@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 22 May 2006 22:59, Chuck Ebbert wrote:
>> Recent discussions about whether to print a message about unimplemented
>> ia32 syscalls on x86_64 have missed the real bug: the number of ia32
>> syscalls is wrong in 2.6.16.  Fixing that kills the message.
> 
> There is already a slightly different patch for this in the FF tree.
> 

Where is the FF tree?

--
				Brian Gerst
