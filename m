Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266654AbSKGW7X>; Thu, 7 Nov 2002 17:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266664AbSKGW7X>; Thu, 7 Nov 2002 17:59:23 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:44432 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S266654AbSKGW7W> convert rfc822-to-8bit; Thu, 7 Nov 2002 17:59:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: NUMA scheduler BK tree
Date: Fri, 8 Nov 2002 00:05:30 +0100
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <1036606243.23147.4.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1036606243.23147.4.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211080005.31181.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 November 2002 19:10, Michael Hohnbaum wrote:
> > Is it ok for you to have it this way or would you prefer having the
> > core and the initial load balancer separate?
>
> This is fine with me.  Can't the core changes and and load
> balancer be maintained as separate changesets within the bk
> tree?

OK, I'll do that. Any idea how I can apply a changeset which has
another name attached to it than mine?

Regards,
Erich

