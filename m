Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWDYIIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDYIIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWDYIIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:08:19 -0400
Received: from unthought.net ([212.97.129.88]:42250 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1750711AbWDYIIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:08:18 -0400
Date: Tue, 25 Apr 2006 10:08:17 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060425080817.GQ14981@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <1143820520.8096.24.camel@lade.trondhjem.org> <20060331160426.GN9811@unthought.net> <20060403152628.GA14981@unthought.net> <1144078900.9111.41.camel@lade.trondhjem.org> <20060403154519.GB14981@unthought.net> <20060404092243.GC14981@unthought.net> <1145916203.10974.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145916203.10974.55.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 06:03:23PM -0400, Trond Myklebust wrote:
...
> 
> Sorry it has taken such a long time to get round to looking into this
> problem. Can you see if the attached patch helps in any way?

No problem.

I will test the patch 'as soon as possible', hopefully today -
unfortunately the test machine is now in pretty heavy use but I should
be able to reproduce the problem and test the patch on another system.

Will let you know.

Thanks,

-- 

 / jakob

