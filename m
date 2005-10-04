Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVJDRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVJDRyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVJDRyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:54:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65265 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964866AbVJDRyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:54:35 -0400
Subject: Re: 2.6.14-rc3-rt2
From: Daniel Walker <dwalker@mvista.com>
To: dino@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
In-Reply-To: <20051004175842.GA5072@in.ibm.com>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
	 <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com>
	 <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20051004175842.GA5072@in.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 10:54:30 -0700
Message-Id: <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 23:28 +0530, Dinakar Guniguntala wrote:

> Nope doesnt help. I booted with this code change and I get the
> same message. 
> 
> I saw that the code change is in #ifdef CONFIG_HIGH_RES_TIMERS.
> I have already disabled CONFIG_HIGH_RES_TIMERS as Thomas Gleixner 
> suggested

Which code is #ifdef'd ?

Is there any diversity in these messages , or is it always the same? Is
the CPU# ever different?

Daniel

