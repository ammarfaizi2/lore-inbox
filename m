Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVADMjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVADMjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 07:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVADMjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 07:39:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261489AbVADMiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 07:38:18 -0500
Date: Tue, 4 Jan 2005 07:36:51 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Felipe Alfaro Solana <lkml@mac.com>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Adrian Bunk <bunk@stusta.de>, Willy Tarreau <willy@w.ods.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: starting with 2.7
In-Reply-To: <9F909072-5E3A-11D9-A816-000D9352858E@mac.com>
Message-ID: <Pine.LNX.4.61.0501040735410.25392@chimarrao.boston.redhat.com>
References: <200501032059.j03KxOEB004666@laptop11.inf.utfsm.cl>
 <0F9DCB4E-5DD1-11D9-892B-000D9352858E@mac.com>
 <Pine.LNX.4.61.0501031648300.25392@chimarrao.boston.redhat.com>
 <5B2E0ED4-5DD3-11D9-892B-000D9352858E@mac.com> <20050103221441.GA26732@infradead.org>
 <20050104054649.GC7048@alpha.home.local> <20050104063622.GB26051@parcelfarce.linux.theplanet.co.uk>
 <9F909072-5E3A-11D9-A816-000D9352858E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Felipe Alfaro Solana wrote:

> I don't pretend that kernel interfaces stay written in stone, for ages. What 
> I would like is that, at least, those interfaces were stable enough, let's 
> say for a few months for a stable kernel series, so I don't have to keep 
> bothering my propietary VMWare vendor to fix the problems for me, since the

How much work are you willing to do to make this happen ? ;)

It would be easy enough for you to take 2.6.9 and add only
security fixes and critical bugfixes to it for the next 6
months - that would give your binary vendors a stable
source base to work with...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
