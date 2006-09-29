Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422801AbWI2UVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWI2UVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWI2UVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:21:39 -0400
Received: from www.osadl.org ([213.239.205.134]:13713 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422802AbWI2UVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:21:37 -0400
Subject: Re: [patch] genirq: clean up irq-flow-type naming
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060929200521.GA30660@elte.hu>
References: <20060929124042.6f03b31a.akpm@osdl.org>
	 <20060929200521.GA30660@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 22:23:28 +0200
Message-Id: <1159561408.9326.745.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 22:05 +0200, Ingo Molnar wrote:
> Subject: genirq: clean up irq-flow-type naming
> From: Ingo Molnar <mingo@elte.hu>
> 
> introduce desc->name and eliminate the handle_irq_name() hack.
> Add set_irq_chip_and_handler_name() to set the flow type and
> name at once.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Thomas Gleixner <tglx@linutronix.de>



