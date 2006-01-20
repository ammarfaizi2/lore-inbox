Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWATKCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWATKCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWATKCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:02:52 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:19423 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750765AbWATKCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:02:51 -0500
Message-ID: <43D0B4F5.30807@cosmosbay.com>
Date: Fri, 20 Jan 2006 11:01:25 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, axboe@suse.de, alan@lxorguk.ukuu.org.uk,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch	removed
 from -mm tree
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>	 <1137648119.30084.94.camel@localhost.localdomain>	 <20060119171708.7f856b42.sfr@canb.auug.org.au>	 <1137664692.8471.21.camel@localhost.localdomain>	 <20060119155933.GX4213@suse.de>	 <1137745995.30084.201.camel@localhost.localdomain>	 <20060120004456.190f451b.akpm@osdl.org> <1137747595.30084.215.camel@localhost.localdomain>
In-Reply-To: <1137747595.30084.215.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 20 Jan 2006 11:01:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse a écrit :
> On Fri, 2006-01-20 at 00:44 -0800, Andrew Morton wrote:
>> Oh crap.  The damn thing wraps into column _1_ and gets tangled up with
>> ifdef statements, function definitions and other things which _should_ go
>> in column one.
> 
> It does that only for people with editors which wrap stuff like that
> into column 1. Those people (which includes myself on some occasions)
> are _used_ to seeing stuff like that in column 1, so it's natural. And
> it's text which is of little importance; not something which has much
> relevance to the code flow.
> 
>> It .looks.  .like.  .crap.  to many other people, and saying random stupid
>> wrong things doesn't alter that very simple fact.
> 
> No, it looks like crap for _some_ people. And making it look like crap
> for _everyone_, which is what your patch does, doesn't alter that fact
> either.

David,

Some readers of linux kernel sources are blind.
They use a kind of terminal that 'displays' a single line of 80 'characters' 
(or even 40) called a 'Braille Display'

This kind of terminal is very expensive, and I think the 80 column one is the 
most you can get (price : about 7000$).

I am ok to be a litle bit upset by this 80 limitation that looks odd on my 
1000$ 24" display, but reminds me the fact that some human people are different.

So please don't count me as part of your _everyone_.

Thank you
Eric
