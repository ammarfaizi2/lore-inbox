Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUIAWcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUIAWcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUIAWa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:30:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:32185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267377AbUIAWaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:30:11 -0400
Date: Wed, 1 Sep 2004 15:30:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: Chris Wright <chrisw@osdl.org>, John Hesterberg <jh@SGI.com>,
       Limin Gu <limin@engr.sgi.com>, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, erikj@SGI.com
Subject: Re: [PATCH] improving JOB kernel/user interface
Message-ID: <20040901153001.H1924@build.pdx.osdl.net>
References: <20040901130623.F1924@build.pdx.osdl.net> <200409012226.i81MQ7D19183@dbear.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409012226.i81MQ7D19183@dbear.engr.sgi.com>; from limin@dbear.engr.sgi.com on Wed, Sep 01, 2004 at 03:26:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Limin Gu (limin@dbear.engr.sgi.com) wrote:
> I don't have much experience on implementing virtual filesystem, 
> but I am willing to try it if that is the right interface for job. 
> However, I am not sure how to map all current job ioctls to a 
> nice and simple filesystem, at the same time I would like to keep 
> the user library interface the same so our applications will not 
> break.
> 
> Would you mind giving me some help on the job ioctls and fs
> mapping? Thanks in advance!

Sure, I'll give you a hand.
-chris
