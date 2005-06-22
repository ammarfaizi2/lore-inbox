Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVFVLvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVFVLvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFVLvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:51:16 -0400
Received: from mx.sileman.pl ([217.173.160.41]:36252 "EHLO mx.sileman.pl")
	by vger.kernel.org with ESMTP id S261176AbVFVLsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:48:40 -0400
Date: Wed, 22 Jun 2005 13:48:30 +0200
From: RedIpS <ris@elsat.net.pl>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: BUG - realtime-preempt-2.6.12-final-V0.7.50
Message-ID: <20050622134830.5e104a9b@redips.elsat.net.pl>
In-Reply-To: <20050622113011.GA10973@elte.hu>
References: <20050622131820.4aa2554e@redips.elsat.net.pl>
	<20050622113011.GA10973@elte.hu>
X-Mailer: Sylpheed-Claws 1.0.1cvs1.3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SILEMAN-MailScanner-Information: Please contact the ISP for more information
X-SILEMAN-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SILEMAN-MCPCheck: MCP-Clean, MCP-Checker (score=-4.9, required 1,
	BAYES_00 -4.90)
X-SILEMAN-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9,
	required 5, autolearn=not spam, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 13:30:11 +0200
Ingo Molnar <mingo@elte.hu> wrote:

>
> uh oh. Can you see this without the nvidia module loaded?
>
I run system without nvidia kernel module on vesa driver and again get
this error message.
I get this error after some time of running system when use network.

> 
> do you have any other patches applied ontop of -RT, like kgdb?
> 
I only applied vesafb-tng driver.

In older version of RT patch all run fine.
