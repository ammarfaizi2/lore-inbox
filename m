Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVACWNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVACWNu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVACWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:13:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261944AbVACWLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:11:55 -0500
Date: Mon, 3 Jan 2005 17:10:35 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Felipe Alfaro Solana <lkml@mac.com>
cc: linux-kernel@vger.kernel.org, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
In-Reply-To: <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com>
Message-ID: <Pine.LNX.4.61.0501031708020.25392@chimarrao.boston.redhat.com>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
 <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com>
 <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com>
 <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Felipe Alfaro Solana wrote:
> On 3 Jan 2005, at 22:48, Rik van Riel wrote:
>> On Mon, 3 Jan 2005, Felipe Alfaro Solana wrote:

>>> Unfortunately, you can't force the entire hardware industry to open up 
>>> their drivers.
>> 
>> That's ok.  I don't have to buy that hardware.
>
> Gosh! I bought an ATI video card, I bought a VMware license, etc.... I 
> want to keep using them.

That's your choice, and you (and your vendors) will have to
deal with the issues.  I don't see why we should hold back
the development of Linux for it...

> Changing a "stable" kernel will continuously annoy users and vendors.

On the other hand, not having a feature users need available
in a stable kernel also annoys users and vendors.  During the
2.4 days this lead to every distribution needing to do a bunch
of backports from the 2.5 kernel, and the availability of 2.4
kernels with every possible subset of 2.5 features - but none
with all the features.  Arguably, that is a much worse situation
for users and vendors than a faster-changing 2.6 tree, where at
least everybody is using the same tree.

You can't have your cake and eat it, too.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
