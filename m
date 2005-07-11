Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVGKQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVGKQZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGKQXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:23:21 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:51912 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262142AbVGKQWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:22:18 -0400
Subject: Re: [openib-general] Re: [PATCH 3/27] Add MAD helper functions
From: Hal Rosenstock <halr@voltaire.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20050711160505.GA15937@us.ibm.com>
References: <1121089079.4389.4511.camel@hal.voltaire.com>
	 <200507111839.41807.adobriyan@gmail.com>
	 <1121094791.4389.4591.camel@hal.voltaire.com>
	 <20050711160505.GA15937@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1121098399.4389.4602.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 12:14:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 12:05, Nishanth Aravamudan wrote:
> On 11.07.2005 [11:30:23 -0400], Hal Rosenstock wrote:
> > On Mon, 2005-07-11 at 10:39, Alexey Dobriyan wrote:
> > > On Monday 11 July 2005 17:48, Hal Rosenstock wrote:
> > > > -- linux-2.6.13-rc2-mm1/drivers/infiniband2/core/mad.c
> > > > +++ linux-2.6.13-rc2-mm1/drivers/infiniband3/core/mad.c
> > > 				   ^^^^^^^^^^^
> > > Ick. You'd better have linux-2.6.13-rc2-mm1-[0123...].
> > 
> > Shall I resubmit with linux-2.6.13-rc2-mm1-[0123...] ?
> 
> Do these patches even apply with -p1 with these odd directories? I think
> it will try to find the addition context in a file which doesn't exist
> (because the directory, e.g. infiniband3, does not). I notice that every
> patch increments these values. I think you only want to differentiate
> between the kernels, not between particular directories in the kernel.

I will resubmit. Sorry.

-- Hal

