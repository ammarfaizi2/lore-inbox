Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVACPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVACPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVACPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:50:26 -0500
Received: from holomorphy.com ([207.189.100.168]:50843 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261481AbVACPuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:50:19 -0500
Date: Mon, 3 Jan 2005 07:46:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103154657.GZ29332@holomorphy.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com> <20050103153438.GF2980@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103153438.GF2980@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
>> This is especially true when you are talking about really
>> big database servers and bugs that take weeks or months
>> to trigger.

On Mon, Jan 03, 2005 at 04:34:38PM +0100, Adrian Bunk wrote:
> If at this time 2.8 was already released, the 2.8 kernel available at 
> this time will be roughly what 2.6 would have been under the current 
> development model, and 2.6 will be a rock stable kernel.
> If it was possible to get the 2.7 cycle pretty short, this would give 
> the advantages of the old development model without most of its' 
> disadvantages.

But that cannot be. Splitting the developer base is guaranteed to
reduce the amount of critical examination and testing given to both
series of kernel versions.

Also, .com's have finite horizons and slow response times; dev kernels
are almost universally beyond them. A dedicated dev kernel with a short
development cycle guarantees that the entire corporate side will be
left out of the development cycle. And this is not speculation; even
the long dev cycles do similar, or are only given attention after their
huge freezes. If they're always too late for a slow-moving dev cycle a
fast-moving dev cycle is guaranteed to outrun them completely.


-- wli
