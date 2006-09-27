Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031180AbWI0Wvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031180AbWI0Wvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031183AbWI0Wvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:51:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:44971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1031180AbWI0Wvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:51:42 -0400
Subject: Re: [PATCH 0/5] Message signaled irq handling cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Luck, Tony" <tony.luck@intel.com>,
       Andi Kleen <ak@suse.de>, Michael Ellerman <michaele@au.ibm.com>
In-Reply-To: <1159396605.18293.83.camel@localhost.localdomain>
References: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
	 <1159396605.18293.83.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 08:51:07 +1000
Message-Id: <1159397467.18293.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> At this point, best is that we finish a working implementation based on
> Michael reworked core for PowerPC (which is currently located in
> arch/powerpc and doesn't exclude whatever sits in drivers/pci/ except
> that we don't build the later on PowerPC) so you can see more what our
> approach looks like and why we need to go that way.

Don't look for it in the tree btw, it's not beem merged, though Michael
posted some versions to linuxppc-dev.

Ben.


