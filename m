Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWEYSZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWEYSZK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWEYSZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:25:10 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52630 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030302AbWEYSZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:25:08 -0400
Date: Thu, 25 May 2006 20:25:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com, tglx@linutronix.de,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] Update rt-mutex-design.txt as per Randy Dunlap suggestions
Message-ID: <20060525182512.GA30847@elte.hu>
References: <200605251502.k4PF21vH027653@shell0.pdx.osdl.net> <1148573982.16319.9.camel@localhost.localdomain> <20060525095242.48c3a310.akpm@osdl.org> <1148579635.18960.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148579635.18960.4.camel@localhost.localdomain>
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

> Update rt-mutex-design.txt as per Randy Dunlap
> 
> This patch contains the updates to the rt-mutex-design.txt document 
> which were suggested by Randy Dunlap.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

indeed i missed this one. Andrew, please fold it into 
pi-futex-rt-mutex-docs.patch.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
