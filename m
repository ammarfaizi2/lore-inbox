Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGAWjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGAWjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGAWjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:39:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbWGAWjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:39:12 -0400
Date: Sat, 1 Jul 2006 15:35:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: bos@pathscale.com, rdreier@cisco.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0 of 39] ipath - bug fixes, performanceenhancements,and
 portability improvements
Message-Id: <20060701153542.73ac101e.akpm@osdl.org>
In-Reply-To: <20060701194323.GB10904@mellanox.co.il>
References: <1151686831.2194.7.camel@localhost.localdomain>
	<20060701194323.GB10904@mellanox.co.il>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006 22:43:23 +0300
"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:

> Quoting r. Bryan O'Sullivan <bos@pathscale.com>:
> > Subject: Re: [PATCH 0 of 39] ipath - bug fixes, performanceenhancements,and portability improvements
> > 
> > On Fri, 2006-06-30 at 19:31 +0300, Michael S. Tsirkin wrote:
> > 
> > > OK, next week I'll put these into my tree, too.
> > 
> > Thanks.  The first 37 are in -mm; the last two you can drop until I sort
> > them out.
> 
> What about patch 28?
> 

I sent 1-27,29-37 to Linus and he has merged them.  But I held #28 back based on
Roland's concerns.
