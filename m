Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTGRXhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270404AbTGRXhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:37:36 -0400
Received: from holomorphy.com ([66.224.33.161]:40585 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270385AbTGRXha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:37:30 -0400
Date: Fri, 18 Jul 2003 16:53:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718235309.GR15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20030717102857.GA1855@dualathlon.random> <20030718191853.A11052@infradead.org> <20030718222750.GL3928@dualathlon.random> <20030718224824.GP15452@holomorphy.com> <20030718225328.GQ3928@dualathlon.random> <20030718230431.GQ15452@holomorphy.com> <20030718231230.GA19045@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718231230.GA19045@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 01:12:30AM +0200, Andrea Arcangeli wrote:
> so the apps will need changes and a kernel API way to know the hardware
> page size provided by hugetlbfs (though they could probe for it with
> many tries).

The hugepage size is exported in /proc/meminfo for the time being.

I think 2.7 will see something we both like better.


-- wli
