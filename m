Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVAEVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVAEVUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVAEVUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:20:23 -0500
Received: from smtpout.mac.com ([17.250.248.45]:26826 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262593AbVAEVUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:20:03 -0500
In-Reply-To: <41DBEC44.9080104@hist.no>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl> <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com> <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com> <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org> <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk> <9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <41DBEC44.9080104@hist.no>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7868F24D-5F5F-11D9-AB48-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@stusta.de>, Willy Tarreau <willy@w.ods.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       William Lee Irwin III <wli@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Rik van Riel <riel@redhat.com>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: starting with 2.7
Date: Wed, 5 Jan 2005 22:19:23 +0100
To: Helge Hafting <helge.hafting@hist.no>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Jan 2005, at 14:31, Helge Hafting wrote:

> Felipe Alfaro Solana wrote:
>
>>
>>  I don't pretend that kernel interfaces stay written in stone, for 
>> ages. What I would like is that, at least, those interfaces were 
>> stable enough, let's say for a few months for a stable kernel series, 
>> so I don't have to keep bothering my propietary VMWare vendor to fix 
>> the problems for me, since the new kernel interface broke VMWare. 
>> Yeah, I know I could decide not to upgrade kernels in last instance, 
>> but that's not always possible.
>
> You should definitely bother your proprietary vendor all the time, 
> they will then
> see more clearly that they have to act fast _if_ they want to stay 
> proprietary.

I do bother them, but they try at its best to fix things, and they do. 
They are propietary, and neither me nor anyone can force them to change 
their minds.

>> If kernel interfaces need to be changed for whatever reason, change 
>> them in 2.7, -mm, -ac or whatever tree first, and let the community 
>> know beforehand what those changes will be, and be prepared to adapt. 
>> Meanwhile, try to leave 2.6 as stable as possible.
>
> Do you follow -mm, -ac, and friends closely?  Most changes do happen 
> in -mm first.
> So you have time, all the way up to the next release.  Use that time 
> to bug your
> vendor about the imminent change.  There seems to be weeks between 
> releases
> now, plenty of time for a vendor to stay up-to-date.

I try to follow -mm releases closely, but as someone said, the 
ChangeLog is extremely dense for me to try to understand what's going 
on deeply.

