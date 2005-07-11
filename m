Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVGKJF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVGKJF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGKJF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:05:26 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:33031 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261390AbVGKJFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:05:24 -0400
Date: Mon, 11 Jul 2005 10:05:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: tglx@linutronix.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS:  [PATCH resend] C99 initializers for hw_interrupt_type structures
Message-ID: <20050711090508.GE2765@linux-mips.org>
References: <1121031634.26713.243.camel@tglx.tec.linutronix.de> <20050710235037.3.patchmail@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050710235037.3.patchmail@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 11:47:24PM +0200, tglx@linutronix.de wrote:

> Convert the initializers of hw_interrupt_type structures to C99 initializers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

None of these exists anymore in the MIPS CVS, at least according to
Rusty's nice little script.

(And yeah, finally having time to cut patch for you, Andrew.)

  Ralf
