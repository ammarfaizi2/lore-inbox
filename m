Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263813AbTEOHj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTEOHj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:39:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63116 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263813AbTEOHjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:39:54 -0400
Date: Thu, 15 May 2003 09:52:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org
Subject: Re: [PATCH] af_netlink: netlink_proto_init has to be core_initcall
Message-ID: <20030515075237.GW15261@suse.de>
References: <20030515023550.GI6372@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515023550.GI6372@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Arnaldo Carvalho de Melo wrote:
> Hi David, 
> 
> 	Please pull from:
> 
> bk://kernel.bkbits.net/acme/net-2.5
> 
> 	Jens, this one fixes the problem you reported, thanks!

I saw your patch in this mornings BK pull, and I can happily tell you
that it works. Thanks!

-- 
Jens Axboe

