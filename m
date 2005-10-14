Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVJNGWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVJNGWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 02:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVJNGWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 02:22:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32207 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932178AbVJNGWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 02:22:19 -0400
Date: Fri, 14 Oct 2005 08:22:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014062244.GB30874@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129135337.21743.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129135337.21743.11.camel@localhost.localdomain>
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


* Badari Pulavarty <pbadari@gmail.com> wrote:

> Hi Ingo,
> 
> I am getting similar segfault on boot problem on 2.6.14-rc4-rt1 on my 
> x86-64 box (with LATENCY_TRACE).

also, could you send me your .config?

	Ingo
