Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758037AbWK1Xic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758037AbWK1Xic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758016AbWK1Xic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:38:32 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:38611 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758007AbWK1Xib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:38:31 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <20061128143321.2abf40b5.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <1164747894.3769.77.camel@dyn9047017103.beaverton.ibm.com>
	 <20061128143321.2abf40b5.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 15:38:25 -0800
Message-Id: <1164757106.6538.17.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 14:33 -0800, Andrew Morton wrote: 
> On Tue, 28 Nov 2006 13:04:53 -0800
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > Thanks, I have acked most of them, and will port them to ext3/4 soon.
> 
> You've acked #2 and #3.  #4, #5 and #6 remain un-commented-upon and #1 is
> unclear?

sorry, just acked #4, #5 and #6. I mean to do that before I said so but
they did not go out of my outbox till now ( I was out for a few hours).

#1 looks correct to me now, just thought there are other issues. I will
comment on that one in that thread.


Mingming

