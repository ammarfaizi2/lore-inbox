Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbTIPVUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbTIPVUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 17:20:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26532 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262506AbTIPVUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 17:20:18 -0400
Subject: Re: [PATCH] use seq_lock for monotonic time
From: john stultz <johnstul@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030916140001.7027d6e5.shemminger@osdl.org>
References: <20030916102706.26bc4516.shemminger@osdl.org>
	 <20030916115935.64ebce3d.akpm@osdl.org>
	 <20030916140001.7027d6e5.shemminger@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063747070.26723.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Sep 2003 14:17:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-16 at 14:00, Stephen Hemminger wrote:
> On Tue, 16 Sep 2003 11:59:35 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > So timer_cyclone and timer_hpet need the same change?
> 
> Yes.

The cyclone bits match those I was testing to send. 
Looks good.

thanks
-john

