Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUIVS0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUIVS0g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUIVS0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:26:36 -0400
Received: from baikonur.stro.at ([213.239.196.228]:62647 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266133AbUIVS0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:26:34 -0400
Date: Wed, 22 Sep 2004 20:26:33 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, kj <kernel-janitors@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Kernel-janitors] Re: 2.6.9-rc2-kjt1 rio_linux compile error
Message-ID: <20040922182633.GD20621@stro.at>
Mail-Followup-To: Nishanth Aravamudan <nacc@us.ibm.com>,
	Adrian Bunk <bunk@fs.tum.de>, kj <kernel-janitors@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040921221307.GG4260@stro.at> <20040922112157.GB27364@fs.tum.de> <20040922162218.GB1924@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922162218.GB1924@us.ibm.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Nishanth Aravamudan wrote:

> On Wed, Sep 22, 2004 at 01:21:58PM +0200, Adrian Bunk wrote:
> > On Wed, Sep 22, 2004 at 12:13:07AM +0200, maximilian attems wrote:
> > >...
> > > added since 2.6.9-rc1-kjt1
> > >...
> > > msleep-drivers_char_rio_linux.patch
> > >   From: Nishanth Aravamudan <nacc@us.ibm.com>
> > >   Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 20/33] char/rio_linux: replace 	schedule_timeout() with msleep()/msleep_interruptible()
> > >...
> > 
> > This doesn't compile (obvious typo):
> 
> Thanks for catching this! Here is the fixed patch:
> 

thanks also fixed in latest kjt.

