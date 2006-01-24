Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWAXHpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWAXHpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWAXHpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:45:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8372 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030208AbWAXHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:45:04 -0500
Date: Tue, 24 Jan 2006 08:45:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] kstopmachine has legit preempt_enable_no_resched (was: 2.6.15-rt12 bugs)
Message-ID: <20060124074535.GA22444@elte.hu>
References: <6bffcb0e0601230521l59b8360et@mail.gmail.com> <1138065822.6695.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138065822.6695.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The kstop_machine has a legitimate preempt_enable_no_resched.

thanks, applied.

	Ingo
