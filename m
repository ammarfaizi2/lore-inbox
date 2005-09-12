Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVILNdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVILNdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVILNdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:33:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38124 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750825AbVILNdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:33:38 -0400
Date: Mon, 12 Sep 2005 15:34:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: trace_irqs_on in raw_local_irq_restore
Message-ID: <20050912133415.GA4332@elte.hu>
References: <1125719249.2709.17.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125719249.2709.17.camel@c-67-188-6-232.hsd1.ca.comcast.net>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> 	Add trace_irqs_on() to raw_local_irq_restore() .
>
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

thanks, applied.

	Ingo
