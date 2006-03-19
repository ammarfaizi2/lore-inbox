Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWCSBoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWCSBoE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWCSBoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:44:04 -0500
Received: from adsl-67-65-19-105.dsl.austtx.swbell.net ([67.65.19.105]:26974
	"EHLO mail.es335.com") by vger.kernel.org with ESMTP
	id S1751211AbWCSBoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:44:01 -0500
Subject: Re: 2.6.16-rc6-mm2: new RDMA CM EXPORT_SYMBOL's
From: Tom Tucker <tom@opengridcomputing.com>
Reply-To: tom@opengridcomputing.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Sean Hefty <sean.hefty@intel.com>,
       linux-kernel@vger.kernel.org, Roland Dreier <rolandd@cisco.com>,
       openib-general@openib.org
In-Reply-To: <20060318172507.GC14608@stusta.de>
References: <20060318044056.350a2931.akpm@osdl.org>
	 <20060318172507.GC14608@stusta.de>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 19:44:02 -0600
Message-Id: <1142732643.8247.6.camel@bigtime.es335.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 18:25 +0100, Adrian Bunk wrote:
> On Sat, Mar 18, 2006 at 04:40:56AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc6-mm1:
> >...
> >  git-infiniband.patch
> >...
> >  git trees.
> >...
> 
> I'm not exactly happy that this tree adds tons of RDMA CM 
> EXPORT_SYMBOL's that are neither currently used nor _GPL.

I apologize in advance for my ignorance, but I don't understand how 'new
symbols' could pass the test of 'currently used'. 


> cu
> Adrian
> 

