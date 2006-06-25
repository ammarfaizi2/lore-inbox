Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWFYQJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWFYQJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFYQJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:09:18 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:21415 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751127AbWFYQJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:09:18 -0400
Date: Sun, 25 Jun 2006 12:08:34 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060625160834.GA20005@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org> <20060623214623.GA7319@ccure.user-mode-linux.org> <20060624140001.GA7752@thunk.org> <20060624152235.GB3627@ccure.user-mode-linux.org> <1151165210.25491.352.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151165210.25491.352.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 06:06:50PM +0200, Thomas Gleixner wrote:
> Jeff, its the following patch:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/broken-out/genirq-allow-usage-of-no_irq_chip.patch
> 
> It was a brown paperbag thinko. Back it out or use -mm2

OK, thanks for letting me know.

				Jeff
