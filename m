Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUFWOmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUFWOmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUFWOlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:41:25 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:27913 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265249AbUFWOj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:39:27 -0400
Message-ID: <40D99A93.8030900@techsource.com>
Date: Wed, 23 Jun 2004 10:58:27 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: Stop the Linux kernel madness
References: <A095D7F069C@vcnet.vc.cvut.cz> <20040622151236.GE20632@lug-owl.de> <20040622173215.GA6300@infradead.org> <20040622184220.GF20632@lug-owl.de>
In-Reply-To: <20040622184220.GF20632@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan-Benedict Glaw wrote:
> On Tue, 2004-06-22 18:32:15 +0100, Christoph Hellwig <hch@infradead.org>
> wrote in message <20040622173215.GA6300@infradead.org>:
> 
>>On Tue, Jun 22, 2004 at 05:12:36PM +0200, Jan-Benedict Glaw wrote:
>>
>>>Just merge the vmware modules upstream. Then, such breakage will be
>>>detected early and probably fixed without putting a lot of work into it
>>>(from your point of view).
>>
>>a) vmware modules themselves aren't under a free license
> 
> 
> That can be changed.


Whatever it is that VMware needs in the kernel can probably be 
generalized in some way that makes it useful to other things (like 
Win4Lin) and then merged into mainline.

