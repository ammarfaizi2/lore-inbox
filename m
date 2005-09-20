Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVITNgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVITNgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVITNgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:36:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32229 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965012AbVITNgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:36:22 -0400
Date: Tue, 20 Sep 2005 15:37:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH linux-2.6.13-rt14] Priority inversion bug
Message-ID: <20050920133706.GA4855@elte.hu>
References: <1127162309.5097.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127162309.5097.15.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I just discovered a priority inversion bug with the current code. 

thanks - added it to my tree. I'm wondering why it never showed up in 
practice?

	Ingo
