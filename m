Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVJDNqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVJDNqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVJDNqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:46:25 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:34216 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932372AbVJDNqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:46:25 -0400
Date: Tue, 4 Oct 2005 09:45:44 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051004130009.GB31466@elte.hu>
Message-ID: <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
 <20051004130009.GB31466@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Oct 2005, Ingo Molnar wrote:

>
> ugh. uploaded -rt6.
>
> 	Ingo

Hmm Ingo,

Looks like -rt6 got rid of all the _nort defines, but it's still used
throughout the kernel.

-- Steve
