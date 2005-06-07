Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVFGFlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVFGFlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVFGFll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:41:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51368 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261746AbVFGFkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:40:17 -0400
Date: Tue, 7 Jun 2005 07:33:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       anton.wilson@camotion.com
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
Message-ID: <20050607053306.GA16181@elte.hu>
References: <1118112390.4533.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118112390.4533.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I tested the patch on an SMP machine where MAX_RT_PRIO = 100 and 
> MAX_USER_RT_PRIO = 99. Without the patch, the system crashes with a 
> reboot.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
