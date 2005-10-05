Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVJEHhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVJEHhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVJEHhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:37:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:1193 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932566AbVJEHhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:37:09 -0400
Date: Wed, 5 Oct 2005 09:37:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Daniel Walker <dwalker@mvista.com>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005073728.GA22873@elte.hu>
References: <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com> <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004175842.GA5072@in.ibm.com> <1128448471.4252.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004181125.GB5072@in.ibm.com> <1128450466.4252.15.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20051004200326.GC5072@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004200326.GC5072@in.ibm.com>
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


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> On Tue, Oct 04, 2005 at 11:27:46AM -0700, Daniel Walker wrote:
> > 
> > This patch should handle both cases . I would think if this doesn't
> > silence it, then it's something else..
> 
> 
> Daniel, This works for me !
> Thanks for fixing this

great - i have applied it to my tree.

	Ingo
