Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVCCW6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVCCW6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVCCWLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:11:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15793 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262662AbVCCWKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:10:48 -0500
Message-ID: <42278B3C.5030307@pobox.com>
Date: Thu, 03 Mar 2005 17:10:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hzhong@cisco.com
CC: "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <greg@kroah.com>,
       "'David S. Miller'" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <200503032156.AWY71165@mira-sjc5-e.cisco.com>
In-Reply-To: <200503032156.AWY71165@mira-sjc5-e.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
> The reason that I think it's important for some other person to do this job
> independently is that you are not bothered by bugfixes, which you never did
> well. :) You move on to each release as you do today, with different
> criteria, and someone else who can do the job better do so to stablize it.
> 
> In the end it's more like the old way of 2.5/2.4, but just with a shorter
> release cycle, and the "2.6 stable release maintainer" could also continue
> to pick up new 2.6.x releases to work on instead of having to be stuck on
> one tree for 2 years or ever. He can say "this is the last 2.6.12.x release
> and next I'll start 2.6.16.1", etc.
> 
> For this to happen the person has to be well-recognized and trusted by the
> community. Alan is one of the best candidates. :) Of course, I'm not sure if
> he is still interested..


I think the system we appear to have wound up with is superior:  there 
is no single 2.6.X.Y maintainer, but more a $sucker mail alias that Does 
The Right Thing.

	Jeff


