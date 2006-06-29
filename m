Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751738AbWF2E64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWF2E64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWF2E64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:58:56 -0400
Received: from ozlabs.org ([203.10.76.45]:18376 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750762AbWF2E6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:58:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17571.24072.340523.225237@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jun 2006 14:58:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu, tglx@linutronix.de,
       bunk@stusta.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch] genirq: rename desc->handler to desc->chip, sparc64 fix
In-Reply-To: <20060628014807.0694436f.akpm@osdl.org>
References: <1151479204.25491.491.camel@localhost.localdomain>
	<20060628081345.GA12647@elte.hu>
	<20060628083008.GA14056@elte.hu>
	<20060628.013940.41192890.davem@davemloft.net>
	<20060628014807.0694436f.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> I'm thinking Thursday/Fridayish.  Is that OK?

I'm not sure that leaves me time to get Ben H's powerpc genirq stuff
into the powerpc.git tree and get Linus to pull before the end of the
merge window...

Paul.
