Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVAaTtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVAaTtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVAaTr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:47:29 -0500
Received: from smtp001.bizmail.yahoo.com ([216.136.172.125]:48289 "HELO
	smtp001.bizmail.yahoo.com") by vger.kernel.org with SMTP
	id S261345AbVAaTqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:46:12 -0500
In-Reply-To: <1107172039.14782.76.camel@localhost.localdomain>
References: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com> <1107172039.14782.76.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <99dcdb1436fcc543ded830f20be17b7c@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] add AMD Geode processor support
Date: Mon, 31 Jan 2005 14:46:04 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 31, 2005, at 11:01 AM, Alan Cox wrote:

> Also you might not want to magically force settings like highmem 
> because
> you want that for multi-target kernels - Geode is a sort of odd case
> where it almost makes sense but its different enough to make me 
> dubious.

I've already taken that out.

In fact, I've decided to wait until I get the 2.6 done first, then go 
back
and properly update for 2.4.  This was just a patch that has been around
for a while, I just wanted to get it off of my plate so I could do a 
minor
update later, but I'll just wait.

Apologies for the wasted bandwidth.

Thanks.

	-- Dan

